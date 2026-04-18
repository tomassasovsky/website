import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../data/portfolio_content.dart';
import '../l10n/generated/strings.g.dart';
import '../l10n/locale_codec.dart';
import '../models/models.dart';

@client
class TestimonialsCarousel extends StatefulComponent {
  const TestimonialsCarousel({required this.localeCode, super.key});

  final String localeCode;

  @override
  State<TestimonialsCarousel> createState() => _TestimonialsCarouselState();
}

class _TestimonialsCarouselState extends State<TestimonialsCarousel> {
  int _index = 0;
  late final List<Testimonial> _items;

  @override
  void initState() {
    super.initState();
    final locale = localeFromPathSegment(component.localeCode) ?? AppLocale.en;
    _items = loadTestimonials(locale.buildSync());
  }

  int get _prevIndex => (_index - 1 + _items.length) % _items.length;
  int get _nextIndex => (_index + 1) % _items.length;

  void _go(int i) => setState(() => _index = i);

  String _slotClass(int i) {
    if (i == _index) return 'active';
    if (i == _prevIndex) return 'prev';
    if (i == _nextIndex) return 'next';
    return 'hidden';
  }

  @override
  Component build(BuildContext context) {
    return div(classes: 'tcarousel', [
      div(classes: 'tcarousel__stage', [
        for (var i = 0; i < _items.length; i++) _TestimonialCard(t: _items[i], slotClass: _slotClass(i)),
      ]),
      div(classes: 'tcarousel__controls', [
        button(
          classes: 'tcarousel__btn',
          onClick: () => _go(_prevIndex),
          [.text('‹')],
        ),
        div(classes: 'tcarousel__dots', [
          for (var i = 0; i < _items.length; i++)
            button(
              classes: 'tcarousel__dot${i == _index ? ' active' : ''}',
              onClick: () => _go(i),
              [],
            ),
        ]),
        button(
          classes: 'tcarousel__btn',
          onClick: () => _go(_nextIndex),
          [.text('›')],
        ),
      ]),
    ]);
  }
}

class _TestimonialCard extends StatelessComponent {
  const _TestimonialCard({required this.t, required this.slotClass});

  final Testimonial t;
  final String slotClass;

  @override
  Component build(BuildContext context) {
    final hidden = slotClass == 'hidden';
    return div(
      classes: 'tcard-item tcard-item--$slotClass',
      attributes: hidden ? const {'aria-hidden': 'true', 'tabindex': '-1'} : const {},
      [
        div(classes: 'tcard__meta', [
          span(classes: 'tcard__author', [.text(t.author)]),
          a(
            href: t.linkedinUrl,
            classes: 'tcard__link',
            attributes: const {'target': '_blank', 'rel': 'noopener noreferrer'},
            [.text(t.dateLabel)],
          ),
        ]),
        div(classes: 'tcard__body', [
          for (final para in t.paragraphs) p([.text(para)]),
        ]),
      ],
    );
  }
}
