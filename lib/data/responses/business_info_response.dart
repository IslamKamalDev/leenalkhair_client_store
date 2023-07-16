class BusinessInfoResponse {
  bool? status;
  String? message;
  Data? data;

  BusinessInfoResponse({this.status, this.message, this.data});

  BusinessInfoResponse.fromJson(Map<String, dynamic>? json) {
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
  int? businessId;
  String? tradeMark;
  String? registrationNumber;
  String? name;
  int? taxNumber;
  String? notes;
  String? latitude;
  String? longitude;
  String? address;
  int? sectorId;
  Type? type;
  List<Files>? files;
  Type? city;

  Data(
      {this.businessId,
      this.tradeMark,
      this.registrationNumber,
      this.name,
      this.taxNumber,
      this.notes,
      this.latitude,
      this.longitude,
      this.address,
      this.type,
      this.sectorId,
      this.files,
      this.city});

  Data.fromJson(Map<String, dynamic> json) {
    businessId = json['business_id'];
    tradeMark = json['trade_mark'];
    registrationNumber = json['registration_number'];
    name = json['name'];
    taxNumber = json['tax_number'];
    notes = json['notes'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    sectorId = json['sector_id'];
    address = json['address'];
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
    city = json['city'] != null ? new Type.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business_id'] = this.businessId;
    data['trade_mark'] = this.tradeMark;
    data['registration_number'] = this.registrationNumber;
    data['name'] = this.name;
    data['tax_number'] = this.taxNumber;
    data['notes'] = this.notes;
    data['sector_id'] = this.sectorId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }
}

class Type {
  int? id;
  String? name;

  Type({this.id, this.name});

  Type.fromJson(Map<String, dynamic> json) {
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

class Files {
  int? id;
  String? fileName;
  String? fileUrl;
  String? type;

  Files({this.id, this.fileName, this.fileUrl,this.type});

  Files.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileName = json['file_name'];
    fileUrl = json['file_url'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['file_name'] = this.fileName;
    data['file_url'] = this.fileUrl;
    data['type'] = this.type;
    return data;
  }
}
