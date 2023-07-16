import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leen_alkhier_store/main.dart';

import 'package:leen_alkhier_store/providers/reset_password_provider.dart';
import 'package:leen_alkhier_store/providers/user_info_provider.dart';
import 'package:leen_alkhier_store/providers/user_provider.dart';
import 'package:leen_alkhier_store/providers/user_register_provider.dart';
import 'package:leen_alkhier_store/providers/user_verfiy_otp_provider.dart';
import 'package:leen_alkhier_store/utils/analytics_service.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/views/auth/confirm_password.dart';
import 'package:leen_alkhier_store/views/auth/forget_password.dart';
import 'package:leen_alkhier_store/views/auth/signup/signup_company.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:leen_alkhier_store/views/widgets/custom_textfield.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../utils/local_const.dart';

class ConfirmCode extends StatefulWidget {
  bool isFromSignUp;
  bool? isToConfirmPass;
  bool fromCreatContract;
  String? email;
  String? phone;
  ConfirmCode({
    this.isFromSignUp = false,
    this.isToConfirmPass,
    this.email,
    this.fromCreatContract = false,
    this.phone,
  });

  @override
  State<ConfirmCode> createState() => _ConfirmCodeState();
}

class _ConfirmCodeState extends State<ConfirmCode> {
  var confCodeFormKey = GlobalKey<FormState>();
  var codeController = TextEditingController();
  var confCodeScaffoldKey = GlobalKey<ScaffoldState>();
  AnalyticsService analytics = AnalyticsService();
  int seconds = 0;

