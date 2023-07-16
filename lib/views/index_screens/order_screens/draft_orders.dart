import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leen_alkhier_store/data/responses/Branch/business_branches_response.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/providers/Branch/business_branches_provider.dart';
import 'package:leen_alkhier_store/providers/Employee/all_employees_provider.dart';
import 'package:leen_alkhier_store/providers/Orders/orders_providers.dart';
import 'package:leen_alkhier_store/providers/contract_products_cart_provider.dart';
import 'package:leen_alkhier_store/providers/contract_products_provider.dart';
import 'package:leen_alkhier_store/providers/get/draftOrderViewModel.dart';
import 'package:leen_alkhier_store/providers/user_all_contract_orders_provider.dart';
import 'package:leen_alkhier_store/providers/user_info_provider.dart';
import 'package:leen_alkhier_store/utils/Constants.dart';
import 'package:leen_alkhier_store/utils/Shared.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/views/widgets/empty_widget.dart';
import 'package:leen_alkhier_store/views/widgets/order_item.dart';
import 'package:leen_alkhier_store/utils/sized_config.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DraftOrders extends StatefulWidget {
  const DraftOrders({
    Key? key,
  }) : super(key: key);

  @override
  State<DraftOrders> createState() => _DraftOrdersState();
}

class _DraftOrdersState extends State<DraftOrders> {
  ScrollController scrollController = ScrollController();
  final DraftOrderViewModel draftorderController =
      Get.put(DraftOrderViewModel());
  // final DraftOrderViewModel draftorderController =
  //     Get.put(DraftOrderViewModel());

  bool currentOrdersFound = false;
  bool firstFound = false;
  Future<BusinessBranchesResponse>? employee_branches;
  SharedPreferences? sharedPreferences;
  var branch_id;

