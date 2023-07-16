// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leen_alkhier_store/data/responses/Branch/business_branches_response.dart';
import 'package:leen_alkhier_store/providers/contract_products_cart_provider.dart';
import 'package:leen_alkhier_store/providers/get/draftOrderViewModel.dart';
import 'package:leen_alkhier_store/providers/get/orderViewModel.dart';
import 'package:leen_alkhier_store/utils/Constants.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

class BranchsListBottomSheet extends StatefulWidget {
  List<Branches>? branches;
  BranchsListBottomSheet({this.branches});

  @override
  _BranchsListBottomSheetState createState() => _BranchsListBottomSheetState();
}

class _BranchsListBottomSheetState extends State<BranchsListBottomSheet> {
  bool checked = false;
  List<Branches> selectedBranches = [];
  final OrderViewModel orderController = Get.put(OrderViewModel());
  final DraftOrderViewModel draftorderController =
      Get.put(DraftOrderViewModel());

  @override
  Widget build(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).size.height * 0.86,
      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
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
                    "${translator.activeLanguageCode == "ar" ? "حدد الفروع" : "Select branches"}",
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
                      itemCount: widget.branches!.length,
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: CustomColors.GREY_LIGHT_A_COLOR,
                          indent: 0.0,
                          endIndent: 0.0,
                        );
                      },
                      itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Checkbox(
                                  side: BorderSide(
                                      color: CustomColors.GREY_LIGHT_B_COLOR),
                                  value: branchsID
                                      .contains(widget.branches![index].id),
                                  activeColor: CustomColors.PRIMARY_GREEN,
                                  onChanged: (value) {
                                    setState(() {

                                      if (branchsID.contains(widget.branches![index].id)) {
                                        if (widget.branches![index].id != "0") {
                                          branchsID.remove(widget.branches![index].id);
                                        } else {
                                          widget.branches!.forEach((element) {
                                            branchsID.remove(element.id);
                                            branchsID = [];
                                          });
                                        }
                                      } else {
                                        if (widget.branches![index].id != "0") {
                                          branchsID.add(widget.branches![index].id);
                                        } else {
                                          widget.branches!.forEach((element) {
                                            if (branchsID.contains(element.id)) {
                                            } else {
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
                                    widget.branches![index].name,
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
                      var contractsProductsCartProvider =
                            Provider.of<ContractProductCartProductItemProvider>(
                                context,
                                listen: false);



                        orderController.currentPage = 1;
                        draftorderController.currentPage = 1;

                        orderController.changeLoadingStatues(true);
                        draftorderController.changeLoadingStatues(true);

                        orderController.orders2 = [];
                        draftorderController.draftorders2 = [];
                        orderController.getOrders(
                            contractID: contractsProductsCartProvider.allProducts[0].contractId.toString(),
                            branch_id: branchsID,
                            pageNumber: orderController.currentPage);
                        draftorderController.getDraftOrders(
                            contractID: contractsProductsCartProvider
                                .allProducts[0].contractId
                                .toString(),
                            branch_id: branchsID,
                            pageNumber: orderController.currentPage);

                        Navigator.pop(context);
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
  }
}
