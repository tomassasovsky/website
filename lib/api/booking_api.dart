import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart';
import 'package:timezone/timezone.dart' as tz;

import 'api_utils.dart';
import 'booking_busy_cache.dart';
import 'booking_config.dart';
import 'booking_copy.dart';
import 'booking_log.dart';
import 'gmail_send.dart';
import 'google_calendar_links.dart';
import 'text_encoding.dart';
import 'tz_utils.dart';

import '../data/site_data.dart';

final _rateLimit = <String, DateTime>{};
const _rateLimitWindow = Duration(seconds: 30);
var _loggedConfig = false;

Middleware get bookingApiMiddleware {
  return (Handler inner) {
    return (Request request) async {
      final path = request.requestedUri.path;
      if (request.method == 'OPTIONS' && path.startsWith('/api/booking')) {
        return Response.ok('', headers: _corsHeaders);
      }
      if (request.method == 'GET' && path == '/api/booking/availability') {
        return _handleAvailability(request);
      }
      if (request.method == 'GET' && path == '/api/booking/month') {
        return _handleMonthAvailability(request);
      }
      if (request.method == 'POST' && path == '/api/booking') {
        return _handleBook(request);
      }
      return inner(request);
    };
  };
}

const _jsonHeaders = {'content-type': 'application/json; charset=utf-8'};
const _corsHeaders = {'access-control-allow-origin': '*', 'access-control-allow-headers': 'content-type'};

void _logConfigOnce(BookingConfig config) {
  if (_loggedConfig) return;
  _loggedConfig = true;
  bookingLog(
    'Config: calendar=${config.calendarId}, tz=${config.timeZone}, '
    'offset=${config.utcOffsetHours}, duration=${config.durationMinutes}min, '
    'hours=${config.startHour}-${config.endHour}, daysAhead=${config.daysAhead}, '
    'minNotice=${config.minNoticeMinutes}min, '
    'workDaysOnly=${config.workDaysOnly}, googleConfigured=${config.hasGoogleCredentials}',
  );
  if (!config.hasGoogleCredentials) {
    bookingWarn('Missing env vars: ${config.missingGoogleCredentials.join(', ')}');
  }
}

Response _errorResponse(int status, String error, {Object? detail, Map<String, String>? headers}) {
  final merged = {..._jsonHeaders, ..._corsHeaders, ...?headers};
  final body = <String, dynamic>{'error': error};
  final debugDetail = detail == null ? null : bookingErrorDetail(detail);
  if (debugDetail != null) body['detail'] = debugDetail;
  return Response(status, body: jsonEncode(body), headers: merged);
}

Future<Response> _handleAvailability(Request request) async {
  final headers = {..._jsonHeaders, ..._corsHeaders};
  final dateStr = request.requestedUri.queryParameters['date'];
  final viewerTzParam = request.requestedUri.queryParameters['timezone'];
  bookingLog('GET /api/booking/availability date=$dateStr timezone=$viewerTzParam');
  if (dateStr == null || !RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(dateStr)) {
    bookingWarn('Invalid date parameter: $dateStr');
    return Response.badRequest(body: '{"error":"Invalid date"}', headers: headers);
  }

  final parts = dateStr.split('-').map(int.parse).toList();
  final config = BookingConfig.fromEnv();
  _logConfigOnce(config);
  ensureTimeZones();
  final viewerTz = normalizeViewerTimeZone(viewerTzParam, config);

  try {
    final utcStart = utcRangeStartForLocalDate(parts[0], parts[1], parts[2], viewerTz);
    final utcEnd = utcRangeEndForLocalDate(parts[0], parts[1], parts[2], viewerTz);
    final candidates = candidateSlotsInUtcRange(
      utcStart: utcStart,
      utcEnd: utcEnd,
      config: config,
      generateForHostDate: _generateCandidateSlots,
    );
    bookingLog('Date $dateStr ($viewerTz): ${candidates.length} candidate slot(s)');
    final available = await _filterAvailableSlots(candidates, config);
    bookingLog('Date $dateStr ($viewerTz): ${available.length} available slot(s) after freeBusy');

    final slots = available.map((slot) => {'start': _toOffsetIso(slot, config.utcOffsetHours)}).toList();

    return Response.ok(
      jsonEncode({
        ..._viewerMeta(config, viewerTz),
        'slots': slots,
      }),
      headers: headers,
    );
  } catch (e, st) {
    bookingError('availability failed for $dateStr', e, st);
    return _errorResponse(500, 'Failed to load availability', detail: e, headers: headers);
  }
}

