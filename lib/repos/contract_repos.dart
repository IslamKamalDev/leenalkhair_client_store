import 'dart:async';
import 'dart:convert';

import 'package:leen_alkhier_store/data/requests/contract_register_request.dart';
import 'package:leen_alkhier_store/data/responses/active_timing_response.dart';
import 'package:leen_alkhier_store/data/responses/add_product_contract_response.dart';
import 'package:leen_alkhier_store/data/responses/contract_info_response.dart';
import 'package:leen_alkhier_store/data/responses/contract_products_response.dart';
import 'package:leen_alkhier_store/data/responses/contract_register_response.dart';
import 'package:leen_alkhier_store/data/responses/create_order_response.dart';
import 'package:leen_alkhier_store/data/responses/delete_contract_product_response.dart';
import 'package:leen_alkhier_store/data/responses/delivery_duration_response.dart';
import 'package:leen_alkhier_store/data/responses/delivery_timing_response.dart';
import 'package:leen_alkhier_store/data/responses/update_contract_product_response.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/network/networkCallback/NetworkCallback.dart';
import 'package:leen_alkhier_store/providers/Branch/business_branches_provider.dart';
import 'package:leen_alkhier_store/utils/Constants.dart';
import 'package:leen_alkhier_store/utils/Enums.dart';
import 'package:provider/provider.dart';

class ContactRepository {
  static Future<DeliveryTimingResponse> getDeliveryTiming() async {
    return DeliveryTimingResponse.fromJson(await (NetworkCall.makeCall(
      endPoint: "api/v3/get_timing",
      method: HttpMethod.GET,
    )));
  }

  static Future<DeliveryDurationResponse?> getDeliveryDuration() async {
    return DeliveryDurationResponse.fromJson(await (NetworkCall.makeCall(
      endPoint: "api/v3/get_duration",
      method: HttpMethod.GET,
    )));
  }

  static Future<ContractRegisterResponse> createContract(
      CreateContractRequest contractRequest) async {
    return ContractRegisterResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v3/create_contract",
        method: HttpMethod.POST,
        requestBody: jsonEncode(contractRequest.toMap()))));
  }

  static Future<CreateOrderResponse> createOrder(
      String? contractID,
      String? deliveryTime,
      String? deliveryTimingId,
      String? branchId,
      List<ContractProductsModel?> products) async {
    return CreateOrderResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v4/create_order",
        method: HttpMethod.POST,
        requestBody: jsonEncode({
          "contract_id": contractID,
          "delivery_time": deliveryTime,
          "delivery_timing_id": deliveryTimingId,
          "branch_id": branchId.toString(),
          "products": products
              .map((e) => {
            "id": e!.productId,
            "units": e.units!.map((u) =>{
              "id" : u.unitId,
              "quantity_per_unit" : u.quantityPerUnit
            }).toList()
          }).toList()

        }))));
  }

  static Future<ActiveTimingResponse> getActiveTiming() async {
    return ActiveTimingResponse.fromJson(await (NetworkCall.makeCall(
      endPoint: "api/get_timing_for_order",
      method: HttpMethod.GET,
    )));
  }

  static Future<ContractRegisterResponse> updateContract(
      CreateContractRequest contractRequest) async {
    return ContractRegisterResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v3/update_contract",
        method: HttpMethod.POST,
        requestBody: jsonEncode(contractRequest.toMap()))));
  }

  static Future<UpdateContractProductResponse> updateContractProducts(
      {String? productId, String? contractId, String? quantityPerOrder}) async {
    return UpdateContractProductResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/update_contract_product",
        method: HttpMethod.POST,
        requestBody: jsonEncode({
          "product_id": productId,
          "contract_id": contractId,
          "quantity_per_order": quantityPerOrder
        }))));
  }

  /// delete product from contract
  static Future<DeleteContractProductResponse> deleteContractProducts(
      {String? productId, String? contractId}) async {
    return DeleteContractProductResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/delete_contract_product",
        method: HttpMethod.POST,
        requestBody: jsonEncode({
          "product_id": productId,
          "contract_id": contractId,
        }))));
  }

  static Future<ContractInfoResponse> getContract() async {
    return ContractInfoResponse.fromJson(await (NetworkCall.makeCall(
      endPoint: "api/v3/get_all_contracts",
      method: HttpMethod.GET,
    )));
  }

  static Future<ContractProductsResponse> getContractProducts(
      {String? branch_id}) async {
    return ContractProductsResponse.fromJson(await (NetworkCall.makeCall(
      endPoint: "api/v4/products_contract",
      queryParams: {"branch_id": branch_id},
      method: HttpMethod.GET,
    )));
  }

  static Future<AddProductToContractResponse> addProductToContract({String? branch_id}) async {
    return AddProductToContractResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v4/assign_product",
        method: HttpMethod.POST,
        requestBody: jsonEncode({
          "branch_id" : branch_id,
          "products": contractProductsList
              .map((e) => {
            "product_id": e.product_id,
            "units": e.units!.map((u) =>{
              "id" : u.unit_id,
              "quantity_per_unit" : u.quantity_per_unit
            }).toList()
          }).toList()
        }))));
  }
}
