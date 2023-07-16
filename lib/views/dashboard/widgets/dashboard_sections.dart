import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leen_alkhier_store/providers/Dashboard/dashboard_pages_provider.dart';
import 'package:leen_alkhier_store/providers/category_provider.dart';
import 'package:leen_alkhier_store/providers/home_tabs_provider.dart';
import 'package:leen_alkhier_store/utils/Shared.dart';
import 'package:leen_alkhier_store/utils/analytics_service.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/Store/stock_on_screen.dart';
import 'package:leen_alkhier_store/views/auth/signup/Create_products.dart';
import 'package:leen_alkhier_store/views/dashboard/dashboard_screen.dart';
import 'package:leen_alkhier_store/views/Store/store_stock_in_supplier_screen.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

class DashbordSections extends StatefulWidget {
  const DashbordSections({
    Key? key,
  }) : super(key: key);

  @override
  State<DashbordSections> createState() => _DashbordSectionsState();
}

class _DashbordSectionsState extends State<DashbordSections> {
  AnalyticsService analytics = AnalyticsService();


  @override
  Widget build(BuildContext context) {
    var dashboardPageProvider = Provider.of<DashboardPageProvider>(context);
    return   Column(
      children: [
        InkWell(
          onTap: () {

            Shared.stock_type = "purchases";
            analytics.setUserProperties(userRole: "StoreStockInSupplierScreen");
            CustomViews.navigateTo(
                context,
                StoreStockInSupplierScreen(

                ),
                "StoreStockInSupplierScreen");
          },
          child: Container(
            padding: EdgeInsets.all(10),
           alignment: Alignment.center,
           width: MediaQuery.of(context).size.width ,
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
                border: Border.all(color: CustomColors.GREY_LIGHT_B_COLOR),
                borderRadius: BorderRadius.circular(5),
                color: CustomColors.WHITE_COLOR),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Image.asset(
                ImageAssets.purchase,
                width: MediaQuery.of(context).size.width * 0.08,
                height: MediaQuery.of(context).size.width * 0.08,

              ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                    "${'purchase'.tr()}",
                    style: TextStyle(
                        color: CustomColors.PRIMARY_GREEN,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )
                  )
            ]),
          ),
        ),

        Padding(padding: EdgeInsets.symmetric(vertical: ScreenUtil.defaultSize.width * 0.03,),
    child:   Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                analytics.setUserProperties(userRole: "StockOnScreen");
                CustomViews.navigateTo(
                    context, StockOnScreen(), "StockOnScreen");
              },
              child:  Container(
                width: MediaQuery.of(context).size.width * 0.44,
                height: MediaQuery.of(context).size.height * 0.11,
                decoration: BoxDecoration(
                    border: Border.all(color: CustomColors.GREY_LIGHT_B_COLOR),
                    borderRadius: BorderRadius.circular(10),
                    color: CustomColors.WHITE_COLOR),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageAssets.stock_on,
                        width: MediaQuery.of(context).size.width * 0.08,
                        height: MediaQuery.of(context).size.width * 0.08,
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                          child:      Text(
                        "${'stock_on'.tr()}",
                        style: TextStyle(
                            color: CustomColors.PRIMARY_GREEN,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),)
                      ),

                    ]),
              ),

            ),
            InkWell(
              onTap: () {
                Shared.stock_type = "stock_out";
                analytics.setUserProperties(userRole: "StoreStockInSupplierScreen");
                CustomViews.navigateTo(
                    context,
                    StoreStockInSupplierScreen(

                    ),
                    "StoreStockInSupplierScreen");

              },
              child: Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.44,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                    border: Border.all(color: CustomColors.GREY_LIGHT_B_COLOR),
                    borderRadius: BorderRadius.circular(5),
                    color: CustomColors.WHITE_COLOR),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageAssets.stock_out,
                        width: MediaQuery.of(context).size.width * 0.08,
                        height: MediaQuery.of(context).size.width * 0.08,

                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "${'stock_out'.tr()}",
                            style: TextStyle(
                                color: CustomColors.PRIMARY_GREEN,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )
                      )
                    ]),
              ),
            ),

          ],
    )   ),


        InkWell(
          onTap: () {

          },
          child: Container(

            width: MediaQuery.of(context).size.width ,

            height: MediaQuery.of(context).size.height * 0.11,
            decoration: BoxDecoration(
                border: Border.all(color: CustomColors.GREY_LIGHT_B_COLOR),
                borderRadius: BorderRadius.circular(10),
                color: CustomColors.WHITE_COLOR),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ImageAssets.report,
                    width: MediaQuery.of(context).size.width * 0.08,
                    height: MediaQuery.of(context).size.width * 0.08,
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                      child:     Text(
                        "${kReports.tr()}",
                        style: TextStyle(
                            color: CustomColors.PRIMARY_GREEN,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )  ),

                ]),
          ),
        ),


 /*       Column(
          children: [
            InkWell(
              onTap: () {

              Shared.stock_type = "purchases";
                analytics.setUserProperties(userRole: "StoreStockInSupplierScreen");
                CustomViews.navigateTo(
                    context,
                    StoreStockInSupplierScreen(

                    ),
                    "StoreStockInSupplierScreen");
              },
              child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * 0.44,
                height: MediaQuery.of(context).size.height * 0.20,
                decoration: BoxDecoration(
                    border: Border.all(color: CustomColors.GREY_LIGHT_B_COLOR),
                    borderRadius: BorderRadius.circular(5),
                    color: CustomColors.WHITE_COLOR),
                child: Column(children: [
                  Expanded(
                    flex: 1,
                      child:  Text(
                    "${'purchase'.tr()}",
                    style: TextStyle(
                        color: CustomColors.PRIMARY_GREEN,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
    ) ),
                  Expanded(
                    flex: 2,
                    child: Image.asset(
                      ImageAssets.purchase,
                    ),
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () {
                analytics.setUserProperties(userRole: "StockOnScreen");
                CustomViews.navigateTo(
                    context, StockOnScreen(), "StockOnScreen");
              },
              child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.20,
                decoration: BoxDecoration(
                    border: Border.all(color: CustomColors.GREY_LIGHT_B_COLOR),
                    borderRadius: BorderRadius.circular(5),
                    color: CustomColors.YELLOW_LIGHT),
                child: Column(children: [
                    Expanded(
                    flex: 1,
                    child:  Text(
                    "${'stock_on'.tr()}",
                    style: TextStyle(
                        color: CustomColors.GREY_COLOR,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    ) ),
                  Expanded(
                    flex: 2,
                    child: Image.asset(
                      ImageAssets.stock_on,
                    ),
                  ),
                ]),
              ),
            ),
          ],
        )*/
      ],

    );
  }
}