  @override
  void initState() {
    var userInfoProvider =
        Provider.of<UserInfoProvider>(context, listen: false);
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      userInfoProvider.userInfoResponse!.contract! ? setPagination() : null;
    });

    super.initState();
  }

  void setPagination() async {
    var allEmployeesProvider =
        Provider.of<AllEmployeesProvider>(context, listen: false);
    var userInfoProvider =
        Provider.of<UserInfoProvider>(context, listen: false);
    draftorderController.changeLoadingStatues(true);
    var userAllContractOrderProvider =
        Provider.of<UserAllContractOrderProvider>(context, listen: false);
    userAllContractOrderProvider.changeLoadingStatues(true);
    draftorderController.changeLoadingPage(true);
    var contractProducts =
        Provider.of<ContractProductsProvider>(context, listen: false);
    var contractsProductsCartProvider =
        Provider.of<ContractProductCartProductItemProvider>(context,
            listen: false);
    try {
      allEmployeesProvider.clearBusinessBranches();
      allEmployeesProvider.getEmployeeBranches().then((value) {

          allEmployeesProvider.businessBranchesResponse = value;
          value!.branches!.forEach((element) async {
            if (value.branches!.indexOf(element) == 0) {
              branch_id = element.id.toString();
              var businessBranchesProvider =
              Provider.of<BusinessBranchesProvider>(context, listen: false);
              businessBranchesProvider.changeBranch(element);

              await contractProducts
                  .getContractProducts(branch_id: element.id.toString())
                  .then((value) {
                contractsProductsCartProvider.setContractsProductsResponse(
                    value);
                draftorderController.changeLoadingStatues(false);

                // TODO: implement initState\
                try {
                  draftorderController.changeLoadingStatues(true);
                  Future.delayed(const Duration(milliseconds: 500), () {
                    draftorderController.draftorders2 = [];
                    draftorderController.draftorders = [];
                    draftorderController.currentPage = 1;
                    try {
                      draftorderController.getDraftOrders(
                          contractID: contractsProductsCartProvider
                              .allProducts[0].contractId
                              .toString(),
                          branch_id: branchsID,
                          pageNumber: draftorderController.currentPage);
                    } catch (e) {
                      draftorderController.changeLoadingStatues(false);
                    }
                    //   orderController.changeLoadingStatues(false);
                  });
                } catch (e) {
                  draftorderController.changeLoadingStatues(false);
                }
              });
            }
          });

      });
    } catch (e) {
      draftorderController.changeLoadingPage(false);
      draftorderController.changeLoadingStatues(false);
    }

    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        //loadingPages=true;
        if (draftorderController.currentPage !=
            draftorderController.draftlastPage) {
          //  currentPage++;
          draftorderController.changeCurrentPage();

          draftorderController.currentPage <=
                  draftorderController.draftlastPage!
              ? draftorderController.getDraftOrders(
                  contractID: contractsProductsCartProvider
                      .allProducts[0].contractId
                      .toString(),
                  branch_id: branchsID,
                  pageNumber: draftorderController.currentPage)
              : '';
        } else {
          draftorderController.changeLoadingPage(false);
          draftorderController.changeLoadingStatues(false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {


    var userInfoProvider = Provider.of<UserInfoProvider>(context);
    var contractsProductsCartProvider =
        Provider.of<ContractProductCartProductItemProvider>(context);

    return Directionality(
        textDirection: MyMaterial.app_langauge == 'ar' ? TextDirection.rtl :TextDirection.ltr,
        child:RefreshIndicator(
      onRefresh: () async {
        draftorderController.draftorders = [];
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          draftorderController.clearValues();
        });
        draftorderController.draftorders2 = [];
        draftorderController.changeLoadingStatues(false);
        draftorderController.currentPage = 1;

        draftorderController.changeLoadingPage(true);

        draftorderController.draftlastPage = null;

        // setPagination();
      },
      child: GetBuilder<DraftOrderViewModel>(
          init: DraftOrderViewModel(),
          builder: (controller) {
            return SingleChildScrollView(
                child: Shared.user_has_branches ? Container(
              height: MediaQuery.of(context).size.height * .735,
              child: (contractsProductsCartProvider.contractProductsResponse ==
                      null)
                  ? SizedBox(
                      height: MediaQuery.of(context).size.width * 0.5,
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: CustomColors.PRIMARY_GREEN,
                        ),
                      ),
                    )
                  : (!contractsProductsCartProvider
                          .contractProductsResponse!.status!)
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              userInfoProvider.userInfoResponse == null ||
                                      userInfoProvider.userInfoResponse!
                                              .contractStatus ==
                                          "Pending"
                                  ?
                                  //new
                                  EmptyWidget(
                                    text:translator.activeLanguageCode == "ar" ? "لا يوجد طلبات" : "No orders found",
                                    )
                                  : EmptyWidget(
                                text:translator.activeLanguageCode == "ar" ? "لا يوجد طلبات" : "No orders found",
                                    ),
                            ],
                          ),
                        )
                      : (contractsProductsCartProvider.allProducts.isEmpty)
                          ? EmptyWidget(
                text:translator.activeLanguageCode == "ar" ? "لا يوجد طلبات" : "No orders found",
                            )
                          : controller.draftorders2.length > 0
                              ? Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.80,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: ListView.builder(
                                      controller: scrollController,
                                      physics: const AlwaysScrollableScrollPhysics(),
                                      shrinkWrap: false,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        if (controller.draftorders2.length >
                                            0) {
                                          if ((controller.draftorders2.length <
                                                      3 &&
                                                  index ==
                                                      controller.draftorders2
                                                          .length &&
                                                  controller.loadingPages ==
                                                      true) ||
                                              (controller.loadingPages ==
                                                      false &&
                                                  index ==
                                                      controller.draftorders2
                                                          .length)) {
                                            return Center(child: Container());
                                          }
                                          if (controller.loadingPages == true &&
                                              index ==
                                                  controller
                                                      .draftorders2.length) {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                backgroundColor:
                                                    CustomColors.PRIMARY_GREEN,
                                              ),
                                            );
                                          }

                                          return OrderItem(
                                            contract_id:
                                                contractsProductsCartProvider
                                                    .allProducts[0].contractId
                                                    .toString(),
                                            branch_id: branch_id,
                                            orderModel:
                                                controller.draftorders2[index],
                                          );
                                        } else {
                                          return EmptyWidget(
                                            text:translator.activeLanguageCode == "ar" ? "لا يوجد طلبات" : "No orders found",);
                                        }
                                      },
                                      itemCount:
                                          controller.draftorders2.length + 1,
                                    ),
                                  ),
                                )
                              : controller.draftorders2.isEmpty &&
                                      (controller.loading == false)
                                  ? EmptyWidget(
                                      text:translator.activeLanguageCode == "ar" ? "لا يوجد طلبات" : "No orders found",                                    )
                                  : Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor:
                                            CustomColors.PRIMARY_GREEN,
                                      ),
                                    ),
            )
                    : Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * .2,),
                      EmptyWidget(
                        text:translator.activeLanguageCode == "ar" ? "لا يوجد طلبات" : "No orders found",                      ),
                    ],
                  ),
                )
            );
          }),
    ));
    // });
  }
}
