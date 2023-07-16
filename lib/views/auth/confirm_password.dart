import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/utils/analytics_service.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';

import 'package:leen_alkhier_store/providers/reset_password_provider.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/views/auth/login.dart';
import 'package:leen_alkhier_store/views/login_boarding.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:leen_alkhier_store/views/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class ConfirmPassword extends StatelessWidget {
  var passController = TextEditingController();
  var confPassController = TextEditingController();

  var confPassFormKey = GlobalKey<FormState>();

  var confPassScaffoldKey = GlobalKey<ScaffoldState>();
  AnalyticsService analytics = AnalyticsService();

  @override
  Widget build(BuildContext context) {
    var resetPasswordProvider = Provider.of<ResetPasswordProvider>(context);
    return  Directionality(
        textDirection: MyMaterial.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child:Scaffold(
      key: confPassScaffoldKey,
    //  backgroundColor: Colors.white,
        appBar : CustomViews.appBarWidget(
        context: context,
        title:kupdate_password,

    ),
      body:GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(35)),
            child:  Form(
                key: confPassFormKey,
                child: SingleChildScrollView(
                  child: Column(
                   // mainAxisSize: MainAxisSize.min,
                    children: [
                   /*  Image.asset(
                        'assets/logo.png',
                        scale: 1.5,
                      ),*/
                      SizedBox(
                        height: ScreenUtil().setWidth(65),
                      ),
                      Container(
                        child: CustomTextField(
                          controller: passController,
                          errorMessage: kEnter_password,
                          icon: Icon(Icons.lock),
                          formKey: confPassFormKey,
                          hasPassword: true,
                          lablel: kPassword,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: CustomTextField(
                          controller: confPassController,
                          hasPassword: true,
                          formKey: confPassFormKey,
                          errorMessage: kEnter_password,
                          icon: Icon(Icons.lock),
                          lablel: kConfirmPassword,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: ScreenUtil().setHeight(45),
                        child: CustomRoundedButton(
                          text: KConfirm,
                          textColor: Colors.white,
                          fontSize: 17,
                          backgroundColor: CustomColors.PRIMARY_GREEN,
                          borderColor: CustomColors.PRIMARY_GREEN,
                          pressed: () async {
                            if (confPassFormKey.currentState!.validate() &&
                                validateInputs(ctx: context, scaffoldKey: confPassScaffoldKey)) {
                              CustomViews.showLoadingDialog(context: context);
                              await resetPasswordProvider
                                  .confirmPassword(passController.text)
                                  .whenComplete(() => CustomViews.dismissDialog(
                                      context: context))
                                  .then((value) {
                                if (resetPasswordProvider.confirmPasswordResponse.status ?? false) {
                                  CustomViews.showSnackBarView(
                                      title_status: true,
                                      message: passwordSuccessChanged,
                                      backgroundColor: CustomColors.PRIMARY_GREEN,
                                      success_icon: true
                                  );
                                  Future.delayed(Duration(seconds: 2), () {
                                    Navigator.of(context)
                                        .popUntil((route) => route.isFirst);

                                    analytics.setUserProperties(
                                        userRole: "Login Screen");
                                    Get.offAll(LoginOnBoarding());

                                  });
                                } else {
                                  CustomViews.showSnackBarView(
                                      title_status: false,
                                      backend_message:  resetPasswordProvider.confirmPasswordResponse.message!,
                                      backgroundColor: CustomColors.RED_COLOR,
                                      success_icon: false
                                  );

                                }
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  bool validateInputs({var scaffoldKey, var ctx}) {
    if (passController.text.length < 6) {
      CustomViews.showSnackBarView(
          title_status: false,
          message: KPassword_Limit,
          backgroundColor: CustomColors.RED_COLOR,
          success_icon: false
      );

      return false;
    }
    if (passController.text != confPassController.text) {
      CustomViews.showSnackBarView(
          title_status: false,
          message: KPassword_not_match,
          backgroundColor: CustomColors.RED_COLOR,
          success_icon: false
      );

      return false;
    }
    return true;
  }

}
