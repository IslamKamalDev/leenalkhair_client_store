import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/data/responses/respone_otp.dart';
import 'package:leen_alkhier_store/data/responses/user_resend_otp.dart';
import 'package:leen_alkhier_store/repos/auth_repository.dart';

class verfiyOtpProvider extends ChangeNotifier {
  late ResponseOtp responseOtp;
  UserResendOtpResponse? userResendOtpResponse;
  bool? resend_timer_status = true;
  Future<void> verfiyOtp(String otp, String? email) async {
    await AuthRepository.verfiyOtp(otp: otp, email: email).then((value) {
      responseOtp = value!;
      notifyListeners();
    });
  }

  Future<void> resendOtp() async {
    await AuthRepository.ResendOtp().then((value) {
      userResendOtpResponse = value;
      resend_timer_status = true;
      notifyListeners();
    });
  }
}
