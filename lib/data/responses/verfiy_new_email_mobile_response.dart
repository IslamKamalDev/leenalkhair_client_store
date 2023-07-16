class ResponseVerfiyNewEmailOrMobile {
  bool? status;
  String? message;
  ResponseVerfiyNewEmailOrMobile({this.status, this.message});
  ResponseVerfiyNewEmailOrMobile.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    message = json['message'];
  }
}
