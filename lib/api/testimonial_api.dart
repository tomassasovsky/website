import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart';

import '../env.dart';
import 'api_utils.dart';

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

  // --- rate limiting ---------------------------------------------------
  pruneRateLimit(_rateLimit, _rateLimitWindow);
  final ip = extractClientIp(request);

  final last = _rateLimit[ip];
  if (last != null && DateTime.now().difference(last) < _rateLimitWindow) {
    return Response(429, body: '{"error":"Too many requests. Please wait before trying again."}', headers: headers);
  }

  // --- parse body -------------------------------------------------------
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

  // --- honeypot check ---------------------------------------------------
  if ((data['website'] as String? ?? '').trim().isNotEmpty) {
    return Response.ok('{"success":true}', headers: headers);
  }

  // --- validate fields --------------------------------------------------
  final name = (data['name'] as String? ?? '').trim();
  final email = (data['email'] as String? ?? '').trim();
  final role = (data['role'] as String? ?? '').trim();
  final linkedinUrl = (data['linkedinUrl'] as String? ?? '').trim();
  final testimonial = (data['testimonial'] as String? ?? '').trim();

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

  // --- send email -------------------------------------------------------
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
  final env = appEnv;
  final clientId = env['GOOGLE_CLIENT_ID'];
  final clientSecret = env['GOOGLE_CLIENT_SECRET'];
  final refreshToken = env['GOOGLE_REFRESH_TOKEN'];
  final fromEmail = env['GOOGLE_USER_EMAIL'];
  final toEmail = env['CONTACT_EMAIL'];

  if ([clientId, clientSecret, refreshToken, fromEmail, toEmail].any((v) => v == null || v.isEmpty)) {
    stderr.writeln(
      '[testimonial] (no credentials) submission from $name: ${testimonial.substring(0, testimonial.length.clamp(0, 80))}…',
    );
    return;
  }

  final tokenResp = await http.post(
    Uri.parse('https://oauth2.googleapis.com/token'),
    headers: {'content-type': 'application/x-www-form-urlencoded'},
    body: {
      'client_id': clientId,
      'client_secret': clientSecret,
      'refresh_token': refreshToken,
      'grant_type': 'refresh_token',
    },
  );
  if (tokenResp.statusCode != 200) {
    throw Exception('token exchange failed (${tokenResp.statusCode}): ${tokenResp.body}');
  }
  final accessToken = (jsonDecode(tokenResp.body) as Map<String, dynamic>)['access_token'] as String;

  // Sanitize every user value used in headers to prevent SMTP header injection.
  final safeName = sanitizeHeader(name);
  final safeEmail = email.isNotEmpty ? sanitizeHeader(email) : '';

  final raw = [
    'From: $fromEmail',
    'To: $toEmail',
    if (safeEmail.isNotEmpty) 'Reply-To: "$safeName" <$safeEmail>',
    'Subject: [Testimonial] New submission from $safeName',
    'MIME-Version: 1.0',
    'Content-Type: text/plain; charset=UTF-8',
    '',
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
  ].join('\r\n');

  final encoded = base64Url.encode(utf8.encode(raw)).replaceAll('=', '');

  final sendResp = await http.post(
    Uri.parse('https://gmail.googleapis.com/gmail/v1/users/me/messages/send'),
    headers: {
      'authorization': 'Bearer $accessToken',
      'content-type': 'application/json',
    },
    body: jsonEncode({'raw': encoded}),
  );
  if (sendResp.statusCode != 200) {
    throw Exception('gmail send failed (${sendResp.statusCode}): ${sendResp.body}');
  }
}
