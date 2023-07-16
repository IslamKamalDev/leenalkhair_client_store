class ContractProductsResponse {
  bool? status;
  String? message;
  List<ContractProductsModel>? data;

  ContractProductsResponse({this.status = false, this.message = '', this.data});

  ContractProductsResponse.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new ContractProductsModel.fromJson(v));
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

class ContractProductsModel {
  var categoryId;
  var productId;
  var name;
  var nameAr;
  var categoryName;
  var categoryNameAr;
  var image;
  var imageUrl;
  var minQuantity;
  var availabe;
  var multiUnits;
  var priceOffer;
  var quantityPerOrder;
  var contractId;
  List<Units>? units;

  ContractProductsModel(
      {this.categoryId,
        this.productId,
        this.name,
        this.nameAr,
        this.categoryName,
        this.categoryNameAr,
        this.image,
        this.imageUrl,
        this.minQuantity,
        this.availabe,
        this.multiUnits,
        this.priceOffer,
        this.quantityPerOrder,
        this.contractId,
        this.units});

  ContractProductsModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    productId = json['product_id'];
    name = json['name'];
    nameAr = json['name_ar'];
    categoryName = json['category_name'];
    categoryNameAr = json['category_name_ar'];
    image = json['image'];
    imageUrl = json['image_url'];
    minQuantity = json['min_quantity'];
    availabe = json['availabe'];
    multiUnits = json['multi_units'];
    priceOffer = json['price_offer'];
    quantityPerOrder = json['quantity_per_order'];
    contractId = json['contract_id'];
    if (json['units'] != null) {
      units = <Units>[];
      json['units'].forEach((v) {
        units!.add(new Units.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    data['category_name'] = this.categoryName;
    data['category_name_ar'] = this.categoryNameAr;
    data['image'] = this.image;
    data['image_url'] = this.imageUrl;
    data['min_quantity'] = this.minQuantity;
    data['availabe'] = this.availabe;
    data['multi_units'] = this.multiUnits;
    data['price_offer'] = this.priceOffer;
    data['quantity_per_order'] = this.quantityPerOrder;
    data['contract_id'] = this.contractId;
    if (this.units != null) {
      data['units'] = this.units!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  }



class Units {
  var unitId;
  var unit;
  var unitAr;
  var weight;
  var quantityPerUnit;
  var price;
  var offerPrice;

  Units(
      {this.unitId,
        this.unit,
        this.unitAr,
        this.weight,
        this.quantityPerUnit,
        this.price,
        this.offerPrice});

  Units.fromJson(Map<String, dynamic> json) {
    unitId = json['unit_id'];
    unit = json['unit'];
    unitAr = json['unit_ar'];
    weight = json['weight'];
    quantityPerUnit = json['quantity_per_unit'];
    price = json['price'];
    offerPrice = json['offer_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unit_id'] = this.unitId;
    data['unit'] = this.unit;
    data['unit_ar'] = this.unitAr;
    data['weight'] = this.weight;
    data['quantity_per_unit'] = this.quantityPerUnit;
    data['price'] = this.price;
    data['offer_price'] = this.offerPrice;
    return data;
  }

  @override
  bool operator ==(Object other) {
    return other != null && other is Units && hashCode == other.hashCode;
  }


  @override
  int get hashCode => unitId;
}
