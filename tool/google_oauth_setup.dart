// ignore_for_file: avoid_print
//
// One-time helper to obtain a Google OAuth refresh token with the scopes
// required by this site (Gmail send + Calendar booking).
//
// Prerequisites:
//   1. Enable Gmail API and Google Calendar API in Google Cloud Console.
//   2. Create an OAuth client (Web application).
//   3. Add http://localhost:8080 to Authorized redirect URIs.
//   4. Set GOOGLE_CLIENT_ID and GOOGLE_CLIENT_SECRET in .env
//
// Usage (stop the dev server first — it also uses port 8080):
//   dart run tool/google_oauth_setup.dart
//
// Options:
//   --port 8080       Local callback port (must match redirect URI in Cloud Console)
//   --write           Update GOOGLE_REFRESH_TOKEN in .env automatically
//   --no-open         Print the URL instead of opening a browser

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:website/env.dart';

const _redirectPath = '/';
const _scopes = [
  'https://www.googleapis.com/auth/gmail.send',
  'https://www.googleapis.com/auth/calendar.events',
  'https://www.googleapis.com/auth/calendar.freebusy',
];

Future<void> main(List<String> args) async {
  final port = _readPort(args);
  final writeEnv = args.contains('--write');
  final openBrowser = !args.contains('--no-open');

  final clientId = appEnv['GOOGLE_CLIENT_ID']?.trim();
  final clientSecret = appEnv['GOOGLE_CLIENT_SECRET']?.trim();
  if (clientId == null || clientId.isEmpty || clientSecret == null || clientSecret.isEmpty) {
    stderr.writeln('Missing GOOGLE_CLIENT_ID or GOOGLE_CLIENT_SECRET in .env');
    exit(1);
  }

  final redirectUri = 'http://localhost:$port';
  final authUrl = Uri.https('accounts.google.com', '/o/oauth2/v2/auth', {
    'client_id': clientId,
    'redirect_uri': redirectUri,
    'response_type': 'code',
    'scope': _scopes.join(' '),
    'access_type': 'offline',
    'prompt': 'consent',
  });

  print('Starting callback server on $redirectUri …');
  print('If this fails, stop `dart run lib/main.server.dart` (same port).\n');

  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, port);
  print('Open this URL and sign in with the account in GOOGLE_USER_EMAIL:\n');
  print(authUrl);
  print('');

  if (openBrowser) {
    await _openInBrowser(authUrl);
  }

  final code = await _waitForAuthCode(server);
  await server.close(force: true);

  print('\nExchanging authorization code for tokens …');
  final tokenResp = await http.post(
    Uri.parse('https://oauth2.googleapis.com/token'),
    headers: {'content-type': 'application/x-www-form-urlencoded'},
    body: {
      'client_id': clientId,
      'client_secret': clientSecret,
      'code': code,
      'grant_type': 'authorization_code',
      'redirect_uri': redirectUri,
    },
  );

  if (tokenResp.statusCode != 200) {
    stderr.writeln('Token exchange failed (${tokenResp.statusCode}):\n${tokenResp.body}');
    exit(1);
  }

  final tokens = jsonDecode(tokenResp.body) as Map<String, dynamic>;
  final refreshToken = tokens['refresh_token'] as String?;
  if (refreshToken == null || refreshToken.isEmpty) {
    stderr.writeln(
      'No refresh_token in response. Revoke this app at '
      'https://myaccount.google.com/permissions and run again.',
    );
    stderr.writeln('Response: ${tokenResp.body}');
    exit(1);
  }

  print('\nSuccess. Add this to .env:\n');
  print('GOOGLE_REFRESH_TOKEN=$refreshToken');

  if (writeEnv) {
    await _writeRefreshToken(refreshToken);
    print('\nUpdated .env with GOOGLE_REFRESH_TOKEN.');
  } else {
    print('\nTip: re-run with --write to update .env automatically.');
  }

  print('\nVerify Calendar access:');
  print('  dart run lib/main.server.dart');
  print('  open http://localhost:8080/en/book-meeting');
}

int _readPort(List<String> args) {
  final idx = args.indexOf('--port');
  if (idx >= 0 && idx + 1 < args.length) {
    return int.parse(args[idx + 1]);
  }
  return 8080;
}

Future<void> _openInBrowser(Uri url) async {
  try {
    if (Platform.isMacOS) {
      await Process.run('open', [url.toString()]);
    } else if (Platform.isLinux) {
      await Process.run('xdg-open', [url.toString()]);
    } else if (Platform.isWindows) {
      await Process.run('cmd', ['/c', 'start', '', url.toString()]);
    }
  } catch (_) {
    print('(Could not open browser automatically — use the URL above.)');
  }
}

Future<String> _waitForAuthCode(HttpServer server) async {
  await for (final request in server) {
    final uri = request.uri;
    if (uri.path != _redirectPath) {
      request.response
        ..statusCode = HttpStatus.notFound
        ..write('Not found')
        ..close();
      continue;
    }

    final error = uri.queryParameters['error'];
    if (error != null) {
      request.response
        ..statusCode = HttpStatus.badRequest
        ..headers.contentType = ContentType.html
        ..write(_html('Authorization failed', '<p>Error: $error</p>'))
        ..close();
      stderr.writeln('Authorization failed: $error');
      exit(1);
    }

    final code = uri.queryParameters['code'];
    if (code == null || code.isEmpty) {
      request.response
        ..statusCode = HttpStatus.badRequest
        ..headers.contentType = ContentType.html
        ..write(_html('Missing code', '<p>No authorization code received.</p>'))
        ..close();
      continue;
    }

    request.response
      ..statusCode = HttpStatus.ok
      ..headers.contentType = ContentType.html
      ..write(
        _html(
          'Authorized',
          '<p>Refresh token captured. You can close this tab and return to the terminal.</p>',
        ),
      )
      ..close();
    return code;
  }
  throw StateError('Server closed before receiving authorization code');
}

Future<void> _writeRefreshToken(String refreshToken) async {
  const envPath = '.env';
  final file = File(envPath);
  if (!file.existsSync()) {
    stderr.writeln('.env not found — copy .env.example first.');
    exit(1);
  }

  final lines = file.readAsLinesSync();
  var found = false;
  final updated = lines.map((line) {
    if (line.startsWith('GOOGLE_REFRESH_TOKEN=')) {
      found = true;
      return 'GOOGLE_REFRESH_TOKEN=$refreshToken';
    }
    return line;
  }).toList();

  if (!found) {
    updated.add('GOOGLE_REFRESH_TOKEN=$refreshToken');
  }

  file.writeAsStringSync('${updated.join('\n')}\n');
}

String _html(String title, String body) =>
    '''
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>$title</title>
  <style>
    body { font-family: system-ui, sans-serif; max-width: 36rem; margin: 4rem auto; line-height: 1.6; }
  </style>
</head>
<body>
  <h1>$title</h1>
  $body
</body>
</html>
''';
