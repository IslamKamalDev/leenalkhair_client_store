class SendMsgResponse {
  bool? status;
  String? message;
  Data? data;

  SendMsgResponse({this.status, this.message, this.data});

  SendMsgResponse.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userType;
  String? content;
  int? conversationId;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.userType,
      this.content,
      this.conversationId,
      this.userId,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    userType = json['user_type'];
    content = json['content'];
    conversationId = json['conversation_id'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_type'] = this.userType;
    data['content'] = this.content;
    data['conversation_id'] = this.conversationId;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
