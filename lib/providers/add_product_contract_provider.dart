import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/data/responses/add_product_contract_response.dart';
import 'package:leen_alkhier_store/repos/contract_repos.dart';
import 'package:leen_alkhier_store/utils/Constants.dart';

class AddProductContractProvider extends ChangeNotifier {
  late AddProductToContractResponse addProductToContractResponse;
  bool selected = false;

  Future<void> addProductContract({String? branch_id}) async {
    await ContactRepository.addProductToContract(branch_id: branch_id)
        .then((value) {

      addProductToContractResponse = value;
      notifyListeners();
    });
  }

  void productAdded() {
    if(contractProductsList.isEmpty)
    selected = false;
    else
    selected = true;
    notifyListeners();
  }

  void productRemoved() {
    if(contractProductsList.isEmpty)
      selected = false;
    else
      selected = true;
    notifyListeners();
  }
}
