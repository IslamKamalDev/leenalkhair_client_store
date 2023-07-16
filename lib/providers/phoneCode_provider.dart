import 'package:flutter/material.dart';

class PhoneCodeProvider extends ChangeNotifier {
  String? phoneCode = "+966";

  void setPhoneCode(String? code) {
    phoneCode = code;
    notifyListeners();
  }
}
