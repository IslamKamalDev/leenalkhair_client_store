class ResponseEmailOrMobile {
  bool? status;
  String? message;
  ResponseEmailOrMobile({this.status, this.message});
  ResponseEmailOrMobile.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    message = json['message'];
  }
}
