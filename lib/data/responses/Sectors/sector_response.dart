class SectorResponse {
  bool? status;
  List<Sector>? sector;

  SectorResponse({this.status, this.sector});

  SectorResponse.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    if (json['data'] != null) {
      sector = <Sector>[];
      json['data'].forEach((v) {
        sector!.add(new Sector.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.sector != null) {
      data['data'] = this.sector!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sector {
  var id;
  var name;
  var nameAr;

  Sector({this.id, this.name, this.nameAr});

  Sector.fromJson(Map<String, dynamic> json) {
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