  @override
  Widget build(BuildContext context) {
    int seconds = 0;
    var resetPassProvider = Provider.of<ResetPasswordProvider>(context);
    var userRegisterationProvider = Provider.of<UserRegisterationProvider>(context);
    var verfiyOtpProvidervalue = Provider.of<verfiyOtpProvider>(context, listen: true);
    var userInfoProvider = Provider.of<UserInfoProvider>(context, listen: false);


    return Directionality(
        textDirection: MyMaterial.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child:Scaffold(
        appBar : CustomViews.appBarWidget(
          context: context,
          title:"Confirm_code",
          route: ForgetPassword()

        ),
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),

              child: Column(children: [

                Center(
                    child: SingleChildScrollView(
                  child: Form(
                    key: confCodeFormKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                         Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                         child:      Text(
                           KEnter_code.tr(),
                           style: TextStyle(
                               color: CustomColors.BLACK_COLOR),
                         ),),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  widget.phone != null
                                      ? Text(
                                    widget.phone!,
                                    // resetPassProvider.resetPasswordResponse.mobileNumber,
                                    style: TextStyle(
                                        color: CustomColors.GREY_COLOR,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  )
                                      : resetPassProvider.resetPasswordResponse ==
                                      null
                                      ? Text(
                                    userInfoProvider.userInfoResponse!
                                        .data!.mobileNumber!,
                                    // resetPassProvider.resetPasswordResponse.mobileNumber,
                                    style: TextStyle(
                                        color: CustomColors.GREY_COLOR,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  )
                                      : Text(
                                    // userInfoProvider.userInfoResponse.data.mobileNumber,
                                    resetPassProvider
                                        .resetPasswordResponse!
                                        .mobileNumber!,
                                    style: TextStyle(
                                        color: CustomColors.GREY_COLOR,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ],
                          ),


                          SizedBox(
                            height: 15,
                          ),

                          Container(
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: codeController,
                              autofocus: false,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.phone,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              maxLength: 4,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                          color: CustomColors.PRIMARY_GREEN)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                          color: CustomColors.PRIMARY_GREEN)),
                                  hintText: "- - - -",
                                  filled: true,
                                  fillColor: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Text(
                           Kresent_OTP.tr(),
                            style: TextStyle(
                                color: CustomColors.GREY_LIGHT_A_COLOR),
                          ),
                          verfiyOtpProvidervalue.resend_timer_status!
                              ? TweenAnimationBuilder<Duration>(
                                  duration: Duration(minutes: 2),
                                  tween: Tween(
                                      begin: Duration(minutes: 2),
                                      end: Duration.zero),
                                  onEnd: () {
                                    verfiyOtpProvidervalue.resend_timer_status =
                                        false;
                                    setState(() {});
                                  },
                                  builder: (BuildContext context,
                                      Duration value, Widget? child) {
                                    final minutes = value.inMinutes;
                                    seconds = value.inSeconds % 60;
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Text(
                                              '$minutes:$seconds',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: CustomColors
                                                      .PRIMARY_GREEN,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ],
                                    );
                                  })
                              : GestureDetector(
                                  onTap: () async {
                                    CustomViews.showLoadingDialog(
                                        context: context);
                                    // ignore: unnecessary_statements
                                    (userRegisterationProvider.userRegisterResponse == null);

                                    verfiyOtpProvidervalue
                                        .resendOtp()
                                        .then((value) {
                                      CustomViews.dismissDialog(
                                          context: context);
                                    });
                                  },
                                  child: Text(
                                  'resend'.tr(),
                                    style: TextStyle(
                                        color: CustomColors.PRIMARY_GREEN),
                                  )),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),

                          Container(
                            height: ScreenUtil().setHeight(45),
                            child: CustomRoundedButton(
                              fontSize: 15,
                              text: KConfirm,
                              textColor: Colors.white,
                              backgroundColor: CustomColors.ORANGE,
                              borderColor: CustomColors.ORANGE,
                              pressed: () async {
                                if (confCodeFormKey.currentState!.validate()) {
                                  FocusScope.of(context).unfocus();
                                  CustomViews.showLoadingDialog(context: context);
                                  await Future.delayed(Duration(seconds: 2),
                                      () async {
                                    (userRegisterationProvider.userRegisterResponse == null);
                                    await verfiyOtpProvidervalue
                                        .verfiyOtp(
                                            codeController.text, widget.email)
                                        .then((value) {
                                      CustomViews.dismissDialog(context: context);
                                      if (verfiyOtpProvidervalue.responseOtp.status == true) {
                                        if (widget.isFromSignUp) {
                                          Navigator.pop(context);
                                        } else {
                                          if (widget.isToConfirmPass == true) {
                                            analytics.setUserProperties(
                                                userRole: "Confirm Password Screen");
                                            CustomViews.navigateToRepalcement(
                                                context, ConfirmPassword(), "Confirm Password Screen");
                                          } else {
                                            if (widget.fromCreatContract) {
                                              analytics.setUserProperties(
                                                  userRole: "Signup Company Screen");
                                              CustomViews.navigateToRepalcement(
                                                      context,
                                                      SignupCompany(),
                                                      "Signup Company Screen");
                                            } else {
                                              analytics.setUserProperties(
                                                  userRole:
                                                      "Signup Company Screen");
                                              CustomViews
                                                  .navigateToRepalcement(
                                                      context,
                                                      SignupCompany(),
                                                      "Signup Company Screen");
                                            }
                                          }
                                        }
                                      } else {

                                        CustomViews.showSnackBarView(
                                            title_status: false,
                                            backend_message: verfiyOtpProvidervalue.responseOtp.message!,
                                            backgroundColor: CustomColors.RED_COLOR,
                                            success_icon: false
                                        );


                                      }
                                    });
                                  });
                                }
                              },
                            ),
                          ),

                          // dontHaveAnAccount()
                        ],
                      ),
                    ),
                  ),
                )),
              ]),
            ),
          )),)
    );
  }

  showSnackbar({var scaffoldKey, required var ctx}) {
    CustomViews.showSnackBarView(
        title_status: false,
        message: KInvalid_code,
        backgroundColor: CustomColors.RED_COLOR,
        success_icon: false
    );

  }
}
