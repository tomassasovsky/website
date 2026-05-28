import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

var _timeZonesInitialized = false;

void _ensureTimeZones() {
  if (_timeZonesInitialized) return;
  tz_data.initializeTimeZones();
  _timeZonesInitialized = true;
}

String normalizeTimeZoneId(String id) {
  final trimmed = id.trim();
  if (trimmed == 'UTC') return 'Etc/UTC';
  return trimmed;
}

/// Server/VM-safe fallbacks for booking date-time labels (SSR).
String detectBrowserTimeZone(String fallback) => fallback;

/// Canonical booking timezone label: `(GMT±HH:MM) Name`.
String formatTimeZoneLabel(String timeZoneId, String locale) {
  final id = normalizeTimeZoneId(timeZoneId);
  return composeTimeZoneLabel(
    formatTimeZoneOffset(id),
    humanizeTimeZoneId(id),
  );
}

String composeTimeZoneLabel(String offset, String name) => '($offset) $name';

/// Always `GMT±HH:MM` with two-digit hours and minutes (e.g. `GMT-05:00`, `GMT+05:30`).
String formatTimeZoneOffset(String timeZoneId) {
  _ensureTimeZones();
  try {
    final location = tz.getLocation(timeZoneId);
    final offset = tz.TZDateTime.now(location).timeZoneOffset;
    final totalMinutes = offset.inMinutes;
    final sign = totalMinutes < 0 ? '-' : '+';
    final absMinutes = totalMinutes.abs();
    final hours = absMinutes ~/ 60;
    final minutes = absMinutes % 60;
    return 'GMT$sign${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  } catch (_) {
    return 'GMT+00:00';
  }
}

String humanizeTimeZoneId(String id) {
  if (id == 'Etc/UTC') return 'UTC';
  final segment = id.split('/').last;
  return segment.replaceAll('_', ' ');
}

DateTime parseSlotInstant(String iso) => DateTime.parse(iso).toUtc();

String formatTimeInTimeZone(DateTime instant, String timeZoneId, String locale) => _fallbackTime(instant, locale);

String formatDateInTimeZone(DateTime instant, String timeZoneId, String locale) => _formatDateFallback(instant, locale);

String formatMonthInLocale(int year, int month, String locale) {
  if (locale.startsWith('es')) {
    const months = [
      'ENERO',
      'FEBRERO',
      'MARZO',
      'ABRIL',
      'MAYO',
      'JUNIO',
      'JULIO',
      'AGOSTO',
      'SEPTIEMBRE',
      'OCTUBRE',
      'NOVIEMBRE',
      'DICIEMBRE',
    ];
    return months[month - 1];
  }
  const months = [
    'JANUARY',
    'FEBRUARY',
    'MARCH',
    'APRIL',
    'MAY',
    'JUNE',
    'JULY',
    'AUGUST',
    'SEPTEMBER',
    'OCTOBER',
    'NOVEMBER',
    'DECEMBER',
  ];
  return months[month - 1];
}

List<String> formatShortWeekdayLabels(String locale) {
  if (locale.startsWith('es')) {
    return ['DOM', 'LUN', 'MAR', 'MIÉ', 'JUE', 'VIE', 'SÁB'];
  }
  return ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
}

String formatDateKeyInTimeZone(String dateKey, String timeZoneId, String locale) {
  final parts = dateKey.split('-').map(int.parse).toList();
  return _formatDateFallback(DateTime.utc(parts[0], parts[1], parts[2]), locale);
}

String _fallbackTime(DateTime instant, String locale) {
  final hour = instant.hour;
  final minute = instant.minute;
  if (locale.startsWith('es')) {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
  final period = hour >= 12 ? 'pm' : 'am';
  final h12 = hour % 12 == 0 ? 12 : hour % 12;
  return minute == 0 ? '$h12:00$period' : '$h12:${minute.toString().padLeft(2, '0')}$period';
}

String capitalizeBookingDateLabel(String label, String locale) {
  if (!locale.startsWith('es')) return label;

  final comma = label.indexOf(', ');
  if (comma == -1) return _capitalizeWord(label);

  final weekday = _capitalizeWord(label.substring(0, comma));
  final rest = label.substring(comma + 2);

  final deIndex = rest.indexOf(' de ');
  if (deIndex == -1) return '$weekday, ${_capitalizeWord(rest)}';

  final dayPart = rest.substring(0, deIndex);
  final monthPart = rest.substring(deIndex + 4);
  return '$weekday, $dayPart de ${_capitalizeWord(monthPart)}';
}

String _capitalizeWord(String word) {
  if (word.isEmpty) return word;
  return word[0].toUpperCase() + word.substring(1);
}

String _formatDateFallback(DateTime date, String locale) {
  final weekday = date.weekday;
  if (locale.startsWith('es')) {
    const days = ['lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado', 'domingo'];
    const months = [
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre',
    ];
    return capitalizeBookingDateLabel(
      '${days[weekday - 1]}, ${date.day} de ${months[date.month - 1]}',
      locale,
    );
  }
  const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  const months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  return '${days[weekday - 1]}, ${months[date.month - 1]} ${date.day}';
}
