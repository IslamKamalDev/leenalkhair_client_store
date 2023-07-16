import 'dart:async';
import 'dart:convert';

import 'package:leen_alkhier_store/data/models/tokenPermissionsResponse.dart';
import 'package:leen_alkhier_store/data/models/general_model.dart';
import 'package:leen_alkhier_store/data/responses/Branch/business_branches_response.dart';
import 'package:leen_alkhier_store/data/responses/Employee/all_employees_response.dart';
import 'package:leen_alkhier_store/data/responses/Employee/employee_permissions_response.dart';
import 'package:leen_alkhier_store/data/responses/Employee/employee_profile_response.dart';
import 'package:leen_alkhier_store/data/responses/user_orders.dart';
import 'package:leen_alkhier_store/network/networkCallback/NetworkCallback.dart';
import 'package:leen_alkhier_store/utils/Enums.dart';
import 'package:leen_alkhier_store/utils/Shared.dart';

class EmployeesRepository {
  static Future<AllEmployeesListResponse> getEmployeesList() async {
    return AllEmployeesListResponse.fromJson(await (NetworkCall.makeCall(
      endPoint: "/api/v4/get_business_employees",
      method: HttpMethod.GET,
    )));
  }

  static Future<TokenPermissionsResponse> decodeTokenForPermissons(
      String token) async {
    String normalizedSource = base64Url.normalize(token.split(".")[1]);
    return TokenPermissionsResponse.fromJson(
        json.decode(utf8.decode(base64Url.decode(normalizedSource))));
  }

  static Future<GeneralModel> deleteEmployee({
    var employee_id,var employee_status
  }) async {
    return GeneralModel.fromJson(await (NetworkCall.makeCall(
        endPoint: "/api/v4/delete_employee",
        method: HttpMethod.POST,
        requestBody: jsonEncode({
          "employee_id": employee_id.toString(),
          "status" : employee_status
        }))));
  }

  static Future<EmployeePermissionsResponse> getPermissions() async {
    return EmployeePermissionsResponse.fromJson(await (NetworkCall.makeCall(
      endPoint: "/api/v3/get_permissions",
      method: HttpMethod.GET,
    )));
  }

  static Future<GeneralModel> saveEmployee(
      {var employee_id,
      var first_name,
      var last_name,
      var email,
      var mobile_number,
      var city_id,
      var business_info_id,
      required List branches,
      required List permissions,
      var type}) async {
    List<Branch> chossedBranches = [];
    List<Permission> chossedPermissions = [];
    branches.forEach((element) {
      chossedBranches.add(new Branch(id: element));
    });

    permissions.forEach((element) {
      chossedPermissions.add(new Permission(permission_id: element));
    });
/*  chossed_permissions.forEach((element) {
  });*/

    return GeneralModel.fromJson(await (NetworkCall.makeCall(
        endPoint: type == "add"
            ? "/api/v3/add_branch_employee"
            : "/api/v3/edit_employee",
        method: HttpMethod.POST,
        requestBody: jsonEncode({
          "employee_id": type == "add" ? null : employee_id.toString(),
          "first_name": first_name.toString(),
          "last_name": last_name.toString(),
          "email": email.toString(),
          "mobile_number": mobile_number.toString(),
          "city_id": city_id.toString(),
          "business_info_id": business_info_id.toString(),
          "branches": chossedBranches
              .map((e) => {
                    "id": e.id,
                  })
              .toList(),
          "permissions": chossedPermissions
              .map((e) => {
                    "permission_id": e.permission_id,
                  })
              .toList(),
        }))));
  }

  static Future<EmployeeProfileResponse> getEmployeeProfileData(
      {var employee_id}) async {
    return EmployeeProfileResponse.fromJson(await (NetworkCall.makeCall(
      endPoint: "/api/v4/show_employee_data/$employee_id",
      method: HttpMethod.GET,
    )));
  }

  static Future<BusinessBranchesResponse> get_employee_branches() async {
    return BusinessBranchesResponse.fromJson(await (NetworkCall.makeCall(
      endPoint: "/api/v4/get_user_branches",
      method: HttpMethod.GET,
    )));
  }

  static Future<OrdersResponse> get_employee_orders(
      {String? employee_id,
      String? branch_id,
      String? start,
      String? end,
      String? page}) async {
    return OrdersResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "/api/v3/get_employee_order",
        method: HttpMethod.GET,
        queryParams: {
          "employee_id": employee_id,
          "branch_id": branch_id,
          "start": start,
          "end": end,
          "page": page
        })));
  }
}
