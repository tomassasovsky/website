/// Localized copy for booking calendar events.
class BookingCopy {
  const BookingCopy._({required this.locale});

  final String locale;

  bool get _isEs => locale == 'es';

  factory BookingCopy.forLocale(String? locale) {
    final normalized = normalizeBookingLocale(locale);
    return BookingCopy._(locale: normalized);
  }

  String eventSummary(String guestName) => _isEs ? 'Reunión con $guestName' : 'Meeting with $guestName';

  String eventDescription({
    required String name,
    required String email,
    required String notes,
  }) {
    final lines = _isEs
        ? ['Reservado vía aquiles.dev', '', 'Invitado: $name', 'Email: $email']
        : ['Booked via aquiles.dev', '', 'Guest: $name', 'Email: $email'];
    if (notes.isNotEmpty) lines.addAll(['', notes]);
    return lines.join('\n');
  }

  /// Subject for the host booking notification (organizer — not a calendar invite).
  String hostNotificationSubject({
    required String summary,
    required String whenLabel,
    required String guestEmail,
  }) {
    final prefix = _isEs ? 'Nueva reserva' : 'New booking';
    return '$prefix: $summary @ $whenLabel ($guestEmail)';
  }

  /// Plain-text body similar to Google's calendar invitation email.
  String hostInvitePlainBody({
    required String summary,
    required String whenLabel,
    required String guestName,
    required String guestEmail,
    required String organizerName,
    required String organizerEmail,
    required String? meetLink,
    required String? calendarLink,
  }) {
    final lines = <String>[
      summary,
      whenLabel,
      '',
    ];

    if (meetLink != null) {
      lines.addAll(_isEs ? ['Unirse con Google Meet', meetLink, ''] : ['Join with Google Meet', meetLink, '']);
    }

    lines.addAll(_isEs ? ['Reservado vía aquiles.dev', ''] : ['Booked via aquiles.dev', '']);

    lines.addAll(
      _isEs ? ['Invitado: $guestName', 'Email: $guestEmail', ''] : ['Guest: $guestName', 'Email: $guestEmail', ''],
    );

    lines.addAll(
      _isEs ? ['Organizador', organizerName, organizerEmail, ''] : ['Organiser', organizerName, organizerEmail, ''],
    );

    lines.addAll(_isEs ? ['Invitados', guestEmail] : ['Guests', guestEmail]);

    if (calendarLink != null) {
      lines.addAll(['', _isEs ? 'Abrir en Google Calendar' : 'Open in Google Calendar', calendarLink]);
    }

    lines.addAll([
      '',
      _isEs
          ? 'Invitación de Google Calendar: https://calendar.google.com/calendar/'
          : 'Invitation from Google Calendar: https://calendar.google.com/calendar/',
    ]);

    return lines.join('\n');
  }

