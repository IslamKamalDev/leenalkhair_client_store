import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:leen_alkhier_store/data/requests/business_register_request.dart';
import 'package:leen_alkhier_store/data/requests/user_login_request.dart';
import 'package:leen_alkhier_store/data/requests/user_register_request.dart';
import 'package:leen_alkhier_store/data/responses/business_register_response.dart';
import 'package:leen_alkhier_store/data/responses/check_password.dart';
import 'package:leen_alkhier_store/data/responses/confirm_password_response.dart';
import 'package:leen_alkhier_store/data/responses/remove_account_resposne.dart';
import 'package:leen_alkhier_store/data/responses/reset_password_response.dart';
import 'package:leen_alkhier_store/data/responses/respone_otp.dart';
import 'package:leen_alkhier_store/data/responses/response_email_mobile.dart';
import 'package:leen_alkhier_store/data/responses/user_info_response.dart';
import 'package:leen_alkhier_store/data/responses/user_login_response.dart';
import 'package:leen_alkhier_store/data/responses/user_register_response.dart';
import 'package:leen_alkhier_store/data/responses/user_resend_otp.dart';
import 'package:leen_alkhier_store/data/responses/verfiy_new_email_mobile_response.dart';
import 'package:leen_alkhier_store/data/responses/version/app_version_response.dart';
import 'package:leen_alkhier_store/network/networkCallback/NetworkCallback.dart';
import 'package:leen_alkhier_store/utils/Enums.dart';

class AuthRepository {
  static Future<UserLoginResponse> login(
      LoginRequestBody loginRequestBody) async {
    return UserLoginResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v3/auth/login",
        method: HttpMethod.POST,
        requestBody: jsonEncode(loginRequestBody.toMap()))));
  }

  static Future<UserInfoResponse?> getUserInfo() async {
    Map<String, dynamic>? result = await (NetworkCall.makeCall(
      endPoint: "api/v3/get_user",
      method: HttpMethod.GET,
    ));
    if (!result!.containsKey("data")) return null;
    return UserInfoResponse.fromJson(result);
  }

  static Future<ResetPasswordResponse> resetPassword({String? email}) async {
    return ResetPasswordResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v3/password/sms",
        method: HttpMethod.POST,
        requestBody: jsonEncode({"email": email}))));
  }

  static Future<ResponseOtp?> verfiyOtp({String? otp, String? email}) async {
    return ResponseOtp.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v3/verfiy_otp",
        method: HttpMethod.POST,
        requestBody: jsonEncode({"otp": otp, "email": email}))));
  }
  ////////////////////////

  //ResendOtp

  static Future<UserResendOtpResponse?> ResendOtp() async {
    return UserResendOtpResponse.fromJson(await (NetworkCall.makeCall(
      endPoint: "api/v3/otp-send",
      method: HttpMethod.POST,
    )));
  }

  static Future<AppVersionResponse>? getAppVersion() async {
    Map<String, dynamic>? result = await (NetworkCall.makeCall(
      endPoint: "api/v3/last_version",
      method: HttpMethod.GET,
    ) //as FutureOr<Map<String, dynamic>>
        );


    return AppVersionResponse.fromJson(result!);
  }


  static Future<ConfirmPasswordResponse?> confirmPassword(
      {String? email, String? password}) async {
    return ConfirmPasswordResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v3/password/reset",
        method: HttpMethod.POST,
        requestBody: jsonEncode({
          "email": email,
          "password": password,
          "password_confirmation": password
        }))));
  }

  static Future<UserRegisterResponse?> register(
      UserRegisterRequest userRegisterRequest) async {
    return UserRegisterResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v3/auth/register",
        method: HttpMethod.POST,
        requestBody: jsonEncode(userRegisterRequest.toMap()))));
  }

  static Future<UserRegisterResponse> update(
      UserRegisterRequest userUpdateRequest) async {
    return UserRegisterResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v3/update_user",
        method: HttpMethod.POST,
        requestBody: jsonEncode(userUpdateRequest.toMap()))));
  }

  static Future<UserRegisterResponse> updateToken(String? token) async {
    return UserRegisterResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v3/update_user",
        method: HttpMethod.POST,
        requestBody: jsonEncode({"device_token": token}))));
  }

  static Future<BusinessRegisterResponse> registerBusiness(
      BusinessRegisterRequest businessRegisterRequest) async {
    return BusinessRegisterResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v3/add_info",
        method: HttpMethod.POST,
        isMultipart: (businessRegisterRequest.commerical == null &&
                businessRegisterRequest.tax == null)
            ? false
            : true,
        multiPartValues: (businessRegisterRequest.commerical == null &&
                businessRegisterRequest.tax == null)
            ? null
            : [
                if (businessRegisterRequest.tax != null)
                  await MultipartFile.fromPath(
                      "tax", businessRegisterRequest.tax!.path),
                if (businessRegisterRequest.commerical != null)
                  await MultipartFile.fromPath(
                      "commercial", businessRegisterRequest.commerical!.path)
              ],
        requestBody: jsonEncode(businessRegisterRequest.toMap()))));
  }
  static Future<BusinessRegisterResponse> updateBusiness(
      BusinessRegisterRequest businessRegisterRequest) async {
    return BusinessRegisterResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v3/update_info",
        method: HttpMethod.POST,
        isMultipart: (businessRegisterRequest.commerical == null &&
                businessRegisterRequest.tax == null)
            ? false
            : true,
        multiPartValues: (businessRegisterRequest.commerical == null &&
                businessRegisterRequest.tax == null)
            ? null
            : [
                if (businessRegisterRequest.tax != null)
                  await MultipartFile.fromPath(
                      "tax", businessRegisterRequest.tax!.path),
                if (businessRegisterRequest.commerical != null)
                  await MultipartFile.fromPath(
                      "commercial", businessRegisterRequest.commerical!.path)
              ],
        requestBody: jsonEncode(businessRegisterRequest.toMap()))));
  }

//UpdateEmail or Mobile

  static Future<ResponseEmailOrMobile> updateEmailOrMobile(
      {String? email}) async {
    return ResponseEmailOrMobile.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v3/update_email_password",
        method: HttpMethod.POST,
        requestBody: jsonEncode({"email": email}))));
  }

  static Future<ResponseVerfiyNewEmailOrMobile> verfiyNewEmailOrMobile(
      {String? email, String? otp}) async {
    return ResponseVerfiyNewEmailOrMobile.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v3/verfiy_new_mail_password",
        method: HttpMethod.POST,
        requestBody: jsonEncode({"email": email, "otp": otp}))));
  }

  static Future<RemoveAccountResponse> remove_account() async {
    return RemoveAccountResponse.fromJson(await (NetworkCall.makeCall(
      endPoint: "api/v3/delete_account",
      method: HttpMethod.POST,
    )));
  }

  static Future<CheckPasswordResponse> checkPassword(String pass) async {
    return CheckPasswordResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v3/check_password",
        method: HttpMethod.POST,
        requestBody: jsonEncode({
          "password": pass,
        }))));
  }
}
