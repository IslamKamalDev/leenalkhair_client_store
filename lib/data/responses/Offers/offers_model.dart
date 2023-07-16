class OffersModel {
  bool? status;
  List<Offer>? offer;

  OffersModel({this.status, this.offer});

  OffersModel.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    if (json['data'] != null) {
      offer = <Offer>[];
      json['data'].forEach((v) {
        offer!.add(new Offer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.offer != null) {
      data['data'] = this.offer!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Offer {
  int? id;
  int? offerId;
  int? price;
  int? categoryId;
  String? name;
  String? description;
  String? image;
  String? imageUrl;
  String? minQuantity;
  bool? contractStatus;
  bool? productStatus;
  String? unitName;
  String? unitNameAr;
  int? weight;

  Offer(
      {this.id,
      this.offerId,
      this.price,
      this.categoryId,
      this.name,
      this.description,
      this.image,
      this.imageUrl,
      this.weight,
      this.minQuantity,
      this.contractStatus,
      this.productStatus,
      this.unitName,
      this.unitNameAr
      });

  Offer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    offerId = json['offer_id'];
    price = json['price'];
    categoryId = json['category_id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    weight = json['weight'];
    imageUrl = json['image_url'];
    minQuantity = json['min_quantity'];
    contractStatus = json['contract_status'];
    productStatus = json['product_status'];
    unitName = json['unit_name'];
    unitNameAr = json['unit_name_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['offer_id'] = this.offerId;
    data['price'] = this.price;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['weight'] = this.weight;
    data['description'] = this.description;
    data['image'] = this.image;
    data['image_url'] = this.imageUrl;
    data['min_quantity'] = this.minQuantity;
    data['contract_status'] = this.contractStatus;
    data['product_status'] = this.productStatus;
    data['unit_name'] = this.unitName;
    data['unit_name_ar'] = this.unitNameAr;
    return data;
  }
}

