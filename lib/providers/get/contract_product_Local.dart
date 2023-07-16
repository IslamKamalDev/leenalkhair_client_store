import 'package:get/get.dart';

class ContractProductLocal extends GetxController {
  List<int?> allProductsAddLocalToContact = [];

  void addToContractLocal(int? id) {
    allProductsAddLocalToContact.add(id);

    update();
  }
}
