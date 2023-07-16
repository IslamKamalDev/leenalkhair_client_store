class EmployeeProfileResponse {
  bool? status;
  Data? data;

  EmployeeProfileResponse({this.status, this.data});

  EmployeeProfileResponse.fromJson(Map<String, dynamic>? json) {
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
  var email;
  var cityId;
  var createdAt;
  var defaultPassword;
  List<Branches>? branches;
  List<Permissions>? permissions;
  var status;
  Data(
      {this.id,
      this.name,
      this.mobileNumber,
      this.email,
      this.cityId,
      this.createdAt,
      this.defaultPassword,
      this.branches,
        this.status,
      this.permissions});

  Data.fromJson(Map<String, dynamic> json) {
    print("json : ${json}");
    id = json['id'];
    name = json['name'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    cityId = json['city_id'];
    createdAt = json['created_at'];
    status = json['status'];
    defaultPassword = json['default_password'];
    if (json['branches'] != null) {
      branches = <Branches>[];
      json['branches'].forEach((v) {
        branches!.add(new Branches.fromJson(v));
      });
    }
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(new Permissions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile_number'] = this.mobileNumber;
    data['email'] = this.email;
    data['city_id'] = this.cityId;
    data['created_at'] = this.createdAt;
    data['status'] = this.status;
    data['default_password'] = this.defaultPassword;
    if (this.branches != null) {
      data['branches'] = this.branches!.map((v) => v.toJson()).toList();
    }
    if (this.permissions != null) {
      data['permissions'] = this.permissions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Branches {
  int? id;
  String? name;

  Branches({this.id, this.name});

  Branches.fromJson(Map<String, dynamic> json) {
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

class Permissions {
  int? id;
  String? name;
  String? nameAr;

  Permissions({this.id, this.name, this.nameAr});

  Permissions.fromJson(Map<String, dynamic> json) {
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
