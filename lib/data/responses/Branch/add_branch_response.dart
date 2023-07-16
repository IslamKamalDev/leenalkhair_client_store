class BranchResponse {
  bool? status;
  String? message;
  Data? data;

  BranchResponse({this.status, this.message, this.data});

  BranchResponse.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  var id;
  var name;
  var mobileNumber;
  var latitude;
  var longitude;
  var isMain;
  var status;

  Data(
      {this.id,
      this.name,
      this.mobileNumber,
      this.latitude,
      this.longitude,
      this.isMain,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobileNumber = json['mobile_number'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isMain = json['is_main'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile_number'] = this.mobileNumber;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['is_main'] = this.isMain;
    data['status'] = this.status;
    return data;
  }
}
