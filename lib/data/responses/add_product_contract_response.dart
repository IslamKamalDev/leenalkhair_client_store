class AddProductToContractResponse {
  AddProductToContractResponse({
    this.status,
    this.message,
    this.data,
  });
  bool? status;
  String? message;
  List<Data>? data;

  AddProductToContractResponse.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    message = json['message'];
    data =json['data']  != null ?
     List.from(json['data']).map((e) => Data.fromJson(e)).toList() : [];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    ;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;

    return _data;
  }
}

class Name {
  Name({
    required this.en,
    required this.ar,
  });
  late final String en;
  late final String ar;

  Name.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['en'] = en;
    _data['ar'] = ar;
    return _data;
  }
}

class Description {
  Description({
    required this.en,
    required this.ar,
  });
  late final String en;
  late final String ar;

  Description.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['en'] = en;
    _data['ar'] = ar;
    return _data;
  }
}
