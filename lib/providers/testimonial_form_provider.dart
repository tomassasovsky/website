import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jaspr_riverpod/legacy.dart';

import '../l10n/generated/strings.g.dart';

enum TestimonialSubmitStatus { idle, loading, success, error }

class TestimonialFormState {
  const TestimonialFormState({
    this.name = '',
    this.email = '',
    this.role = '',
    this.linkedinUrl = '',
    this.testimonial = '',
    this.status = TestimonialSubmitStatus.idle,
    this.errorMsg = '',
  });

  final String name;
  final String email;
  final String role;
  final String linkedinUrl;
  final String testimonial;
  final TestimonialSubmitStatus status;
  final String errorMsg;

  bool get isLoading => status == TestimonialSubmitStatus.loading;
  bool get isSuccess => status == TestimonialSubmitStatus.success;
  bool get isError => status == TestimonialSubmitStatus.error;

  TestimonialFormState copyWith({
    String? name,
    String? email,
    String? role,
    String? linkedinUrl,
    String? testimonial,
    TestimonialSubmitStatus? status,
    String? errorMsg,
  }) {
    return TestimonialFormState(
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      linkedinUrl: linkedinUrl ?? this.linkedinUrl,
      testimonial: testimonial ?? this.testimonial,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

class TestimonialFormNotifier extends StateNotifier<TestimonialFormState> {
  TestimonialFormNotifier() : super(const TestimonialFormState());

  void updateName(String v) => state = state.copyWith(name: v);
  void updateEmail(String v) => state = state.copyWith(email: v);
  void updateRole(String v) => state = state.copyWith(role: v);
  void updateLinkedinUrl(String v) => state = state.copyWith(linkedinUrl: v);
  void updateTestimonial(String v) => state = state.copyWith(testimonial: v);

  Future<void> submit(AppLocalizations s) async {
    if (state.name.trim().isEmpty || state.testimonial.trim().isEmpty) {
      state = state.copyWith(
        status: TestimonialSubmitStatus.error,
        errorMsg: s.testiFormErrorRequired,
      );
      return;
    }

    state = state.copyWith(status: TestimonialSubmitStatus.loading);

    try {
      final resp = await http.post(
        Uri.parse('/api/testimonial'),
        headers: {'content-type': 'application/json'},
        body: jsonEncode({
          'name': state.name.trim(),
          'email': state.email.trim(),
          'role': state.role.trim(),
          'linkedinUrl': state.linkedinUrl.trim(),
          'testimonial': state.testimonial.trim(),
          'website': '',
        }),
      );
      state = state.copyWith(
        status: resp.statusCode == 200 ? TestimonialSubmitStatus.success : TestimonialSubmitStatus.error,
        errorMsg: resp.statusCode == 200 ? '' : s.formErrorGeneric,
      );
    } catch (_) {
      state = state.copyWith(
        status: TestimonialSubmitStatus.error,
        errorMsg: s.formErrorGeneric,
      );
    }
  }
}

final testimonialFormProvider = StateNotifierProvider.autoDispose<TestimonialFormNotifier, TestimonialFormState>(
  (ref) => TestimonialFormNotifier(),
);