Future<Response> _handleMonthAvailability(Request request) async {
  final headers = {..._jsonHeaders, ..._corsHeaders};
  final year = int.tryParse(request.requestedUri.queryParameters['year'] ?? '');
  final month = int.tryParse(request.requestedUri.queryParameters['month'] ?? '');
  final viewerTzParam = request.requestedUri.queryParameters['timezone'];
  final findFirst = request.requestedUri.queryParameters['findFirst'] == 'true';
  bookingLog('GET /api/booking/month year=$year month=$month timezone=$viewerTzParam findFirst=$findFirst');
  if (year == null || month == null || month < 1 || month > 12) {
    bookingWarn('Invalid month parameters: year=$year month=$month');
    return Response.badRequest(body: '{"error":"Invalid year or month"}', headers: headers);
  }

  final config = BookingConfig.fromEnv();
  _logConfigOnce(config);
  ensureTimeZones();
  final viewerTz = normalizeViewerTimeZone(viewerTzParam, config);

  try {
    if (findFirst) {
      return _handleFindFirstMonth(year: year, month: month, viewerTz: viewerTz, config: config, headers: headers);
    }

    final monthPrefix = '$year-${month.toString().padLeft(2, '0')}';
    final utcStart = utcRangeStartForLocalMonth(year, month, viewerTz);
    final utcEnd = utcRangeEndForLocalMonth(year, month, viewerTz);
    final candidates = candidateSlotsInUtcRange(
      utcStart: utcStart,
      utcEnd: utcEnd,
      config: config,
      generateForHostDate: _generateCandidateSlots,
    );
    bookingLog('Month $monthPrefix ($viewerTz): ${candidates.length} candidate slot(s)');

    final available = await _filterAvailableSlots(candidates, config);
    final dates =
        available
            .map((slot) => dateKeyInTimeZone(slot.toUtc(), viewerTz))
            .where((key) => key.startsWith(monthPrefix))
            .toSet()
            .toList()
          ..sort();
    bookingLog('Month $monthPrefix ($viewerTz): ${dates.length} available date(s): ${dates.join(', ')}');
    return Response.ok(
      jsonEncode({
        ..._viewerMeta(config, viewerTz),
        'year': year,
        'month': month,
        'dates': dates,
      }),
      headers: headers,
    );
  } catch (e, st) {
    bookingError('month availability failed for $year-$month', e, st);
    return _errorResponse(500, 'Failed to load availability', detail: e, headers: headers);
  }
}

Future<Response> _handleFindFirstMonth({
  required int year,
  required int month,
  required String viewerTz,
  required BookingConfig config,
  required Map<String, String> headers,
}) async {
  final window = _bookableWindowUtc(config);
  final candidates = candidateSlotsInUtcRange(
    utcStart: window.start,
    utcEnd: window.end,
    config: config,
    generateForHostDate: _generateCandidateSlots,
  );
  bookingLog('findFirst ($viewerTz): ${candidates.length} candidate slot(s) in bookable window');

  final available = await _filterAvailableSlots(candidates, config);
  final datesByMonth = <String, Set<String>>{};
  for (final slot in available) {
    final dateKey = dateKeyInTimeZone(slot.toUtc(), viewerTz);
    final monthKey = dateKey.substring(0, 7);
    datesByMonth.putIfAbsent(monthKey, () => {}).add(dateKey);
  }

  var probeYear = year;
  var probeMonth = month;
  for (var attempt = 0; attempt < 24; attempt++) {
    final monthPrefix = '$probeYear-${probeMonth.toString().padLeft(2, '0')}';
    final monthDates = datesByMonth[monthPrefix];
    if (monthDates != null && monthDates.isNotEmpty) {
      final dates = monthDates.toList()..sort();
      bookingLog('findFirst ($viewerTz): first available month $monthPrefix (${dates.length} date(s))');
      return Response.ok(
        jsonEncode({
          ..._viewerMeta(config, viewerTz),
          'year': probeYear,
          'month': probeMonth,
          'dates': dates,
        }),
        headers: headers,
      );
    }

    if (_isAtOrPastLastBookableMonth(probeYear, probeMonth, config, viewerTz)) break;
    final next = _shiftCalendarMonth(probeYear, probeMonth, 1);
    probeYear = next.$1;
    probeMonth = next.$2;
  }

  bookingLog('findFirst ($viewerTz): no available dates in bookable window');
  return Response.ok(
    jsonEncode({
      ..._viewerMeta(config, viewerTz),
      'year': probeYear,
      'month': probeMonth,
      'dates': <String>[],
    }),
    headers: headers,
  );
}

