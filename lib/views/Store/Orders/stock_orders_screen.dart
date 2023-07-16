import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/utils/analytics_service.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/Store/Orders/order_details_screen.dart';
import 'package:leen_alkhier_store/views/widgets/text_widget_with_style.dart';
import 'package:localize_and_translate/localize_and_translate.dart';


class StockOrdersScreen extends StatefulWidget{
  final String? type;
  StockOrdersScreen({this.type});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StockOrdersScreenState();
  }

}

class StockOrdersScreenState extends State<StockOrdersScreen>{
  List<OrderData> stock_in_orders = [
    OrderData(
      order_number: 100,
      name: "اسم مركز تشغيل الرئيسى",
      editable: true,
      register_date: "22/11/2022",
    ),
    OrderData(
      order_number: 101,
      name: "اسم مركز تشغيل الرئيسى",
      editable: false,
      register_date: "7/09/2023",
    ),
    OrderData(
      order_number: 102,
      name: "اسم مركز تشغيل الرئيسى",
      editable: true,
      register_date: "25/05/2021",
    ),
  ];
  AnalyticsService analytics = AnalyticsService();
  List<OrderData> stock_out_orders = [
    OrderData(
      order_number: 9,
      name: "اسم مركز تشغيل الرئيسى",
      editable: false,
      register_date: "29/12/2020",
    ),
    OrderData(
      order_number: 10,
      name: "اسم مركز تشغيل الرئيسى",
      editable: true,
      register_date: "9/01/2021",
    ),
    OrderData(
      order_number: 11,
      name: "اسم مركز تشغيل الرئيسى",
      editable: false,
      register_date: "21/02/2014",
    ),
  ];
  List<OrderData> orders =[];

  @override
  Widget build(BuildContext context) {
    orders = widget.type == "purchases" ? stock_in_orders :stock_out_orders;
    return Directionality(
        textDirection: MyMaterial.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child:Container(
          height:
          MediaQuery.of(context).size.height *
              0.80,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 15, vertical: 5),
            child: ListView.builder(
              itemCount: orders.length,
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: false,
              itemBuilder: (BuildContext context, int index) {
                return   Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child:Directionality(textDirection: translator.activeLanguageCode == 'ar'? TextDirection.rtl : TextDirection.ltr,
                    child: Container(
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
                                  '${'order_number'.tr()}  ${orders[index].order_number} # ',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                               InkWell(
                                 onTap: (){
                                   analytics
                                       .setUserProperties(
                                       userRole:
                                       "Signup Contract Screen");
                                    Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                           builder: (ctx) =>
                                               OrderDetailsScreen(
                                                 order_number: orders[index].order_number,
                                               )));
                                 },
                                 child:  Container(
                                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(5),
                                     color:CustomColors.PRIMARY_GREEN,
                                   ),
                                   child: Text(
                                     kdetails.tr(),
                                     style: TextStyle(color: Colors.white, fontSize: 12),
                                   ),
                                 ),
                               )
                              ],
                            ),
                            Divider(
                              color: CustomColors.GREY_LIGHT_A_COLOR,
                              indent: 0.0,
                              endIndent: 0.0,
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
                                              text:orders[index].name!),

                                        ],
                                      ),
                                      Row(
                                        children: [
                                          TextWidgetwithStyle(
                                              text: kregisteration_date.tr()),
                                          SizedBox(width: 5,),
                                          TextWidgetwithStyle(
                                              text: orders[index].register_date!)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          TextWidgetwithStyle(
                                              text: keditable.tr()),
                                          SizedBox(width: 10,),
                                          Text(orders[index].editable! ? kyes.tr() : kno.tr(),
                                              style: TextStyle(
                                                  color: orders[index].editable! ? CustomColors.PRIMARY_GREEN :CustomColors.RED_COLOR,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal))

                                        ],
                                      ),


                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ));
              },

            ),
          ),
        )
    );
  }

}

class OrderData{
  final int? order_number;
  final String? register_date;
  final bool? editable;
  final String? name;
  OrderData({this.order_number,this.name,this.editable,this.register_date});
}