class ContractInfoResponse {
  bool? status;
  List<ContractModel>? data;

  ContractInfoResponse({this.status, this.data});

  ContractInfoResponse.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new ContractModel.fromJson(v));
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

class ContractModel {
  String? id;
  String? startDate;
  String? endDate;
  Timing? timing;
  Timing? duration;
  String? status;
  PricingType? pricingType;
  String? pricingsubType;
  String? pricingsubTypeAr;
  ContractModel(
      {this.startDate,
      this.endDate,
      this.timing,
      this.duration,
      this.id,
      this.pricingType,
      this.pricingsubType,
      this.pricingsubTypeAr});

  ContractModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    status = json['status'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    timing = Timing.fromJson(json['timing']);
    duration = (json['duration'] != null)
        ? new Timing.fromJson(json['duration'])
        : null;
    pricingType = json['pricingType'] != null
        ? new PricingType.fromJson(json['pricingType'])
        : null;
    pricingsubType = json['pricingsubType'];
    pricingsubTypeAr = json['pricingsubType_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    if (this.timing != null) {
      data['timing'] = this.timing!.toJson();
    }
    if (this.duration != null) {
      data['duration'] = this.duration!.toJson();
    }
    if (this.pricingType != null) {
      data['pricingType'] = this.pricingType!.toJson();
    }
    data['pricingsubType'] = this.pricingsubType;
    data['pricingsubType_ar'] = this.pricingsubTypeAr;
    return data;
  }
}

class Timing {
  int? id;
  String? name;

  Timing({this.id, this.name});

  Timing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class PricingType {
  int? id;
  String? name;
  String? nameAr;

  PricingType({this.id, this.name, this.nameAr});

  PricingType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    return data;
  }
}