Map<String, dynamic> _viewerMeta(BookingConfig config, String viewerTz) => {
  'timezone': viewerTz,
  'hostTimezone': config.timeZone,
  'today': todayKeyInTimeZone(viewerTz),
  'maxDate': maxBookableDateKeyInTimeZone(config, viewerTz),
  'hostStartHour': config.startHour,
  'hostEndHour': config.endHour,
  'minNoticeMinutes': config.minNoticeMinutes,
};

Future<Response> _handleBook(Request request) async {
  final headers = {..._jsonHeaders, ..._corsHeaders};

  pruneRateLimit(_rateLimit, _rateLimitWindow);
  final ip = extractClientIp(request);
  final last = _rateLimit[ip];
  if (last != null && DateTime.now().difference(last) < _rateLimitWindow) {
    bookingWarn('Rate limited booking request from $ip');
    return Response(429, body: '{"error":"Too many requests. Please wait before trying again."}', headers: headers);
  }

  Map<String, dynamic> data;
  try {
    final body = await request.readAsString();
    if (body.length > 5000) {
      bookingWarn('Booking request too large (${body.length} bytes) from $ip');
      return Response(413, body: '{"error":"Request too large"}', headers: headers);
    }
    data = jsonDecode(body) as Map<String, dynamic>;
  } catch (e) {
    bookingWarn('Invalid JSON body from $ip: $e');
    return Response.badRequest(body: '{"error":"Invalid JSON body"}', headers: headers);
  }

  if ((data['website'] as String? ?? '').trim().isNotEmpty) {
    bookingLog('Honeypot triggered — silently succeeding');
    return Response.ok('{"success":true}', headers: headers);
  }

  final name = normalizeUserText(data['name'] as String? ?? '');
  final email = normalizeUserText(data['email'] as String? ?? '').toLowerCase();
  final slotStart = (data['slotStart'] as String? ?? '').trim();
  final notes = normalizeUserText(data['notes'] as String? ?? '', multiline: true);
  final locale = normalizeBookingLocale(data['locale'] as String?);

  bookingLog(
    'POST /api/booking slot=$slotStart guest=${redactEmail(email)} '
    'nameLen=${name.length} notesLen=${notes.length} ip=$ip',
  );

  if (name.isEmpty || email.isEmpty || slotStart.isEmpty) {
    bookingWarn('Missing required fields (name/email/slotStart)');
    return Response.badRequest(body: '{"error":"Name, email, and time slot are required"}', headers: headers);
  }
  if (name.length > 100 || email.length > 200 || notes.length > 1000) {
    bookingWarn('Input too long');
    return Response.badRequest(body: '{"error":"Input too long"}', headers: headers);
  }
  if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email)) {
    bookingWarn('Invalid email format: ${redactEmail(email)}');
    return Response.badRequest(body: '{"error":"Invalid email address"}', headers: headers);
  }

  final config = BookingConfig.fromEnv();
  _logConfigOnce(config);
  final slot = _parseOffsetIso(slotStart, config.utcOffsetHours);
  if (slot == null) {
    bookingWarn(
      'Could not parse slotStart="$slotStart" with expected offset ${config.utcOffsetHours}',
    );
    return _errorResponse(
      400,
      'Invalid time slot',
      detail: 'Expected offset ${config.utcOffsetHours}, got: $slotStart',
      headers: headers,
    );
  }

  final today = _todayUtc(config);
  if (slot.isBefore(today) || slot.isAfter(today.add(Duration(days: config.daysAhead + 1)))) {
    bookingWarn('Slot out of booking window: parsed=$slot today=$today daysAhead=${config.daysAhead}');
    return Response.badRequest(body: '{"error":"Time slot is not available"}', headers: headers);
  }

  final earliestBookable = DateTime.now().toUtc().add(Duration(minutes: config.minNoticeMinutes));
  if (!slot.isAfter(earliestBookable)) {
    bookingWarn(
      'Slot too soon: parsed=$slot earliest=$earliestBookable minNotice=${config.minNoticeMinutes}min',
    );
    return Response.badRequest(body: '{"error":"That time is too soon. Please pick a later slot."}', headers: headers);
  }

  try {
    if (config.hasGoogleCredentials) {
      bookingLog('Checking slot availability before booking …');
      final stillAvailable = await _isSlotAvailable(slot, config);
      if (!stillAvailable) {
        bookingWarn('Slot no longer available: $slotStart');
        return Response(
          409,
          body: '{"error":"That time slot was just booked. Please pick another."}',
          headers: headers,
        );
      }

      bookingLog('Creating calendar event …');
      final created = await _createCalendarEvent(
        name: name,
        email: email,
        notes: notes,
        slotStart: slot,
        config: config,
        copy: BookingCopy.forLocale(locale),
      );
      await _sendHostCalendarInvite(
        guestName: name,
        guestEmail: email,
        notes: notes,
        slotStart: slot,
        config: config,
        copy: BookingCopy.forLocale(locale),
        created: created,
      );
      _rateLimit[ip] = DateTime.now();
      BookingBusyCache.invalidateBusy();
      bookingLog(
        'Booking succeeded for $slotStart guest=${redactEmail(email)} meetLink=${created.meetLink ?? '(none)'}',
      );
      return Response.ok(jsonEncode({'success': true, 'meetLink': created.meetLink}), headers: headers);
    }

    bookingWarn(
      'Google credentials not configured — booking logged but no event created. '
      'Missing: ${config.missingGoogleCredentials.join(', ')}',
    );
    stderr.writeln(
      '[booking] (no credentials) $name <${redactEmail(email)}> at $slotStart${notes.isEmpty ? '' : ' — $notes'}',
    );
    _rateLimit[ip] = DateTime.now();
    return Response.ok('{"success":true}', headers: headers);
  } catch (e, st) {
    bookingError('book failed for $slotStart guest=${redactEmail(email)}', e, st);
    return _errorResponse(500, 'Failed to book meeting. Please try again later.', detail: e, headers: headers);
  }
}

