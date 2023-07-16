class ResetPasswordResponse {
  bool? status;
  //String code;
  String? mobileNumber;
  String? message;

  ResetPasswordResponse({this.status, this.mobileNumber, this.message});

  ResetPasswordResponse.fromJson(Map<String, dynamic>? json) {
    status = json!['status'] ?? false;
    //code = json['code'] ?? null;
    mobileNumber = json['mobile_number']?.toString() ?? '';
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    // data['code'] = this.code;
    data['mobile_number'] = this.mobileNumber;
    data['message'] = this.message;
    return data;
  }
}
