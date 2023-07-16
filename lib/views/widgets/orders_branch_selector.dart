import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide trans;
import 'package:leen_alkhier_store/providers/Branch/business_branches_provider.dart';
import 'package:leen_alkhier_store/providers/Employee/all_employees_provider.dart';
import 'package:leen_alkhier_store/providers/contract_products_cart_provider.dart';
import 'package:leen_alkhier_store/providers/get/draftOrderViewModel.dart';
import 'package:leen_alkhier_store/providers/get/orderViewModel.dart';
import 'package:leen_alkhier_store/utils/Constants.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/views/index_screens/order_screens/BranchListBottomSheet.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

import '../../data/responses/Branch/business_branches_response.dart';
import '../../utils/local_const.dart';

class OrderBranchSelector extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrderBranchSelectorState();
  }

}

class OrderBranchSelectorState extends State<OrderBranchSelector>{
  bool checked = false;
  final OrderViewModel orderController = Get.put(OrderViewModel());
  final DraftOrderViewModel draftorderController =
  Get.put(DraftOrderViewModel());
  List<Branches> branchList = [];

  @override
  void initState() {

    var businessBranchesProvider = Provider.of<BusinessBranchesProvider>(context,listen: false);
    Provider.of<AllEmployeesProvider>(context, listen: false)
        .businessBranchesResponse!.branches!
        .forEach((element) {
          if(element.id == "0"){
            print("aaaaaaaaaaaaaaaa");
            businessBranchesProvider.changeBranch(element);
          }
      branchList.add(element);
    });
// sort branches list to gell all branches in top of list
    branchList.sort((a, b) => a.id.toString().compareTo(b.id.toString()));

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    var businessBranchesProvider = Provider.of<BusinessBranchesProvider>(context);
    var allEmployeesProvider = Provider.of<AllEmployeesProvider>(context);


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
            /*return BranchsListBottomSheet(
              branches: branchList,
            );*/
            return StatefulBuilder(builder: (context, setState)
            {
              return Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.86,
                margin: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(30)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            child: Image.asset(ImageAssets.close),
                            width: 40,
                            height: 40,
                            // color: Colors.red,
                          ),
                        )
                      ]),
                      Center(
                          child: SingleChildScrollView(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "${translator.activeLanguageCode == "ar" ?  "حدد الفروع" : "Select branches"}",
                                  style: TextStyle(
                                      color: CustomColors.PRIMARY_GREEN,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Divider(
                                  color: CustomColors.GREY_LIGHT_A_COLOR,
                                  indent: 0.0,
                                  endIndent: 0.0,
                                ),
                                ListView.separated(
                                    physics: const ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: branchList.length,
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        color: CustomColors.GREY_LIGHT_A_COLOR,
                                        indent: 0.0,
                                        endIndent: 0.0,
                                      );
                                    },
                                    itemBuilder: (context, index) =>
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 0),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  5.0),
                                              child: Row(
                                                children: [
                                                  Checkbox(
                                                    side: BorderSide(
                                                        color: CustomColors.GREY_LIGHT_B_COLOR),
                                                    value: branchsID.contains(branchList[index].id),
                                                    activeColor: CustomColors.PRIMARY_GREEN,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        if (branchsID.contains(branchList[index].id)) {
                                                          if (branchList[index].id != "0") {
                                                            branchsID.remove(branchList[index].id);
                                                          } else {
                                                            branchList.forEach((element) {
                                                              branchsID.remove(element.id);
                                                              branchsID = [];
                                                            });
                                                          }
                                                        }
                                                        else {
                                                          if (branchList[index].id != "0") {
                                                            branchsID.add(branchList[index].id);
                                                          } else {
                                                            branchList.forEach((element) {
                                                              if (branchsID.contains(element.id)) {} else {
                                                                branchsID.add(element.id);
                                                              }
                                                            });
                                                          }
                                                        }
                                                      });
                                                    },
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      branchList[index].name,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ))),
                                Divider(
                                  color: CustomColors.GREY_LIGHT_A_COLOR,
                                  indent: 0.0,
                                  endIndent: 0.0,
                                ),
                                SizedBox(
                                  height: 70,
                                ),
                                // Spacer(),
                                Container(
                                  height: ScreenUtil().setHeight(45),
                                  child: CustomRoundedButton(
                                    fontSize: 15,
                                    text: "show_results",
                                    textColor: CustomColors.WHITE_COLOR,
                                    backgroundColor: CustomColors.PRIMARY_GREEN,
                                    borderColor: CustomColors.PRIMARY_GREEN,
                                    pressed: () {
                                      if(branchsID.length ==0){
                                        CustomViews.showSnackBarView(
                                            title_status: false,
                                            message: translator.activeLanguageCode == "ar" ? "لابد من اختيار الفرع " : "you must choose branch",
                                            backgroundColor: CustomColors.RED_COLOR,
                                            success_icon: false);
                                      }else{

                                        var contractsProductsCartProvider =
                                        Provider.of<ContractProductCartProductItemProvider>(context, listen: false);


                                        orderController.currentPage = 1;
                                        draftorderController.currentPage = 1;

                                        orderController.changeLoadingStatues(
                                            true);
                                        draftorderController.changeLoadingStatues(
                                            true);

                                        orderController.orders2 = [];
                                        draftorderController.draftorders2 = [];
                                        orderController.getOrders(
                                            contractID: contractsProductsCartProvider
                                                .allProducts[0].contractId
                                                .toString(),
                                            branch_id: branchsID,
                                            pageNumber: orderController
                                                .currentPage);
                                        draftorderController.getDraftOrders(
                                            contractID: contractsProductsCartProvider
                                                .allProducts[0].contractId
                                                .toString(),
                                            branch_id: branchsID,
                                            pageNumber: orderController
                                                .currentPage);

                                        if(branchsID.length == branchList.length){
                                          businessBranchesProvider.changeBranch(branchList[0]);
                                        }else{
                                          branchList.forEach((element) {

                                            if(branchsID.contains(element.id)){
                                              businessBranchesProvider.changeBranch(element);
                                            }

                                          });
                                        }

                                        Navigator.pop(context);

                                      }

                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                // dontHaveAnAccount()
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              );
            });
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
                borderRadius: BorderRadius.circular(8),
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
                                businessBranchesProvider.selectedBranch!.name
                          /*      businessBranchesProvider.selectedBranch == null
                                    ?allEmployeesProvider.businessBranchesResponse!.branches!.length == 0 ? "" :
                                allEmployeesProvider.businessBranchesResponse!.branches![
                                allEmployeesProvider.businessBranchesResponse!.branches!.length - 1].name
                                    : businessBranchesProvider.selectedBranch!.name ?? ""*/
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