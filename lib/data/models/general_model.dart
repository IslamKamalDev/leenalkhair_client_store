class GeneralModel {
  var status;
  var message;
  Errors? errors;

  GeneralModel({this.status, this.message, this.errors});

  GeneralModel.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    message = json['message'];
    errors =
        json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    return data;
  }
}

class Errors {
  bool? status;
  Message? message;

  Errors({this.status, this.message});

  Errors.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Message {
  List<String>? firstName;
  List<String>? lastName;
  List<String>? email;
  List<String>? mobileNumber;
  List<String>? businessInfoId;

  Message(
      {this.firstName,
      this.lastName,
      this.email,
      this.mobileNumber,
      this.businessInfoId});

  Message.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'] == null
        ? firstName
        : json['first_name'].cast<String>();
    lastName =
        json['last_name'] == null ? lastName : json['last_name'].cast<String>();
    email = json['email'] == null ? email : json['email'].cast<String>();
    mobileNumber = json['mobile_number'] == null
        ? mobileNumber
        : json['mobile_number'].cast<String>();
    businessInfoId = json['business_info_id'] == null
        ? businessInfoId
        : json['business_info_id'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['business_info_id'] = this.businessInfoId;
    return data;
  }
}
