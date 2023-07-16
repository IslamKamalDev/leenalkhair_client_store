import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leen_alkhier_store/data/models/request_product_details_list.dart';
import 'package:leen_alkhier_store/data/responses/contract_products_response.dart';
import 'package:leen_alkhier_store/data/responses/order_details.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/providers/Branch/business_branches_provider.dart';
import 'package:leen_alkhier_store/providers/Employee/all_employees_provider.dart';
import 'package:leen_alkhier_store/providers/cart_product_item_provider.dart';
import 'package:leen_alkhier_store/providers/contract_products_cart_provider.dart';
import 'package:leen_alkhier_store/providers/contract_products_provider.dart';
import 'package:leen_alkhier_store/providers/user_orders_provider.dart';
import 'package:leen_alkhier_store/utils/analytics_service.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:leen_alkhier_store/views/widgets/signup_header.dart';
import 'package:leen_alkhier_store/views/widgets/widget_bottom2.dart';
import 'package:provider/provider.dart';

import 'package:leen_alkhier_store/views/index_screens/order_screens/order\'s_details.dart';

class AddProducts extends StatefulWidget {
  OrderrDetails? order;
  String? branch;
  String? type;
  Widget? order_details_screen;
  AddProducts({this.order, this.branch, this.order_details_screen,this.type});
  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  AnalyticsService analytics = AnalyticsService();