DateTime _todayUtc(BookingConfig config) {
  final now = DateTime.now().toUtc().add(Duration(hours: config.utcOffsetHours));
  return DateTime.utc(now.year, now.month, now.day);
}

List<DateTime> _generateCandidateSlots(DateTime date, BookingConfig config) {
  final lastStartMinutes = config.endHour * 60 - config.durationMinutes;
  if (lastStartMinutes < config.startHour * 60) return [];

  final earliestBookable = DateTime.now().toUtc().add(Duration(minutes: config.minNoticeMinutes));

  final slots = <DateTime>[];
  for (var minutes = config.startHour * 60; minutes <= lastStartMinutes; minutes += config.durationMinutes) {
    final hour = minutes ~/ 60;
    final minute = minutes % 60;
    final slotUtc = DateTime.utc(date.year, date.month, date.day, hour - config.utcOffsetHours, minute);
    if (!slotUtc.isAfter(earliestBookable)) continue;
    slots.add(slotUtc);
  }
  return slots;
}

Future<List<DateTime>> _filterAvailableSlots(List<DateTime> candidates, BookingConfig config) async {
  if (candidates.isEmpty) return [];
  if (!config.hasGoogleCredentials) return candidates;

  final queryStart = candidates.first.toUtc();
  final queryEnd = candidates.last.toUtc().add(Duration(minutes: config.durationMinutes));
  final busy = await _busyIntervalsForRange(
    config: config,
    timeMin: queryStart,
    timeMax: queryEnd,
  );

  final available = candidates.where((slot) {
    final slotEnd = slot.add(Duration(minutes: config.durationMinutes));
    return !busy.any((b) => slot.isBefore(b.end) && slotEnd.isAfter(b.start));
  }).toList();

  bookingLog('freeBusy filtered ${candidates.length} → ${available.length} slot(s), ${busy.length} busy interval(s)');
  return available;
}

