import 'dart:js_interop';

import 'booking_tz_format_stub.dart' as stub;

@JS('Intl.DateTimeFormat')
extension type IntlDateTimeFormat._(JSObject _) implements JSObject {
  external factory IntlDateTimeFormat([JSString? locales, JSAny? options]);
  external JSString format(JSDate date);
  external JSArray<JSObject> formatToParts(JSDate date);
  external IntlResolvedOptions resolvedOptions();
}

extension type IntlDateTimeFormatPart._(JSObject _) implements JSObject {
  external JSString get type;
  external JSString get value;
}

extension type IntlResolvedOptions._(JSObject _) implements JSObject {
  external JSString get timeZone;
}

@JS('Date')
extension type JSDate._(JSObject _) implements JSObject {
  external factory JSDate(JSAny? value);
}

/// Reads the browser's IANA timezone (e.g. `America/New_York`).
String detectBrowserTimeZone(String fallback) {
  try {
    final timeZone = IntlDateTimeFormat().resolvedOptions().timeZone.toDart;
    if (timeZone.isNotEmpty) return timeZone;
  } catch (_) {}
  return fallback;
}

DateTime parseSlotInstant(String iso) => stub.parseSlotInstant(iso);

String formatTimeZoneLabel(String timeZoneId, String locale) {
  final id = stub.normalizeTimeZoneId(timeZoneId);
  final offset = stub.formatTimeZoneOffset(id);
  try {
    final now = JSDate(DateTime.now().millisecondsSinceEpoch.toJS);
    final name = _timeZoneNamePart(now, locale, id, 'longGeneric') ?? _timeZoneNamePart(now, locale, id, 'long');
    if (name != null) {
      return stub.composeTimeZoneLabel(offset, name);
    }
  } catch (_) {}
  return stub.formatTimeZoneLabel(id, locale);
}

String? _timeZoneNamePart(JSDate date, String locale, String timeZoneId, String timeZoneNameStyle) {
  final formatter = IntlDateTimeFormat(
    locale.toJS,
    {
      'timeZone': timeZoneId,
      'timeZoneName': timeZoneNameStyle,
    }.jsify(),
  );
  for (final part in formatter.formatToParts(date).toDart) {
    final typed = part as IntlDateTimeFormatPart;
    if (typed.type.toDart == 'timeZoneName') {
      final value = typed.value.toDart;
      if (value.isNotEmpty) return value;
    }
  }
  return null;
}

String formatTimeInTimeZone(DateTime instant, String timeZoneId, String locale) {
  try {
    final formatter = IntlDateTimeFormat(
      locale.toJS,
      {
        'hour': 'numeric',
        'minute': '2-digit',
        'timeZone': timeZoneId,
      }.jsify(),
    );
    return formatter.format(JSDate(instant.millisecondsSinceEpoch.toJS)).toDart;
  } catch (_) {
    return stub.formatTimeInTimeZone(instant, timeZoneId, locale);
  }
}

String formatDateInTimeZone(DateTime instant, String timeZoneId, String locale) {
  try {
    final formatter = IntlDateTimeFormat(
      locale.toJS,
      {
        'weekday': 'long',
        'month': 'long',
        'day': 'numeric',
        'timeZone': timeZoneId,
      }.jsify(),
    );
    return stub.capitalizeBookingDateLabel(
      formatter.format(JSDate(instant.millisecondsSinceEpoch.toJS)).toDart,
      locale,
    );
  } catch (_) {
    return stub.formatDateInTimeZone(instant, timeZoneId, locale);
  }
}

String formatMonthInLocale(int year, int month, String locale) {
  try {
    final formatter = IntlDateTimeFormat(
      locale.toJS,
      {'month': 'long'}.jsify(),
    );
    final label = formatter.format(JSDate(DateTime.utc(year, month, 15).millisecondsSinceEpoch.toJS)).toDart;
    return label.toUpperCase();
  } catch (_) {
    return stub.formatMonthInLocale(year, month, locale);
  }
}

List<String> formatShortWeekdayLabels(String locale) {
  try {
    final formatter = IntlDateTimeFormat(
      locale.toJS,
      {'weekday': 'short', 'timeZone': 'UTC'}.jsify(),
    );
    return [
      for (var day = 7; day <= 13; day++)
        formatter.format(JSDate(DateTime.utc(2024, 1, day).millisecondsSinceEpoch.toJS)).toDart.toUpperCase(),
    ];
  } catch (_) {
    return stub.formatShortWeekdayLabels(locale);
  }
}

String formatDateKeyInTimeZone(String dateKey, String timeZoneId, String locale) {
  final parts = dateKey.split('-').map(int.parse).toList();
  return formatDateInTimeZone(
    DateTime.utc(parts[0], parts[1], parts[2], 12),
    timeZoneId,
    locale,
  );
}
