import 'dart:io';

import 'package:shelf/shelf.dart';

/// Strips CR and LF characters from [value] to prevent SMTP header injection.
String sanitizeHeader(String value) => value.replaceAll(RegExp(r'[\r\n]'), ' ').trim();

/// Resolves the real client IP.
///
/// [X-Forwarded-For] is only trusted when the immediate TCP connection comes
/// from a loopback or private-network address (i.e. a known reverse proxy).
/// A public client can otherwise spoof the header and bypass rate limiting.
String extractClientIp(Request request) {
  final connInfo = request.context['shelf.io.connection_info'] as HttpConnectionInfo?;
  final connIp = connInfo?.remoteAddress.address ?? 'unknown';

  final xff = request.headers['x-forwarded-for'];
  if (xff != null && _isTrustedProxy(connIp)) {
    return xff.split(',').first.trim();
  }
  return connIp;
}

bool _isTrustedProxy(String ip) =>
    ip == '127.0.0.1' ||
    ip == '::1' ||
    ip.startsWith('10.') ||
    ip.startsWith('192.168.') ||
    // 172.16.0.0 – 172.31.255.255
    RegExp(r'^172\.(1[6-9]|2\d|3[01])\.').hasMatch(ip);

/// Removes entries from [rateLimit] older than [window], preventing unbounded
/// memory growth on long-running servers.
void pruneRateLimit(Map<String, DateTime> rateLimit, Duration window) {
  final cutoff = DateTime.now().subtract(window);
  rateLimit.removeWhere((_, time) => time.isBefore(cutoff));
}
