import 'dart:io';

import '../env.dart';

/// When true, logs detailed booking flow steps to stderr.
bool get bookingDebugEnabled => (appEnv['BOOKING_DEBUG'] ?? 'false').toLowerCase() == 'true';

void bookingLog(String message) {
  if (!bookingDebugEnabled) return;
  stderr.writeln('[booking] $message');
}

void bookingWarn(String message) {
  stderr.writeln('[booking] WARN $message');
}

void bookingError(String message, [Object? error, StackTrace? stackTrace]) {
  stderr.writeln('[booking] ERROR $message');
  if (error != null) stderr.writeln('[booking]   cause: $error');
  if (bookingDebugEnabled && stackTrace != null) {
    stderr.writeln('[booking]   stack: $stackTrace');
  }
}

/// Redacts an email for logs: `j***@example.com`
String redactEmail(String email) {
  final parts = email.split('@');
  if (parts.length != 2 || parts[0].isEmpty) return '(invalid email)';
  final local = parts[0];
  final visible = local.length <= 1 ? '*' : '${local[0]}***';
  return '$visible@${parts[1]}';
}

/// Optional debug detail appended to JSON error responses.
String? bookingErrorDetail(Object error) {
  if (!bookingDebugEnabled) return null;
  return error.toString();
}