  /// HTML body styled like a Google Calendar notification (for the organizer).
  String hostNotificationHtmlBody({
    required String summary,
    required String whenLabel,
    required String guestName,
    required String guestEmail,
    required String organizerName,
    required String organizerEmail,
    required String? meetLink,
    required String? calendarLink,
    String? notes,
  }) {
    final meetButton = meetLink == null
        ? ''
        : '''
<p style="margin:0 0 24px;">
  <a href="${_escapeHtmlAttr(meetLink)}" style="background-color:#1a73e8;border-radius:4px;color:#ffffff;display:inline-block;font-family:Roboto,Helvetica,Arial,sans-serif;font-size:14px;font-weight:700;line-height:20px;padding:10px 25px;text-decoration:none;" target="_blank">${_isEs ? 'Unirse con Google Meet' : 'Join with Google Meet'}</a>
</p>''';

    final meetLine = meetLink == null
        ? ''
        : '''
<h2 style="color:#3c4043;font-size:14px;font-weight:700;margin:0 0 4px;">${_isEs ? 'Enlace de la reunión' : 'Meeting link'}</h2>
<p style="color:#70757a;font-size:14px;line-height:20px;margin:0 0 24px;"><a href="${_escapeHtmlAttr(meetLink)}" style="color:#70757a;text-decoration:none;">${_escapeHtml(_meetDisplay(meetLink))}</a></p>''';

    final notesBlock = notes == null || notes.isEmpty
        ? ''
        : '''
<p style="color:#3c4043;font-size:14px;line-height:20px;margin:0 0 24px;white-space:pre-wrap;">${_escapeHtml(notes)}</p>''';

    final calendarBlock = calendarLink == null
        ? ''
        : '''
<p style="margin:24px 0 0;">
  <a href="${_escapeHtmlAttr(calendarLink)}" style="color:#1a73e8;font-family:Roboto,Helvetica,Arial,sans-serif;font-size:14px;font-weight:700;text-decoration:none;" target="_blank">${_isEs ? 'Abrir en Google Calendar' : 'Open in Google Calendar'}</a>
</p>''';

    return '''
<!doctype html>
<html>
<head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"></head>
<body style="margin:0;padding:0;background-color:#ffffff;">
  <div style="font-family:Roboto,Helvetica,Arial,sans-serif;padding:16px;">
    <div style="border:1px solid #dadce0;border-radius:8px;max-width:640px;padding:24px 32px;">
      <h1 style="color:#3c4043;font-size:20px;font-weight:400;line-height:28px;margin:0 0 8px;">${_escapeHtml(summary)}</h1>
      <p style="color:#3c4043;font-size:14px;line-height:20px;margin:0 0 24px;">${_escapeHtml(whenLabel)}</p>
      $meetButton
      $meetLine
      <p style="color:#3c4043;font-size:14px;line-height:20px;margin:0 0 24px;">${_isEs ? 'Reservado vía aquiles.dev' : 'Booked via aquiles.dev'}</p>
      <h2 style="color:#3c4043;font-size:14px;font-weight:700;margin:0 0 4px;">${_isEs ? 'Invitado' : 'Guest'}</h2>
      <p style="color:#3c4043;font-size:14px;line-height:20px;margin:0 0 24px;">${_escapeHtml(guestName)}<br><a href="mailto:${_escapeHtmlAttr(guestEmail)}" style="color:#3c4043;text-decoration:none;">${_escapeHtml(guestEmail)}</a></p>
      $notesBlock
      <h2 style="color:#3c4043;font-size:14px;font-weight:700;margin:0 0 4px;">${_isEs ? 'Organizador' : 'Organiser'}</h2>
      <p style="color:#3c4043;font-size:14px;line-height:20px;margin:0;">${_escapeHtml(organizerName)}<br><a href="mailto:${_escapeHtmlAttr(organizerEmail)}" style="color:#70757a;text-decoration:none;">${_escapeHtml(organizerEmail)}</a></p>
      $calendarBlock
    </div>
    <p style="color:#70757a;font-size:12px;line-height:16px;margin:16px 0 0;max-width:640px;">${_isEs ? 'Recibís este correo porque sos el organizador del calendario de reservas en aquiles.dev.' : 'You are receiving this email because you are the booking calendar organizer on aquiles.dev.'}</p>
  </div>
</body>
</html>''';
  }
}

String _escapeHtml(String value) =>
    value.replaceAll('&', '&amp;').replaceAll('<', '&lt;').replaceAll('>', '&gt;').replaceAll('"', '&quot;');

String _escapeHtmlAttr(String value) => _escapeHtml(value);

String _meetDisplay(String meetLink) {
  final uri = Uri.tryParse(meetLink);
  if (uri == null) return meetLink;
  final host = uri.host;
  final path = uri.path.startsWith('/') ? uri.path.substring(1) : uri.path;
  if (host.isEmpty) return meetLink;
  return path.isEmpty ? host : '$host/$path';
}

String normalizeBookingLocale(String? locale) {
  final code = locale?.trim().toLowerCase();
  if (code != null && code.startsWith('es')) return 'es';
  return 'en';
}
