class ContractPricingMethodResponse {
  bool? status;
  String? message;
  Types? types;

  ContractPricingMethodResponse({this.status, this.message, this.types});

  ContractPricingMethodResponse.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    message = json['message'];
    types = json['types'] != null ? new Types.fromJson(json['types']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.types != null) {
      data['types'] = this.types!.toJson();
    }
    return data;
  }
}

class Types {
  List<String?>? subTypes;
  List<String?>? subTypesAr;

  Types({this.subTypes, this.subTypesAr});

  Types.fromJson(Map<String, dynamic> json) {
    subTypes = json['sub_types'].cast<String>();
    subTypesAr = json['sub_types_ar'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_types'] = this.subTypes;
    data['sub_types_ar'] = this.subTypesAr;
    return data;
  }
}
