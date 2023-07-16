import 'package:leen_alkhier_store/data/responses/user_orders.dart';

class OrderModel {
  int? id;
  int? refrenceNumber;
  double? total;
  String? status;
  String? orderDate;
  String? timingName;
  TimingName? timingName2;
  String? rating;


  OrderModel(
      {this.id,
        this.refrenceNumber,
        this.total,
        this.status,
        this.orderDate,
        this.timingName,
        this.timingName2,this.rating});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refrenceNumber = json['refrence_number'];
    total =
    (json['total'] != null) ? double.parse(json['total'].toString()) : 0.0;
    status = json['status'];
    orderDate = json['order_date'];
    rating = json['rate'];
    timingName2=TimingName.fromJson(json['timing_name']);

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['refrence_number'] = this.refrenceNumber;
    data['total'] = this.total;
    data['status'] = this.status;
    data['order_date'] = this.orderDate;
    data['rating'] = this.rating;

    return data;
  }
}