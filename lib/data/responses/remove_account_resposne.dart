class RemoveAccountResponse {
  bool? status;

  RemoveAccountResponse({this.status});

  RemoveAccountResponse.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    return data;
  }
}