class SalesReturnedReasonsModel {
  bool? status;
  List<Data>? data;

  SalesReturnedReasonsModel({this.status, this.data});

  SalesReturnedReasonsModel.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  var id;
  var reasonAr;
  var reasonEn;

  Data({this.id, this.reasonAr, this.reasonEn});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reasonAr = json['reason_ar'];
    reasonEn = json['reason_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reason_ar'] = this.reasonAr;
    data['reason_en'] = this.reasonEn;
    return data;
  }

  bool operator ==(dynamic other) =>
      other != null && other is Data && this.id == other.id;

  @override
  int get hashCode => super.hashCode;
}
