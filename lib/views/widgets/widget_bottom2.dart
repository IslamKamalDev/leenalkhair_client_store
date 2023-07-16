import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:leen_alkhier_store/data/responses/Units/uint_entity.dart';
import 'package:leen_alkhier_store/data/responses/contract_products_response.dart';
import 'package:leen_alkhier_store/providers/Units/product_units_provider.dart';
import 'package:leen_alkhier_store/providers/cart_product_item_provider.dart';
import 'package:leen_alkhier_store/providers/contract_products_cart_provider.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/widgets/add_quantity_dialog.dart';
import 'package:leen_alkhier_store/views/widgets/contract_product_units_widget.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

import 'custom_rounded_btn.dart';

class BottomSheetWidget2 extends StatelessWidget {
  final ContractProductsModel? productModel;
  bool? inCart = false;
  String? branch_id;
                                                                                              BottomSheetWidget2({this.productModel, this.inCart,this.branch_id});
  @override
  Widget build(BuildContext context) {
    var cartProductsProvider = Provider.of<OrderDetailsCartProductItemProvider>(context, listen: false);

    return Consumer<OrderDetailsCartProductItemProvider>(
        builder: (context, controller, _) {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: CustomColors.WHITE_COLOR,
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
            // border: Border.all(color: CustomColors.PRIMARY_GREEN)
          ),
          child: SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
            productModel!.priceOffer!
                ? Stack(
                    children: [
                      CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.1,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              NetworkImage(productModel!.imageUrl!)),
                      Positioned(
                          right: 0,
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: CustomColors.RED_COLOR,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      translator
                                          .translate("offer")!,
                                      style: TextStyle(
                                        color: CustomColors.WHITE_COLOR,
                                      ),
                                    ),
                                  ))))
                    ],
                  )
                : CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: MediaQuery.of(context).size.width * 0.1,
                    backgroundImage: NetworkImage(productModel!.imageUrl!)),
            SizedBox(
              height: 5,
            ),

            Text(
              (translator.activeLanguageCode == 'en')
                  ? productModel!.name
                  : productModel!.nameAr,
            ),

            SizedBox(
              height: 5,
            ),

                productModel!.multiUnits!
                    ? Text(" ${kMultiple_quantity.tr()} ", style: TextStyle(color: Colors.black),)
                    :    Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                (translator.activeLanguageCode == 'en')
                    ? Text(
                  productModel!.priceOffer!
                      ? productModel!.units![0].offerPrice.toString()
                      :  productModel!.units![0].price.toString() + " SAR ",
                        style: TextStyle(color: Colors.teal),
                      )
                    : Text(
                        productModel!.priceOffer!
                            ? productModel!.units![0].offerPrice.toString()
                            : productModel!.units![0].price.toString() +
                                " ر.س ",
                        style: TextStyle(color: Colors.teal),
                      ),
                SizedBox(
                  width:ScreenUtil.defaultSize.width * 0.008,
                ),
                Text(
                  (translator.activeLanguageCode== 'en')
                      ? productModel!.units![0].unit.toString()
                      : productModel!.units![0].unitAr.toString(),
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),

            SizedBox(
              height: 5,
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                controller.localStorageProductsDetails
                        .any((element) => element == productModel)
                    ? productModel!.multiUnits!
                        ? CustomRoundedButton(
                           width: ScreenUtil.defaultSize.width * 0.3,
                            backgroundColor: CustomColors.SECONDART_GREEN,
                            borderColor: CustomColors.PRIMARY_GREEN,
                            text: kAdded_to_cart,
                            fontSize: 12,
                            height: MediaQuery.of(context).size.width * 0.1,
                            textColor: Colors.black,
                            pressed: () async {

                              List<int?> product_units_chossed = [];
                              var product_units_provider = Provider.of<ProductUnitsProvider>(context, listen: false);
                              product_units_provider.selectd_unit = null;
                              product_units_provider.getContractProductUnits(
                                  product_id: productModel!.productId.toString(),
                                  contract_id: productModel!.contractId.toString(),
                                  branch_id: branch_id
                              ).whenComplete(() async {
                                cartProductsProvider.allProducts.map((e) {
                                  if(e.id == productModel!.productId){
                                    product_units_provider.contractProductUnitResponse!.data!.forEach((element) {
                                      if(e.unitId == element.id){
                                        product_units_chossed.add(element.id);
                                      }
                                    });
                                  }
                                }).toList();
                              }).whenComplete(() async {

                                if(product_units_chossed.length >= product_units_provider.contractProductUnitResponse!.data!.length){
                                  ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                                    duration: const Duration(seconds: 1),
                                    content: Text(kProduct_units_filled.tr(),
                                      textAlign: TextAlign.center,),
                                  )
                                  );
                                }
                                else{
                                  List<UintEntity> contract_product_units_list = [];
                                  var result = await   showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    shape: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(ScreenUtil.defaultSize.width * 0.1),
                                            topRight:Radius.circular( ScreenUtil.defaultSize.width * 0.1)
                                        )
                                    ),
                                    builder: (context) {
                                      return    ContractProductUnitsWidget(
                                        ctx: context,
                                        product_id: productModel!.productId.toString(),
                                        product_units_chossed: product_units_chossed,
                                        contract_id: productModel!.contractId.toString(),
                                      );
                                    },
                                  );
                         /*         var result = await showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (ctx) =>
                                          ContractProductUnitsWidget(
                                            ctx: ctx,
                                            product_id: productModel!.productId.toString(),
                                            product_units_chossed: product_units_chossed,
                                            contract_id: productModel!.contractId.toString(),
                                          ));*/

                                  if (result['accept'] != null && result['accept']) {
                                    contract_product_units_list = result['contract_product_units_list'];

                                    contract_product_units_list.forEach((element) {
                                      productModel!.units!.forEach((e) {
                                        if (element.unit_id == e.unitId) {
                                          e.quantityPerUnit =
                                              element.quantity_per_unit;
                                        }
                                      });
                                    });

                                    controller.setProductsInLocalStorageInDetails(productModel);
                                  }

                                }
                              });


                            },
                          )

                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: GestureDetector(
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                      onTap: () async {
                                       if (productModel!.units![0].quantityPerUnit > 1.toDouble()) {
                                            controller.incrementQuantityInAddProduct(productModel);
                                            controller.setProductsInLocalStorageInDetails(productModel);
                                             return;
                                       }
                                      }),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    var result = await showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (ctx) => addQuntityDialog(
                                              quantity: productModel!.units![0].quantityPerUnit.toString().split('.')[0],
                                            ));
                                    if (result['accept'] != null &&
                                        result['accept'] == true) {
                                      controller.setQuantity(productModel, result['Quantity']);
                                      controller.setProductsInLocalStorageInDetails(productModel);
                                    }
                                  },
                                  child: Container(
                                    height: 23,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
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
                                    child: Text(productModel!.units![0].quantityPerUnit.toString().split('.')[0]),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.circular(5)),

                                  child: GestureDetector(
                                      child: Icon(
                                        Icons.remove_outlined,
                                        color: Colors.white,
                                      ),
                                      onTap: () async {
                                       if (productModel!.units![0].quantityPerUnit > 1.toDouble()) {
                                         controller.decrementQuantityInAddProduct(productModel);
                                         controller.setProductsInLocalStorageInDetails(productModel);
                                         return;
                                       }

                                      }),
                                )
                              ],
                            ),
                          )

                    : controller.ordersListFromApi.any((element) =>
                            element.pivot!.productId == productModel!.productId)
                        ? productModel!.multiUnits!
                            ? Container(
                                child: CustomRoundedButton(
                                  width: ScreenUtil.defaultSize.width * 0.25,
                                  backgroundColor: CustomColors.SECONDART_GREEN,
                                  borderColor: CustomColors.PRIMARY_GREEN,
                                  text: kAdded_to_cart,
                                  fontSize: 12,
                                  height:
                                      MediaQuery.of(context).size.width * 0.1,
                                  textColor: Colors.black,
                                  pressed: () async {
                                    List<int?> product_units_chossed = [];
                                    var product_units_provider = Provider.of<ProductUnitsProvider>(context, listen: false);
                                    product_units_provider.selectd_unit = null;
                                    product_units_provider.getContractProductUnits(
                                        product_id: productModel!.productId.toString(),
                                        contract_id: productModel!.contractId.toString(),
                                        branch_id: branch_id
                                    )
                                        .whenComplete(() async {
                                      cartProductsProvider.allProducts.map((e) {
                                        if(e.id == productModel!.productId){
                                          product_units_provider.contractProductUnitResponse!.data!.forEach((element) {
                                            if(e.unitId == element.id){
                                              product_units_chossed.add(element.id);
                                            }
                                          });
                                        }
                                      }).toList();
                                    }).whenComplete(() async {

                                      if(product_units_chossed.length >= product_units_provider.contractProductUnitResponse!.data!.length){
                                        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                                          duration: const Duration(seconds: 1),
                                          content: Text(kProduct_units_filled.tr(),
                                            textAlign: TextAlign.center,),

                                        )
                                        );
                                      }
                                      else{
                                        List<UintEntity> contract_product_units_list = [];
                                        var result = await   showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          shape: OutlineInputBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(ScreenUtil.defaultSize.width * 0.1),
                                                  topRight:Radius.circular( ScreenUtil.defaultSize.width * 0.1)
                                              )
                                          ),
                                          builder: (context) {
                                            return    ContractProductUnitsWidget(
                                              ctx: context,
                                              product_id: productModel!.productId.toString(),
                                              contract_id: productModel!.contractId.toString(),
                                              product_units_chossed: product_units_chossed,
                                            );
                                          },
                                        );
                                    /*    var result = await showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (ctx) =>
                                                ContractProductUnitsWidget(
                                                  ctx: ctx,
                                                  product_id: productModel!.productId.toString(),
                                                  contract_id: productModel!.contractId.toString(),
                                                  product_units_chossed: product_units_chossed,
                                                ));*/

                                        if (result['accept'] != null && result['accept']) {
                                          contract_product_units_list = result['contract_product_units_list'];

                                          contract_product_units_list.forEach((element) {
                                            productModel!.units!.forEach((e) {
                                              if (element.unit_id == e.unitId) {
                                                e.quantityPerUnit =
                                                    element.quantity_per_unit;
                                              }
                                            });
                                          });

                                          controller.setProductsInLocalStorageInDetails(productModel);
                                        }

                                      }
                                    });


                                  },
                                ),
                              )
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.teal,
                                          borderRadius: BorderRadius.circular(5)),
                                      child: GestureDetector(
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                          onTap: () async {
                                            controller.incrementQuantityInAddProduct(productModel);
                                            controller.setProductsInLocalStorageInDetails(productModel);
                                            return;
                                          }),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        var result = await showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (ctx) => addQuntityDialog(
                                                  quantity: productModel!
                                                      .quantityPerOrder
                                                      .toString().split('.')[0],
                                                ));
                                        if (result['accept'] != null &&
                                            result['accept'] == true) {
                                          controller.setQuantity(
                                              productModel, result['Quantity']);
                                          controller.setProductsInLocalStorageInDetails(productModel);
                                        }
                                      },
                                      child: Container(
                                        height: 23,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
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
                                        child: Text(controller.ordersListFromApi.firstWhere((element) =>
                                                    element.pivot!.productId == productModel!.productId).pivot!.quantity.toString().split('.')[0]),
                                      ),
                                    ),
                                    Container(
                                      // padding: EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                          // border: Border.all(color: Colors.grey),
                                          color: Colors.teal,
                                          borderRadius:
                                              BorderRadius.circular(5)),

                                      child: GestureDetector(
                                          child: Icon(
                                            Icons.remove_outlined,
                                            color: Colors.white,
                                          ),
                                          onTap: () async {
                                              controller.decrementQuantityInAddProduct(productModel);
                                              controller.setProductsInLocalStorageInDetails(productModel);

                                              return;

                                          }),
                                    )
                                  ],
                                ),
                              )
                        :  CustomRoundedButton(
                              backgroundColor: CustomColors.PRIMARY_GREEN,
                              borderColor: CustomColors.PRIMARY_GREEN,
                             width: ScreenUtil.defaultSize.width * 0.25,
                              text: "Add_to_cart",
                              textColor: Colors.white,
                              pressed: () async {
                                if (productModel!.multiUnits!) {
                                  CustomViews.showLoadingDialog(context: context);

                                  var product_units_provider = Provider.of<ProductUnitsProvider>(context, listen: false);
                                  product_units_provider.selectd_unit = null;
                                  product_units_provider.getContractProductUnits(
                                          product_id: productModel!.productId.toString(),
                                          contract_id: productModel!.contractId.toString(),
                                    branch_id: branch_id
                                  ).whenComplete(() async {
                                    CustomViews.dismissDialog(context: context);
                                    List<UintEntity>contract_product_units_list = [];
                                    var result = await   showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      shape: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(ScreenUtil.defaultSize.width * 0.1),
                                              topRight:Radius.circular( ScreenUtil.defaultSize.width * 0.1)
                                          )
                                      ),
                                      builder: (context) {
                                        return    ContractProductUnitsWidget(
                                          ctx: context,
                                          product_id: productModel!.productId.toString(),
                                          contract_id: productModel!.contractId.toString(),
                                          product_units_chossed: [],
                                        );
                                      },
                                    );
                          /*          var result = await showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (ctx) =>
                                            ContractProductUnitsWidget(
                                              ctx: ctx,
                                              product_id: productModel!.productId.toString(),
                                              contract_id: productModel!.contractId.toString(),
                                              product_units_chossed: [],
                                            ));
*/
                                    if (result['accept'] != null &&
                                        result['accept']) {
                                      contract_product_units_list =
                                          result['contract_product_units_list'];

                                      contract_product_units_list
                                          .forEach((element) {
                                        productModel!.units!.forEach((e) {
                                          if (element.unit_id == e.unitId) {
                                            e.quantityPerUnit =
                                                element.quantity_per_unit;
                                          }
                                        });
                                      });

                                      controller
                                          .setProductsInLocalStorageInDetails(
                                              productModel);
                                    }
                                  });
                                } else {
                                  controller.setProductsInLocalStorageInDetails(
                                      productModel);
                                }
                              },
                            ),

              ],
            ),
          ])));
    });
  }
}
