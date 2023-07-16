class LoginRequestBody {
  String? email;
  String? password;
  String? device_token;
  String? lang;
  LoginRequestBody({this.email, this.password,this.device_token,this.lang});

  toMap() => {"email": email, "password": password,"device_token":device_token,"lang":lang};
}
