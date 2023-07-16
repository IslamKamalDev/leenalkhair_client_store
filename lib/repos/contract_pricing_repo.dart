import 'dart:async';

import 'package:leen_alkhier_store/data/responses/Pricing/contract_pricing_method_response.dart';
import 'package:leen_alkhier_store/data/responses/Pricing/contract_pricing_type_response.dart';
import 'package:leen_alkhier_store/network/networkCallback/NetworkCallback.dart';
import 'package:leen_alkhier_store/utils/Enums.dart';

class ContractPricingRepo {
  static Future<ContractPricingResponse> getContractType() async {
    return ContractPricingResponse.fromJson(await (NetworkCall.makeCall(
      endPoint: "api/v3/get_Contract_types",
      method: HttpMethod.GET,
    )));
  }

  static Future<ContractPricingMethodResponse>
      getContractPricingMethod() async {
    return ContractPricingMethodResponse.fromJson(await (NetworkCall.makeCall(
      endPoint: "api/v3/contract_subtypes",
      method: HttpMethod.GET,
    )));
  }
}
