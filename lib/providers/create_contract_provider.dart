import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/data/requests/contract_register_request.dart';
import 'package:leen_alkhier_store/data/responses/contract_register_response.dart';
import 'package:leen_alkhier_store/data/responses/delivery_duration_response.dart';
import 'package:leen_alkhier_store/data/responses/delivery_timing_response.dart';
import 'package:leen_alkhier_store/repos/contract_repos.dart';

class CreateContractProvider extends ChangeNotifier {
  DeliveryDuration? deliveryDuration;
  DeliveryTiming? deliveryTiming;
  DateTime? fromDate;
  DateTime? toDate;
  DateTime now = new DateTime.now();

  ContractRegisterResponse? contractRegisterResponse;

  Future<void> createContract(CreateContractRequest contractRequest) async {
    await ContactRepository.createContract(contractRequest).then((value) {
      contractRegisterResponse = value;
      notifyListeners();
    });
  }

  Future<void> updateContract(CreateContractRequest contractRequest) async {
    await ContactRepository.updateContract(contractRequest).then((value) {
      contractRegisterResponse = value;
      notifyListeners();
    });
  }

  void setFromDate(DateTime dateTime) {
    fromDate = dateTime;
    notifyListeners();
  }

  void setToDate(DateTime dateTime) {
    toDate = dateTime;
    notifyListeners();
  }

  void changeDuration(DeliveryDuration? d) {
    deliveryDuration = d;
    notifyListeners();
  }

  void changeTiming(DeliveryTiming? t) {
    deliveryTiming = t;
    notifyListeners();
  }

  void clear() {
    deliveryDuration = null;
    deliveryTiming = null;
    fromDate = null;
    toDate = null;
    notifyListeners();
  }
}
