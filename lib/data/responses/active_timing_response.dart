class ActiveTimingResponse {
  bool? status;
  String? message;
  List<ActiveTimeModel>? data;

  ActiveTimingResponse({this.status, this.message, this.data});

  ActiveTimingResponse.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    message = json['message'];
    if (json['data'] != null) {
      // ignore: deprecated_member_use
      // data =  List<ActiveTimeModel>();
      data = <ActiveTimeModel>[];
      json['data'].forEach((v) {
        data!.add(new ActiveTimeModel.fromJson(v));
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

class ActiveTimeModel {
  int? id;
  String? name;
  String? time;
  int? active;
  String? currentDate;

  ActiveTimeModel(
      {this.id, this.name, this.time, this.active, this.currentDate});

  ActiveTimeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    time = json['time'];
    active = json['active'];
    currentDate = json['current_date'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.name != null) {
      data['name'] = this.name;
    }
    data['time'] = this.time;
    data['active'] = this.active;
    data['current_date'] = this.currentDate;
    return data;
  }
}

class Name {
  String? en;
  String? ar;

  Name({this.en, this.ar});

  Name.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['ar'] = this.ar;
    return data;
  }
}