Future<bool> _isSlotAvailable(DateTime slot, BookingConfig config) async {
  if (!config.hasGoogleCredentials) return true;

  final slotEnd = slot.add(Duration(minutes: config.durationMinutes));
  final busy = await _busyIntervalsForRange(
    config: config,
    timeMin: slot.toUtc(),
    timeMax: slotEnd.toUtc(),
  );
  bookingLog('Slot ${_toOffsetIso(slot, config.utcOffsetHours)} busy intervals: ${busy.length}');
  return !busy.any((b) => slot.isBefore(b.end) && slotEnd.isAfter(b.start));
}

Future<List<BusyInterval>> _busyIntervalsForRange({
  required BookingConfig config,
  required DateTime timeMin,
  required DateTime timeMax,
}) async {
  final cached = BookingBusyCache.busyIntervalsCovering(
    config: config,
    timeMin: timeMin,
    timeMax: timeMax,
  );
  if (cached != null) {
    bookingLog('freeBusy cache hit (${cached.length} interval(s))');
    return cached;
  }

  final window = _bookableWindowUtc(config);
  return _fetchAndCacheBusyIntervals(
    config: config,
    timeMin: window.start,
    timeMax: window.end,
  );
}

Future<List<BusyInterval>> _fetchAndCacheBusyIntervals({
  required BookingConfig config,
  required DateTime timeMin,
  required DateTime timeMax,
}) async {
  final accessToken = await BookingBusyCache.accessToken();
  if (accessToken == null) {
    bookingLog('No access token — treating calendar as free');
    return [];
  }

  final payload = {
    'timeMin': timeMin.toUtc().toIso8601String(),
    'timeMax': timeMax.toUtc().toIso8601String(),
    'timeZone': config.timeZone,
    'items': [
      {'id': config.calendarId},
    ],
  };
  bookingLog(
    'freeBusy query calendar=${config.calendarId} '
    'from=${payload['timeMin']} to=${payload['timeMax']} tz=${config.timeZone}',
  );

  final resp = await http.post(
    Uri.parse('https://www.googleapis.com/calendar/v3/freeBusy'),
    headers: {
      'authorization': 'Bearer $accessToken',
      'content-type': 'application/json',
    },
    body: jsonEncode(payload),
  );
  if (resp.statusCode != 200) {
    bookingError('freeBusy failed (${resp.statusCode})', resp.body);
    throw Exception('freeBusy failed (${resp.statusCode}): ${resp.body}');
  }

  final body = jsonDecode(resp.body) as Map<String, dynamic>;
  final calendars = body['calendars'] as Map<String, dynamic>? ?? {};
  final calendar = calendars[config.calendarId] as Map<String, dynamic>? ?? {};
  final busyList = calendar['busy'] as List<dynamic>? ?? [];

  if (calendar.isEmpty && calendars.isNotEmpty) {
    bookingWarn(
      'freeBusy returned no data for calendar id "${config.calendarId}". '
      'Response keys: ${calendars.keys.join(', ')}',
    );
  }

  final intervals = busyList.map((entry) {
    final map = entry as Map<String, dynamic>;
    return BusyInterval(
      start: DateTime.parse(map['start'] as String).toUtc(),
      end: DateTime.parse(map['end'] as String).toUtc(),
    );
  }).toList();

  BookingBusyCache.storeBusy(
    calendarId: config.calendarId,
    windowStart: timeMin,
    windowEnd: timeMax,
    intervals: intervals,
  );
  return intervals;
}

