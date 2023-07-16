import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/data/responses/all_cats_response.dart';

class HomeTabsProvider extends ChangeNotifier {
  int index = -1;
  CategoryModel? categoryModel;
  String? tab_type;

  void setIndex(int i) {
    index = i;
    notifyListeners();
  }

  void setCategory(CategoryModel? model) {
    this.categoryModel = model!;
    notifyListeners();
  }

  void setTabType(String type) {
    tab_type = type;
    notifyListeners();
  }
}
