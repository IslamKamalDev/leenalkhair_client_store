import 'dart:async';

import 'package:leen_alkhier_store/data/responses/all_cats_response.dart';
import 'package:leen_alkhier_store/data/responses/all_products_response.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/network/networkCallback/NetworkCallback.dart';
import 'package:leen_alkhier_store/utils/Enums.dart';
import 'package:leen_alkhier_store/utils/Settings.dart';

class CategoryRepository {

  static Future<AllCategoriesResponse> getAllCategories() async {
    return AllCategoriesResponse.fromJson(await (NetworkCall.makeCall(
      endPoint: "api/v3/all_categories",
      method: HttpMethod.GET,
    )));
  }

  static Future<AllProductsResponse> getAllProducts() async {
    return AllProductsResponse.fromJson(await (NetworkCall.makeCall(
      endPoint: "api/v3/all_products",
      method: HttpMethod.GET,
    )));
  }
}
