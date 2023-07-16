class AllEmployeesListResponse {
  bool? status;
  String? message;
  List<Data>? data;

  AllEmployeesListResponse({this.status, this.message, this.data});

  AllEmployeesListResponse.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  var id;
  var firstName;
  var lastName;
  var businessInfoId;
  var city;
  var phone;
  var status;
  Data(
      {this.id,
      this.firstName,
      this.lastName,
      this.businessInfoId,
      this.city,
        this.status,
      this.phone});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    businessInfoId = json['business_info_id'];
    city = json['city'];
    status = json['status'];
    phone = json['mobile_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['business_info_id'] = this.businessInfoId;
    data['city'] = this.city;
    data['mobile_number'] = this.phone;
    data['status'] = this.status;
    return data;
  }
}
