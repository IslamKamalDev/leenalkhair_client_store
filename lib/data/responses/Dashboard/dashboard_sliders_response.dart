class DashboardSlidersResponse {
  bool? status;
  String? deleteAccount;
  List<FirstSlider>? firstSlider;
  List<FirstSlider>? single;
  List<FirstSlider>? lastSlider;

  DashboardSlidersResponse(
      {this.status,
      this.deleteAccount,
      this.firstSlider,
      this.single,
      this.lastSlider});

  DashboardSlidersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    deleteAccount = json['delete_account'];
    if (json['first_slider'] != null) {
      firstSlider = <FirstSlider>[];
      json['first_slider'].forEach((v) {
        firstSlider!.add(new FirstSlider.fromJson(v));
      });
    }
    if (json['single'] != null) {
      single = <FirstSlider>[];
      json['single'].forEach((v) {
        single!.add(new FirstSlider.fromJson(v));
      });
    }
    if (json['last_Slider'] != null) {
      lastSlider = <FirstSlider>[];
      json['last_Slider'].forEach((v) {
        lastSlider!.add(new FirstSlider.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['delete_account'] = this.deleteAccount;
    if (this.firstSlider != null) {
      data['first_slider'] = this.firstSlider!.map((v) => v.toJson()).toList();
    }
    if (this.single != null) {
      data['single'] = this.single!.map((v) => v.toJson()).toList();
    }
    if (this.lastSlider != null) {
      data['last_Slider'] = this.lastSlider!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FirstSlider {
  int? id;
  String? image;
  String? type;
  String? imageUrl;

  FirstSlider({this.id, this.image, this.type, this.imageUrl});

  FirstSlider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    type = json['type'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['type'] = this.type;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
