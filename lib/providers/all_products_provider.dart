import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/data/responses/all_products_response.dart';
import 'package:leen_alkhier_store/repos/category_repos.dart';

class ProductProvider extends ChangeNotifier {
  late AllProductsResponse allProductsResponse;

  Future<void> getAllProduct() async {
    CategoryRepository.getAllProducts().then((value) {
      allProductsResponse = value;
      notifyListeners();
    });
  }


}
