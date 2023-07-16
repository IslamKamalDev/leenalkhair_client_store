/*
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leen_alkhier_store/data/responses/Branch/business_branches_response.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/providers/Branch/business_branches_provider.dart';
import 'package:leen_alkhier_store/providers/Employee/all_employees_provider.dart';
import 'package:leen_alkhier_store/providers/Orders/orders_providers.dart';
import 'package:leen_alkhier_store/providers/contract_info_provider.dart';

import 'package:leen_alkhier_store/providers/contract_products_cart_provider.dart';
import 'package:leen_alkhier_store/providers/contract_products_provider.dart';
import 'package:leen_alkhier_store/providers/get/draftOrderViewModel.dart';
import 'package:leen_alkhier_store/providers/get/orderViewModel.dart';
import 'package:leen_alkhier_store/providers/user_all_contract_orders_provider.dart';
import 'package:leen_alkhier_store/providers/user_info_provider.dart';
import 'package:leen_alkhier_store/utils/Constants.dart';

import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/index_screens/order_screens/BranchListBottomSheet.dart';
import 'package:leen_alkhier_store/views/index_screens/order_screens/all_orders.dart';
import 'package:leen_alkhier_store/views/index_screens/order_screens/draft_orders.dart';
import 'package:leen_alkhier_store/views/widgets/branch_list_radio.dart';

import 'package:leen_alkhier_store/views/widgets/empty_widget.dart';
import 'package:leen_alkhier_store/views/widgets/order_item.dart';
import 'package:leen_alkhier_store/views/widgets/orders_branch_selector.dart';
import 'package:leen_alkhier_store/views/widgets/signup_header.dart';
import 'package:leen_alkhier_store/utils/sized_config.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Orders extends StatefulWidget {
  final String? type;
  final int? tabNum;
  Orders({this.type, this.tabNum});
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  ScrollController scrollController = ScrollController();
  final OrderViewModel orderController = Get.put(OrderViewModel());
  final DraftOrderViewModel draftorderController =
      Get.put(DraftOrderViewModel());

  bool currentOrdersFound = false;
  bool firstFound = false;
  Future<BusinessBranchesResponse>? employee_branches;
  SharedPreferences? sharedPreferences;

  bool Confirme_Orders_status = false;
@override
  void initState() {
  var allEmployeesProvider = Provider.of<AllEmployeesProvider>(context,listen: false);
  allEmployeesProvider.tokenPermissionsRespnse.permissions!
      .forEach((element) {
   if (element.name == "Confirme Orders") {
      Confirme_Orders_status = true;
    }

  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    branchsID = [];
    SizeConfig().init(context);

    var userInfoProvider = Provider.of<UserInfoProvider>(context);
    var tabedProvider = Provider.of<OrderProvider>(context, listen: true);
    return Directionality(
        textDirection: MyMaterial.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child:RefreshIndicator(
        onRefresh: () async {
          var contractsProductsCartProvider = Provider.of<ContractProductCartProductItemProvider>(context, listen: false);

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

        },
        color: Colors.transparent,
        backgroundColor: Colors.transparent,
        edgeOffset: 0.0,
        displacement: 0.0,
        strokeWidth: 0.0,

        child:userInfoProvider.userInfoResponse!.contract!
        ? SafeArea(
            bottom: false,
            child: Scaffold(
              backgroundColor: CustomColors.WHITE_COLOR,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: ScreenUtil.defaultSize.width * 0.03,
                    ),

               //     branch_selector(),
                    OrderBranchSelector(),

                    SizedBox(
                      height: ScreenUtil.defaultSize.width * 0.1,
                    ),
                    Confirme_Orders_status ?   Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Expanded(child:   InkWell(
                                onTap: () {
                                  tabedProvider.setIndex(0);
                                },
                                child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.46,
                                    color: tabedProvider.tabNumber == 0
                                        ? CustomColors.WHITE_COLOR
                                        : Colors.transparent,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          "${translator.activeLanguageCode == "ar" ? "الطلبات الحالية" : "Current Orders"}",
                                          style: tabedProvider.tabNumber == 0
                                              ? Theme.of(context)
                                              .textTheme
                                              .labelLarge
                                              : TextStyle(
                                            // color: CustomColors.,
                                              fontWeight:
                                              FontWeight.normal),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                      ],
                                    ))),),
                              Expanded(child:   InkWell(
                                  onTap: () {
                                    tabedProvider.setIndex(1);
                                  },
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.46,
                                      color: tabedProvider.tabNumber == 1
                                          ? CustomColors.WHITE_COLOR
                                          : Colors.transparent,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            "${translator.activeLanguageCode == "ar" ?  "الطلبات المعلقة" : "Draft Orders"}",
                                            style: tabedProvider.tabNumber == 1
                                                ? Theme.of(context)
                                                    .textTheme
                                                    .labelLarge
                                                : TextStyle(
                                                    color:
                                                        CustomColors.GREY_COLOR,
                                                    fontWeight:
                                                        FontWeight.normal),
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                        ],
                                      )))),
                            ],
                          ),
                          Container(
                            height: 5,
                            color: CustomColors.PRIMARY_GREEN,
                            // width: 25.w,
                          ),
                        ],
                      ),
                    ) : Container(),
                    tabedProvider.tabNumber == 0 ? AllOrders() : DraftOrders(),
                  ],
                ),
              ),
            ),
          )
        : SingleChildScrollView(
            child: Column(children: [

            SizedBox(
              height: MediaQuery.of(context).size.width * 0.5,
            ),
            Center(
                child: EmptyWidget(
                  text:translator.activeLanguageCode == "ar" ? "لا يوجد طلبات" : "No orders found",            )),
          ]))
        )  );
  }

  Widget branch_selector() {
    List<Branches> branchList = [];


    var businessBranchesProvider = Provider.of<BusinessBranchesProvider>(context);
    var allEmployeesProvider = Provider.of<AllEmployeesProvider>(context);

    Provider.of<AllEmployeesProvider>(context, listen: false)
        .businessBranchesResponse!.branches!
        .forEach((element) {
      branchList.add(element);
    });
// sort branches list to gell all branches in top of list
    branchList.sort((a, b) => a.id.toString().compareTo(b.id.toString()));


    return Provider.of<AllEmployeesProvider>(context, listen: false).businessBranchesResponse!.branches!.isEmpty ?
    Container() : InkWell(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(ScreenUtil.defaultSize.width * 0.1),
                  topRight:Radius.circular( ScreenUtil.defaultSize.width * 0.1)
              )
          ),
          context: context,
          builder: (context) {
            return BranchsListBottomSheet(
              branches: branchList,
            );

          },
        );
      },
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: ScreenUtil().setHeight(35),
            //   width: MediaQuery.of(context).size.width * 0.75,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: CustomColors.WHITE_COLOR,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: CustomColors.GREY_LIGHT_B_COLOR)),
            child: Row(
              children: [
                //
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                businessBranchesProvider.selectedBranch == null
                                ?allEmployeesProvider.businessBranchesResponse!.branches!.length == 0 ? "" :
                             allEmployeesProvider.businessBranchesResponse!.branches![
                               allEmployeesProvider.businessBranchesResponse!.branches!.length - 1].name
                                : businessBranchesProvider.selectedBranch!.name ?? ""
                            ),
                            Row(
                              children: [
                                Icon(Icons.keyboard_arrow_down),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    // height: 40,
                                    width: 2,
                                    color: CustomColors.GREY_LIGHT_B_COLOR,
                                  ),
                                ),
                                Image.asset(ImageAssets.selectBranch),
                              ],
                            )
                          ]),

                    ))
              ],
            ),
          )),
    );
  }


}
*/
