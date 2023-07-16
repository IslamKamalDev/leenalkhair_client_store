class UserRegisterResponse {
  bool? status;
  String? message;
  Data? data;
  Errors? errors;
  String? token;

  UserRegisterResponse({this.status, this.message, this.data, this.token});

  UserRegisterResponse.fromJson(Map<String, dynamic>? json) {
    errors =
        (json!['errors']) != null ? new Errors.fromJson(json['errors']) : null;
    status = json['status'];
    message = json['message'];
    token = json['token'];
    if (json['data'] != null) data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Errors {
  Message? message;
  bool? status;

  Errors({this.message, this.status});

  Errors.fromJson(Map<String, dynamic> json) {
    message = new Message.fromJson(json['message']);
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Message {
  List<dynamic>? email;

  Message({this.email});

  Message.fromJson(Map<String, dynamic> json) {
    email = (json['email'] == null) ? json['mobile_number'] : json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    return data;
  }
}

class Data {
  String? firstName;
  String? lastName;
  String? email;
  String? cityId;
  String? mobileNumber;
  int? countryId;
  String? status;
  int? countryCode;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data({
    this.firstName,
    this.lastName,
    this.email,
    this.cityId,
    this.mobileNumber,
    this.countryId,
    this.status,
    this.countryCode,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  Data.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    cityId = json['city_id'].toString();
    mobileNumber = json['mobile_number'];
    countryId = json['country_id'];
    status = json['status'];
    countryCode = json['country_code'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['city_id'] = this.cityId;
    data['mobile_number'] = this.mobileNumber;
    data['country_id'] = this.countryId;
    data['status'] = this.status;
    data['country_code'] = this.countryCode;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;

    return data;
  }
}
