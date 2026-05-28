import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

import '../data/booking_timezones.dart';
import '../l10n/generated/strings.g.dart';
import '../l10n/locale_codec.dart';
import '../l10n/paths.dart';
import 'booking_tz_format.dart';

enum _Step { pickTime, details, success }

enum _PickPhase { date, time }

@client
class BookingScheduler extends StatefulComponent {
  const BookingScheduler({required this.localeCode, super.key});

  final String localeCode;

  @override
  State<BookingScheduler> createState() => _BookingSchedulerState();
}

class _BookingSchedulerState extends State<BookingScheduler> {
  static const _calendarWeeks = 6;
  static const _calendarCellCount = _calendarWeeks * 7;

  var _step = _Step.pickTime;
  var _pickPhase = _PickPhase.date;
  var _errorMsg = '';
  var _monthLoadStarted = false;
  var _initialLoadDone = false;
  var _slotsLoading = false;

  var _viewYear = 0;
  var _viewMonth = 0;
  var _selectedDate = '';
  var _selectedSlot = '';
  var _availableDates = <String>{};
  var _slots = <String>[];

  var _viewerTimezone = defaultBookingTimeZone;
  var _todayKey = '';
  var _maxDateKey = '';
  var _hostStartHour = 9;
  var _hostEndHour = 17;

  var _name = '';
  var _email = '';
  var _notes = '';
  var _honeypot = '';
  var _booking = false;

