import 'dart:convert';

/// Builds a Google Calendar event URL that opens in the **organizer's** calendar.
///
/// Guest invite links encode `{eventId} {guestEmail}` in `eid`, which only works
/// for that guest. The host needs `{eventId} {organizerEmail}` (or calendar id).
String buildOrganizerCalendarEventLink({
  required String eventId,
  required String calendarId,
  required String organizerEmail,
  String? timeZone,
}) {
  final resolvedCalendar = calendarId == 'primary' || calendarId.isEmpty ? organizerEmail : calendarId;
  final eid = base64.encode(utf8.encode('$eventId $resolvedCalendar')).replaceAll('=', '');

  return Uri(
    scheme: 'https',
    host: 'calendar.google.com',
    path: '/calendar/event',
    queryParameters: {
      'action': 'VIEW',
      'eid': eid,
      if (timeZone != null && timeZone.isNotEmpty) 'ctz': timeZone,
    },
  ).toString();
}
