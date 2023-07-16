import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/data/responses/contract_products_response.dart';
import 'package:leen_alkhier_store/data/responses/user_orders.dart';

class OrderDetailsCartProductItemProvider extends ChangeNotifier {
  List<Products> allProducts = [];
  List<ContractProductsModel> allProductsDetails = [];
  double? total = 0;
  double? tax = 0;
  double? charge = 0;
  double? discount = 0;

  get getTax => this.tax;

  set setTax(tax) => this.tax = tax;

  get getCharge => this.charge;

  set setCharge(charge) => this.charge = charge;

  get getDiscount => this.discount;

  set setDiscount(discount) => this.discount = discount;
  void setTotal(double? t) {
    total = t;
    notifyListeners();
  }

  void ClearLists() {
    localStorageProductsDetails.clear();
    ordersListFromApi.clear();
    notifyListeners();
  }

  void setQuantity(ContractProductsModel? product, var Quantity) {
    allProductsDetails.firstWhere((element) => element == product).units![0].quantityPerUnit
         = allProductsDetails.firstWhere((element) => element == product)
        .units![0].quantityPerUnit = Quantity;


    notifyListeners();
  }

  void setProducts(List<Products> products) {
    allProducts.clear();
    allProducts.addAll(products);
    notifyListeners();
  }

  incrementQuantity(Products? product) async {
    allProducts.firstWhere((element) => element == product).pivot!.quantity =
        allProducts
                .firstWhere((element) => element == product)
                .pivot!
                .quantity +
            1;

    checkoutTotal();
    //notifyListeners();
  }

  decrementQuantity(Products? product) async {
    allProducts.firstWhere((element) => element == product).pivot!.quantity =
        allProducts
                .firstWhere((element) => element == product)
                .pivot!.quantity - 1;
    checkoutTotal();
    //notifyListeners();
  }

  incrementQuantityInAddProduct(ContractProductsModel? product) async {
    allProductsDetails
        .firstWhere((element) => element.productId == product!.productId)
        .units![0].quantityPerUnit = allProductsDetails
        .firstWhere((element) => element.productId == product!.productId)
        .units![0].quantityPerUnit! +
        1;
  }

  decrementQuantityInAddProduct(ContractProductsModel? product) async {
    allProductsDetails
        .firstWhere((element) => element.productId == product!.productId)
        .units![0].quantityPerUnit = allProductsDetails
            .firstWhere((element) => element.productId == product!.productId)
          .units![0].quantityPerUnit! - 1;
  }

  void removeProduct(Products? product) async {
    allProducts.remove(product);
    ordersListFromApi.remove(product);
    localStorageProductsDetails.remove(product);

    checkoutTotal();

    notifyListeners();
  }

  List<ContractProductsModel?> localStorageProductsDetails = [];
  List<Products> ordersListFromApi = [];

  void setProductsInLocalStorageInDetails(ContractProductsModel? product) {
    if (localStorageProductsDetails
            .any((element) => element!.productId == product!.productId) ==
        false) {
      localStorageProductsDetails.add(product);
    } else {
      localStorageProductsDetails[localStorageProductsDetails.indexWhere(
              (element) => element!.productId == product!.productId)]!
          .quantityPerOrder = product!.quantityPerOrder;
    }
    notifyListeners();
  }

  void deleteItemFromListOfApi(Products product) {
    ordersListFromApi.removeWhere(
        (item) => item.pivot!.productId == product.pivot!.productId);
    notifyListeners();
  }

  void updateProductsInAllProduct(var productId, var quantity) {
    try {
      allProductsDetails[allProductsDetails
              .indexWhere((element) => element.productId == productId)]
          .quantityPerOrder = quantity;
    } catch (e) {}

    notifyListeners();
  }

  void clearProductsFromStorage() {
    localStorageProductsDetails.clear();
  }

  void clearProducts() {
    allProducts.clear();
  }

  checkoutTotal() {
    total = 0;
    allProducts.forEach((element) {
      total = total! + (element.pivot!.price! * element.pivot!.quantity);
    });

    var c = charge! / 100 * total!;
    var d = discount! / 100 * total!;
    var t = tax! / 100 * total!;

    total = total! + (c + t - d);

    notifyListeners();
  }
}
