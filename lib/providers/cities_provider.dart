import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/data/responses/cities_response.dart';
import 'package:leen_alkhier_store/repos/custom_repository.dart';

class CitiesProvider extends ChangeNotifier {
  late CitiesResponse citiesResponse;

  Future<void> getAllCities() async {
    await CustomRepository.getAllCities().then((value) {
      {
        citiesResponse = value;
        notifyListeners();
      }
    });
  }
}
