import 'package:get/get.dart';
import 'package:leen_alkhier_store/data/responses/contract_products_response.dart';
import 'package:leen_alkhier_store/repos/contract_repos.dart';

class ContractProduct extends GetxController {
  ContractProductsResponse? contractProductsResponse;

  void setContractsProductsResponse(ContractProductsResponse response) {
    contractProductsResponse = response;
    if (response.data != null) setProducts(response.data!);
    update();
  }

  void clearContractProductsResponse() {
    contractProductsResponse = null;
    update();
  }

  List<ContractProductsModel> allProducts = [];
  List<ContractProductsModel> localStorageProducts = [];
  void setProductsInLocalStorage(ContractProductsModel product) {
    if (localStorageProducts.contains(product) == false) {
      localStorageProducts.add(product);
    } else {
      //  localStorageProducts.s(product);
      localStorageProducts[localStorageProducts.indexWhere(
          (element) => element.productId == product.productId)] = product;
    }
    //notifyListeners();
  }

  void setProducts(List<ContractProductsModel> products) {
    allProducts = [];
    allProducts.clear();
    allProducts.addAll(products);

    if (localStorageProducts.length > 0) {
      localStorageProducts.forEach((localProduct) {
        allProducts[allProducts.indexWhere(
                (element) => element.productId == localProduct.productId)]
            .quantityPerOrder = localProduct.quantityPerOrder;
      });
    }

    update();
  }

  void incrementQuantity(ContractProductsModel product) {
    allProducts.firstWhere((element) => element == product).quantityPerOrder =
        allProducts
                .firstWhere((element) => element == product)
                .quantityPerOrder! +
            1;

    update();
  }

  void setQuantity(ContractProductsModel product, int Quantity) {
    allProducts.firstWhere((element) => element == product).quantityPerOrder =
        allProducts
            .firstWhere((element) => element == product)
            .quantityPerOrder = Quantity;

    update();
  }

  void resetQuantity(ContractProductsModel product) {
    allProducts.firstWhere((element) => element == product).quantityPerOrder =
        0;

    update();
  }

  Future<void> decrementQuantity(ContractProductsModel product) async {
    allProducts.firstWhere((element) => element == product).quantityPerOrder =
        allProducts
                .firstWhere((element) => element == product)
                .quantityPerOrder! -
            1;

    update();
  }

  Future<void> removeProduct(ContractProductsModel product) async {
    allProducts.remove(product);
    await ContactRepository.deleteContractProducts(
      contractId: product.contractId.toString(),
      productId: product.productId.toString(),
    );
    update();
  }

  void clearProducts() {
    allProducts.clear();
  }
}
