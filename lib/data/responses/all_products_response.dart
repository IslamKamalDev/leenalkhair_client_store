class AllProductsResponse {
  bool? status;
  String? message;
  List<ProductModel>? data;

  AllProductsResponse({this.status, this.message, this.data});

  AllProductsResponse.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new ProductModel.fromJson(v));
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

class ProductModel {
  int? id;
  int? categoryId;
  String? name;
  String? description;
  String? image;
  String? imageUrl;
  String? minQuantity;
  bool? contractStatus;
  bool? productStatus;

  ProductModel({
    this.id,
    this.categoryId,
    this.name,
    this.description,
    this.image,
    this.imageUrl,
    this.minQuantity,
    this.contractStatus,
    this.productStatus,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    imageUrl = json['image_url'];
    minQuantity = json['min_quantity'];
    contractStatus = json['contract_status'];
    productStatus = json['product_status'];

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
    data['contract_status'] = this.contractStatus;
    data['product_status'] = this.productStatus;
    return data;
  }
}

class Unit {
  int? id;
  String? name_en;
  String? name_ar;

  Unit({this.id, this.name_en, this.name_ar});

  Unit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name_en = json['name'];
    name_ar = json['name_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name_en;
    data['name_ar'] = this.name_ar;
    return data;
  }
}
