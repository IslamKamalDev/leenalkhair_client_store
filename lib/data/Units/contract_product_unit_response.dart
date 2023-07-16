class ContractProductUnitResponse {
  bool? status;
  List<Data>? data;

  ContractProductUnitResponse({this.status, this.data});

  ContractProductUnitResponse.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? nameAr;
  int? price;
  int? quantity;
  int? offerPrice;
  int? weight;
  bool? onContract;
  Data({this.id, this.name, this.nameAr, this.price, this.quantity,this.offerPrice,this.weight,this.onContract});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    price = json['price'];
    weight = json['weight'];
    quantity = json['quantity'];
    offerPrice = json['offer_price'];
    onContract = json['on_contract'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    data['price'] = this.price;
    data['weight'] = this.weight;
    data['quantity'] = this.quantity;
    data['offer_price'] = this.offerPrice;
    data['on_contract'] = this.onContract;
    return data;
  }
}