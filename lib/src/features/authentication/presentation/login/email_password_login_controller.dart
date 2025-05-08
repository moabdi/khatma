import 'dart:async';

import 'package:khatma/src/features/authentication/application/auth_service.dart';
import 'package:khatma/src/features/authentication/presentation/login/email_password_login_form_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'email_password_login_controller.g.dart';

@riverpod
class EmailPasswordSignInController extends _$EmailPasswordSignInController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }
  Future<bool> submit(
      {required String email,
      required String password,
      required EmailPasswordSignInFormType formType}) async {
    state = const AsyncValue.loading();
    state =
        await AsyncValue.guard(() => _authenticate(email, password, formType));
    return state.hasError == false;
  }

  Future<void> _authenticate(
      String email, String password, EmailPasswordSignInFormType formType) {
    final authService = ref.read(authServiceProvider.notifier);
    switch (formType) {
      case EmailPasswordSignInFormType.signIn:
        return authService.signInWithEmailAndPassword(email, password);
      case EmailPasswordSignInFormType.register:
        return authService.createUserWithEmailAndPassword(email, password);
    }
  }
}
