import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

/// Default IANA timezone for host availability (from [BOOKING_TIMEZONE] env).
const defaultBookingTimeZone = 'America/Argentina/Buenos_Aires';

/// Shown first in the booking timezone selector (common visitor zones).
const preferredBookingTimeZoneIds = [
  'America/Argentina/Buenos_Aires',
  'America/Sao_Paulo',
  'America/New_York',
  'America/Chicago',
  'America/Denver',
  'America/Los_Angeles',
  'Europe/London',
  'Europe/Madrid',
  'Europe/Berlin',
  'Asia/Tokyo',
  'Australia/Sydney',
  'Etc/UTC',
];

class BookingTimeZoneOption {
  const BookingTimeZoneOption({required this.id});

  final String id;
}

var _timeZonesInitialized = false;
List<BookingTimeZoneOption>? _bookingTimeZoneOptionsCache;
Set<String>? _bookingTimeZoneIdsCache;

void _ensureTimeZones() {
  if (_timeZonesInitialized) return;
  tz_data.initializeTimeZones();
  _timeZonesInitialized = true;
}

/// Maps legacy or alias ids to IANA ids in the timezone database.
String normalizeBookingTimeZoneId(String id) {
  final trimmed = id.trim();
  if (trimmed == 'UTC') return 'Etc/UTC';
  return trimmed;
}

bool isKnownBookingTimeZone(String id) {
  _ensureTimeZones();
  final normalized = normalizeBookingTimeZoneId(id);
  if (normalized.isEmpty) return false;
  try {
    tz.getLocation(normalized);
    return true;
  } catch (_) {
    return false;
  }
}

int _offsetMinutesNow(String timeZoneId) {
  try {
    final location = tz.getLocation(timeZoneId);
    final now = tz.TZDateTime.now(location);
    return now.timeZoneOffset.inMinutes;
  } catch (_) {
    return 0;
  }
}

List<BookingTimeZoneOption> _buildBookingTimeZoneOptions() {
  _ensureTimeZones();
  final ids = tz.timeZoneDatabase.locations.keys.toList()
    ..sort((a, b) {
      final offsetCmp = _offsetMinutesNow(a).compareTo(_offsetMinutesNow(b));
      if (offsetCmp != 0) return offsetCmp;
      return a.compareTo(b);
    });

  final preferred = <String>{
    for (final id in preferredBookingTimeZoneIds)
      if (ids.contains(id)) id,
  };
  final ordered = [
    for (final id in preferredBookingTimeZoneIds)
      if (preferred.contains(id)) id,
    for (final id in ids)
      if (!preferred.contains(id)) id,
  ];

  return [for (final id in ordered) BookingTimeZoneOption(id: id)];
}

/// All IANA timezones from the timezone package, with common zones listed first.
List<BookingTimeZoneOption> get bookingTimeZoneOptions {
  _bookingTimeZoneOptionsCache ??= _buildBookingTimeZoneOptions();
  return _bookingTimeZoneOptionsCache!;
}

Set<String> get _bookingTimeZoneIds {
  _bookingTimeZoneIdsCache ??= {for (final option in bookingTimeZoneOptions) option.id};
  return _bookingTimeZoneIdsCache!;
}

List<BookingTimeZoneOption> bookingTimeZoneOptionsIncluding(String? id) {
  final normalized = id == null ? null : normalizeBookingTimeZoneId(id);
  if (normalized == null || normalized.isEmpty || _bookingTimeZoneIds.contains(normalized)) {
    return bookingTimeZoneOptions;
  }
  if (!isKnownBookingTimeZone(normalized)) {
    return bookingTimeZoneOptions;
  }
  return [
    BookingTimeZoneOption(id: normalized),
    ...bookingTimeZoneOptions,
  ];
}

/// Drops options that share the same [labelFor] text (e.g. multiple Alaska IANA ids).
List<BookingTimeZoneOption> dedupeBookingTimeZoneOptions(
  List<BookingTimeZoneOption> options, {
  required String Function(String id) labelFor,
}) {
  final seen = <String>{};
  return [
    for (final option in options)
      if (seen.add(labelFor(option.id))) option,
  ];
}

/// Maps an IANA id to the first option with the same display label.
String canonicalBookingTimeZoneId(
  String id, {
  required List<BookingTimeZoneOption> options,
  required String Function(String id) labelFor,
}) {
  final normalized = normalizeBookingTimeZoneId(id);
  final label = labelFor(normalized);
  for (final option in options) {
    if (labelFor(option.id) == label) return option.id;
  }
  return normalized;
}