  @override
  void initState() {
    var allEmployeesProvider =
        Provider.of<AllEmployeesProvider>(context, listen: false);

    allEmployeesProvider.getEmployeeBranches().then((value) {
      value!.branches!.forEach((element) {
        if (element.name == widget.branch) {
          var businessBranchesProvider =
              Provider.of<BusinessBranchesProvider>(context, listen: false);
          businessBranchesProvider.changeBranch(element);
        }
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userOrderProvider = Provider.of<UserOrderProvider>(context);
    var contractProducts = Provider.of<ContractProductsProvider>(context, listen: false);
    var orderDetailsCartProductItemProvider = Provider.of<OrderDetailsCartProductItemProvider>(context, listen: false);
    var contractsProductsCartProvider = Provider.of<ContractProductCartProductItemProvider>(context);

    return Consumer<OrderDetailsCartProductItemProvider>(
        builder: (context, controller, _) {
      return SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: CustomColors.GREY_COLOR_A,
          appBar : CustomViews.appBarWidget(
            context: context,
            title:"update_order",
          ),
          body: Directionality(
            textDirection: MyMaterial.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr,
            child:Column(
            children: [

              SizedBox(
                height: 20,
              ),
              Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Expanded(
                          child: Container(
                        child: Column(
                          children: [
                            Expanded(
                              child: OrientationBuilder(
                                builder: (context, orientation) =>
                                    GridView.count(
                                  padding: EdgeInsets.all(0),
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: orientation == Orientation.portrait ? 3 : 3,
                                  childAspectRatio: ScreenUtil.defaultSize.aspectRatio * 1.1,
                                  children: [
                                    ...contractsProductsCartProvider.allProducts
                                        .map((e) {

                                      var existingItem = contractsProductsCartProvider.localStorageProducts
                                              .firstWhere((itemToCheck) => itemToCheck!.productId == e.productId,
                                                  orElse: () => null);

                                      if (existingItem != null) {
                                        return BottomSheetWidget2(
                                          productModel: e,
                                          branch_id: widget.order!.branchId.toString(),
                                        );

                                      } else {
                                        return BottomSheetWidget2(
                                          productModel: e,
                                          branch_id: widget.order!.branchId.toString(),
                                        );

                                      }
                                    }).toList(),
                                  ],
                                ),
                              ),

                            )
                          ],
                        ),
                      ))
                    ],
                  )
              ),

              Expanded(
                flex: 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: CustomRoundedButton(
                            backgroundColor: CustomColors.PRIMARY_GREEN,
                            borderColor: CustomColors.PRIMARY_GREEN,
                            text: kSave,
                            textColor: Colors.white,

                            fontSize: 15,
                            pressed: () async {
                              CustomViews.showLoadingDialog(context: context);
                              var businessBranchesProvider = Provider.of<BusinessBranchesProvider>(context, listen: false);

                              var contractId;
                              await contractProducts.getContractProducts(
                                      branch_id: businessBranchesProvider.selectedBranch!.id.toString()
                              ).then((value) {
                                contractsProductsCartProvider.setContractsProductsResponse(value);
                                contractId = contractsProductsCartProvider.allProducts[0].contractId;
                              });

                              List<ProductDetails> products = [];
                              controller.localStorageProductsDetails.map((e) {
                                e!.units!.removeWhere((element) => element.quantityPerUnit ==  ""
                                    || element.quantityPerUnit ==  0.toString() || element.price == null
                                );

                                products.add(ProductDetails(
                                    order_id: widget.order!.id,
                                  product_id: e.productId,
                                  prod_units: e.units));
                              }).toList();

                              controller.ordersListFromApi.map((e) {
                                List<Units> units_list = [];
                                controller.ordersListFromApi.forEach((element) {
                                  if(element.id == e.id){
                                    units_list.add(Units(
                                      unitId: element.unitId,
                                      unit: element.unit_name_en,
                                      unitAr: element.unit_name_ar,
                                      quantityPerUnit: element.pivot!.quantity,
                                      price: element.pivot!.price,
                                    ));

                                  }
                                });

                                units_list.removeWhere((element) => element.quantityPerUnit == ""
                                    || element.quantityPerUnit ==  0.toString()|| element.price == null
                                );

                                Map<int, Units> mp = {};
                                for (var item in units_list) {
                                  mp[item.unitId] = item;
                                }
                                var filteredList = mp.values.toList();

                                products.add(ProductDetails(
                                    order_id: e.pivot!.orderId,
                                    product_id: e.pivot!.productId,
                                    prod_units: filteredList)
                                );

                              }).toList();

                              if (products.length == 0) {
                                CustomViews.dismissDialog(context: context);
                                CustomViews.showSnackBarView(
                                    title_status: false,
                                    message: 'can_not_create_order',
                                    backgroundColor: CustomColors.RED_COLOR,
                                    success_icon: false
                                );

                              } else {

                                await userOrderProvider
                                    .updateOrder(
                                        contract_id: contractId.toString(),
                                        orderId: widget.order!.id.toString(),
                                        products: products)
                                    .whenComplete(() =>
                                        CustomViews.dismissDialog(
                                            context: context))
                                    .then((value) {
                                  if (!value.status!) {
                                    CustomViews.showSnackBarView(
                                        title_status: false,
                                        backend_message:  value.message!,
                                        backgroundColor: CustomColors.RED_COLOR,
                                        success_icon: false
                                    );
                                  } else{
                                    CustomViews.showSnackBarView(
                                        title_status: true,
                                        message: 'order_success_update',
                                        backgroundColor: CustomColors.PRIMARY_GREEN,
                                        success_icon: true
                                    );
                                  }

                                  orderDetailsCartProductItemProvider
                                      .ClearLists();
                                  orderDetailsCartProductItemProvider
                                      .ordersListFromApi = [];
                                  orderDetailsCartProductItemProvider
                                      .localStorageProductsDetails = [];
                                  // Navigator.pop(context);
                                  Navigator.pop(context);
                                  analytics.setUserProperties(
                                      userRole: "Order Details Screen");
                                  CustomViews.navigateTo(
                                      context,
                                      widget.order_details_screen!,
                                      "Order Details  Screen");
                                }).catchError((e) {
                                  orderDetailsCartProductItemProvider.ClearLists();
                                  orderDetailsCartProductItemProvider.ordersListFromApi = [];
                                  orderDetailsCartProductItemProvider.localStorageProductsDetails = [];
                                });
                              }
                            },
                            //borderColor: Colors.red,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          child: CustomRoundedButton(
                            backgroundColor: CustomColors.ORANGE,
                            borderColor: CustomColors.ORANGE,
                            text: 'Cancel',
                            fontSize: 15,

                            textColor: Colors.white,
                            pressed: () async {
                              orderDetailsCartProductItemProvider
                                  .localStorageProductsDetails = [];
                              Navigator.pop(context);
                            },
                            //borderColor: Colors.red,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
            //child: BottomSheetWidget()
          ),)
        ),
      );
    });
  }
}
