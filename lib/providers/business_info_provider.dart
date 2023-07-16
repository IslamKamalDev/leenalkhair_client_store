import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:leen_alkhier_store/data/requests/business_register_request.dart';
import 'package:leen_alkhier_store/data/responses/business_info_response.dart';
import 'package:leen_alkhier_store/data/responses/business_register_response.dart';
import 'package:leen_alkhier_store/data/responses/types_response.dart';
import 'package:leen_alkhier_store/repos/auth_repository.dart';
import 'package:leen_alkhier_store/repos/profile_repos.dart';

class BusinessInfoProvider extends ChangeNotifier {
  BusinessType? selectedType;
  LatLng? businessLocation;
  BusinessInfoResponse? businessInfoResponse;
  BusinessRegisterResponse? businessRegisterResponse;

  void changeBusiness(BusinessType type) {
    selectedType = type;
    notifyListeners();
  }

  void changeBusinessLocation(LatLng? latLng) {
    businessLocation = latLng;
    notifyListeners();
  }

  Future<void> getBusiness() async {
    await ProfileRepository.getBusiness().then((value) {
      businessInfoResponse = value;
      notifyListeners();
    });
  }

  Future<void> updateBusiness(
      {required BusinessRegisterRequest requestBody}) async {
    await AuthRepository.updateBusiness(requestBody).then((value) {

      businessRegisterResponse = value;
      notifyListeners();
    });
  }
}
