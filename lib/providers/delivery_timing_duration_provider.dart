import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/data/responses/delivery_duration_response.dart';
import 'package:leen_alkhier_store/data/responses/delivery_timing_response.dart';
import 'package:leen_alkhier_store/repos/contract_repos.dart';

class DeliveryTimingDurationProvider extends ChangeNotifier {
  late DeliveryDurationResponse deliveryDurationResponse;
  late DeliveryTimingResponse deliveryTimingResponse;

  Future<void> getDuration() async {
    await ContactRepository.getDeliveryDuration().then((value) {
      deliveryDurationResponse = value!;
      notifyListeners();
    });
  }

  Future<void> getTime() async {
    await ContactRepository.getDeliveryTiming().then((value) {
      deliveryTimingResponse = value;
      notifyListeners();
    });
  }
}
