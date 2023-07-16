import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/data/requests/user_register_request.dart';
import 'package:leen_alkhier_store/data/responses/cities_response.dart';
import 'package:leen_alkhier_store/data/responses/user_register_response.dart';
import 'package:leen_alkhier_store/repos/auth_repository.dart';

class UserRegisterationProvider extends ChangeNotifier {
  City? selectedCity;
  UserRegisterResponse? userRegisterResponse;
  bool status = false;
  void changeUserStatus(bool val) {
    status = val;
    notifyListeners();
  }

  void changeCity(City? city) {
    selectedCity = city;
    notifyListeners();
  }

  Future<void> registerUser({required UserRegisterRequest requestBody}) async {
    await AuthRepository.register(requestBody).then((value) {
      userRegisterResponse = value;
      notifyListeners();
    });
  }

  Future<void> updateUser({required UserRegisterRequest requestBody}) async {
    await AuthRepository.update(requestBody).then((value) {
      userRegisterResponse = value;
      notifyListeners();
    });
  }

  Future<void> updateUserToken({String? token}) async {
    await AuthRepository.updateToken(token).then((value) {
      userRegisterResponse = value;
      notifyListeners();
    });
  }
}
