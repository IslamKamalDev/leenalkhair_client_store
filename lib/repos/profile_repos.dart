import 'dart:async';

import 'package:leen_alkhier_store/data/responses/business_info_response.dart';
import 'package:leen_alkhier_store/network/networkCallback/NetworkCallback.dart';
import 'package:leen_alkhier_store/utils/Enums.dart';

class ProfileRepository {
  static Future<BusinessInfoResponse> getBusiness() async {
    return BusinessInfoResponse.fromJson(await (NetworkCall.makeCall(
      endPoint: "api/v3/get_info",
      method: HttpMethod.GET,
    )));
  }
}
