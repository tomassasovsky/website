import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';

import 'api_utils.dart';
import 'gmail_send.dart';
import 'text_encoding.dart';

// In-memory rate limit: IP → last submission time. Pruned on every request.
final _rateLimit = <String, DateTime>{};
const _rateLimitWindow = Duration(seconds: 60);

/// Shelf middleware that handles [POST /api/testimonial].
///
/// Receives a testimonial submission from a past client and forwards it via
/// Gmail so it can be reviewed before adding it to the site.
Middleware get testimonialApiMiddleware {
  return (Handler inner) {
    return (Request request) async {
      if (request.method == 'POST' && request.requestedUri.path == '/api/testimonial') {
        return _handleTestimonial(request);
      }
      if (request.method == 'OPTIONS' && request.requestedUri.path == '/api/testimonial') {
        return Response.ok('', headers: _corsHeaders);
      }
      return inner(request);
    };
  };
}

const _jsonHeaders = {'content-type': 'application/json; charset=utf-8'};
const _corsHeaders = {'access-control-allow-origin': '*', 'access-control-allow-headers': 'content-type'};

Future<Response> _handleTestimonial(Request request) async {
  final headers = {..._jsonHeaders, ..._corsHeaders};

  pruneRateLimit(_rateLimit, _rateLimitWindow);
  final ip = extractClientIp(request);

  final last = _rateLimit[ip];
  if (last != null && DateTime.now().difference(last) < _rateLimitWindow) {
    return Response(429, body: '{"error":"Too many requests. Please wait before trying again."}', headers: headers);
  }

  Map<String, dynamic> data;
  try {
    final body = await request.readAsString();
    if (body.length > 20000) {
      return Response(413, body: '{"error":"Request too large"}', headers: headers);
    }
    data = (jsonDecode(body) as Map<String, dynamic>);
  } catch (_) {
    return Response.badRequest(body: '{"error":"Invalid JSON body"}', headers: headers);
  }

  if ((data['website'] as String? ?? '').trim().isNotEmpty) {
    return Response.ok('{"success":true}', headers: headers);
  }

  final name = normalizeUserText(data['name'] as String? ?? '');
  final email = normalizeUserText(data['email'] as String? ?? '').toLowerCase();
  final role = normalizeUserText(data['role'] as String? ?? '');
  final linkedinUrl = normalizeUserText(data['linkedinUrl'] as String? ?? '');
  final testimonial = normalizeUserText(data['testimonial'] as String? ?? '', multiline: true);

  if (name.isEmpty || testimonial.isEmpty) {
    return Response.badRequest(body: '{"error":"Name and testimonial are required"}', headers: headers);
  }
  if (name.length > 100 ||
      email.length > 200 ||
      role.length > 200 ||
      linkedinUrl.length > 500 ||
      testimonial.length > 10000) {
    return Response.badRequest(body: '{"error":"Input too long"}', headers: headers);
  }
  final emailRe = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
  if (email.isNotEmpty && !emailRe.hasMatch(email)) {
    return Response.badRequest(body: '{"error":"Invalid email address"}', headers: headers);
  }
  if (linkedinUrl.isNotEmpty && !linkedinUrl.startsWith('https://')) {
    return Response.badRequest(body: '{"error":"LinkedIn URL must start with https://"}', headers: headers);
  }

  try {
    await _sendEmail(name: name, email: email, role: role, linkedinUrl: linkedinUrl, testimonial: testimonial);
    _rateLimit[ip] = DateTime.now();
    return Response.ok('{"success":true}', headers: headers);
  } catch (e) {
    stderr.writeln('[testimonial] Failed to send email: $e');
    return Response.internalServerError(
      body: '{"error":"Failed to submit testimonial. Please try again later."}',
      headers: headers,
    );
  }
}

Future<void> _sendEmail({
  required String name,
  required String email,
  required String role,
  required String linkedinUrl,
  required String testimonial,
}) async {
  final toEmail = notificationEmail;
  if (toEmail == null) {
    stderr.writeln(
      '[testimonial] (no credentials) submission from $name: ${testimonial.substring(0, testimonial.length.clamp(0, 80))}…',
    );
    return;
  }

  await sendGmailMessage(
    to: toEmail,
    subject: '[Testimonial] New submission from $name',
    body: [
      '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━',
      'Testimonial submission',
      '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━',
      '',
      'Name:  $name',
      if (email.isNotEmpty) 'Email: $email',
      if (role.isNotEmpty) 'Role:  $role',
      if (linkedinUrl.isNotEmpty) 'LinkedIn / social: $linkedinUrl',
      '',
      '--- Testimonial ---',
      '',
      testimonial,
      '',
      '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━',
    ].join('\n'),
    replyToName: email.isNotEmpty ? name : null,
    replyToEmail: email.isNotEmpty ? email : null,
  );
}
