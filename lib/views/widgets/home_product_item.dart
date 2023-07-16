import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;

import 'package:leen_alkhier_store/data/models/request_product_details_list.dart';
import 'package:leen_alkhier_store/data/responses/Units/uint_entity.dart';
import 'package:leen_alkhier_store/data/responses/all_products_response.dart';
import 'package:leen_alkhier_store/providers/Employee/all_employees_provider.dart';
import 'package:leen_alkhier_store/providers/Units/product_units_provider.dart';
import 'package:leen_alkhier_store/providers/add_product_contract_provider.dart';
import 'package:leen_alkhier_store/providers/contract_products_cart_provider.dart';
import 'package:leen_alkhier_store/providers/contract_products_provider.dart';
import 'package:leen_alkhier_store/providers/get/contract_product_Local.dart';
import 'package:leen_alkhier_store/providers/home_tabs_provider.dart';
import 'package:leen_alkhier_store/providers/user_info_provider.dart';
import 'package:leen_alkhier_store/utils/Constants.dart';
import 'package:leen_alkhier_store/utils/Shared.dart';
import 'package:leen_alkhier_store/utils/analytics_service.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/Store/stock_in_product_register_notes_screen.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:leen_alkhier_store/views/widgets/custom_textfield.dart';
import 'package:leen_alkhier_store/views/widgets/product_units_widget.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

class HomeProductItem extends StatefulWidget {
  ProductModel? productModel;
  bool? productStatu;

  HomeProductItem({this.productModel});

  @override
  _HomeProductItemState createState() => _HomeProductItemState();
}

class _HomeProductItemState extends State<HomeProductItem> {
  var quantityFormKey = GlobalKey<FormState>();
  bool addContractStatus = false;
  AnalyticsService analytics = AnalyticsService();

