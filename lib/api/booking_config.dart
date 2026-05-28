import '../env.dart';

/// Server-side booking settings loaded from environment variables.
class BookingConfig {
  const BookingConfig({
    required this.calendarId,
    required this.timeZone,
    required this.utcOffsetHours,
    required this.durationMinutes,
    required this.startHour,
    required this.endHour,
    required this.daysAhead,
    required this.minNoticeMinutes,
    required this.workDaysOnly,
  });

  final String calendarId;
  final String timeZone;
  final int utcOffsetHours;
  final int durationMinutes;
  final int startHour;
  final int endHour;
  final int daysAhead;

  /// Minimum minutes from now before a slot can be booked (e.g. 1440 = 24 hours).
  final int minNoticeMinutes;
  final bool workDaysOnly;

  static BookingConfig fromEnv([Map<String, String>? env]) {
    final e = env ?? appEnv;
    return BookingConfig(
      calendarId: e['GOOGLE_CALENDAR_ID'] ?? 'primary',
      timeZone: e['BOOKING_TIMEZONE'] ?? 'America/Argentina/Buenos_Aires',
      utcOffsetHours: int.tryParse(e['BOOKING_UTC_OFFSET_HOURS'] ?? '-3') ?? -3,
      durationMinutes: int.tryParse(e['BOOKING_DURATION_MINUTES'] ?? '30') ?? 30,
      startHour: int.tryParse(e['BOOKING_START_HOUR'] ?? '9') ?? 9,
      endHour: int.tryParse(e['BOOKING_END_HOUR'] ?? '17') ?? 17,
      daysAhead: int.tryParse(e['BOOKING_DAYS_AHEAD'] ?? '14') ?? 14,
      minNoticeMinutes: int.tryParse(e['BOOKING_MIN_NOTICE_MINUTES'] ?? '1440') ?? 1440,
      workDaysOnly: (e['BOOKING_WORK_DAYS_ONLY'] ?? 'true').toLowerCase() != 'false',
    );
  }

  bool get hasGoogleCredentials => missingGoogleCredentials.isEmpty;

  /// Env keys that are missing or empty for Google API access.
  List<String> get missingGoogleCredentials {
    final env = appEnv;
    const keys = [
      'GOOGLE_CLIENT_ID',
      'GOOGLE_CLIENT_SECRET',
      'GOOGLE_REFRESH_TOKEN',
      'GOOGLE_USER_EMAIL',
    ];
    return keys.where((key) {
      final value = env[key];
      return value == null || value.trim().isEmpty;
    }).toList();
  }
}
