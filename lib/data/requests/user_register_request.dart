class UserRegisterRequest {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? cityId;
  String? mobileNumber;
  String? country_code;
  String? lang;
  String? status;
  String? device_token;

  UserRegisterRequest(
      {this.cityId,
      this.email,
      this.firstName,
      this.lastName,
      this.mobileNumber,
      this.country_code,
      this.password,
      this.lang,
      this.status,
      this.device_token});

  toMap() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        if (password!.isNotEmpty) "password": password,
        "city_id": cityId,
        "mobile_number": mobileNumber,
        "country_code": country_code,
        "lang": lang,
        "status": status,
        "device_token": device_token,
      };
}
