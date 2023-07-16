import 'dart:convert';


class Page {
  int? id;
  String? name;
  String? content;
  String? slug;

  Page(
      {this.id,
        this.name,
        this.content,
        this.slug});

  Page.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    content = json['content'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['content'] = this.content;
    data['slug'] = this.slug;
    return data;
  }

  factory Page.fromJson(String source) => Page.fromMap(json.decode(source));
}