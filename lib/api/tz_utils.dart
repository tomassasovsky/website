import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import 'booking_config.dart';

var _initialized = false;

void ensureTimeZones() {
  if (_initialized) return;
  tz_data.initializeTimeZones();
  _initialized = true;
}

tz.Location? resolveTimeZone(String id) {
  ensureTimeZones();
  try {
    return tz.getLocation(id);
  } catch (_) {
    return null;
  }
}

String _normalizeTimeZoneId(String id) {
  if (id == 'UTC') return 'Etc/UTC';
  return id;
}

/// Returns a validated viewer timezone id, falling back to the host timezone.
String normalizeViewerTimeZone(String? value, BookingConfig config) {
  final candidate = value?.trim();
  if (candidate != null && candidate.isNotEmpty) {
    final normalized = _normalizeTimeZoneId(candidate);
    if (resolveTimeZone(normalized) != null) {
      return normalized;
    }
  }
  return config.timeZone;
}

String dateKeyInTimeZone(DateTime utcInstant, String timeZoneId) {
  final location = resolveTimeZone(timeZoneId);
  if (location == null) return _dateKeyUtc(utcInstant);
  final local = tz.TZDateTime.from(utcInstant.toUtc(), location);
  return _dateKey(local.year, local.month, local.day);
}

DateTime utcRangeStartForLocalDate(int year, int month, int day, String timeZoneId) {
  final location = resolveTimeZone(timeZoneId)!;
  return tz.TZDateTime(location, year, month, day).toUtc();
}

DateTime utcRangeEndForLocalDate(int year, int month, int day, String timeZoneId) {
  final location = resolveTimeZone(timeZoneId)!;
  return tz.TZDateTime(location, year, month, day).add(const Duration(days: 1)).toUtc();
}

DateTime utcRangeStartForLocalMonth(int year, int month, String timeZoneId) {
  final location = resolveTimeZone(timeZoneId)!;
  return tz.TZDateTime(location, year, month, 1).toUtc();
}

DateTime utcRangeEndForLocalMonth(int year, int month, String timeZoneId) {
  final location = resolveTimeZone(timeZoneId)!;
  final nextMonth = month == 12 ? tz.TZDateTime(location, year + 1, 1, 1) : tz.TZDateTime(location, year, month + 1, 1);
  return nextMonth.toUtc();
}

DateTime hostDateFromUtcInstant(DateTime utcInstant, BookingConfig config) {
  final location = resolveTimeZone(config.timeZone)!;
  final local = tz.TZDateTime.from(utcInstant.toUtc(), location);
  return DateTime.utc(local.year, local.month, local.day);
}

String _dateKey(int year, int month, int day) =>
    '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

String _dateKeyUtc(DateTime utc) => _dateKey(utc.year, utc.month, utc.day);

/// Host-local calendar days that could contain slots overlapping [utcStart, utcEnd).
Iterable<DateTime> hostDatesOverlappingUtcRange(
  DateTime utcStart,
  DateTime utcEnd,
  BookingConfig config,
) sync* {
  var day = hostDateFromUtcInstant(utcStart, config);
  final lastDay = hostDateFromUtcInstant(utcEnd.subtract(const Duration(milliseconds: 1)), config);
  while (!day.isAfter(lastDay)) {
    yield day;
    day = day.add(const Duration(days: 1));
  }
}

List<DateTime> candidateSlotsInUtcRange({
  required DateTime utcStart,
  required DateTime utcEnd,
  required BookingConfig config,
  required List<DateTime> Function(DateTime hostDate, BookingConfig config) generateForHostDate,
}) {
  final slots = <DateTime>[];
  for (final hostDate in hostDatesOverlappingUtcRange(utcStart, utcEnd, config)) {
    if (config.workDaysOnly && hostDate.weekday >= DateTime.saturday) continue;
    final today = _todayHost(config);
    if (hostDate.isBefore(today)) continue;
    if (hostDate.isAfter(today.add(Duration(days: config.daysAhead)))) continue;

    for (final slot in generateForHostDate(hostDate, config)) {
      final instant = slot.toUtc();
      if (!instant.isBefore(utcStart) && instant.isBefore(utcEnd)) {
        slots.add(slot);
      }
    }
  }
  return slots;
}

DateTime _todayHost(BookingConfig config) {
  final location = resolveTimeZone(config.timeZone)!;
  final now = tz.TZDateTime.from(DateTime.now().toUtc(), location);
  return DateTime.utc(now.year, now.month, now.day);
}

String todayKeyInTimeZone(String timeZoneId) => dateKeyInTimeZone(DateTime.now().toUtc(), timeZoneId);

String maxBookableDateKeyInTimeZone(BookingConfig config, String viewerTimeZoneId) {
  final location = resolveTimeZone(config.timeZone)!;
  final now = tz.TZDateTime.from(DateTime.now().toUtc(), location);
  final maxHost = tz.TZDateTime(location, now.year, now.month, now.day).add(Duration(days: config.daysAhead));
  return dateKeyInTimeZone(maxHost.toUtc(), viewerTimeZoneId);
}

/// Local wall-clock time in the booking timezone (for ICS DTSTART/DTEND).
DateTime localInstantInBookingZone(DateTime slotUtc, BookingConfig config) {
  final location = resolveTimeZone(config.timeZone)!;
  final local = tz.TZDateTime.from(slotUtc.toUtc(), location);
  return DateTime(local.year, local.month, local.day, local.hour, local.minute, local.second);
}

/// Google Calendar–style when line for invitation emails.
String formatInviteWhenLabel({
  required DateTime slotStartUtc,
  required int durationMinutes,
  required BookingConfig config,
  required String locale,
}) {
  ensureTimeZones();
  final location = resolveTimeZone(config.timeZone)!;
  final start = tz.TZDateTime.from(slotStartUtc.toUtc(), location);
  final end = start.add(Duration(minutes: durationMinutes));
  final isEs = locale == 'es';

  final weekday = isEs ? _esWeekdays[start.weekday - 1] : _enWeekdays[start.weekday - 1];
  final month = isEs ? _esMonths[start.month - 1] : _enMonths[start.month - 1];
  final offset = config.utcOffsetHours;
  final offsetLabel = offset == 0 ? 'GMT' : 'GMT${offset >= 0 ? '+' : ''}$offset';

  final startTime = _format12h(start.hour, start.minute);
  final endTime = _format12h(end.hour, end.minute);

  return '$weekday ${start.day} $month ${start.year} · $startTime – $endTime ($offsetLabel)';
}

String _format12h(int hour, int minute) {
  final h = hour % 12 == 0 ? 12 : hour % 12;
  final ampm = hour < 12 ? 'am' : 'pm';
  if (minute == 0) return '$h$ampm';
  return '$h:${minute.toString().padLeft(2, '0')}$ampm';
}

const _enWeekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
const _esWeekdays = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];
const _enMonths = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
const _esMonths = ['ene', 'feb', 'mar', 'abr', 'may', 'jun', 'jul', 'ago', 'sep', 'oct', 'nov', 'dic'];
