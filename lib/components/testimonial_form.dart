import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';

import '../l10n/generated/strings.g.dart';
import '../l10n/locale_codec.dart';
import '../providers/testimonial_form_provider.dart';

@client
class TestimonialForm extends StatelessComponent {
  const TestimonialForm({required this.localeCode, super.key});

  final String localeCode;

  @override
  Component build(BuildContext context) {
    final s = (localeFromPathSegment(localeCode) ?? AppLocale.en).buildSync();
    final formState = context.watch(testimonialFormProvider);
    final notifier = context.read(testimonialFormProvider.notifier);

    if (formState.isSuccess) {
      return div(classes: 'form-success', [
        div(classes: 'form-success__icon', [.text('✓')]),
        p(classes: 'form-success__msg', [.text(s.testiFormSuccess)]),
      ]);
    }

    return div(classes: 'contact-form', [
      // Honeypot – hidden from real users
      input(
        type: InputType.text,
        name: 'website',
        attributes: {
          'aria-hidden': 'true',
          'tabindex': '-1',
          'autocomplete': 'off',
          'style': 'position:absolute;left:-9999px;width:0;height:0',
        },
      ),
      div(classes: 'form-row', [
        div(classes: 'form-group', [
          label(classes: 'form-label', htmlFor: 'tf-name', [.text(s.testiFormName)]),
          input(
            type: InputType.text,
            id: 'tf-name',
            name: 'name',
            classes: 'form-input',
            value: formState.name,
            attributes: {'placeholder': s.testiFormNameHint, 'maxlength': '100', 'autocomplete': 'off'},
            onInput: notifier.updateName,
          ),
        ]),
        div(classes: 'form-group', [
          label(classes: 'form-label', htmlFor: 'tf-email', [.text(s.formEmail)]),
          input(
            type: InputType.email,
            id: 'tf-email',
            name: 'email',
            classes: 'form-input',
            value: formState.email,
            attributes: {'placeholder': s.formEmailHint, 'maxlength': '200', 'autocomplete': 'off'},
            onInput: notifier.updateEmail,
          ),
        ]),
      ]),
      div(classes: 'form-row', [
        div(classes: 'form-group', [
          label(classes: 'form-label', htmlFor: 'tf-role', [.text(s.testiFormRole)]),
          input(
            type: InputType.text,
            id: 'tf-role',
            name: 'role',
            classes: 'form-input',
            value: formState.role,
            attributes: {'placeholder': s.testiFormRoleHint, 'maxlength': '200', 'autocomplete': 'off'},
            onInput: notifier.updateRole,
          ),
        ]),
        div(classes: 'form-group', [
          label(classes: 'form-label', htmlFor: 'tf-linkedin', [.text(s.testiFormLinkedin)]),
          input(
            type: InputType.url,
            id: 'tf-linkedin',
            name: 'linkedinUrl',
            classes: 'form-input',
            value: formState.linkedinUrl,
            attributes: {'placeholder': s.testiFormLinkedinHint, 'maxlength': '500', 'autocomplete': 'off'},
            onInput: notifier.updateLinkedinUrl,
          ),
        ]),
      ]),
      div(classes: 'form-group', [
        label(classes: 'form-label', htmlFor: 'tf-testimonial', [.text(s.testiFormTestimonial)]),
        textarea(
          id: 'tf-testimonial',
          name: 'testimonial',
          classes: 'form-input form-textarea',
          rows: 7,
          attributes: {'maxlength': '10000', 'autocomplete': 'off'},
          placeholder: s.testiFormTestimonialHint,
          onInput: notifier.updateTestimonial,
          [.text(formState.testimonial)],
        ),
      ]),
      if (formState.isError) p(classes: 'form-error-msg', [.text(formState.errorMsg)]),
      button(
        classes: 'btn btn-primary form-submit${formState.isLoading ? " form-submit--loading" : ""}',
        attributes: formState.isLoading ? {'disabled': ''} : {},
        onClick: formState.isLoading ? null : () => notifier.submit(s),
        [.text(formState.isLoading ? s.formSending : s.testiFormSubmit)],
      ),
    ]);
  }
}
