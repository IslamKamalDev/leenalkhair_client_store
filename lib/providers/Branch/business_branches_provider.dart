// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:leen_alkhier_store/data/responses/Branch/add_branch_response.dart';
import 'package:leen_alkhier_store/data/responses/Branch/branch_data_response.dart';
import 'package:leen_alkhier_store/data/responses/Branch/business_branches_response.dart';
import 'package:leen_alkhier_store/data/responses/Branch/check_branch_orders_response.dart';
import 'package:leen_alkhier_store/repos/branch_repo.dart';

class BusinessBranchesProvider extends ChangeNotifier {
  Branches? selectedBranch;
  BusinessBranchesResponse? businessBranchesResponse;
  bool? order_cancel_status = false;
  late BranchResponse branchResponse;
  CheckBranchOrdersResponse? checkBranchOrdersResponse;
  late BranchDataResponse branchDataResponse;


  void changeBranch(Branches? branch) {
    selectedBranch = branch;
    notifyListeners();
  }

  void change_order_cancel_status({bool? status}) {
    order_cancel_status = status;
    notifyListeners();
  }

  Future<BusinessBranchesResponse?> get_all_business_branches(
      {var business_info_id}) async {
    businessBranchesResponse = await BranchRepository.get_all_business_branches(
        business_info_id: business_info_id);
    notifyListeners();
    return businessBranchesResponse;
  }

  Future<void> change_branch_status({var branch_id, var status}) async {
    await BranchRepository.delete_branch(branch_id: branch_id, status: status);
    notifyListeners();
  }

  Future<BranchDataResponse?> get_branch_data({var branch_id}) async {
    branchDataResponse = await BranchRepository.getBranchData(branch_id: branch_id);
    notifyListeners();
    return null;
    //  return branchDataResponse;
  }

  Future<void> editBranchFun(
      {var branch_id,
      var name,
      var mobile_number,
      var address,
      var latitude,
      var longitude,
      var city_id}) async {
    branchResponse = await BranchRepository.edit_branch(
        branch_id: branch_id,
        name: name,
        mobile_number: mobile_number,
        address: address,
        latitude: latitude,
        longitude: longitude,
        city_id: city_id);
    notifyListeners();
  }


}
