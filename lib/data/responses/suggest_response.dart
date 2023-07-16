class SuggestResponse {
  String? message;
  String? details;

  SuggestResponse({this.message, this.details});

  SuggestResponse.fromJson(Map<String, dynamic>? json) {
    message = json!['message'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['details'] = this.details;
    return data;
  }
}
