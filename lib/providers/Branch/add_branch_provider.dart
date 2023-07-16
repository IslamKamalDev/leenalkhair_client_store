import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:leen_alkhier_store/data/responses/Branch/add_branch_response.dart';
import 'package:leen_alkhier_store/repos/branch_repo.dart';

class AddBranchProvider extends ChangeNotifier{
  LatLng? businessLocation;
  String? branch_address;
  BranchResponse? addBranchResponse;
  void changeBranchLocation(LatLng? latLng) {
    businessLocation = latLng;
    notifyListeners();
  }

  Future<void> saveBranchFun({var name, var mobile_number , var address , var latitude ,  var longitude , var city_id}) async {
  await BranchRepository.save_branch(
        name: name,
        mobile_number: mobile_number,
        address: address,
        latitude: latitude,
        longitude: longitude,
      city_id: city_id
    ).then((value){
    addBranchResponse = value;
    });
    notifyListeners();
  }

  void clear_data(){
    businessLocation = null;
    branch_address = '';
  }

  void branch_name_fun(String? address){
    branch_address = address;
    notifyListeners();
  }
}