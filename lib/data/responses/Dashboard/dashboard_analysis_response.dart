class DashboardAnalysisResponse {
  var purchases;
  var ordersNumber;
  var returnes;
  var taxes;
  List<ReceivedOrders>? receivedOrders;
  List<ReceivedOrdersDays>? receivedOrdersDays;
  List<Products>? products;
  List<Branches>? branches;
  List<Cities>? cities;

  DashboardAnalysisResponse(
      {this.purchases,
      this.ordersNumber,
      this.returnes,
      this.taxes,
      this.receivedOrders,
      this.receivedOrdersDays,
      this.products,
      this.branches,
      this.cities});

  DashboardAnalysisResponse.fromJson(Map<String, dynamic>? json) {
    purchases = json!['purchases'];
    ordersNumber = json['orders_number'];
    returnes = json['returnes'];
    taxes = json['taxes'];
    if (json['received_orders'] != null) {
      receivedOrders = <ReceivedOrders>[];
      json['received_orders'].forEach((v) {
        receivedOrders!.add(new ReceivedOrders.fromJson(v));
      });
    }
    if (json['received_orders_days'] != null) {
      receivedOrdersDays = <ReceivedOrdersDays>[];
      json['received_orders_days'].forEach((v) {
        receivedOrdersDays!.add(new ReceivedOrdersDays.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    if (json['branches'] != null) {
      branches = <Branches>[];
      json['branches'].forEach((v) {
        branches!.add(new Branches.fromJson(v));
      });
    }
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(new Cities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['purchases'] = this.purchases;
    data['orders_number'] = this.ordersNumber;
    data['returnes'] = this.returnes;
    data['taxes'] = this.taxes;
    if (this.receivedOrders != null) {
      data['received_orders'] =
          this.receivedOrders!.map((v) => v.toJson()).toList();
    }
    if (this.receivedOrdersDays != null) {
      data['received_orders_days'] =
          this.receivedOrdersDays!.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.branches != null) {
      data['branches'] = this.branches!.map((v) => v.toJson()).toList();
    }
    if (this.cities != null) {
      data['cities'] = this.cities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReceivedOrders {
  var month;
  var count;

  ReceivedOrders({this.month, this.count});

  ReceivedOrders.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['count'] = this.count;
    return data;
  }
}

class ReceivedOrdersDays {
  var month;
  var count;

  ReceivedOrdersDays({this.month, this.count});

  ReceivedOrdersDays.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['count'] = this.count;
    return data;
  }
}

class Products {
  Name? name;
  var quantity;
  var total;

  Products({this.name, this.quantity, this.total});

  Products.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    quantity = json['quantity'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    return data;
  }
}

class Name {
  var en;
  var ar;

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

class Branches {
  var quantity;
  var total;
  var name;

  Branches({this.quantity, this.total, this.name});

  Branches.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    total = json['total'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    data['name'] = this.name;
    return data;
  }
}

/*class Cities {
  Name name;
  var numberOrders;
  var total;

  Cities({this.name, this.numberOrders, this.total});

  Cities.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    numberOrders = json['number_orders'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.name != null) {
      data['name'] = this.name.toJson();
    }
    data['number_orders'] = this.numberOrders;
    data['total'] = this.total;
    return data;
  }
}*/

class Cities {
  var name;
  var numberOrders;
  var total;

  Cities({this.name, this.numberOrders, this.total});

  Cities.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    numberOrders = json['number_orders'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['number_orders'] = this.numberOrders;
    data['total'] = this.total;
    return data;
  }
}
