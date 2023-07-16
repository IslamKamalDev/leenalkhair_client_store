class UserInfoResponse {
  bool? status;
  bool? businessInfo;
  String? businessInfoStatus;
  bool? contract;
  bool? product;
  String? contractStatus;
  int? draftOrders;
  Data? data;

  UserInfoResponse(
      {this.status,
      this.businessInfo,
      this.businessInfoStatus,
      this.contract,
      this.contractStatus,
      this.product,
      this.draftOrders,
      this.data});

  UserInfoResponse.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    businessInfo = json['business_info'];
    businessInfoStatus = json['business_info_status'];
    contract = json['contract'];
    product = json['product'];
    contractStatus = json['contract_status'];
    draftOrders = json['draft_orders'];
    if (json['data'] != null) data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['business_info'] = this.businessInfo;
    data['business_info_status'] = this.businessInfoStatus;
    data['contract'] = this.contract;
    data['product'] = this.product;
    data['contract_status'] = this.contractStatus;
    data['draft_orders'] = this.draftOrders;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? businessInfoId;
  String? firstName;
  String? lastName;
  String? email;
  int? otp;
  String? emailVerifiedAt;
  String? mobileNumber;
  String? deviceToken;
  int? countryCode;
  String? status;
  int? cityId;
  int? countryId;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.businessInfoId,
      this.firstName,
      this.lastName,
      this.email,
      this.otp,
      this.emailVerifiedAt,
      this.mobileNumber,
      this.deviceToken,
      this.countryCode,
      this.status,
      this.cityId,
      this.countryId,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessInfoId = json['business_info_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    otp = json['otp'];
    emailVerifiedAt = json['email_verified_at'];
    mobileNumber = json['mobile_number'];
    deviceToken = json['device_token'];
    countryCode = json['country_code'];
    status = json['status'];
    cityId = json['city_id'];
    countryId = json['country_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_info_id'] = this.businessInfoId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['otp'] = this.otp;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['mobile_number'] = this.mobileNumber;
    data['device_token'] = this.deviceToken;
    data['country_code'] = this.countryCode;
    data['status'] = this.status;
    data['city_id'] = this.cityId;
    data['country_id'] = this.countryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