  @override
  void initState() {
    //Check If user has (contract add and edit) permission or not
    Provider.of<AllEmployeesProvider>(context, listen: false).tokenPermissionsRespnse.permissions!
        .forEach((element) {
      if (element.name == "add and edit contract") {
        addContractStatus = true;
      }
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var userInfoProvider = Provider.of<UserInfoProvider>(context);
    var contractsProductsCartProvider =
        Provider.of<ContractProductCartProductItemProvider>(context);
    var addProductContractProvider = Provider.of<AddProductContractProvider>(context,listen: false);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Container(
          decoration: BoxDecoration(
            color: CustomColors.WHITE_COLOR,
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
            // border: Border.all(color: CustomColors.PRIMARY_GREEN)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  flex: 4,
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: FadeInImage.assetNetwork(
                          image: widget.productModel!.imageUrl!,
                          fit: BoxFit.contain,
                          placeholder: "assets/placeholder.png",
                        ),
                      ),
                      contractProductsList.any((element) => element.product_id == widget.productModel!.id)
                        && widget.productModel!.productStatus == false  ?     Align(
                        alignment:  Alignment.topRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           Expanded(
                               flex:1,
                               child:   Align(
                                   alignment:  translator.activeLanguageCode == "en"
                                       ? Alignment.topRight :Alignment.topLeft,
                                   child:IconButton (
                             icon: Icon(
                               Icons.delete,
                               color: Colors.deepOrangeAccent,
                             ),

                             onPressed: () {
                               bool addProductTocontractProducts =
                               contractProductsList.any((product) => product.product_id == widget.productModel!.id);
                               if (addProductTocontractProducts == true) {
                                 for(int i = 0 ; i< contractProductsList.length ; i++){
                                   if (contractProductsList[i].product_id == widget.productModel!.id) {
                                     contractProductsList.remove(contractProductsList[i]);
                                     setState(() {});
                                     addProductContractProvider.productRemoved();
                                   }
                                   //      break;
                                 }

                               }

                             },
                           ))),

                            Expanded(
                                flex:2,
                                child:  Align(
                                  alignment:  translator.activeLanguageCode == "en"
                                      ? Alignment.topRight :Alignment.topLeft,
                                  child: IconButton (
                                    icon: Image.asset(ImageAssets.edit_product,
                                    ),
                                     iconSize: ScreenUtil.defaultSize.width * 0.02,
                                    onPressed: () {
                                      analytics.setUserProperties(
                                          userRole:
                                          "StockInProductRegisterNotesScreen");
                                      CustomViews.navigateTo(
                                          context,
                                          StockInProductRegisterNotesScreen(
                                            product_name: widget.productModel!.name,
                                          ),
                                          "StockInProductRegisterNotesScreen");
                                    },
                                  ),
                                ))
                          ],
                        ),
                      ) : Container()
                    ],
                  )


              ),
              Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      widget.productModel!.name!,
                      maxLines: 4,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 2,
                        height: 1,
                      ),
                    ),
                  )),
              Expanded(
                  flex: 3,
                  child: OrientationBuilder(
                    builder: (context, orientation) => Container(
                      child: GetBuilder<ContractProductLocal>(
                        init: ContractProductLocal(),
                        builder: (controller) => Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: CustomRoundedButton(
                                backgroundColor: widget.productModel!.productStatus == true ? CustomColors.ORANGE : CustomColors.PRIMARY_GREEN,
                                fontSize: 12,
                                height: MediaQuery.of(context).size.width * 0.08,
                                borderColor: widget.productModel!.productStatus == true ? CustomColors.ORANGE : CustomColors.PRIMARY_GREEN,
                                text: (contractsProductsCartProvider.allProducts.any((element) => element.productId == widget.productModel!.id)
                                    && userInfoProvider.userInfoResponse!.contract == true)
                                    || (controller.allProductsAddLocalToContact.contains(widget.productModel!.id))
                                    || widget.productModel!.contractStatus!
                                    ? widget.productModel!.productStatus == false
                                        ? 'product_not_active'
                                        : kadded_to_contract
                                    : contractProductsList.any((element) => element.product_id == widget.productModel!.id)
                                        ? "choised"
                                        : kSelect_product,
                                textColor: CustomColors.WHITE_COLOR,

                                pressed:
                                    (widget.productModel!.contractStatus! && widget.productModel!.productStatus == false)
                                        ? () {}
                                        : () async {
                                  if(Shared.user_has_branches){
                                    if (addContractStatus) {
                                      CustomViews.showLoadingDialog(context: context);
                                      await userInfoProvider.getUserInfo().whenComplete(() => CustomViews.dismissDialog(context: context))
                                          .then((value) async {
                                        if (userInfoProvider.userInfoResponse!.contract == false) {
                                          CustomViews.showSnackBarView(
                                              title_status: false,
                                              message: 'home_no_contract_active',
                                              backgroundColor: CustomColors.RED_COLOR,
                                              success_icon: false
                                          );

                                          return;
                                        }
                                        else {
                                          var product_units_provider = Provider.of<ProductUnitsProvider>(context, listen: false);
                                          product_units_provider.selectd_unit = null;

                                          product_units_provider.getContractProductUnits(
                                              product_id: widget.productModel!.id.toString())
                                              .whenComplete(() async {
                                            if (!product_units_provider.contractProductUnitResponse!.data!
                                                .any((element) => element.onContract == false)) {
                                              ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                                                duration: const Duration(seconds: 1),
                                                content: Text(
                                                  translator.activeLanguageCode == "ar"
                                                      ? "تم اضافة كمية لكل وحدات المنتج" : "A quantity has been added to each product unit",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ));
                                            } else {
                                              List<UintEntity>product_units_list = [];
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
                                                  return ProductUnitsWidget(
                                                    ctx: context,
                                                    productModel: widget.productModel,);
                                                },
                                              );


                                              if (result != null) {
                                                if (result['accept'] != null && result['accept']) {
                                                  product_units_list = result['product_units_list'];
                                                  bool addProductTocontractProducts =
                                                  contractProductsList.any((product) => product.product_id == widget.productModel!.id);
                                                  if (addProductTocontractProducts == true) {
                                                    contractProductsList.forEach((product) {
                                                      if (product.product_id == widget.productModel!.id) {
                                                        product_units_list.forEach((element) {
                                                          product.units!.add(element);
                                                        });
                                                      }
                                                    });
                                                  }
                                                  else {
                                                    contractProductsList.add(ProductDetails(
                                                        product_id: widget.productModel!.id,
                                                        product_name: widget.productModel!.name,
                                                        product_image: widget.productModel!.imageUrl,
                                                        units: product_units_list));

                                                    setState(() {});
                                                    addProductContractProvider.productAdded();
                                                  }


                                                }
                                              }

                                            }
                                          });
                                        }
                                      });

                                    }
                                    else {

                                      CustomViews.showSnackBarView(
                                          title_status: false,
                                          message: kno_permission,
                                          backgroundColor: CustomColors.RED_COLOR,
                                          success_icon: false
                                      );

                                    }


                                  }else{
                                    CustomViews.showSnackBarView(
                                        title_status: false,
                                        message: kuser_has_o_branches_message,
                                        backgroundColor: CustomColors.RED_COLOR,
                                        success_icon: false
                                    );
                                  }


                                          },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ))
            ],
          )),
    );
  }
}
