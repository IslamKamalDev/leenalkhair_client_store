class CheckBranchOrdersResponse {
  bool? status;
  bool? orders;

  CheckBranchOrdersResponse({this.status, this.orders});

  CheckBranchOrdersResponse.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    orders = json['orders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['orders'] = this.orders;
    return data;
  }
}
