class ContactUs {
  bool? status;
  String? message;
  String? data;

  ContactUs({this.status, this.message, this.data});

  ContactUs.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['data'] = this.message;
    return data;
  }
}
