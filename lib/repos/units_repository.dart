import 'dart:convert';

import 'package:leen_alkhier_store/data/responses/Units/contract_product_unit_response.dart';
import 'package:leen_alkhier_store/data/responses/Units/remove_product_unit_response.dart';
import 'package:leen_alkhier_store/network/networkCallback/NetworkCallback.dart';
import 'package:leen_alkhier_store/utils/Enums.dart';

class UnitsRepository{

  static Future<ContractProductUnitResponse> getContractProductUnits(
      {String? contract_id ,String? product_id ,String? branch_id}) async {
    print("product_id : ${product_id}");
    print("contract_id : ${contract_id}");
    print("branch_id : ${branch_id}");
    return ContractProductUnitResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v4/contract_products_unit",
        method: HttpMethod.GET,
        queryParams: {
          "product_id": product_id,
          "contract_id" : contract_id,
          "branch_id" : branch_id

        }
    )));
  }

  static Future<RemoveProductUnitResponse> remove_product_unit({contract_id, product_id,unit_id}) async {
    return RemoveProductUnitResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v4/remove_product_unit",
        method: HttpMethod.POST,
        requestBody: jsonEncode(
            {"contract_id": contract_id,
              "product_id": product_id,
              "unit_id" : unit_id
            }
              ))
    ));
  }
}