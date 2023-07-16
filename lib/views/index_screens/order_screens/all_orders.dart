import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/providers/Branch/business_branches_provider.dart';
import 'package:leen_alkhier_store/providers/Employee/all_employees_provider.dart';
import 'package:leen_alkhier_store/providers/Orders/orders_providers.dart';
import 'package:leen_alkhier_store/providers/contract_products_cart_provider.dart';
import 'package:leen_alkhier_store/providers/contract_products_provider.dart';
import 'package:leen_alkhier_store/providers/get/draftOrderViewModel.dart';
import 'package:leen_alkhier_store/providers/get/orderViewModel.dart';
import 'package:leen_alkhier_store/providers/user_all_contract_orders_provider.dart';
import 'package:leen_alkhier_store/providers/user_info_provider.dart';
import 'package:leen_alkhier_store/utils/Constants.dart';
import 'package:leen_alkhier_store/utils/Shared.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/sized_config.dart';
import 'package:leen_alkhier_store/views/widgets/empty_widget.dart';
import 'package:leen_alkhier_store/views/widgets/order_item.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/responses/Branch/business_branches_response.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({
    Key? key,
  }) : super(key: key);

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  ScrollController scrollController = ScrollController();
  final OrderViewModel orderController = Get.put(OrderViewModel());
  bool currentOrdersFound = false;
  bool firstFound = false;
  SharedPreferences? sharedPreferences;
  var branch_id;
  @override
  void initState() {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      setPagination();
    });

    super.initState();
  }

  void setPagination() async {
    var allEmployeesProvider = Provider.of<AllEmployeesProvider>(context, listen: false);
    var userAllContractOrderProvider = Provider.of<UserAllContractOrderProvider>(context, listen: false);
    var contractProducts = Provider.of<ContractProductsProvider>(context, listen: false);
    var contractsProductsCartProvider = Provider.of<ContractProductCartProductItemProvider>(context, listen: false);

    orderController.changeLoadingStatues(true);
    userAllContractOrderProvider.changeLoadingStatues(true);
    orderController.changeLoadingPage(true);

    try {
      allEmployeesProvider.clearBusinessBranches();
      allEmployeesProvider.getEmployeeBranches().then((value) {

          allEmployeesProvider.businessBranchesResponse = value;
          value!.branches!.forEach((element) async {
            if (value.branches!.indexOf(element) == 0) {
              branch_id = element.id.toString();
              branchsID = [];
              branchsID.add(branch_id);
              var businessBranchesProvider = Provider.of<BusinessBranchesProvider>(context, listen: false);
              print("sssssssssss");
              businessBranchesProvider.changeBranch(element);

              await contractProducts.getContractProducts(branch_id: element.id.toString()).then((value) {
                contractsProductsCartProvider.setContractsProductsResponse(value);
                orderController.changeLoadingStatues(false);

                // TODO: implement initState\
                try {
                  orderController.changeLoadingStatues(true);
                  Future.delayed(const Duration(milliseconds: 500), () {
                    orderController.orders2 = [];
                    orderController.orders = [];
                    orderController.currentPage = 1;
                    try {
                      orderController.getOrders(
                          contractID: contractsProductsCartProvider.allProducts[0].contractId.toString(),
                          branch_id: branchsID,
                          pageNumber: orderController.currentPage);
                    } catch (e) {
                      orderController.changeLoadingStatues(false);
                    }
                    //   orderController.changeLoadingStatues(false);
                  });
                } catch (e) {
                  orderController.changeLoadingStatues(false);
                }
              });
            }
          });


      });
    } catch (e) {
      orderController.changeLoadingPage(false);
      orderController.changeLoadingStatues(false);
    }

    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        //loadingPages=true;
        if (orderController.currentPage != orderController.lastPage) {
          //  currentPage++;
          orderController.changeCurrentPage();
          orderController.currentPage <= orderController.lastPage!
              ? orderController.getOrders(
                  contractID: contractsProductsCartProvider
                      .allProducts[0].contractId
                      .toString(),
                  branch_id: branchsID,
                  pageNumber: orderController.currentPage)
              : '';
        } else {
          orderController.changeLoadingPage(false);
          orderController.changeLoadingStatues(false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);

    var contractsProductsCartProvider =
        Provider.of<ContractProductCartProductItemProvider>(context);

    return  Directionality(
        textDirection: MyMaterial.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child:RefreshIndicator(
      onRefresh: () async {
        orderController.orders = [];
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          orderController.clearValues();
        });
        orderController.orders2 = [];
        orderController.changeLoadingStatues(false);
        orderController.currentPage = 1;

        orderController.changeLoadingPage(true);

        orderController.lastPage = null;

        // setPagination();
      },
      child: GetBuilder<OrderViewModel>(
          init: OrderViewModel(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Shared.user_has_branches ?  Container(
                  height: MediaQuery.of(context).size.height * .735,
                  child: (contractsProductsCartProvider.contractProductsResponse == null)
                      ? SizedBox(
                          height: MediaQuery.of(context).size.width * 0.5,
                          child: Center(
                            child: CircularProgressIndicator(
                              backgroundColor: CustomColors.PRIMARY_GREEN,
                            ),
                          ),
                        )
                      : (!contractsProductsCartProvider.contractProductsResponse!.status! )
                          ? Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  EmptyWidget(
                                    text:translator.activeLanguageCode == "ar" ? "لا يوجد طلبات" : "No orders found",
                                  ),
                                ],
                              ),
                            )
                          : (contractsProductsCartProvider.allProducts.isEmpty)
                              ? EmptyWidget(
                                text:translator.activeLanguageCode == "ar" ? "لا يوجد طلبات" : "No orders found",
                                )
                              : controller.orders2.length > 0
                                  ? Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.80,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        child: ListView.builder(
                                          controller: scrollController,
                                          physics: const AlwaysScrollableScrollPhysics(),
                                          shrinkWrap: false,
                                          itemBuilder: (BuildContext context, int index) {
                                            if (controller.orders2.length > 0) {
                                              if ((controller.orders2.length < 3 &&
                                                      index == controller.orders2.length &&
                                                      controller.loadingPages == true) ||
                                                  (controller.loadingPages == false && index == controller.orders2.length)) {
                                                return Center(
                                                    child: Container());
                                              }
                                              if (controller.loadingPages == true &&
                                                  index == controller
                                                          .orders2.length) {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    backgroundColor:
                                                        CustomColors.RED_COLOR,
                                                  ),
                                                );
                                              }
                                              return OrderItem(
                                                contract_id:
                                                    contractsProductsCartProvider
                                                        .allProducts[0]
                                                        .contractId
                                                        .toString(),
                                                branch_id: branch_id,
                                                orderModel:
                                                    controller.orders2[index],
                                              );
                                            } else {
                                              return EmptyWidget(
                                                text:translator.activeLanguageCode == "ar" ? "لا يوجد طلبات" : "No orders found",);
                                            }
                                          },
                                          itemCount:
                                              controller.orders2.length + 1,
                                        ),
                                      ),
                                    )
                                  : controller.orders2.isEmpty &&
                                          (controller.loading == false)
                                      ? EmptyWidget(
                                         text:translator.activeLanguageCode == "ar" ? "لا يوجد طلبات" : "No orders found",
                                        )
                                      : Center(
                                          child: CircularProgressIndicator(
                                            backgroundColor:
                                                CustomColors.PRIMARY_GREEN,
                                          ),
                                        ))
                  :  Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * .2,),
                    EmptyWidget(
                      text:translator.activeLanguageCode == "ar" ? "لا يوجد طلبات" : "No orders found",
                    ),
                  ],
                ),
              ),
            );
          }),
        ) );
    // });
  }
}