({DateTime start, DateTime end}) _bookableWindowUtc(BookingConfig config) {
  ensureTimeZones();
  final location = resolveTimeZone(config.timeZone)!;
  final now = tz.TZDateTime.from(DateTime.now().toUtc(), location);
  final today = DateTime.utc(now.year, now.month, now.day);
  final maxHostDay = today.add(Duration(days: config.daysAhead));
  final windowEnd = tz.TZDateTime(
    location,
    maxHostDay.year,
    maxHostDay.month,
    maxHostDay.day,
  ).add(const Duration(days: 1)).toUtc();
  final windowStart = DateTime.now().toUtc().add(Duration(minutes: config.minNoticeMinutes));
  return (start: windowStart, end: windowEnd);
}

bool _isAtOrPastLastBookableMonth(int year, int month, BookingConfig config, String viewerTz) {
  final maxKey = maxBookableDateKeyInTimeZone(config, viewerTz);
  final parts = maxKey.split('-').map(int.parse).toList();
  return year > parts[0] || (year == parts[0] && month >= parts[1]);
}

(int, int) _shiftCalendarMonth(int year, int month, int delta) {
  var y = year;
  var m = month + delta;
  while (m < 1) {
    m += 12;
    y--;
  }
  while (m > 12) {
    m -= 12;
    y++;
  }
  return (y, m);
}

Future<_CreatedCalendarEvent> _createCalendarEvent({
  required String name,
  required String email,
  required String notes,
  required DateTime slotStart,
  required BookingConfig config,
  required BookingCopy copy,
}) async {
  final accessToken = await BookingBusyCache.accessToken();
  if (accessToken == null) return const _CreatedCalendarEvent();

  final slotEnd = slotStart.add(Duration(minutes: config.durationMinutes));
  final requestId = '${DateTime.now().millisecondsSinceEpoch}-${Random().nextInt(1 << 32)}';

  final description = copy.eventDescription(name: name, email: email, notes: notes);

  final eventPayload = {
    'summary': copy.eventSummary(name),
    'description': description,
    'start': {
      'dateTime': _toOffsetIso(slotStart, config.utcOffsetHours),
      'timeZone': config.timeZone,
    },
    'end': {
      'dateTime': _toOffsetIso(slotEnd, config.utcOffsetHours),
      'timeZone': config.timeZone,
    },
    'attendees': [
      {'email': email, 'displayName': name},
    ],
    'conferenceData': {
      'createRequest': {
        'requestId': requestId,
        'conferenceSolutionKey': {'type': 'hangoutsMeet'},
      },
    },
    'reminders': {
      'useDefault': true,
    },
  };

  bookingLog(
    'events.insert calendar=${config.calendarId} sendUpdates=all '
    'start=${(eventPayload['start'] as Map)['dateTime']} end=${(eventPayload['end'] as Map)['dateTime']}',
  );

  final resp = await http.post(
    Uri.parse(
      'https://www.googleapis.com/calendar/v3/calendars/${Uri.encodeComponent(config.calendarId)}/events'
      '?conferenceDataVersion=1&sendUpdates=all',
    ),
    headers: {
      'authorization': 'Bearer $accessToken',
      'content-type': 'application/json',
    },
    body: jsonEncode(eventPayload),
  );
  if (resp.statusCode != 200) {
    bookingError('event create failed (${resp.statusCode})', resp.body);
    throw Exception('event create failed (${resp.statusCode}): ${resp.body}');
  }

  final event = jsonDecode(resp.body) as Map<String, dynamic>;
  final eventId = event['id'] as String?;
  final htmlLink = event['htmlLink'] as String?;
  bookingLog('Event created id=$eventId link=$htmlLink');

  final entryPoints = (event['conferenceData'] as Map<String, dynamic>?)?['entryPoints'] as List<dynamic>?;
  final meetUri = entryPoints
      ?.cast<Map<String, dynamic>>()
      .where((e) => e['entryPointType'] == 'video')
      .map((e) => e['uri'] as String?)
      .firstWhere((u) => u != null, orElse: () => null);
  if (meetUri == null) {
    bookingWarn('Event created but no Google Meet link in response');
  }
  return _CreatedCalendarEvent(
    eventId: eventId,
    meetLink: meetUri,
    summary: event['summary'] as String? ?? copy.eventSummary(name),
  );
}

