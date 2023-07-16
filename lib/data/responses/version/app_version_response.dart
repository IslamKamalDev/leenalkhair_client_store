
class AppVersionResponse {
  bool? status;
  String? data;
  String? tax;
  String? fees;
  String? descount;
  String? twitter;
  String? instgram;
  String? whatsapp;
  String? mobileNumber;

  AppVersionResponse(
      {this.status,
        this.data,
        this.tax,
        this.fees,
        this.descount,
        this.twitter,
        this.instgram,
        this.whatsapp,
        this.mobileNumber});

  AppVersionResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
    tax = json['tax'];
    fees = json['fees'];
    descount = json['descount'];
    twitter = json['twitter'];
    instgram = json['instgram'];
    whatsapp = json['whatsapp'];
    mobileNumber = json['mobile_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['data'] = this.data;
    data['tax'] = this.tax;
    data['fees'] = this.fees;
    data['descount'] = this.descount;
    data['twitter'] = this.twitter;
    data['instgram'] = this.instgram;
    data['whatsapp'] = this.whatsapp;
    data['mobile_number'] = this.mobileNumber;
    return data;
  }
}