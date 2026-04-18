import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart';

import '../env.dart';
import 'api_utils.dart';

// In-memory rate limit: IP → last submission time. Pruned on every request.
final _rateLimit = <String, DateTime>{};
const _rateLimitWindow = Duration(seconds: 30);

/// Shelf middleware that handles [POST /api/contact].
///
/// Reads Gmail OAuth2 credentials from environment variables, exchanges the
/// stored refresh token for an access token, then sends the message via the
/// Gmail REST API. Falls back to stderr logging if credentials are absent (dev).
Middleware get contactApiMiddleware {
  return (Handler inner) {
    return (Request request) async {
      if (request.method == 'POST' && request.requestedUri.path == '/api/contact') {
        return _handleContact(request);
      }
      if (request.method == 'OPTIONS' && request.requestedUri.path == '/api/contact') {
        return Response.ok('', headers: _corsHeaders);
      }
      return inner(request);
    };
  };
}

const _jsonHeaders = {'content-type': 'application/json; charset=utf-8'};
const _corsHeaders = {'access-control-allow-origin': '*', 'access-control-allow-headers': 'content-type'};

Future<Response> _handleContact(Request request) async {
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
    if (body.length > 10000) {
      return Response(413, body: '{"error":"Request too large"}', headers: headers);
    }
    data = (jsonDecode(body) as Map<String, dynamic>);
  } catch (_) {
    return Response.badRequest(body: '{"error":"Invalid JSON body"}', headers: headers);
  }

  // --- honeypot check ---------------------------------------------------
  if ((data['website'] as String? ?? '').trim().isNotEmpty) {
    // Bot detected – silently succeed
    return Response.ok('{"success":true}', headers: headers);
  }

  // --- validate fields --------------------------------------------------
  final name = (data['name'] as String? ?? '').trim();
  final email = (data['email'] as String? ?? '').trim();
  final subject = (data['subject'] as String? ?? '').trim();
  final message = (data['message'] as String? ?? '').trim();

  if (name.isEmpty || email.isEmpty || subject.isEmpty || message.isEmpty) {
    return Response.badRequest(body: '{"error":"All fields are required"}', headers: headers);
  }
  if (name.length > 100 || email.length > 200 || subject.length > 200 || message.length > 5000) {
    return Response.badRequest(body: '{"error":"Input too long"}', headers: headers);
  }

  final emailRe = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
  if (!emailRe.hasMatch(email)) {
    return Response.badRequest(body: '{"error":"Invalid email address"}', headers: headers);
  }

  // --- send email -------------------------------------------------------
  try {
    await _sendEmail(name: name, email: email, subject: subject, message: message);
    _rateLimit[ip] = DateTime.now();
    return Response.ok('{"success":true}', headers: headers);
  } catch (e) {
    stderr.writeln('[contact] Failed to send email: $e');
    return Response.internalServerError(
      body: '{"error":"Failed to send message. Please try again later."}',
      headers: headers,
    );
  }
}

Future<void> _sendEmail({
  required String name,
  required String email,
  required String subject,
  required String message,
}) async {
  final env = appEnv;
  final clientId = env['GOOGLE_CLIENT_ID'];
  final clientSecret = env['GOOGLE_CLIENT_SECRET'];
  final refreshToken = env['GOOGLE_REFRESH_TOKEN'];
  final fromEmail = env['GOOGLE_USER_EMAIL'];
  final toEmail = env['CONTACT_EMAIL'];

  if ([clientId, clientSecret, refreshToken, fromEmail, toEmail].any((v) => v == null || v.isEmpty)) {
    // Credentials not configured – log to console for local dev
    stderr.writeln('[contact] (no credentials) message from $name <$email>: $subject');
    return;
  }

  // 1. Exchange refresh token for access token
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

  // 2. Build RFC 2822 message — sanitize every user value used in headers.
  final safeName = sanitizeHeader(name);
  final safeEmail = sanitizeHeader(email);
  final safeSubject = sanitizeHeader(subject);

  final raw = [
    'From: $fromEmail',
    'To: $toEmail',
    'Reply-To: "$safeName" <$safeEmail>',
    'Subject: [Contact] $safeSubject',
    'MIME-Version: 1.0',
    'Content-Type: text/plain; charset=UTF-8',
    '',
    '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━',
    'Contact form submission',
    '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━',
    '',
    'Name:    $name',
    'Email:   $email',
    'Subject: $subject',
    '',
    '--- Message ---',
    '',
    message,
    '',
    '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━',
  ].join('\r\n');

  final encoded = base64Url.encode(utf8.encode(raw)).replaceAll('=', '');

  // 3. Send via Gmail API
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
