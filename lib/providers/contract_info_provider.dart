import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/data/responses/contract_info_response.dart';
import 'package:leen_alkhier_store/repos/contract_repos.dart';

class ContractInfoProvider extends ChangeNotifier {
  ContractInfoResponse? contractInfoResponse;

  Future<ContractInfoResponse?> getContract() async {
    contractInfoResponse = await ContactRepository.getContract();
      notifyListeners();
   return contractInfoResponse;
  }

  clearContractInfo() {
    contractInfoResponse = null;
    notifyListeners();
  }
}
