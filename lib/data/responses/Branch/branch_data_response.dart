class BranchDataResponse {
  bool? status;
  Data? data;

  BranchDataResponse({this.status, this.data});

  BranchDataResponse.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
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
  City? city;
  var address;
  Data(
      {this.id,
      this.name,
        this.address,
      this.mobileNumber,
      this.latitude,
      this.longitude,
      this.isMain,
      this.status,
      this.city});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? "";
    mobileNumber = json['mobile_number'] ?? "";
    latitude = json['latitude'];
    longitude = json['longitude'];
    isMain = json['is_main'];
    status = json['status'];
    address = json['address'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
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
    data['address'] = this.address;
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }
}

class City {
  int? id;
  String? name;

  City({this.id, this.name});

  City.fromJson(Map<String, dynamic> json) {
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
