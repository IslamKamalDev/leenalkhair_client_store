import 'package:leen_alkhier_store/data/responses/user_orders.dart';

class OrderrDetails {
  int? id;
  int? refrenceNumber;
  String? branch;
  var branchId;
  int? contractId;
  double? total;
  String? status;
  String? status_ar;
  String? orderDate;
  String? startDate;
  String? endDate;
  String? deliveryDate;
  String? durationName;
  String? timingName;
  TimingName? timingName2;
  String? timingName_en;
  bool? returns;
  List<Products>? products;
  double? tax, charge, discount;
  Notes? notes;
  var draft;
  OrderrDetails(
      {this.id,
      this.refrenceNumber,
      this.branch,
        this.branchId,
      this.contractId,
      this.total,
      this.status,
      this.status_ar,
      this.orderDate,
      this.startDate,
      this.deliveryDate,
      this.endDate,
      this.charge,
      this.tax,
      this.discount,
      this.durationName,
      this.timingName,
      this.products,
      this.returns,
      this.timingName2,
        this.draft,
      this.notes});

  OrderrDetails.fromJson(Map<String, dynamic>? json) {
    tax = double.parse(json!['data']['tax'].toString());
    discount = double.parse(json['data']['discount'].toString());
    charge = double.parse(json['data']['charge'].toString());
    id = json['data']['id'];
    branchId = json['data']['branch_id'];
    branch = json['data']['branch'];
    contractId = json['data']['contract_id'];
    deliveryDate = json['data']['delivery_time'];
    refrenceNumber = json['data']['refrence_number'];
    total = (json['data']['total'] != null)
        ? double.parse(json['data']['total'].toString())
        : 0.0;
    status = json['data']['status'].toString();
    status_ar = json['data']['status_ar'].toString();
    orderDate = json['data']['order_date'];
    startDate = json['data']['start_date'];
    endDate = json['data']['end_date'];
    durationName = json['data']['duration_name'];
    //  timingName = json['timing_name'];
    returns = json['data']['returns'];
    timingName2 = TimingName.fromJson(json['data']['timing_name']);
    if (json['data']['products'] != null) {
      products = <Products>[];
      //  new List<Products>();
      json['data']['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    draft = json['data']['draft'];

    notes = json['data']['notes'] != null
        ? new Notes.fromJson(json['data']['notes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['refrence_number'] = this.refrenceNumber;
    data['total'] = this.total;
    data['branch'] = this.branch;
    data['branch'] = this.branch;
    data['contract_id'] = this.contractId;
    data['status'] = this.status;
    data['status_ar'] = this.status_ar;
    data['order_date'] = this.orderDate;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['duration_name'] = this.durationName;
    // if (this.timingName != null) {
    //   data['timing_name'] = this.timingName;
    // }
    data['returns'] = this.returns;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.notes != null) {
      data['notes'] = this.notes!.toJson();
    }
    data['draft'] = this.draft;

    return data;
  }
}

class Notes {
  var id;
  var message;
  List<Images>? images;

  Notes({this.id, this.message, this.images});

  Notes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  var id;
  var image;
  var imageUrl;

  Images({this.id, this.image, this.imageUrl});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
