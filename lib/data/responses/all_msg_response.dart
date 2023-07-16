class AllMsgResponse {
  bool? status;
  List<Data>? data;
  String? message;

  AllMsgResponse({this.status, this.data});

  AllMsgResponse.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    if (json['message'] != null) {
      message = json['message'];
    }
    if (json['data'] != null) {
      // data = new List<Data>();
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? userType;
  String? content;
  String? createdAt;

  Data({this.userType, this.content, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    userType = json['user_type'];
    content = json['content'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_type'] = this.userType;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    return data;
  }
}
