import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/data/responses/Pricing/contract_pricing_method_response.dart';
import 'package:leen_alkhier_store/data/responses/Pricing/contract_pricing_type_response.dart';
import 'package:leen_alkhier_store/repos/contract_pricing_repo.dart';

class ContractPricingProvider extends ChangeNotifier {
  ContractPricingResponse? contractPricingResponse;
  Data? pricing_type;

  Future<ContractPricingResponse?> getContractTypes() async {
    contractPricingResponse = await ContractPricingRepo.getContractType();
    notifyListeners();
    return null;
  }

  void changePriceType(Data? t) {
    pricing_type = t;
    notifyListeners();
  }

  //------------------------------------
  late ContractPricingMethodResponse contractPricingMethodResponse;
  String? pricing_method;

  Future<ContractPricingMethodResponse?> getContractPricingMethod() async {
    contractPricingMethodResponse =
        await ContractPricingRepo.getContractPricingMethod();
    notifyListeners();
    return null;
  }

  void changePriceTypeMethod(String? t) {
    pricing_method = t;
    notifyListeners();
  }
}
