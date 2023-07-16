import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/data/responses/user_info_response.dart';
import 'package:leen_alkhier_store/data/responses/version/app_version_response.dart';
import 'package:leen_alkhier_store/repos/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoProvider extends ChangeNotifier {
  UserInfoResponse? userInfoResponse;
  AppVersionResponse? appVersionResponse;
  String? start_date;
  String? end_date;
  Future<void> getUserInfo() async {
    var prefs = await SharedPreferences.getInstance();

    await AuthRepository.getUserInfo().then((value) {
      if (value != null) {
        print("value : ${value.toJson()}");
        userInfoResponse = value;
        if (userInfoResponse!.data!.businessInfoId != null) {
          prefs.setInt(
              "business_info_id", userInfoResponse!.data!.businessInfoId!);
        }

        notifyListeners();
      }
    });
  }

  Future<void> getAppVersion() async {
    var prefs = await SharedPreferences.getInstance();
    await AuthRepository.getAppVersion()!.then((value) {

      if (value != null) {
        appVersionResponse = value;
        if (appVersionResponse!.data != null) {
          prefs.setString("app_version", appVersionResponse!.data!);
        }

        notifyListeners();
      }
    });
  }
}
