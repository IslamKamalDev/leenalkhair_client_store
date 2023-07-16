import 'dart:io';

class BusinessRegisterRequest {
  String? registrationNumber;
  String? name;
  String? tax_number;
  double? latitude;
  double? longitude;
  File? commerical;
  File? tax;
  String? trade_mark;
  String? city_id;
  String? sector_id;
  BusinessRegisterRequest(
      {this.tax,
      this.name,
      this.tax_number,
      this.commerical,
      this.latitude,
      this.longitude,
      this.registrationNumber,
      this.trade_mark,
      this.city_id,
      this.sector_id});

  Map<String, String?> toMap() => {
        "registration_number": registrationNumber,
        "longitude": longitude.toString(),
        "latitude": latitude.toString(),
        "trade_mark": trade_mark,
        "city_id": city_id,
        "name": name,
        "tax_number": tax_number,
        "sector_id": sector_id
      };
}
