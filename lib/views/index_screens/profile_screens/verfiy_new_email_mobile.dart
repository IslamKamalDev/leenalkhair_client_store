import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leen_alkhier_store/providers/user_info_provider.dart';
import 'package:leen_alkhier_store/providers/user_provider.dart';
import 'package:leen_alkhier_store/utils/analytics_service.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/index_screens/more.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:leen_alkhier_store/views/widgets/custom_textfield.dart';
import 'package:leen_alkhier_store/views/widgets/signup_header.dart';
import 'package:provider/provider.dart';

class VerfiyNewEmailOrMobile extends StatefulWidget {
  String? email;
  VerfiyNewEmailOrMobile({this.email});
  @override
  _VerfiyNewEmailOrMobileState createState() => _VerfiyNewEmailOrMobileState();
}

class _VerfiyNewEmailOrMobileState extends State<VerfiyNewEmailOrMobile> {
  var otpController = TextEditingController();
  var otpFormKey = GlobalKey<FormState>();
  var VerfiyNewEmailOrMobile = GlobalKey<ScaffoldState>();
  AnalyticsService analytics = AnalyticsService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var userInfoProvider =
        Provider.of<UserInfoProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      key: VerfiyNewEmailOrMobile,
        appBar : CustomViews.appBarWidget(
          context: context,
          title: 'verfiy_otp',
        ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: otpFormKey,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(14)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: CustomTextField(
                          controller: otpController,
                          lablel: kverfiyOtp,
                          //formKey: updateFormKey,
                          isEditable: true,
                          //icon: Icon(Icons.email),
                          errorMessage: kEnter_verfiyOtp,
                          isMobile: true,
                          isValidator: false,

                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: CustomRoundedButton(
                          fontSize: 15,
                          text: ksend,
                          textColor: Colors.white,
                          backgroundColor: CustomColors.PRIMARY_GREEN,
                          borderColor: CustomColors.PRIMARY_GREEN,
                          pressed: () {
                            if (otpFormKey.currentState!.validate()) {
                              CustomViews.showLoadingDialog(context: context);
                              userProvider
                                  .verfiyNewEmailOrMobile(
                                  email: widget.email,
                                  otp: otpController.text)
                                  .whenComplete(() async {
                                CustomViews.dismissDialog(context: context);

                                if (userProvider.responseVerfiyNewEmailOrMobile.status == true) {
                                  var userInfoProvider = Provider.of<UserInfoProvider>(context, listen: false);

                                  CustomViews.showSnackBarView(
                                      title_status: true,
                                      message: "update_success",
                                      backgroundColor: CustomColors.PRIMARY_GREEN,
                                      success_icon: true
                                  );

                                  await userInfoProvider.getUserInfo();

                                  Future.delayed(Duration(seconds: 2), () {
                                    analytics.setUserProperties(
                                        userRole: "Profile Screen");
                                    CustomViews.navigateTo(
                                        context, More(), "Profile Screen");

                                  });
                                } else {
                                  CustomViews.showSnackBarView(
                                      title_status: false,
                                      backend_message: userProvider.responseVerfiyNewEmailOrMobile.message!,
                                      backgroundColor: CustomColors.RED_COLOR,
                                      success_icon: false
                                  );

                                }
                              });
                            }
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
