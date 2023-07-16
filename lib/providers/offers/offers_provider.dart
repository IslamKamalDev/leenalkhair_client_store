import 'package:flutter/cupertino.dart';
import 'package:leen_alkhier_store/data/responses/Offers/offers_model.dart';
import 'package:leen_alkhier_store/data/responses/contract_products_response.dart';
import 'package:leen_alkhier_store/repos/offers_repository.dart';

class OffersProvider extends ChangeNotifier {
  OffersModel? offersModel;
  Future<OffersModel>? get_offers() async {
    offersModel = await OffersRepository.get_offers();

    notifyListeners();
    return offersModel!;
  }
}
