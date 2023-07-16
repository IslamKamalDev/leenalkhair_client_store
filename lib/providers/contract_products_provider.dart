import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/data/responses/active_timing_response.dart';
import 'package:leen_alkhier_store/data/responses/contract_products_response.dart';
import 'package:leen_alkhier_store/data/responses/create_order_response.dart';
import 'package:leen_alkhier_store/data/responses/delete_contract_product_response.dart';
import 'package:leen_alkhier_store/data/responses/update_contract_product_response.dart';
import 'package:leen_alkhier_store/repos/contract_repos.dart';

class ContractProductsProvider extends ChangeNotifier {
  late ActiveTimingResponse activeTimingResponse;
  DeleteContractProductResponse? deleteContractProductResponse;

  Future<ContractProductsResponse> getContractProducts(
      {String? branch_id}) async {
    return await ContactRepository.getContractProducts(branch_id: branch_id);
  }

  Future<CreateOrderResponse> createOrder(
      {String? contractID,
      String? delivery_time,
      String? delivery_timing_id,
      String? branch_id,
      required List<ContractProductsModel?> products}) async {
    return await ContactRepository.createOrder(
        contractID, delivery_time, delivery_timing_id, branch_id, products);
  }

  Future<void> getActiveTiming() async {
    await ContactRepository.getActiveTiming().then((value) {
      activeTimingResponse = value;
      notifyListeners();
    });
  }

  Future<UpdateContractProductResponse> updateContractProducts(
      {String? contractID, String? productId, String? quantity}) async {
    return await ContactRepository.updateContractProducts(
        contractId: contractID,
        productId: productId,
        quantityPerOrder: quantity);
  }

/////
  Future<DeleteContractProductResponse?> deleteContractProducts(
      {String? contractID, String? productId}) async {
    await ContactRepository.deleteContractProducts(
      contractId: contractID,
      productId: productId,
    ).then((value) {
      deleteContractProductResponse = value;
      notifyListeners();
    });
    return null;
  }
}
