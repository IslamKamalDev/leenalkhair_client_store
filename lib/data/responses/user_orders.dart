class OrdersResponse {
  var status;
  List<OrderModel>? data;
  var currentPage;
  var firstPageUrl;
  var from;
  var lastPage;
  var lastPageUrl;
  List<Links>? links;
  var nextPageUrl;
  var path;
  var perPage;
  var prevPageUrl;
  var to;
  var total;

  OrdersResponse(
      {this.status,
      this.data,
      this.currentPage,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  OrdersResponse.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    if (json['data'] != null) {
      data = <OrderModel>[];
      // new List<OrderModel>();

      json['data'].forEach((v) {
        data!.add(new OrderModel.fromJson(v));
      });
    }
    currentPage = json['current_page'];
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      // new List<Links>();
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['current_page'] = this.currentPage;
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class OrderModel {
  var id;
  var refrenceNumber;
  var total;
  var status_en;
  var status_ar;
  var branch_name;
  var orderDate;
  var timingName;
  TimingName? timingName2;
  var rating;

  OrderModel(
      {this.id,
      this.refrenceNumber,
      this.total,
      this.status_en,
      this.status_ar,
      this.branch_name,
      this.orderDate,
      this.timingName,
      this.timingName2,
      this.rating});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refrenceNumber = json['refrence_number'];
    total =
        (json['total'] != null) ? double.parse(json['total'].toString()) : 0.0;
    status_en = json['status'];
    status_ar = json['status_ar'];
    branch_name = json['branch_name'];
    orderDate = json['order_date'];
    rating = json['rate'];
    timingName2 = TimingName.fromJson(json['timing_name']);
    // if (json['products'] != null) {
    //   products = new List<Products>();
    //   json['products'].forEach((v) {
    //     products.add(new Products.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['refrence_number'] = this.refrenceNumber;
    data['total'] = this.total;
    data['status'] = this.status_en;
    data['branch_name'] = this.branch_name;
    data['status_ar'] = this.status_ar;
    data['order_date'] = this.orderDate;
    data['rating'] = this.rating;
    // data['start_date'] = this.startDate;
    // data['end_date'] = this.endDate;
    // data['duration_name'] = this.durationName;
    // if (this.timingName != null) {
    //   data['timing_name'] = this.timingName;
    // }
    // if (this.products != null) {
    //   data['products'] = this.products.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class TimingName {
  String? en;
  String? ar;

  TimingName({this.en, this.ar});

  TimingName.fromJson(Map<String, dynamic> json) {
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

class Products {
  var id;
  TimingName? timeName;
  var image;
  var imageUrl;
  Pivot? pivot;
  var weight;
  var returnsCount;
  var unit_name_ar;
  var unit_name_en;
  var unitId;
  Products(
      {
        this.id,
        this.timeName,
      this.image,
      this.imageUrl,
      this.pivot,
        this.weight,
        this.unitId,
      this.unit_name_en,
      this.unit_name_ar,
      this.returnsCount});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timeName = TimingName.fromJson(json['name']);
    unitId = json['unit_id'];
    image = json['image'];
    weight = json['weight'];

    imageUrl = json['image_url'];
    unit_name_en = json['unit_name_en'];
    unit_name_ar = json['unit_name_ar'];
    returnsCount = json['returns_count'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.timeName != null) {
      data['name'] = this.timeName;
    }
    data['weight'] = this.weight;
    data['unit_id'] = this.unitId;
    data['image'] = this.image;
    data['unit_name_en'] = this.unit_name_en;
    data['unit_name_ar'] = this.unit_name_ar;
    data['image_url'] = this.imageUrl;
    data['returns_count'] = this.returnsCount;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  var orderId;
  var productId;
  var price;
  var quantity;
  var total;
  var returnedQuantity;
  var unit_id;
  var lastQuantity;
  Pivot(
      {this.orderId,
      this.productId,
      this.price,
      this.quantity,
      this.total,
        this.unit_id,
        this.lastQuantity,
      this.returnedQuantity});

  Pivot.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    productId = json['product_id'];
    price = double.parse(json['price'].toString());
    quantity = json['quantity'].toDouble();
    total = double.parse(json['total'].toString());
    returnedQuantity = json['returned_quantity'];
    unit_id = json['unit_id'];
    lastQuantity = json['last_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['returned_quantity'] = this.returnedQuantity;
    data['unit_id'] = this.unit_id;
    data['last_quantity'] = this.lastQuantity;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
