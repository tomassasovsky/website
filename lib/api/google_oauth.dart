import 'dart:convert';

import 'package:http/http.dart' as http;

import '../env.dart';
import 'booking_log.dart';

class GoogleAccessToken {
  const GoogleAccessToken({required this.token, required this.expiresAt});

  final String token;
  final DateTime expiresAt;
}

/// Returns a Google OAuth2 access token using the refresh token from env.
Future<GoogleAccessToken?> refreshGoogleAccessToken() async {
  final env = appEnv;
  final clientId = env['GOOGLE_CLIENT_ID'];
  final clientSecret = env['GOOGLE_CLIENT_SECRET'];
  final refreshToken = env['GOOGLE_REFRESH_TOKEN'];

  if ([clientId, clientSecret, refreshToken].any((v) => v == null || v.isEmpty)) {
    bookingLog('OAuth skipped: missing client id, secret, or refresh token');
    return null;
  }

  bookingLog('Refreshing Google access token …');
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
    bookingError('Token exchange failed (${tokenResp.statusCode})', tokenResp.body);
    throw Exception('token exchange failed (${tokenResp.statusCode}): ${tokenResp.body}');
  }

  final body = jsonDecode(tokenResp.body) as Map<String, dynamic>;
  final scope = body['scope'] as String?;
  final expiresIn = body['expires_in'] as int? ?? 3600;
  bookingLog('Access token obtained${scope == null ? '' : ' (scopes: $scope)'}');
  return GoogleAccessToken(
    token: body['access_token'] as String,
    expiresAt: DateTime.now().add(Duration(seconds: expiresIn)),
  );
}

/// Convenience wrapper returning only the token string.
Future<String?> fetchGoogleAccessToken() async => (await refreshGoogleAccessToken())?.token;
