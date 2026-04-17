import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../l10n/generated/strings.g.dart';
import '../l10n/locale_codec.dart';

enum _Status { idle, loading, success, error }

@client
class ContactForm extends StatefulComponent {
  const ContactForm({required this.localeCode, super.key});

  final String localeCode;

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  var _name = '';
  var _email = '';
  var _subject = '';
  var _message = '';
  var _status = _Status.idle;
  var _errorMsg = '';

  AppLocalizations get _s => (localeFromPathSegment(component.localeCode) ?? AppLocale.en).buildSync();

  void _submit() {
    final s = _s;
    if (_name.trim().isEmpty || _email.trim().isEmpty || _subject.trim().isEmpty || _message.trim().isEmpty) {
      setState(() {
        _status = _Status.error;
        _errorMsg = s.formErrorRequired;
      });
      return;
    }
    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(_email.trim())) {
      setState(() {
        _status = _Status.error;
        _errorMsg = s.formErrorEmail;
      });
      return;
    }
    setState(() => _status = _Status.loading);
    _doPost(s);
  }

  Future<void> _doPost(AppLocalizations s) async {
    try {
      final resp = await http.post(
        Uri.parse('/api/contact'),
        headers: {'content-type': 'application/json'},
        body: jsonEncode({
          'name': _name.trim(),
          'email': _email.trim(),
          'subject': _subject.trim(),
          'message': _message.trim(),
          'website': '',
        }),
      );
      setState(() {
        if (resp.statusCode == 200) {
          _status = _Status.success;
        } else {
          _status = _Status.error;
          _errorMsg = s.formErrorGeneric;
        }
      });
    } catch (_) {
      setState(() {
        _status = _Status.error;
        _errorMsg = s.formErrorGeneric;
      });
    }
  }

  @override
  Component build(BuildContext context) {
    final s = _s;
    final loading = _status == _Status.loading;

    if (_status == _Status.success) {
      return div(classes: 'form-success', [
        div(classes: 'form-success__icon', [.text('✓')]),
        p(classes: 'form-success__msg', [.text(s.formSuccess)]),
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
          label(classes: 'form-label', htmlFor: 'f-name', [.text(s.formName)]),
          input(
            type: InputType.text,
            id: 'f-name',
            name: 'name',
            classes: 'form-input',
            value: _name,
            attributes: {'placeholder': s.formNameHint},
            onInput: (String v) => setState(() => _name = v),
          ),
        ]),
        div(classes: 'form-group', [
          label(classes: 'form-label', htmlFor: 'f-email', [.text(s.formEmail)]),
          input(
            type: InputType.email,
            id: 'f-email',
            name: 'email',
            classes: 'form-input',
            value: _email,
            attributes: {'placeholder': s.formEmailHint},
            onInput: (String v) => setState(() => _email = v),
          ),
        ]),
      ]),
      div(classes: 'form-group', [
        label(classes: 'form-label', htmlFor: 'f-subject', [.text(s.formSubject)]),
        input(
          type: InputType.text,
          id: 'f-subject',
          name: 'subject',
          classes: 'form-input',
          value: _subject,
          attributes: {'placeholder': s.formSubjectHint},
          onInput: (String v) => setState(() => _subject = v),
        ),
      ]),
      div(classes: 'form-group', [
        label(classes: 'form-label', htmlFor: 'f-message', [.text(s.formMessage)]),
        textarea(
          id: 'f-message',
          name: 'message',
          classes: 'form-input form-textarea',
          rows: 5,
          placeholder: s.formMessageHint,
          onInput: (String v) => setState(() => _message = v),
          [.text(_message)],
        ),
      ]),
      if (_status == _Status.error) p(classes: 'form-error-msg', [.text(_errorMsg)]),
      button(
        classes: 'btn btn-primary form-submit${loading ? " form-submit--loading" : ""}',
        attributes: loading ? {'disabled': ''} : {},
        onClick: loading ? null : _submit,
        [.text(loading ? s.formSending : s.formSend)],
      ),
    ]);
  }
}
