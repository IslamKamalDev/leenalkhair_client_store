class UserLoginResponse {
  bool? status;
  String? error;
  String? message;
  String? token;
  Data? data;

  UserLoginResponse(
      {this.status, this.error, this.message, this.token, this.data});

  UserLoginResponse.fromJson(Map<String, dynamic>? json) {
    print("json : ${json}");
    status = json!['status'];
    error = json['error'];
    message = json['message'];
    token = json['token'];
    data = (json['data'] != null) ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['error'] = this.error;
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.data != String) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

}

class Data {
  Data({
    required this.businessInfo,
    required this.businessInfoStatus,
    required this.contract,
    required this.contractStatus,
    required this.user,
  });
  var  businessInfo;
  var businessInfoStatus;
  var contract;
  var contractStatus;
  User? user;

  Data.fromJson(Map<String, dynamic> json) {
    businessInfo = json['business_info'];
    businessInfoStatus = json['business_info_status'];
    contract = json['contract'];
    contractStatus = json['contract_status'];
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['business_info'] = businessInfo;
    _data['business_info_status'] = businessInfoStatus;
    _data['contract'] = contract;
    _data['contract_status'] = contractStatus;
    _data['user'] = user!.toJson();
    return _data;
  }
}

class User {
  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
    required this.businessInfoId,
    required this.cityId,
    required this.countryId,
    required this.status,
    required this.defaultPassword,
  });
  var firstName;
  var lastName;
  var email;
  var mobileNumber;
  var businessInfoId;
  var cityId;
  var countryId;
  var status;
  var defaultPassword;

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    businessInfoId = json['business_info_id'];
    cityId = json['city_id'];
    countryId = json['country_id'];
    status = json['status'];
    defaultPassword = json['default_password'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['email'] = email;
    _data['mobile_number'] = mobileNumber;
    _data['business_info_id'] = businessInfoId;
    _data['city_id'] = cityId;
    _data['country_id'] = countryId;
    _data['status'] = status;
    _data['default_password'] = defaultPassword;
    return _data;
  }
}
