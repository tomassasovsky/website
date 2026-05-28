import 'dart:convert';

import 'api_utils.dart';

/// Preserves Unicode letters (accents, ñ, etc.).
String normalizeUserText(String value, {bool multiline = false}) {
  var text = value.trim();
  final controlChars = multiline ? RegExp(r'[\x00-\x08\x0B\x0C\x0E-\x1F\x7F]') : RegExp(r'[\x00-\x1F\x7F]');
  return text.replaceAll(controlChars, '');
}

/// RFC 2047 encoded-word for non-ASCII email header values (Subject, display names).
String encodeMimeHeader(String value) {
  final sanitized = sanitizeHeader(value);
  if (sanitized.isEmpty) return '';
  if (sanitized.runes.every((r) => r < 128)) return sanitized;
  final encoded = base64.encode(utf8.encode(sanitized));
  return '=?UTF-8?B?$encoded?=';
}

/// Formats `"Display Name" <email@example.com>` with UTF-8-safe display names.
String formatEmailAddress(String? name, String email) {
  final safeEmail = sanitizeHeader(email);
  if (name == null || name.trim().isEmpty) return safeEmail;
  return '${encodeMimeHeader(name.trim())} <$safeEmail>';
}
