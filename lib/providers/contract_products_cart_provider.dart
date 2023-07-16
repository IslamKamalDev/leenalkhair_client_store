import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/data/responses/contract_products_response.dart';
import 'package:leen_alkhier_store/data/responses/delete_contract_product_response.dart';
import 'package:leen_alkhier_store/repos/contract_repos.dart';
import 'package:leen_alkhier_store/utils/Shared.dart';

class ContractProductCartProductItemProvider extends ChangeNotifier {
  ContractProductsResponse? contractProductsResponse;
  DeleteContractProductResponse? deleteContractProductResponse;

  void setContractsProductsResponse(ContractProductsResponse response) {
    contractProductsResponse = response;
    if (response.data != null) setProducts(response.data!);
    notifyListeners();
  }

  void clearContractProductsResponse() {
    contractProductsResponse = null;
    notifyListeners();
  }

  List<ContractProductsModel> allProducts = [];
  List<ContractProductsModel> allProductsss = [];
  List<ContractProductsModel?> localStorageProducts = [];
  List<ContractProductsModel> localStorageProductsDetails = [];

  void setProductsInLocalStorage(ContractProductsModel? product) {
    if (localStorageProducts.contains(product) == false) {
      localStorageProducts.add(product);
    } else {
      localStorageProducts[localStorageProducts.indexWhere(
          (element) => element!.productId == product!.productId)] = product;
    }
    notifyListeners();
  }

  void setProducts(List<ContractProductsModel> products) {
    allProducts = [];
    allProducts.clear();
    allProducts.addAll(products);
    allProductsss.addAll(products);

    if (localStorageProducts.length > 0) {
      localStorageProducts.forEach((localProduct) {
        if (allProducts.indexWhere(
                (element) => element.productId == localProduct?.productId) ==
            -1) {
        } else {
          allProducts[allProducts.indexWhere(
                  (element) => element.productId == localProduct?.productId)]
              .quantityPerOrder = localProduct?.quantityPerOrder;
        }
      });
    }
    notifyListeners();
  }

  void incrementQuantity(ContractProductsModel? product) {
    allProducts.firstWhere((element) => element == product).units![0].quantityPerUnit =
    ((allProducts.firstWhere((element) => element == product).units![0].quantityPerUnit == null
        ? 0
        : allProducts.firstWhere((element) => element == product).units![0].quantityPerUnit)! + 1)  ;

    notifyListeners();
  }

  void setQuantity(ContractProductsModel? product, var Quantity) {
    allProducts.firstWhere((element) => element == product).units![0].quantityPerUnit =
        allProducts
            .firstWhere((element) => element == product).units![0].quantityPerUnit = Quantity;

    notifyListeners();
  }

  void resetQuantity(ContractProductsModel? product) {
    localStorageProducts
        .removeWhere((element) => element!.productId == product!.productId);

    notifyListeners();
  }

  Future<void> decrementQuantity(ContractProductsModel? product) async {
    allProducts.firstWhere((element) => element == product).units![0].quantityPerUnit =
    ((allProducts.firstWhere((element) => element == product).units![0].quantityPerUnit== null
        ? 0
        : allProducts.firstWhere((element) => element == product).units![0].quantityPerUnit)! - 1);
    notifyListeners();
  }

  Future<void> removeProduct(ContractProductsModel product) async {
    allProducts.remove(product);
    await ContactRepository.deleteContractProducts(
      contractId: product.contractId.toString(),
      productId: product.productId.toString(),
    );
    notifyListeners();
  }

  Future<DeleteContractProductResponse?> deleteContractProducts(
      {required ContractProductsModel product}) async {
    await ContactRepository.deleteContractProducts(
      contractId: product.contractId.toString(),
      productId: product.productId.toString(),
    ).then((value) {
      deleteContractProductResponse = value;
      if (value.status!) {
        allProducts.remove(product);
      }
      notifyListeners();
    });
    return null;
  }

  void clearProducts() {
    allProducts.clear();
  }
}
