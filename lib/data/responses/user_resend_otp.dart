class UserResendOtpResponse {
  bool? status;
  String? message;
  String? code;

  UserResendOtpResponse({this.status, this.message, this.code});
  UserResendOtpResponse.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    message = json['message'];
    code = json['code'];
  }
}
