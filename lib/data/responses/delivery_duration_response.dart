class DeliveryDurationResponse {
  bool? status;
  String? message;
  List<DeliveryDuration>? data;

  DeliveryDurationResponse({this.status, this.message, this.data});

  DeliveryDurationResponse.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new DeliveryDuration.fromJson(v));
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

class DeliveryDuration {
  int? id;
  String? name;

  DeliveryDuration({this.id, this.name});

  DeliveryDuration.fromJson(Map<String, dynamic> json) {
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
