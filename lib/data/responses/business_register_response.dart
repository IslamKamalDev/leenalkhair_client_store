class BusinessRegisterResponse {
  bool? status;
  Data? data;
  String? message;

  BusinessRegisterResponse({this.status, this.data, this.message});

  BusinessRegisterResponse.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    data = (json['date'] != null) ? new Data.fromJson(json['date']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['date'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  BusinessInfo? businessInfo;

  Data({this.businessInfo});

  Data.fromJson(Map<String, dynamic> json) {
    businessInfo = (json['business_info'] != null)
        ? new BusinessInfo.fromJson(json['business_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.businessInfo != null) {
      data['business_info'] = this.businessInfo!.toJson();
    }
    return data;
  }
}

class BusinessInfo {
  String? registrationNumber;
  int? userId;
  String? idType;
  String? notes;
  String? status;
  String? longitude;
  String? latitude;
  String? address;
  String? updatedAt;
  String? createdAt;
  int? id;

  BusinessInfo(
      {this.registrationNumber,
      this.userId,
      this.idType,
      this.notes,
      this.status,
      this.longitude,
      this.latitude,
      this.address,
      this.updatedAt,
      this.createdAt,
      this.id});

  BusinessInfo.fromJson(Map<String, dynamic> json) {
    registrationNumber = json['registration_number'];
    userId = json['user_id'];
    idType = json['id_type'];
    notes = json['notes'];
    status = json['status'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    address = json['address'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['registration_number'] = this.registrationNumber;
    data['user_id'] = this.userId;
    data['id_type'] = this.idType;
    data['notes'] = this.notes;
    data['status'] = this.status;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['address'] = this.address;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
