import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/data/responses/all_cats_response.dart';
import 'package:leen_alkhier_store/repos/category_repos.dart';

class CategoryProvider extends ChangeNotifier {
  AllCategoriesResponse? allCategoriesResponse;
  CategoryModel? selectedCategory;
  bool showAllProduct = true;
  
  Future<AllCategoriesResponse?>  getAllCategories() async {
    await CategoryRepository.getAllCategories().then((value) {
      allCategoriesResponse = value;
      notifyListeners();
    });
    return allCategoriesResponse;
  }

  void setCategory(CategoryModel categoryModel) {
    selectedCategory = categoryModel;
    notifyListeners();
  }
}
