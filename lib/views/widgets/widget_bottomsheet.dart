import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/data/responses/contract_products_response.dart';
import 'package:leen_alkhier_store/providers/cart_product_item_provider.dart';
import 'package:leen_alkhier_store/providers/contract_products_cart_provider.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:provider/provider.dart';

import 'custom_rounded_btn.dart';

class BottomSheetWidget extends StatelessWidget {
  final ContractProductsModel? productModel;
  bool? inCart = false;
  BottomSheetWidget({this.productModel, this.inCart});
  @override
  Widget build(BuildContext context) {
    var contractProductCartProductItemProvider =
        Provider.of<ContractProductCartProductItemProvider>(context);
    return Consumer<OrderDetailsCartProductItemProvider>(
        builder: (context, controller, _) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(productModel!.imageUrl!)),
                    SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      productModel!.units![0].price.toString() + "SR",
                      style: TextStyle(color: Colors.teal),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    (controller.localStorageProductsDetails
                            .any((element) => element == productModel)
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: GestureDetector(
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                      onTap: () async {
                                        if (productModel!.quantityPerOrder! >
                                            1.toDouble()) {
                                          controller
                                              .incrementQuantityInAddProduct(
                                                  productModel);
                                          controller
                                              .setProductsInLocalStorageInDetails(
                                                  productModel);

                                          return;
                                        }
                                      }),
                                ),
                                GestureDetector(
                                  onTap: () async {},
                                  child: Container(
                                    height: 23,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      // border: Border.all(color: Colors.grey),
                                      border: Border(
                                        bottom: BorderSide(
                                          //                   <--- bottom side
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                        top: BorderSide(
                                          //                    <--- top side
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                      //    borderRadius: BorderRadius.circular(5)
                                    ),
                                    // child: Text(contractProductProvider. allProducts.firstWhere((element) => element == widget.productModel).quantityPerOrder.toString()),
                                    child: Text(productModel!.quantityPerOrder
                                        .toString()),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      // border: Border.all(color: Colors.grey),
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: GestureDetector(
                                      child: Icon(
                                        Icons.remove_outlined,
                                        color: Colors.white,
                                      ),
                                      onTap: () async {
                                        if (productModel!.quantityPerOrder! >
                                            1.toDouble()) {
                                          controller
                                              .decrementQuantityInAddProduct(
                                                  productModel);

                                          controller
                                              .setProductsInLocalStorageInDetails(
                                                  productModel);

                                          return;
                                        }
                                      }),
                                )
                              ],
                            ),
                          )
                        : controller.ordersListFromApi.any((element) =>
                                element.pivot!.productId ==
                                productModel!.productId)
                            ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.teal,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: GestureDetector(
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                          onTap: () async {
                                              controller
                                                  .incrementQuantityInAddProduct(
                                                      productModel);

                                              controller
                                                  .setProductsInLocalStorageInDetails(
                                                      productModel);

                                              return;

                                          }),
                                    ),
                                    GestureDetector(
                                      onTap: () async {},
                                      child: Container(
                                        height: 23,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          // border: Border.all(color: Colors.grey),
                                          border: Border(
                                            bottom: BorderSide(
                                              //                   <--- bottom side
                                              color: Colors.grey,
                                              width: 1.0,
                                            ),
                                            top: BorderSide(
                                              //                    <--- top side
                                              color: Colors.grey,
                                              width: 1.0,
                                            ),
                                          ),
                                          //    borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Text(controller.ordersListFromApi
                                            .firstWhere((element) =>
                                                element.pivot!.productId ==
                                                productModel!.productId)
                                            .pivot!
                                            .quantity
                                            .toString()),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.teal,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: GestureDetector(
                                          child: Icon(
                                            Icons.remove_outlined,
                                            color: Colors.white,
                                          ),
                                          onTap: () async {

                                              controller
                                                  .decrementQuantityInAddProduct(
                                                      productModel);
                                              controller
                                                  .setProductsInLocalStorageInDetails(
                                                      productModel);

                                              return;

                                          }),
                                    )
                                  ],
                                ),
                              )
                            : Container(
                                width: 100,
                                child: CustomRoundedButton(
                                  backgroundColor: CustomColors.PRIMARY_GREEN,
                                  borderColor: CustomColors.PRIMARY_GREEN,
                                  text: "Add_to_cart",
                                  textColor: Colors.white,
                                  pressed: () async {
                                    controller
                                        .setProductsInLocalStorageInDetails(
                                            productModel);
                                  },
                                  //borderColor: Colors.red,
                                ),
                              ))
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