Future<void> _sendHostCalendarInvite({
  required String guestName,
  required String guestEmail,
  required String notes,
  required DateTime slotStart,
  required BookingConfig config,
  required BookingCopy copy,
  required _CreatedCalendarEvent created,
}) async {
  final hostEmail = notificationEmail ?? organizerEmail;
  if (hostEmail == null || hostEmail.isEmpty) {
    bookingWarn('Host booking notification skipped — no notification email configured');
    return;
  }
  if (hostEmail.toLowerCase() == guestEmail.toLowerCase()) {
    bookingLog('Host booking notification skipped — host and guest share the same inbox');
    return;
  }
  if (created.eventId == null || created.eventId!.isEmpty) {
    bookingWarn('Host booking notification skipped — event has no id');
    return;
  }

  final organizer = organizerEmail ?? hostEmail;
  final whenLabel = formatInviteWhenLabel(
    slotStartUtc: slotStart,
    durationMinutes: config.durationMinutes,
    config: config,
    locale: copy.locale,
  );
  final summary = created.summary ?? copy.eventSummary(guestName);
  final calendarLink = buildOrganizerCalendarEventLink(
    eventId: created.eventId!,
    calendarId: config.calendarId,
    organizerEmail: organizer,
    timeZone: config.timeZone,
  );

  final subject = copy.hostNotificationSubject(
    summary: summary,
    whenLabel: whenLabel,
    guestEmail: guestEmail,
  );
  final plainBody = copy.hostInvitePlainBody(
    summary: summary,
    whenLabel: whenLabel,
    guestName: guestName,
    guestEmail: guestEmail,
    organizerName: siteName,
    organizerEmail: organizer,
    meetLink: created.meetLink,
    calendarLink: calendarLink,
  );
  final htmlBody = copy.hostNotificationHtmlBody(
    summary: summary,
    whenLabel: whenLabel,
    guestName: guestName,
    guestEmail: guestEmail,
    organizerName: siteName,
    organizerEmail: organizer,
    meetLink: created.meetLink,
    calendarLink: calendarLink,
    notes: notes.isEmpty ? null : notes,
  );

  try {
    await sendHtmlNotificationEmail(
      to: hostEmail,
      subject: subject,
      plainBody: plainBody,
      htmlBody: htmlBody,
      replyToName: guestName,
      replyToEmail: guestEmail,
    );
    bookingLog('Host booking notification sent to ${redactEmail(hostEmail)} link=$calendarLink');
  } catch (e, st) {
    bookingWarn('Host booking notification failed: $e\n$st');
  }
}

class _CreatedCalendarEvent {
  const _CreatedCalendarEvent({
    this.eventId,
    this.meetLink,
    this.summary,
  });

  final String? eventId;
  final String? meetLink;
  final String? summary;
}

String _toOffsetIso(DateTime utcSlot, int offsetHours) {
  final local = utcSlot.toUtc().add(Duration(hours: offsetHours));
  final sign = offsetHours >= 0 ? '+' : '-';
  final abs = offsetHours.abs().toString().padLeft(2, '0');
  final y = local.year.toString().padLeft(4, '0');
  final mo = local.month.toString().padLeft(2, '0');
  final d = local.day.toString().padLeft(2, '0');
  final h = local.hour.toString().padLeft(2, '0');
  final mi = local.minute.toString().padLeft(2, '0');
  return '$y-$mo-${d}T$h:$mi:00$sign$abs:00';
}

DateTime? _parseOffsetIso(String value, int expectedOffsetHours) {
  final match = RegExp(r'^(\d{4}-\d{2}-\d{2})T(\d{2}):(\d{2}):00([+-]\d{2}):00$').firstMatch(value);
  if (match == null) return null;

  final offset = int.parse(match.group(4)!);
  if (offset != expectedOffsetHours) return null;

  final y = int.parse(match.group(1)!.substring(0, 4));
  final mo = int.parse(match.group(1)!.substring(5, 7));
  final d = int.parse(match.group(1)!.substring(8, 10));
  final h = int.parse(match.group(2)!);
  final mi = int.parse(match.group(3)!);
  return DateTime.utc(y, mo, d, h - expectedOffsetHours, mi);
}
