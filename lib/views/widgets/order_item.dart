// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:leen_alkhier_store/data/responses/user_orders.dart';
import 'package:leen_alkhier_store/providers/user_all_contract_orders_provider.dart';
import 'package:leen_alkhier_store/utils/analytics_service.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/index_screens/order_screens/order\'s_details.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
class OrderItem extends StatefulWidget {
  OrderModel? orderModel;
  String? employee_id;
  String? contract_id;
  String? branch_id;
  Widget? route;
  String? type;
  OrderItem(
      {this.orderModel,
      this.employee_id,
      this.contract_id,
      this.branch_id,
      this.type,
      this.route});

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var f = NumberFormat("###,###.00#", "en_US");
  AnalyticsService analytics = AnalyticsService();

  @override
  Widget build(BuildContext context) {
    var userAllContractOrderProvider =
        Provider.of<UserAllContractOrderProvider>(context, listen: false);
    return Directionality(textDirection: translator.activeLanguageCode == 'ar'? ui.TextDirection.rtl : ui.TextDirection.ltr,
        child: Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        // margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: CustomColors.WHITE_COLOR,
        ),
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(15),
            vertical: ScreenUtil().setWidth(15)),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${'order_number'.tr()}  ${widget.orderModel!.refrenceNumber} # ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: widget.orderModel!.status_en == "Pending"
                        ? CustomColors.BLUE_LIGHT_A
                        : widget.orderModel!.status_en == "Canceled"
                        ? CustomColors.RED_LIGHT_A
                        : widget.orderModel!.status_en == "Completed"
                        ? CustomColors.GREEN_LIGHT_A
                        : widget.orderModel!.status_en == "Accepted"
                        ? CustomColors.BLUE_LIGHT_B
                        : widget.orderModel!.status_en == "Packed"
                        ? CustomColors.BRAWN_LIGHT
                        : widget.orderModel!.status_en ==
                        "Ontheway"
                        ? CustomColors.GREEN_LIGHT
                        : widget.orderModel!.status_en ==
                        "draft"
                        ? CustomColors.ORANGE_LIGHT
                        : CustomColors.PRIMARY_GREEN,
                  ),
                  child: Text(
                    (translator.activeLanguageCode== 'en')
                        ? widget.orderModel!.status_en!
                        : widget.orderModel!.status_ar!,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                )
              ],
            ),
            Divider(
              color: CustomColors.GREY_LIGHT_A_COLOR,
              indent: 0.0,
              endIndent: 0.0,
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidgetwithStyle(
                              text:kbranch_name.tr()),
                          TextWidgetwithStyle(
                              text: widget.orderModel!.branch_name!)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidgetwithStyle(
                              text: "order_date".tr()),
                          TextWidgetwithStyle(
                              text: widget.orderModel!.orderDate!
                                  .split("T")[0])
                        ],
                      ),
                      Container(
                        alignment: translator.activeLanguageCode == 'ar'? Alignment.centerRight : Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidgetwithStyle(
                                text: "deliver_hours".tr()),
                            TextWidgetwithStyle(
                                text: (translator.activeLanguageCode == 'en')
                                    ? widget.orderModel!.timingName2!.en!.toLowerCase()
                                    : widget.orderModel!.timingName2!.ar!.toLowerCase())
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidgetwithStyle(text: "total".tr()),
                          TextWidgetwithStyle(
                              text: f.format(double.parse(widget
                                  .orderModel!.total!
                                  .toStringAsFixed(2))) +
                                  " ${'currency'.tr()}")
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () async {
                    analytics.setUserProperties(
                        userRole: "Order Details Screen");

                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => OrderDetails(
                              orderModel: widget.orderModel,
                              id: widget.orderModel!.id,
                              employee_id: widget.employee_id,
                              refrenceNumber: widget
                                  .orderModel!.refrenceNumber
                                  .toString(),
                              route: widget.route,
                              type: widget.type,
                            ),
                            settings:
                            RouteSettings(name: "Order Details Screen")));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.yellow,
                    ),
                    child: Text('details'.tr(),
                        style: TextStyle(
                            color: CustomColors.BLACK_COLOR, fontSize: 12)),
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    ));
  }
}
