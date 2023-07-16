import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:leen_alkhier_store/data/responses/Units/uint_entity.dart';
import 'package:leen_alkhier_store/data/responses/contract_products_response.dart';
import 'package:leen_alkhier_store/providers/Units/product_units_provider.dart';
import 'package:leen_alkhier_store/providers/contract_products_cart_provider.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/widgets/contract_product_units_widget.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

import 'add_quantity_dialog.dart';

class MyProductsProductItem extends StatefulWidget {
  ContractProductsModel? productModel;
  bool? inCart;
  String? branch_id;

  MyProductsProductItem({
    this.productModel,
    this.inCart,
    this.branch_id

  });

  @override
  _MyProductsProductItemState createState() => _MyProductsProductItemState();
}

class _MyProductsProductItemState extends State<MyProductsProductItem> {
  var homeScaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    var contractProductProvider =
        Provider.of<ContractProductCartProductItemProvider>(context,
            listen: true);


    return Consumer<ContractProductCartProductItemProvider>(
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
              Container(
                height: ScreenUtil.defaultSize.width * 0.23,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Center(
                      child: widget.productModel!.priceOffer!
                          ? Stack(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: FadeInImage.assetNetwork(
                                    image: widget.productModel!.imageUrl!,
                                    fit: BoxFit.contain,
                                    placeholder: "assets/placeholder.png",
                                    
                                  ),
                                ),
                                Positioned(
                                    right: 0,
                                    // top: 20,
                                    bottom: 60,
                                    child: Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.12,
                                            // height: MediaQuery.of(context).size.width * 0.05,
                                            decoration: BoxDecoration(
                                                color: CustomColors.RED_COLOR,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                translator
                                                    .translate("offer"),
                                                style: TextStyle(
                                                  color:
                                                      CustomColors.WHITE_COLOR,
                                                ),
                                              ),
                                            ))))
                              ],
                            )
                          : Container(
                              child: FadeInImage.assetNetwork(
                                image: widget.productModel!.imageUrl!,
                                fit: BoxFit.contain,
                                placeholder: "assets/placeholder.png",
                              ),
                            ),
                    ),

                    (widget.inCart != true) ?
                        Container()
                        : Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.deepOrangeAccent,
                              ),
                              onPressed: () {
                                contractProductProvider.resetQuantity(
                                    widget.productModel);
                                // contractProductProvider
                                //     .setProductsInLocalStorage(
                                //         widget.productModel);
                              },
                            ),
                          )
                  ],
                ),
              ),
              Text(
                (translator.activeLanguageCode == 'en')
                    ? widget.productModel!.name!
                    : widget.productModel!.nameAr!,
                maxLines: 5,
              ),

              SizedBox(
                height: 5,
              ),


              !(widget.productModel!.units!.where((element) => element.price != null).toList().length > 0)
                  ? Column(
                          children: [
                            widget.productModel!.multiUnits!
                                ? Text(
                              " ${kMultiple_quantity} ",
                              style: TextStyle(color: Colors.black),
                            )
                                : SizedBox(
                              height: MediaQuery.of(context).size.width * 0.07,
                            ),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              onPressed: () {},
                              child: Center(
                                  child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 0),
                                child: Text(
                              'product_not_priced'.tr(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12),
                                  //style: TextStyle(height: 1.3),
                                ),
                              )),
                              color: CustomColors.PRIMARY_GREEN,
                              textColor: Colors.white,
                            ),
                          ],
                        )
                  : widget.productModel!.multiUnits! ?
                   Text(" ${kMultiple_quantity.tr()} ", style: TextStyle(color: Colors.black),)
                  : Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              (!widget.productModel!.priceOffer! ?
                              (widget.productModel!.units!.firstWhere((element) => element.price != null)).price.toString()
                                  : (widget.productModel!.units!.firstWhere((element) => element.price != null)).offerPrice.toString()) +
                                  " ${'currency'.tr()} ",
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              (translator.activeLanguageCode == 'en')
                                  ? (widget.productModel!.units!.firstWhere((element) => element.price != null)).unit!.toLowerCase()
                                  : (widget.productModel!.units!.firstWhere((element) => element.price != null)).unitAr!.toLowerCase(),
                              style: TextStyle(color: CustomColors.ORANGE),
                            ),
                          ],
                        ),

              SizedBox(
                height: 5,
              ),

              (!(widget.productModel!.units!.where((element) => element.price != null).toList().length > 0)
                  && !widget.productModel!.priceOffer!)
                  ? Container()

                  : (widget.productModel!.availabe == true)

                  ? (controller.localStorageProducts.any((element) => element == widget.productModel) ||  widget.inCart == true)

                  ?widget.productModel!.multiUnits!
                  ? Container(
                  child: CustomRoundedButton(
                    backgroundColor:
                    CustomColors.PRIMARY_GREEN,
                    borderColor:
                    CustomColors.PRIMARY_GREEN,
                    text: kAdded_to_cart,
                    fontSize: 12,
                    height: MediaQuery.of(context).size.width * 0.1,
                    textColor: Colors.white,
                    pressed: () async {},
                  ),
                )
                  : Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      //      padding: EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                          //  border: Border.all(color: Colors.grey),
                                          color: Colors.teal,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: GestureDetector(
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                          onTap: () async {
                                            widget.inCart = false;
                                            contractProductProvider
                                                .incrementQuantity(
                                                    widget.productModel);
                                            contractProductProvider
                                                .setProductsInLocalStorage(
                                                    widget.productModel);
                                          }),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        var result = await showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (ctx) =>   addQuntityDialog(
                                                quantity: widget.productModel!.units![0].quantityPerUnit== null
                                                    ? 0.toString()
                                                    :widget.productModel!.units![0].quantityPerUnit.toString()
                                              //widget.productModel!.quantityPerOrder.toString(),
                                            ));
                                        if (result['accept'] != null &&
                                            result['accept'] == true) {
                                          contractProductProvider.setQuantity(
                                              widget.productModel,
                                              result['Quantity']);
                                          contractProductProvider
                                              .setProductsInLocalStorage(
                                                  widget.productModel);
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
                                        child: Text(
                                          (contractProductProvider.allProducts.firstWhere((element) => element == widget
                                              .productModel).units![0].quantityPerUnit) == null
                                              ? 0.toString()
                                              : contractProductProvider.allProducts.firstWhere((element) =>
                                          element == widget.productModel).units![0].quantityPerUnit.toString().split('.')[0],
                                        ),
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
                                            contractProductProvider.decrementQuantity(widget.productModel);
                                            contractProductProvider.setProductsInLocalStorage(widget.productModel);
                                            return;
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            )

                          : Container(
                              child: CustomRoundedButton(
                                backgroundColor: CustomColors.PRIMARY_GREEN,
                                borderColor: CustomColors.PRIMARY_GREEN,
                                text: "Add_to_cart",
                                height: MediaQuery.of(context).size.width * 0.1,
                                textColor: Colors.white,
                                fontSize: 12,
                                pressed: () async {
                                  if (widget.productModel!.multiUnits!) {
                                    CustomViews.showLoadingDialog(context: context);

                                    var product_units_provider = Provider.of<ProductUnitsProvider>(context, listen: false);
                                    product_units_provider.selectd_unit = null;
                                    product_units_provider.getContractProductUnits(
                                        product_id: widget.productModel!.productId.toString(),
                                        contract_id: widget.productModel!.contractId.toString(),
                                      branch_id: widget.branch_id
                                    ).whenComplete(() async {
                                      CustomViews.dismissDialog(context: context);
                                      List<UintEntity>contract_product_units_list = [];
                                      var result = await   showModalBottomSheet(
                                        isScrollControlled: true,
                                        shape: OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(ScreenUtil.defaultSize.width * 0.1),
                                                topRight:Radius.circular( ScreenUtil.defaultSize.width * 0.1)
                                            )
                                        ),
                                        context: context,
                                        builder: (context) {
                                          return    ContractProductUnitsWidget(
                                            ctx: context,
                                            product_id: widget.productModel!.productId.toString(),
                                            contract_id: widget.productModel!.contractId.toString(),
                                            product_units_chossed: [],
                                          );
                                        },
                                      );

                                      if (result['accept'] != null && result['accept']) {
                                        contract_product_units_list = result['contract_product_units_list'];
                                        contract_product_units_list.forEach((element) {
                                          widget.productModel!.units!.forEach((e) {
                                            if (element.unit_id == e.unitId){
                                              e.quantityPerUnit = element.quantity_per_unit;
                                            }
                                          });
                                        });
                                        controller.setProductsInLocalStorage(widget.productModel);
                                        setState(() {});
                                      }
                                    });
                                  } else {
                                    controller.setProductsInLocalStorage(widget.productModel);
                                    setState(() {});
                                  }
                                },
                                //borderColor: Colors.red,
                              ),
                            )

                  : RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          onPressed: () {
                            print('product_not_availabe'.tr());
                          },
                          child: Center(
                              child: Padding(
                            //padding: const EdgeInsets.(4.0),
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              'product_not_availabe'.tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 12),
                            ),
                          )),
                          //  color: CustomColors.PRIMARY_GREEN,
                          color: Colors.red,
                          textColor: Colors.white,
                        )
            ],
          )),
        );
      },
    );
  }


}
