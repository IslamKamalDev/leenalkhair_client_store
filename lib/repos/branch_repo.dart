import 'dart:async';
import 'dart:convert';

import 'package:leen_alkhier_store/data/models/general_model.dart';
import 'package:leen_alkhier_store/data/responses/Branch/business_branches_response.dart';
import 'package:leen_alkhier_store/data/responses/Branch/check_branch_orders_response.dart';
import 'package:leen_alkhier_store/network/networkCallback/NetworkCallback.dart';
import 'package:leen_alkhier_store/utils/Enums.dart';
import 'package:leen_alkhier_store/data/responses/Branch/add_branch_response.dart';
import 'package:leen_alkhier_store/data/responses/Branch/branch_data_response.dart';

class BranchRepository {
  static Future<BusinessBranchesResponse> get_all_business_branches(
      {var business_info_id}) async {
    return BusinessBranchesResponse.fromJson(await (NetworkCall.makeCall(
      endPoint: "/api/v4/business_brnaches/$business_info_id",
      method: HttpMethod.GET,
    )));
  }

  static Future<GeneralModel> delete_branch({branch_id, status}) async {
    return GeneralModel.fromJson(await (NetworkCall.makeCall(
        endPoint: "/api/v3/inactive_branch",
        method: HttpMethod.POST,
        requestBody: jsonEncode(
            {"branch_id": branch_id.toString(), "status": status}))));
  }

  static Future<BranchResponse> save_branch(
      {var name,
      var mobile_number,
      var address,
      var latitude,
      var longitude,
      var city_id}) async {
    return BranchResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "/api/v3/create_branch",
        method: HttpMethod.POST,
        requestBody: jsonEncode({
          "name": name.toString(),
          "latitude": latitude.toString(),
          "longitude": longitude.toString(),
          "address": address.toString(),
          "mobile_number": mobile_number.toString(),
          "city_id": city_id
        }))));
  }

  static Future<BranchDataResponse> getBranchData({var branch_id}) async {
    return BranchDataResponse.fromJson(await (NetworkCall.makeCall(
      endPoint: "/api/v3/show_branch/$branch_id",
      method: HttpMethod.GET,
    )));
  }

  static Future<BranchResponse> edit_branch(
      {var branch_id,
      var name,
      var mobile_number,
      var address,
      var latitude,
      var longitude,
      var city_id}) async {
    return BranchResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "/api/v3/edit_branch",
        method: HttpMethod.POST,
        requestBody: jsonEncode({
          "branch_id": branch_id.toString(),
          "name": name.toString(),
          "latitude": latitude.toString(),
          "longitude": longitude.toString(),
          "address": address.toString(),
          "mobile_number": mobile_number.toString(),
          "city_id": city_id
        }))));
  }


}
