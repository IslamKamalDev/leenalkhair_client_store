import 'package:leen_alkhier_store/data/responses/Offers/offers_model.dart';
import 'package:leen_alkhier_store/data/responses/contract_products_response.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/network/networkCallback/NetworkCallback.dart';
import 'package:leen_alkhier_store/utils/Enums.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class OffersRepository {
  static Future<OffersModel> get_offers() async {
    return OffersModel.fromJson(await (NetworkCall.makeCall(
      endPoint: "api/v4/get_offers",
      method: HttpMethod.GET,
      queryParams: {
        "lang": translator.activeLanguageCode
      },
    )));
  }
}
