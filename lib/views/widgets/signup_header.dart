import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/utils/analytics_service.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:leen_alkhier_store/data/responses/user_orders.dart';

class SignupHeader extends StatelessWidget {
  String? headerTitle;
  Function()? backAction;
  String? employee_back;
  Widget? onbackscreen;
  OrderModel? orderModel;
  String? employee_id;
  Widget? aditional_data;
  SignupHeader(
      {this.headerTitle,
      this.backAction,
      this.employee_back,
      this.onbackscreen,
      this.orderModel,
      this.employee_id,
      this.aditional_data});

  var click_counter = 0;
  AnalyticsService analytics = AnalyticsService();

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Directionality(
        textDirection: MyMaterial.app_langauge == 'ar'
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Container(
          child: Column(
            children: [
              Container(
                height: ScreenUtil().setHeight(60),
                padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                decoration: BoxDecoration(
                  color: Colors.white,

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: backAction,
                      color: CustomColors.GREY_COLOR,
                      icon:translator.activeLanguageCode == "ar"
                          ? Image.asset(ImageAssets.rightBack)
                          : Image.asset(ImageAssets.leftback),
                    ),
                    Text(
                      headerTitle!.tr(),
                      style: TextStyle(
                          color: CustomColors.GREY_COLOR,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 30,
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
