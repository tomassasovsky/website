import 'booking_config.dart';
import 'booking_log.dart';
import 'google_oauth.dart';

/// Short-lived in-memory cache for Google Calendar free/busy data.
class BookingBusyCache {
  BookingBusyCache._();

  static const _busyTtl = Duration(seconds: 90);

  static String? _accessToken;
  static DateTime? _accessTokenExpiresAt;

  static String? _busyCalendarId;
  static DateTime? _busyFetchedAt;
  static DateTime? _busyWindowStart;
  static DateTime? _busyWindowEnd;
  static List<BusyInterval> _busyIntervals = [];

  static Future<String?> accessToken() async {
    final now = DateTime.now();
    if (_accessToken != null &&
        _accessTokenExpiresAt != null &&
        now.isBefore(_accessTokenExpiresAt!.subtract(const Duration(minutes: 2)))) {
      return _accessToken;
    }

    final refreshed = await refreshGoogleAccessToken();
    if (refreshed == null) return null;

    _accessToken = refreshed.token;
    _accessTokenExpiresAt = refreshed.expiresAt;
    return _accessToken;
  }

  static void invalidateBusy() {
    _busyCalendarId = null;
    _busyFetchedAt = null;
    _busyWindowStart = null;
    _busyWindowEnd = null;
    _busyIntervals = [];
  }

  static void storeBusy({
    required String calendarId,
    required DateTime windowStart,
    required DateTime windowEnd,
    required List<BusyInterval> intervals,
  }) {
    _busyCalendarId = calendarId;
    _busyFetchedAt = DateTime.now();
    _busyWindowStart = windowStart.toUtc();
    _busyWindowEnd = windowEnd.toUtc();
    _busyIntervals = intervals;
    bookingLog(
      'Cached freeBusy for $calendarId (${intervals.length} busy interval(s), '
      'window ${_busyWindowStart!.toIso8601String()}–${_busyWindowEnd!.toIso8601String()})',
    );
  }

  static List<BusyInterval>? busyIntervalsCovering({
    required BookingConfig config,
    required DateTime timeMin,
    required DateTime timeMax,
  }) {
    if (_busyCalendarId != config.calendarId || _busyFetchedAt == null) return null;
    if (DateTime.now().difference(_busyFetchedAt!) > _busyTtl) return null;

    final min = timeMin.toUtc();
    final max = timeMax.toUtc();
    if (_busyWindowStart == null || _busyWindowEnd == null) return null;
    if (min.isBefore(_busyWindowStart!) || max.isAfter(_busyWindowEnd!)) return null;

    return _busyIntervals;
  }
}

class BusyInterval {
  const BusyInterval({required this.start, required this.end});

  final DateTime start;
  final DateTime end;
}
