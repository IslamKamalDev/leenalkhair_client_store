class TypesResponse {
  List<BusinessType>? data;
  String? message;
  bool? status;

  TypesResponse({this.data, this.message, this.status});

  TypesResponse.fromJson(Map<String, dynamic>? json) {
    if (json!['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new BusinessType.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class BusinessType {
  int? id;
  String? name;

  BusinessType({this.id, this.name});

  BusinessType.fromJson(Map<String, dynamic> json) {
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
