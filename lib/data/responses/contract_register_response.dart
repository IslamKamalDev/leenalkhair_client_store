class ContractRegisterResponse {
  bool? status;
  String? message;
  String? contractStatus;

  ContractRegisterResponse({this.status, this.message, this.contractStatus});

  ContractRegisterResponse.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    message = json['message'];
    contractStatus = json['contract_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['contract_status'] = this.contractStatus;
    return data;
  }
}
