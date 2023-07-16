class ReturnedOrderProductDataResponse {
  bool? status;
  SalesData? data;

  ReturnedOrderProductDataResponse({this.status, this.data});

  ReturnedOrderProductDataResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new SalesData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SalesData {
  var id;
  var productId;
  var orderId;
  var returnedReasonId;
  var quantity;
  var notes;
  var clientNotes;
  List<Media>? media;

  SalesData(
      {this.id,
      this.productId,
      this.orderId,
      this.returnedReasonId,
      this.quantity,
      this.notes,
      this.clientNotes,
      this.media});

  SalesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    orderId = json['order_id'];
    returnedReasonId = json['returned_reason_id'];
    quantity = json['quantity'];
    notes = json['notes'];
    clientNotes = json['client_notes'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(new Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['order_id'] = this.orderId;
    data['returned_reason_id'] = this.returnedReasonId;
    data['quantity'] = this.quantity;
    data['notes'] = this.notes;
    data['client_notes'] = this.clientNotes;
    if (this.media != null) {
      data['media'] = this.media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Media {
  var id;
  var image;
  var mediaUrl;
  String? type;
  Media({this.id, this.image, this.mediaUrl, this.type});

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    mediaUrl = json['media_url'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['media_url'] = this.mediaUrl;
    data['type'] = this.type;
    return data;
  }
}
