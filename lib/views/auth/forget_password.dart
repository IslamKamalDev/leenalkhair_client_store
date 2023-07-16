import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/utils/analytics_service.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';

import 'package:leen_alkhier_store/providers/reset_password_provider.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/views/auth/confirm_password.dart';
import 'package:leen_alkhier_store/views/auth/login.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:leen_alkhier_store/views/widgets/custom_textfield.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

import 'confirm_code.dart';

class ForgetPassword extends StatelessWidget {
  var forgetPasswordFormKey = GlobalKey<FormState>();

  var forgetPasswordScaffoldKey = GlobalKey<ScaffoldState>();
  var emailController = TextEditingController();
  AnalyticsService analytics = AnalyticsService();

  @override
  Widget build(BuildContext context) {

    var resetPasswordProvider = Provider.of<ResetPasswordProvider>(context);
    return Directionality(
        textDirection: MyMaterial.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child:GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          key: forgetPasswordScaffoldKey,
       //   backgroundColor: Colors.white,
            appBar : CustomViews.appBarWidget(
              context: context,
              title:kforget_password,
              route: Login()
            ),

            body:  Container(
              margin:
              EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(35)),
              child: Center(
                child: Form(
                  key: forgetPasswordFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(padding: EdgeInsets.symmetric(vertical: ScreenUtil.defaultSize.width * 0.1),
                      child: Text(kforget_password_message.tr())/*Image.asset(
                        'assets/logo.png',
                        scale: 2,
                      ),*/

                      ),

                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          child: CustomTextField(
                            controller: emailController,
                            // icon: Icon(Icons.email),
                            formKey: forgetPasswordFormKey,
                            // direction: TextDirection.ltr,
                            alignment: TextAlign.left,
                            lablel: kphone,
                            //  lablel: kPassword,
                            isMobile: true,
                            isPhoneCode: true,
                            // isEmail: true,
                            // alignment: TextAlign.left,
                            // direction: TextDirection.ltr,
                            errorMessage: kEnter_the_phone_correctly,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: ScreenUtil().setHeight(45),
                        child: CustomRoundedButton(
                          fontSize: 15,
                          text: ksend,
                          textColor: Colors.white,
                          backgroundColor: CustomColors.PRIMARY_GREEN,
                          borderColor: CustomColors.PRIMARY_GREEN,
                          pressed: () {
                            if (forgetPasswordFormKey.currentState!
                                .validate() &&
                                validateInputs(context,
                                    ctx: context,
                                    scaffoldKey: forgetPasswordScaffoldKey)) {
                              resetPasswordProvider.setEmail(
                                  m: emailController.text);
                              CustomViews.showLoadingDialog(context: context);
                              resetPasswordProvider
                                  .resetPasswordKInForget()
                                  .whenComplete(() =>
                                  CustomViews.dismissDialog(
                                      context: context))
                                  .then((value) {

                                analytics.setUserProperties(
                                    userRole: "Confirm Password Screen");
                                CustomViews.navigateToRepalcement(
                                    context, ConfirmPassword(), "Confirm Password Screen");

                        /*        analytics.setUserProperties(
                                    userRole: "Confirm Code Screen");
                                CustomViews
                                    .navigateToRepalcement(
                                    context,
                                    ConfirmCode(
                                      isToConfirmPass: true,
                                      email: emailController.text,
                                      phone: emailController.text,
                                    ),
                                    "Signup Company Screen");
*/

                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
    )
        ));
  }

  bool validateInputs(BuildContext context, {var scaffoldKey, var ctx}) {
    return true;
  }
}