  AppLocalizations get _s => (localeFromPathSegment(component.localeCode) ?? AppLocale.en).buildSync();

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _viewYear = now.year;
    _viewMonth = now.month;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!context.binding.isClient) return;
    if (_monthLoadStarted) return;
    _monthLoadStarted = true;
    _viewerTimezone = _canonicalTimeZoneId(
      detectBrowserTimeZone(defaultBookingTimeZone),
    );
    Future.microtask(() {
      if (mounted) _loadMonth(advanceIfEmpty: true);
    });
  }

  void _goToDatePhase() {
    setState(() {
      _pickPhase = _PickPhase.date;
      _errorMsg = '';
    });
  }

  void _resetPickPhase() {
    _pickPhase = _PickPhase.date;
  }

  String _pickTimeTitle(AppLocalizations s) {
    return switch (_pickPhase) {
      _PickPhase.date => s.bookingStepDateTitle,
      _PickPhase.time => s.bookingStepTimeTitle,
    };
  }

  int get _activeBookingStep {
    if (_step == _Step.details) return 3;
    if (_pickPhase == _PickPhase.time) return 2;
    return 1;
  }

  void _selectSlot(String slot) {
    setState(() {
      _selectedSlot = slot;
      _errorMsg = '';
    });
    _ensureConfirmVisible();
  }

  void _ensureConfirmVisible() {
    if (!context.binding.isClient) return;

    final smooth = !web.window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    final behavior = smooth ? 'smooth' : 'auto';

    void scrollIfNeeded() {
      final el = web.document.getElementById('booking-confirm');
      if (el == null) return;

      final rect = el.getBoundingClientRect();
      const topClearance = 24.0;
      const bottomClearance = 96.0;
      final viewportBottom = web.window.innerHeight - bottomClearance;

      var delta = 0.0;
      if (rect.bottom > viewportBottom) {
        delta = rect.bottom - viewportBottom;
      } else if (rect.top < topClearance) {
        delta = rect.top - topClearance;
      }

      if (delta != 0) {
        web.window.scrollBy(
          web.ScrollToOptions(top: delta, behavior: behavior),
        );
      }
    }

    Future.microtask(() {
      if (!mounted) return;
      scrollIfNeeded();
      Future.delayed(const Duration(milliseconds: 360), () {
        if (!mounted) return;
        scrollIfNeeded();
      });
    });
  }

  String get _localeTag => component.localeCode == 'es' ? 'es' : 'en';

  String _timeZoneLabel(String id) => formatTimeZoneLabel(id, _localeTag);

  List<BookingTimeZoneOption>? _dedupedTimeZoneOptionsCache;
  String? _dedupedTimeZoneOptionsLocale;

  List<BookingTimeZoneOption> _dedupedTimeZoneOptions() {
    if (_dedupedTimeZoneOptionsCache != null && _dedupedTimeZoneOptionsLocale == _localeTag) {
      return _dedupedTimeZoneOptionsCache!;
    }
    _dedupedTimeZoneOptionsLocale = _localeTag;
    _dedupedTimeZoneOptionsCache = dedupeBookingTimeZoneOptions(
      bookingTimeZoneOptions,
      labelFor: _timeZoneLabel,
    );
    return _dedupedTimeZoneOptionsCache!;
  }

  String _canonicalTimeZoneId(String id) => canonicalBookingTimeZoneId(
    id,
    options: _dedupedTimeZoneOptions(),
    labelFor: _timeZoneLabel,
  );

  List<BookingTimeZoneOption> _displayTimeZoneOptions() {
    return dedupeBookingTimeZoneOptions(
      bookingTimeZoneOptionsIncluding(_viewerTimezone),
      labelFor: _timeZoneLabel,
    );
  }

  void _applyViewerMeta(Map<String, dynamic> data) {
    final tz = data['timezone'] as String?;
    if (tz != null && tz.isNotEmpty) {
      _viewerTimezone = _canonicalTimeZoneId(tz);
    }
    _todayKey = data['today'] as String? ?? _todayKey;
    _maxDateKey = data['maxDate'] as String? ?? _maxDateKey;
    _hostStartHour = data['hostStartHour'] as int? ?? _hostStartHour;
    _hostEndHour = data['hostEndHour'] as int? ?? _hostEndHour;
  }

  (int, int) _shiftMonth(int year, int month, int delta) {
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

  String _effectiveTodayKey() {
    if (_todayKey.isNotEmpty) return _todayKey;
    final now = DateTime.now();
    return _dateKey(now.year, now.month, now.day);
  }

  String _effectiveMaxDateKey() {
    if (_maxDateKey.isNotEmpty) return _maxDateKey;
    final max = DateTime.now().add(const Duration(days: 14));
    return _dateKey(max.year, max.month, max.day);
  }

  void _onTimezoneChange(String timezone) {
    final now = DateTime.now();
    setState(() {
      _viewerTimezone = _canonicalTimeZoneId(timezone);
      _viewYear = now.year;
      _viewMonth = now.month;
      _selectedDate = '';
      _selectedSlot = '';
      _slots = [];
      _availableDates = {};
      _errorMsg = '';
      _resetPickPhase();
    });
    _loadMonth(advanceIfEmpty: true);
  }

  Future<Map<String, dynamic>> _fetchMonthData(int year, int month, {bool findFirst = false}) async {
    final tz = Uri.encodeComponent(_viewerTimezone);
    final findFirstParam = findFirst ? '&findFirst=true' : '';
    final resp = await http.get(
      Uri.parse('/api/booking/month?year=$year&month=$month&timezone=$tz$findFirstParam'),
    );
    if (resp.statusCode != 200) {
      throw StateError('month failed');
    }
    return jsonDecode(resp.body) as Map<String, dynamic>;
  }

  void _applyMonthResult(Map<String, dynamic> data, List<String> dates) {
    _applyViewerMeta(data);
    _availableDates = dates.toSet();
    if (_selectedDate.isNotEmpty && !_availableDates.contains(_selectedDate)) {
      _selectedDate = '';
      _selectedSlot = '';
      _slots = [];
    }
  }

  Future<void> _loadMonth({bool advanceIfEmpty = false}) async {
    try {
      if (advanceIfEmpty) {
        final data = await _fetchMonthData(_viewYear, _viewMonth, findFirst: true);
        final dates = (data['dates'] as List<dynamic>? ?? []).cast<String>();
        if (!mounted) return;
        setState(() {
          _viewYear = data['year'] as int? ?? _viewYear;
          _viewMonth = data['month'] as int? ?? _viewMonth;
          _applyMonthResult(data, dates);
          _initialLoadDone = true;
        });
        if (_selectedDate.isNotEmpty) await _loadSlots(_selectedDate);
        return;
      }

      final data = await _fetchMonthData(_viewYear, _viewMonth);
      final dates = (data['dates'] as List<dynamic>? ?? []).cast<String>();
      if (!mounted) return;
      setState(() {
        _applyMonthResult(data, dates);
        _initialLoadDone = true;
      });
      if (_selectedDate.isNotEmpty) await _loadSlots(_selectedDate);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _initialLoadDone = true;
        _errorMsg = _s.bookingErrorGeneric;
      });
    }
  }

  String _dateKey(int year, int month, int day) =>
      '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

  Future<void> _loadSlots(String date) async {
    if (!mounted) return;
    setState(() {
      _slotsLoading = true;
      _selectedSlot = '';
    });
    try {
      final tz = Uri.encodeComponent(_viewerTimezone);
      final resp = await http.get(
        Uri.parse('/api/booking/availability?date=$date&timezone=$tz'),
      );
      if (resp.statusCode != 200) {
        throw StateError('availability failed');
      }
      final data = jsonDecode(resp.body) as Map<String, dynamic>;
      final slots = (data['slots'] as List<dynamic>? ?? [])
          .map((entry) => (entry as Map<String, dynamic>)['start'] as String)
          .toList();
      if (!mounted) return;
      setState(() {
        _applyViewerMeta(data);
        _slots = slots;
        _slotsLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _slotsLoading = false;
        _errorMsg = _s.bookingErrorGeneric;
      });
    }
  }

  void _selectDate(int year, int month, int day) {
    final key = _dateKey(year, month, day);
    if (!_availableDates.contains(key)) return;
    setState(() {
      _selectedDate = key;
      _selectedSlot = '';
      _errorMsg = '';
      _pickPhase = _PickPhase.time;
    });
    _loadSlots(key);
  }

  void _prevMonth() {
    final prev = _shiftMonth(_viewYear, _viewMonth, -1);
    setState(() {
      _viewYear = prev.$1;
      _viewMonth = prev.$2;
      _selectedDate = '';
      _selectedSlot = '';
      _slots = [];
      _availableDates = {};
      _errorMsg = '';
      _resetPickPhase();
    });
    _loadMonth();
  }

  void _nextMonth() {
    final next = _shiftMonth(_viewYear, _viewMonth, 1);
    setState(() {
      _viewYear = next.$1;
      _viewMonth = next.$2;
      _selectedDate = '';
      _selectedSlot = '';
      _slots = [];
      _availableDates = {};
      _errorMsg = '';
      _resetPickPhase();
    });
    _loadMonth();
  }

  void _confirmTime() {
    if (_selectedSlot.isEmpty) return;
    setState(() {
      _step = _Step.details;
      _errorMsg = '';
    });
  }

  Future<void> _submitBooking() async {
    final s = _s;
    if (_name.trim().isEmpty || _email.trim().isEmpty) {
      setState(() {
        _errorMsg = s.bookingErrorRequired;
      });
      return;
    }
    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(_email.trim())) {
      setState(() {
        _errorMsg = s.formErrorEmail;
      });
      return;
    }
    setState(() {
      _booking = true;
      _errorMsg = '';
    });
    try {
      final resp = await http.post(
        Uri.parse('/api/booking'),
        headers: {'content-type': 'application/json'},
        body: jsonEncode({
          'name': _name.trim(),
          'email': _email.trim(),
          'slotStart': _selectedSlot,
          'notes': _notes.trim(),
          'locale': component.localeCode,
          'website': _honeypot,
        }),
      );
      if (!mounted) return;
      if (resp.statusCode == 200) {
        setState(() {
          _step = _Step.success;
          _booking = false;
        });
      } else if (resp.statusCode == 409) {
        setState(() {
          _step = _Step.pickTime;
          _booking = false;
          _errorMsg = s.bookingErrorConflict;
          _selectedSlot = '';
          _selectedDate = '';
          _availableDates = {};
          _resetPickPhase();
        });
        _loadMonth(advanceIfEmpty: true);
      } else {
        setState(() {
          _booking = false;
          _errorMsg = _apiErrorMessage(resp, s.bookingErrorGeneric);
        });
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _booking = false;
        _errorMsg = s.bookingErrorGeneric;
      });
    }
  }

  String _apiErrorMessage(http.Response resp, String fallback) {
    try {
      final data = jsonDecode(resp.body) as Map<String, dynamic>;
      final detail = data['detail'] as String?;
      if (detail != null && detail.isNotEmpty) return '$fallback ($detail)';
    } catch (_) {}
    return fallback;
  }

  String _formatSlotLabel(String iso) => formatTimeInTimeZone(
    parseSlotInstant(iso),
    _viewerTimezone,
    _localeTag,
  );

  String _formatSelectedDateHeader() {
    if (_selectedSlot.isNotEmpty) {
      return formatDateInTimeZone(parseSlotInstant(_selectedSlot), _viewerTimezone, _localeTag);
    }
    if (_selectedDate.isEmpty) return '';
    return formatDateKeyInTimeZone(_selectedDate, _viewerTimezone, _localeTag);
  }

  String _monthLabel() => formatMonthInLocale(_viewYear, _viewMonth, _localeTag);

  List<String> _weekdayLabels() => formatShortWeekdayLabels(_localeTag);

  String _skeletonClasses(String modifier) => 'book-meeting-skeleton $modifier';

  List<Component> _skeletonBars(int count, String className) => [
    for (var i = 0; i < count; i++) div(classes: _skeletonClasses(className), []),
  ];

  Component _buildInitialSkeleton() {
    return div(
      key: const ValueKey('booking-initial-skeleton'),
      classes: 'book-meeting-layout book-meeting-layout--skeleton',
      [
        div(classes: 'book-meeting-times', [
          ..._skeletonBars(1, 'book-meeting-skeleton--hint'),
          ..._skeletonBars(4, 'book-meeting-skeleton--slot'),
        ]),
        div(classes: 'book-meeting-calendar', [
          div(classes: 'book-meeting-calendar__header', [
            div(classes: _skeletonClasses('book-meeting-skeleton--month'), []),
            div(classes: _skeletonClasses('book-meeting-skeleton--nav'), []),
          ]),
          div(classes: 'book-meeting-calendar__weekdays', [
            for (var i = 0; i < 7; i++) div(classes: _skeletonClasses('book-meeting-skeleton--weekday'), []),
          ]),
          div(classes: 'book-meeting-calendar__grid book-meeting-calendar__grid--skeleton', [
            for (var i = 0; i < _calendarCellCount; i++)
              div(classes: _skeletonClasses('book-meeting-skeleton--day'), []),
          ]),
          div(classes: _skeletonClasses('book-meeting-skeleton--select'), []),
        ]),
      ],
    );
  }

  Component _buildStepIndicator(AppLocalizations s) {
    final steps = [
      (1, s.bookingStepDate),
      (2, s.bookingStepTime),
      (3, s.bookingStepDetails),
    ];

    return div(classes: 'book-meeting-steps', [
      for (final (index, label) in steps) ...[
        if (index > 1) span(classes: 'book-meeting-steps__line', []),
        span(
          classes:
              'book-meeting-steps__item${index == _activeBookingStep ? ' book-meeting-steps__item--active' : ''}'
              '${index < _activeBookingStep ? ' book-meeting-steps__item--done' : ''}',
          attributes: index == _activeBookingStep ? {'aria-current': 'step'} : {},
          [
            span(classes: 'book-meeting-steps__dot', [.text('$index')]),
            span(classes: 'book-meeting-steps__label', [.text(label)]),
          ],
        ),
      ],
    ]);
  }

  Component _buildCalendarPanel(AppLocalizations s) {
    return div(classes: 'book-meeting-calendar', [
      div(classes: 'book-meeting-calendar__header', [
        span(
          key: ValueKey('month-$_viewYear-$_viewMonth'),
          classes: 'book-meeting-calendar__month book-meeting-animate-in',
          [.text(_monthLabel())],
        ),
        div(classes: 'book-meeting-calendar__nav', [
          button(
            type: ButtonType.button,
            classes: 'book-meeting-calendar__arrow',
            attributes: {'aria-label': s.bookingPrevMonth},
            onClick: _prevMonth,
            [.text('‹')],
          ),
          button(
            type: ButtonType.button,
            classes: 'book-meeting-calendar__arrow',
            attributes: {'aria-label': s.bookingNextMonth},
            onClick: _nextMonth,
            [.text('›')],
          ),
        ]),
      ]),
      div(classes: 'book-meeting-calendar__weekdays', [
        for (final label in _weekdayLabels()) span(classes: 'book-meeting-calendar__weekday', [.text(label)]),
      ]),
      div(
        key: ValueKey('grid-$_viewYear-$_viewMonth'),
        classes: 'book-meeting-calendar__grid book-meeting-animate-in',
        _calendarCells(),
      ),
      div(classes: 'book-meeting-calendar__tz-row', [
        label(
          classes: 'book-meeting-calendar__tz-label',
          htmlFor: 'booking-timezone',
          [.text(s.bookingTimezoneLabel)],
        ),
        select(
          id: 'booking-timezone',
          classes: 'book-meeting-calendar__tz-select',
          value: _viewerTimezone,
          attributes: {'aria-label': s.bookingTimezoneLabel},
          onChange: (values) {
            final next = values.isNotEmpty ? values.first : _viewerTimezone;
            if (next != _viewerTimezone) _onTimezoneChange(next);
          },
          [
            for (final tz in _displayTimeZoneOptions())
              option(
                value: tz.id,
                selected: tz.id == _viewerTimezone,
                [.text(_timeZoneLabel(tz.id))],
              ),
          ],
        ),
      ]),
      p(classes: 'book-meeting-calendar__tz-hint', [
        .text(s.bookingHostHoursHint(startHour: _hostStartHour, endHour: _hostEndHour)),
      ]),
    ]);
  }

  Component _buildTimesPanel(AppLocalizations s) {
    if (_selectedDate.isEmpty) {
      return p(classes: 'book-meeting-times__hint book-meeting-animate-in', [.text(s.bookingPickDateHint)]);
    }

    return div(classes: 'book-meeting-times__content book-meeting-animate-in', [
      button(
        type: ButtonType.button,
        classes: 'book-meeting-back book-meeting-back--mobile',
        onClick: _goToDatePhase,
        [.text('← ${s.bookingChangeDate}')],
      ),
      p(classes: 'book-meeting-times__date', [.text(_formatSelectedDateHeader())]),
      if (_slotsLoading)
        div(classes: 'book-meeting-slot-list book-meeting-slot-list--loading', [
          for (var i = 0; i < 4; i++) div(classes: 'book-meeting-slot book-meeting-slot--ghost', []),
        ])
      else if (_slots.isEmpty)
        p(classes: 'book-meeting-times__hint', [.text(s.bookingNoSlots)])
      else
        div(
          key: ValueKey('slots-$_selectedDate'),
          classes: 'book-meeting-slot-list',
          [
            for (final slot in _slots)
              button(
                type: ButtonType.button,
                classes: 'book-meeting-slot${slot == _selectedSlot ? ' book-meeting-slot--active' : ''}',
                onClick: () => _selectSlot(slot),
                [.text(_formatSlotLabel(slot))],
              ),
            div(
              classes: 'book-meeting-confirm-wrap${_selectedSlot.isNotEmpty ? ' book-meeting-confirm-wrap--open' : ''}',
              [
                div(classes: 'book-meeting-confirm-wrap__inner', [
                  button(
                    type: ButtonType.button,
                    id: 'booking-confirm',
                    classes: 'btn btn-primary book-meeting-confirm',
                    attributes: _selectedSlot.isEmpty ? {'tabindex': '-1', 'aria-hidden': 'true'} : {},
                    onClick: _selectedSlot.isEmpty ? null : _confirmTime,
                    [.text(s.bookingConfirmTime)],
                  ),
                ]),
              ],
            ),
          ],
        ),
    ]);
  }

  @override
  Component build(BuildContext context) {
    final s = _s;
    if (_step == _Step.success) {
      final locale = localeFromPathSegment(component.localeCode) ?? AppLocale.en;
      return div(classes: 'book-meeting-scheduler book-meeting-scheduler--success', [
        div(classes: 'form-success book-meeting-animate-in', [
          div(classes: 'form-success__icon', [.text('✓')]),
          p(classes: 'form-success__msg', [.text(s.bookingSuccess)]),
          div(classes: 'form-success__actions', [
            a(href: AppPaths.projects(locale), classes: 'btn btn-primary', [.text(s.bookingSuccessCtaWork)]),
            a(href: AppPaths.home(locale), classes: 'btn btn-ghost', [.text(s.bookingSuccessCtaAbout)]),
            a(href: AppPaths.projectsWithFilter(locale, 'oss'), classes: 'form-success__link', [
              .text(s.bookingSuccessCtaOss),
            ]),
          ]),
        ]),
      ]);
    }

    return div(classes: 'book-meeting-scheduler book-meeting-scheduler--${_step.name}', [
      // Honeypot – hidden from real users; bots that fill it are rejected server-side.
      input(
        type: InputType.text,
        name: 'website',
        value: _honeypot,
        attributes: {
          'aria-hidden': 'true',
          'tabindex': '-1',
          'autocomplete': 'off',
          'style': 'position:absolute;left:-9999px;width:0;height:0',
        },
        onInput: (String v) => setState(() => _honeypot = v),
      ),
      if (_step == _Step.pickTime) ...[
        _buildStepIndicator(s),
        h2(classes: 'book-meeting-card__title book-meeting-card__title--desktop', [.text(s.bookingSelectDateTime)]),
        h2(
          key: ValueKey('mobile-title-${_pickPhase.name}'),
          classes: 'book-meeting-card__title book-meeting-card__title--mobile book-meeting-animate-in',
          [.text(_pickTimeTitle(s))],
        ),
        if (!_initialLoadDone)
          _buildInitialSkeleton()
        else
          div(classes: 'book-meeting-layout book-meeting-layout--phase-${_pickPhase.name}', [
            div(classes: 'book-meeting-times', [_buildTimesPanel(s)]),
            _buildCalendarPanel(s),
          ]),
      ] else ...[
        div(classes: 'book-meeting-flow-panel book-meeting-animate-in', [
          _buildStepIndicator(s),
          button(
            type: ButtonType.button,
            classes: 'book-meeting-back',
            onClick: () => setState(() {
              _step = _Step.pickTime;
              _pickPhase = _selectedDate.isNotEmpty ? _PickPhase.time : _PickPhase.date;
              _errorMsg = '';
            }),
            [.text('← ${s.bookingBack}')],
          ),
          h2(classes: 'book-meeting-card__title', [.text(s.bookingEnterDetails)]),
          p(classes: 'book-meeting-summary', [
            .text('${_formatSelectedDateHeader()} · ${_formatSlotLabel(_selectedSlot)}'),
          ]),
          div(classes: 'book-meeting-details', [
            div(classes: 'form-group', [
              label(classes: 'form-label', htmlFor: 'b-name', [.text(s.formName)]),
              input(
                type: InputType.text,
                id: 'b-name',
                classes: 'form-input',
                value: _name,
                attributes: {'placeholder': s.formNameHint, 'maxlength': '100', 'autocomplete': 'name'},
                onInput: (String v) => setState(() => _name = v),
              ),
            ]),
            div(classes: 'form-group', [
              label(classes: 'form-label', htmlFor: 'b-email', [.text(s.formEmail)]),
              input(
                type: InputType.email,
                id: 'b-email',
                classes: 'form-input',
                value: _email,
                attributes: {'placeholder': s.formEmailHint, 'maxlength': '200', 'autocomplete': 'email'},
                onInput: (String v) => setState(() => _email = v),
              ),
            ]),
            div(classes: 'form-group', [
              label(classes: 'form-label', htmlFor: 'b-notes', [.text(s.bookingNotes)]),
              textarea(
                id: 'b-notes',
                classes: 'form-input form-textarea booking-notes',
                rows: 3,
                placeholder: s.bookingNotesHint,
                attributes: {'maxlength': '1000'},
                onInput: (String v) => setState(() => _notes = v),
                [.text(_notes)],
              ),
            ]),
            if (_errorMsg.isNotEmpty) p(classes: 'form-error-msg book-meeting-animate-in', [.text(_errorMsg)]),
            button(
              classes: 'btn btn-primary form-submit${_booking ? ' form-submit--loading' : ''}',
              attributes: _booking ? {'disabled': ''} : {},
              onClick: _booking ? null : _submitBooking,
              [.text(_booking ? s.bookingBooking : s.bookingConfirm)],
            ),
          ]),
        ]),
      ],
      if (_step == _Step.pickTime && _errorMsg.isNotEmpty)
        p(classes: 'form-error-msg book-meeting-animate-in', [.text(_errorMsg)]),
    ]);
  }

  List<Component> _calendarCells() {
    final firstOfMonth = DateTime(_viewYear, _viewMonth, 1);
    final daysInMonth = DateTime(_viewYear, _viewMonth + 1, 0).day;
    final startOffset = firstOfMonth.weekday % 7;
    final today = _effectiveTodayKey();
    final maxDate = _effectiveMaxDateKey();
    final cells = <Component>[];

    for (var i = 0; i < startOffset; i++) {
      cells.add(span(classes: 'book-meeting-calendar__day book-meeting-calendar__day--empty', []));
    }

    for (var day = 1; day <= daysInMonth; day++) {
      final key = _dateKey(_viewYear, _viewMonth, day);
      final isAvailable = _availableDates.contains(key);
      final isPast = key.compareTo(today) < 0;
      final isFuture = key.compareTo(maxDate) > 0;
      final isSelected = key == _selectedDate;
      final isDisabled = !isAvailable || isPast || isFuture;

      var classes = 'book-meeting-calendar__day';
      if (isAvailable && !isPast && !isFuture) classes += ' book-meeting-calendar__day--available';
      if (isSelected) classes += ' book-meeting-calendar__day--selected';
      if (isDisabled) classes += ' book-meeting-calendar__day--disabled';

      cells.add(
        button(
          type: ButtonType.button,
          classes: classes,
          attributes: isDisabled ? {'disabled': '', 'aria-label': '$day'} : {'aria-label': '$day'},
          onClick: isDisabled ? null : () => _selectDate(_viewYear, _viewMonth, day),
          [.text('$day')],
        ),
      );
    }

    while (cells.length < _calendarCellCount) {
      cells.add(span(classes: 'book-meeting-calendar__day book-meeting-calendar__day--empty', []));
    }

    return cells;
  }
}
