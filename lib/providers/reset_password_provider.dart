import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/data/responses/confirm_password_response.dart';
import 'package:leen_alkhier_store/data/responses/reset_password_response.dart';
import 'package:leen_alkhier_store/repos/auth_repository.dart';

class ResetPasswordProvider extends ChangeNotifier {
  String? email;
  ResetPasswordResponse? resetPasswordResponse;
  late ConfirmPasswordResponse confirmPasswordResponse;
  void setEmail({String? m}) {
    email = m;
    notifyListeners();
  }

  Future<void> resetPassword() async {
    await AuthRepository.resetPassword(email: email).then((value) {
      resetPasswordResponse = value;
      notifyListeners();
    });
  }

  Future<void> resetPasswordKInForget() async {
    await AuthRepository.resetPassword(email: email).then((value) {
      resetPasswordResponse = value;
      notifyListeners();
    });
  }

  Future<void> confirmPassword(String password) async {
    await AuthRepository.confirmPassword(email: email, password: password)
        .then((value) {
      confirmPasswordResponse = value!;
      notifyListeners();
    });
  }
}
