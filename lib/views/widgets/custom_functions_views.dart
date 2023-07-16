import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart' hide Trans;
import 'package:intl/intl.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/utils/analytics_service.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/dashboard/dashboard_screen.dart';
import 'package:leen_alkhier_store/views/index.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class CustomViews {
  static showLoadingDialog({required BuildContext context}) {
    showDialog(
        context: context,
        useSafeArea: true,
        barrierDismissible: false,
        builder: (ctx) => SpinKitWave(
              color: Colors.white,
              size: 38.0,
            ));
  }

  static dismissDialog({required BuildContext context}) {
    Navigator.of(context, rootNavigator: true).pop('dialog');
  }


  static void navigateTo(
      BuildContext? context, Widget widget, String routeName) {
    Navigator.push(
        context!,
        MaterialPageRoute(
          builder: (ctx) => widget,
          settings: RouteSettings(name: routeName),
        ));
  }

  static void navigateToRepalcement(
      BuildContext? context, Widget widget, String routeName) {
    Navigator.pushReplacement(
        context!,
        MaterialPageRoute(
          builder: (ctx) => widget,
          settings: RouteSettings(name: routeName),
        ));
  }

  static void showSnackBarView({bool? title_status, String? message, String? backend_message,
     Color? backgroundColor, bool? success_icon }) {
    Get.snackbar(
     title_status! ? kcongratulations.tr(): kfault.tr() ,
      backend_message?? message!.tr(),
      colorText: Colors.white,
      backgroundColor: backgroundColor ?? CustomColors.RED_COLOR,
      icon: success_icon! ? Image.asset(
        ImageAssets.congratulations,
        width: 30,
        height: 30,
        color: CustomColors.WHITE_COLOR,
      )
          : Image.asset(
        ImageAssets.error,
        width: 30,
        height: 30,
        color: CustomColors.WHITE_COLOR,
      )
    );
  }

  static PreferredSizeWidget appBarWidget(
      {BuildContext? context, String? title, Widget? route, bool? draft_icon = false}) {
    AnalyticsService analytics = AnalyticsService();

    return AppBar(
      backgroundColor: CustomColors.WHITE_COLOR,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        systemNavigationBarColor: CustomColors.GREY_COLOR_A,
        systemNavigationBarDividerColor: CustomColors.GREY_COLOR_A,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      centerTitle: true,
      title: Text(
        title!.tr(),
        style: TextStyle(color: CustomColors.BLACK_COLOR, fontSize: 18),
      ),
      leading: MyMaterial.app_langauge == 'ar' ?  IconButton(
        onPressed: () {
          if(route == null){
            Navigator.of(context!).pop();
          }else{
            analytics.setUserProperties(userRole: "${route} Screen");
            CustomViews.navigateTo(context, route, "${route} Screen");
          }

        },
        icon: translator.activeLanguageCode == "en"
            ? Image.asset(ImageAssets.leftback)
            : Image.asset(ImageAssets.rightBack),
      )
          : IconButton(
        onPressed: () {
          if(route == null){
            Navigator.of(context!).pop();
          }else{
            analytics.setUserProperties(userRole: "${route} Screen");
            CustomViews.navigateTo(context, route, "${route} Screen");
          }

        },
        icon: translator.activeLanguageCode == "ar"
            ? Image.asset(ImageAssets.rightBack)
            : Image.asset(ImageAssets.leftback),
      ) ,
      actions: [
        draft_icon! ? IconButton(
          onPressed: () {

            analytics.setUserProperties(userRole: "Signup Contract Screen");
            Navigator.push(
                navigatorKey.currentContext!,
                MaterialPageRoute(
                    builder: (ctx) =>
                        Index()));

            CustomViews.showSnackBarView(
                title_status: true,
                message: ksave_draft.tr(),
                backgroundColor: CustomColors.PRIMARY_GREEN,
                success_icon: true);
          },
          icon: Image.asset(ImageAssets.save_draft)
             ,
        ) : Container()
      ],

    );
  }

  static final spinkit = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.red : Colors.green,
        ),
      );
    },
  );
}
