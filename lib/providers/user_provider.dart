import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/data/requests/user_login_request.dart';
import 'package:leen_alkhier_store/data/responses/check_password.dart';
import 'package:leen_alkhier_store/data/responses/remove_account_resposne.dart';
import 'package:leen_alkhier_store/data/responses/response_email_mobile.dart';
import 'package:leen_alkhier_store/data/responses/user_login_response.dart';
import 'package:leen_alkhier_store/data/responses/verfiy_new_email_mobile_response.dart';
import 'package:leen_alkhier_store/repos/auth_repository.dart';

class UserProvider extends ChangeNotifier {
  UserLoginResponse? userLoginResponse;
  late ResponseEmailOrMobile responseEmailOrMobile;
  late ResponseVerfiyNewEmailOrMobile responseVerfiyNewEmailOrMobile;
  bool? removeAccountResponse;
  bool? correctPassResponse;

  Future<void> loginUser({required LoginRequestBody requestBody}) async {
    await AuthRepository.login(requestBody).then((value) async {
      userLoginResponse = value;

      notifyListeners();
    });
  }

  Future<ResponseEmailOrMobile?> updateEmailOrMobile({String? email}) async {
    await AuthRepository.updateEmailOrMobile(email: email).then((value) async {
      responseEmailOrMobile = value;

      notifyListeners();
    });
    return null;
  }

  Future<ResponseVerfiyNewEmailOrMobile?> verfiyNewEmailOrMobile(
      {String? email, String? otp}) async {
    await AuthRepository.verfiyNewEmailOrMobile(email: email, otp: otp)
        .then((value) async {
      responseVerfiyNewEmailOrMobile = value;
      notifyListeners();
    });
    return null;
  }

  Future<RemoveAccountResponse?> remove_account() async {
    await AuthRepository.remove_account().then((value) async {
      removeAccountResponse = value.status!;
      notifyListeners();
    });
  }

  Future<CheckPasswordResponse?> checkPass(String pass) async {
    await AuthRepository.checkPassword(pass).then((value) async {
      correctPassResponse = value.status!;
      notifyListeners();
    });
  }
}
