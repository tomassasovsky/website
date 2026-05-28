import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/booking_scheduler.dart';
import '../l10n/l10n_extension.dart';

class BookMeetingPage extends StatelessComponent {
  const BookMeetingPage({super.key});

  @override
  Component build(BuildContext context) {
    final s = context.strings;
    final locale = context.locale;

    return .fragment([
      Document.head(title: s.metaTitleBookMeeting),
      div(classes: 'page book-meeting-page', [
        div(classes: 'container', [
          div(classes: 'book-meeting-card', [
            header(classes: 'book-meeting-event', [
              h1(classes: 'book-meeting-event__title', [.text(s.bookingMeetingTitle)]),
              span(classes: 'book-meeting-event__duration', [.text(s.bookingMeetingDuration)]),
            ]),
            BookingScheduler(localeCode: locale.languageCode),
          ]),
        ]),
      ]),
    ]);
  }
}
