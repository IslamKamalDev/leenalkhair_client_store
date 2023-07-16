import 'dart:async';

import 'package:leen_alkhier_store/data/responses/Sectors/sector_response.dart';
import 'package:leen_alkhier_store/data/responses/cities_response.dart';
import 'package:leen_alkhier_store/data/responses/types_response.dart';
import 'package:leen_alkhier_store/network/networkCallback/NetworkCallback.dart';
import 'package:leen_alkhier_store/utils/Enums.dart';

class CustomRepository {
  static Future<CitiesResponse> getAllCities() async {
    return CitiesResponse.fromJson(await (NetworkCall.makeCall(
      endPoint: "api/v3/all_city",
      method: HttpMethod.GET,
    )));
  }

  static Future<SectorResponse> getAllSectors() async {
    return SectorResponse.fromJson(await (NetworkCall.makeCall(
      endPoint: "api/v3/get_sectors",
      method: HttpMethod.GET,
    )));
  }
}
