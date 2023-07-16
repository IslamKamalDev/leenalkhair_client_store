class CreateOrderResponse {
  bool? status;
  String? message;
  Data? data;

  CreateOrderResponse({this.status, this.message, this.data});

  CreateOrderResponse.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    message = json['message'];
    if (json['data'] != null) data = new Data.fromJson(json['data']);
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
  List<Products>? products;
  Contract? contract;
  Order? order;

  Data({this.products, this.contract, this.order});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    contract = Contract.fromJson(json['contract']);
    order = new Order.fromJson(json['order']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.contract != null) {
      data['contract'] = this.contract!.toJson();
    }
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    return data;
  }
}

class Products {
  int? id;
  int? categoryId;
  String? name;
  String? description;
  String? image;
  String? imageUrl;
  String? minQuantity;
  String? status;
  // Unit? unit;

  Products({
    this.id,
    this.categoryId,
    this.name,
    this.description,
    this.image,
    this.imageUrl,
    this.minQuantity,
    this.status,
    // this.unit
  });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    imageUrl = json['image_url'];
    minQuantity = json['min_quantity'];
    status = json['status'];
    // unit = new Unit.fromJson(json['unit']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['image_url'] = this.imageUrl;
    data['min_quantity'] = this.minQuantity;
    data['status'] = this.status;
    // if (this.unit != null) {
    //   data['unit'] = this.unit!.toJson();
    // }
    return data;
  }
}

class Unit {
  int? id;
  String? name;

  Unit({this.id, this.name});

  Unit.fromJson(Map<String, dynamic> json) {
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

class Contract {
  String? startDate;
  String? endDate;
  Unit? timing;
  Unit? duration;

  Contract({this.startDate, this.endDate, this.timing, this.duration});

  Contract.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    timing = new Unit.fromJson(json['timing']);
    duration = new Unit.fromJson(json['duration']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    if (this.timing != null) {
      data['timing'] = this.timing!.toJson();
    }
    if (this.duration != null) {
      data['duration'] = this.duration!.toJson();
    }
    return data;
  }
}

class Order {
  int? id;
  int? refrenceNumber;
  int? contractId;
  int? userId;
  Null driverId;
  var subTotal;
  double? sum;
  int? discount;
  int? tax;
  int? charge;
  String? status;
  Null assignedDate;
  Null completedDate;
  String? createdAt;
  String? updatedAt;

  Order(
      {this.id,
      this.refrenceNumber,
      this.contractId,
      this.userId,
      this.driverId,
      this.subTotal,
      this.sum,
      this.discount,
      this.tax,
      this.charge,
      this.status,
      this.assignedDate,
      this.completedDate,
      this.createdAt,
      this.updatedAt});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refrenceNumber = json['refrence_number'];
    contractId = json['contract_id'];
    userId = json['user_id'];
    driverId = json['driver_id'];
    subTotal = json['sub_total'];
    sum = double.parse(json['sum'].toString());
    discount = json['discount'];
    tax = json['tax'];
    charge = json['charge'];
    status = json['status'];
    assignedDate = json['assigned_date'];
    completedDate = json['completed_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['refrence_number'] = this.refrenceNumber;
    data['contract_id'] = this.contractId;
    data['user_id'] = this.userId;
    data['driver_id'] = this.driverId;
    data['sub_total'] = this.subTotal;
    data['sum'] = this.sum;
    data['discount'] = this.discount;
    data['tax'] = this.tax;
    data['charge'] = this.charge;
    data['status'] = this.status;
    data['assigned_date'] = this.assignedDate;
    data['completed_date'] = this.completedDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
