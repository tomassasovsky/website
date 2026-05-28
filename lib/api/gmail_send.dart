import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/site_data.dart';
import '../env.dart';
import 'google_oauth.dart';
import 'text_encoding.dart';

class GmailAttachment {
  const GmailAttachment({
    required this.filename,
    required this.mimeType,
    required this.content,
  });

  final String filename;
  final String mimeType;
  final String content;
}

/// Sends a plain + HTML notification email (multipart/alternative).
Future<void> sendHtmlNotificationEmail({
  required String to,
  required String subject,
  required String plainBody,
  required String htmlBody,
  String? replyToName,
  String? replyToEmail,
}) async {
  _requireFromEmail();
  final fromEmail = appEnv['GOOGLE_USER_EMAIL']!;
  final boundary = _mimeBoundary('alt');

  final headers = <String>[
    'From: ${formatEmailAddress(siteName, fromEmail)}',
    'To: ${formatEmailAddress(null, to)}',
    'Subject: ${encodeMimeHeader(subject)}',
    'MIME-Version: 1.0',
    'Content-Type: multipart/alternative; boundary="$boundary"',
    if (replyToEmail != null && replyToEmail.isNotEmpty) 'Reply-To: ${formatEmailAddress(replyToName, replyToEmail)}',
  ];

  final body = StringBuffer()
    ..writeln(headers.join('\r\n'))
    ..writeln()
    ..writeln('--$boundary')
    ..writeln('Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes')
    ..writeln('Content-Transfer-Encoding: 8bit')
    ..writeln()
    ..writeln(plainBody)
    ..writeln()
    ..writeln('--$boundary')
    ..writeln('Content-Type: text/html; charset="UTF-8"')
    ..writeln('Content-Transfer-Encoding: 8bit')
    ..writeln()
    ..writeln(htmlBody)
    ..writeln()
    ..writeln('--$boundary--');

  await _sendRawMime(body.toString());
}

/// Sends a plain-text email via the Gmail API using credentials from env.
Future<void> sendGmailMessage({
  required String to,
  required String subject,
  required String body,
  String? replyToName,
  String? replyToEmail,
  List<GmailAttachment> attachments = const [],
}) async {
  _requireFromEmail();

  final fromEmail = appEnv['GOOGLE_USER_EMAIL']!;

  final headers = <String>[
    'From: ${formatEmailAddress(siteName, fromEmail)}',
    'To: ${formatEmailAddress(null, to)}',
    if (replyToEmail != null && replyToEmail.isNotEmpty) 'Reply-To: ${formatEmailAddress(replyToName, replyToEmail)}',
    'Subject: ${encodeMimeHeader(subject)}',
    'MIME-Version: 1.0',
  ];

  final String mimeBody;
  if (attachments.isEmpty) {
    headers.add('Content-Type: text/plain; charset=UTF-8');
    headers.add('Content-Transfer-Encoding: 8bit');
    mimeBody = [...headers, '', body].join('\r\n');
  } else {
    final boundary = _mimeBoundary('mixed');
    headers.add('Content-Type: multipart/mixed; boundary="$boundary"');

    final parts = <String>[
      ...headers,
      '',
      '--$boundary',
      'Content-Type: text/plain; charset=UTF-8',
      'Content-Transfer-Encoding: 8bit',
      '',
      body,
    ];

    for (final attachment in attachments) {
      parts.addAll([
        '--$boundary',
        'Content-Type: ${attachment.mimeType}; charset=UTF-8; name="${attachment.filename}"',
        'Content-Disposition: attachment; filename="${attachment.filename}"',
        'Content-Transfer-Encoding: base64',
        '',
        base64.encode(utf8.encode(attachment.content)),
      ]);
    }

    parts.add('--$boundary--');
    mimeBody = parts.join('\r\n');
  }

  await _sendRawMime(mimeBody);
}

Future<void> _sendRawMime(String mimeBody) async {
  final accessToken = await fetchGoogleAccessToken();
  if (accessToken == null) {
    throw Exception('Google OAuth credentials are not configured');
  }

  final encoded = base64Url.encode(utf8.encode(mimeBody)).replaceAll('=', '');

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

String _requireFromEmail() {
  final fromEmail = appEnv['GOOGLE_USER_EMAIL'];
  if (fromEmail == null || fromEmail.isEmpty) {
    throw Exception('GOOGLE_USER_EMAIL is not configured');
  }
  return fromEmail;
}

String _mimeBoundary(String prefix) => '${prefix}_${DateTime.now().microsecondsSinceEpoch}';

/// Inbox for site notifications — falls back to [GOOGLE_USER_EMAIL].
String? get notificationEmail {
  final contact = appEnv['CONTACT_EMAIL']?.trim();
  if (contact != null && contact.isNotEmpty) return contact;
  final user = appEnv['GOOGLE_USER_EMAIL']?.trim();
  if (user != null && user.isNotEmpty) return user;
  return null;
}

String? get organizerEmail => appEnv['GOOGLE_USER_EMAIL']?.trim();
