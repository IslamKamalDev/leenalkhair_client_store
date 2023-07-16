import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:leen_alkhier_store/data/requests/business_register_request.dart';
import 'package:leen_alkhier_store/data/responses/business_register_response.dart';
import 'package:leen_alkhier_store/data/responses/types_response.dart';
import 'package:leen_alkhier_store/repos/auth_repository.dart';

class BusinessRegisterationProvider extends ChangeNotifier {
  BusinessType? selectedType;
  LatLng? businessLocation;
  late BusinessRegisterResponse businessRegisterResponse;

  void changeBusiness(BusinessType type) {
    selectedType = type;
    notifyListeners();
  }

  void changeBusinessLocation(LatLng? latLng) {
    businessLocation = latLng;
    notifyListeners();
  }

  Future<void> registerBusiness({required BusinessRegisterRequest requestBody}) async {
    await AuthRepository.registerBusiness(requestBody).then((value) {
      businessRegisterResponse = value;
      notifyListeners();
    });
  }
}
