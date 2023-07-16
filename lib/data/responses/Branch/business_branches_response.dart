class BusinessBranchesResponse {
  bool? status;
  List<Branches>? branches;

  BusinessBranchesResponse({this.status, this.branches});

  BusinessBranchesResponse.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    if (json['branches'] != null) {
      branches = <Branches>[];
      json['branches'].forEach((v) {
        branches!.add(new Branches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.branches != null) {
      data['branches'] = this.branches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Branches {
  var id;
  var name;
  var mobileNumber;
  var latitude;
  var longitude;
  var isMain;
  var status;
  String? address;
  City? city;
  Branches(
      {this.id,
      this.name,
      this.mobileNumber,
      this.latitude,
      this.longitude,
      this.isMain,
        this.address,
      this.status,
      this.city});

  Branches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobileNumber = json['mobile_number'];
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
    data['address'] = this.address;
    data['status'] = this.status;
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }

  bool operator ==(dynamic other) =>
      other != null && other is Branches && this.id == other.id;

  @override
  int get hashCode => super.hashCode;
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
