import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/providers/user_info_provider.dart';
import 'package:leen_alkhier_store/providers/user_provider.dart';
import 'package:leen_alkhier_store/utils/analytics_service.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/index_screens/profile_screens/verfiy_new_email_mobile.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:leen_alkhier_store/views/widgets/custom_textfield.dart';
import 'package:leen_alkhier_store/views/widgets/signup_header.dart';
import 'package:provider/provider.dart';

class UpdateEmail extends StatefulWidget {
  @override
  _UpdateEmailState createState() => _UpdateEmailState();
}

class _UpdateEmailState extends State<UpdateEmail> {
  var emailController = TextEditingController();
  var updateEmailFormKey = GlobalKey<FormState>();
  var updateEmailScaffoldKey = GlobalKey<ScaffoldState>();
  AnalyticsService analytics = AnalyticsService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var userInfoProvider =
        Provider.of<UserInfoProvider>(context, listen: false);

    emailController.text = userInfoProvider.userInfoResponse!.data!.email!;
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      key: updateEmailScaffoldKey,
      appBar: CustomViews.appBarWidget(
          context: context,
          title: 'update_email'
      ) ,
      body: Directionality(
          textDirection: MyMaterial.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr,
          child:GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: updateEmailFormKey,
                child: Column(
                  children: [

                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(14)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: CustomTextField(
                              controller: emailController,
                              lablel: kEmail,
                              //formKey: updateFormKey,
                              isEditable: true,
                              icon: Icon(Icons.email),
                              errorMessage: kEnter_email,
                              isEmail: true,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            child: CustomRoundedButton(
                              fontSize: 15,
                              text: kupdate,
                              textColor: Colors.white,
                              backgroundColor: CustomColors.PRIMARY_GREEN,
                              borderColor: CustomColors.PRIMARY_GREEN,
                              pressed: () {
                                if (updateEmailFormKey.currentState!.validate() &&
                                    validateInputs(context,
                                        scaffoldKey: updateEmailScaffoldKey,
                                        ctx: context)) {
                                  CustomViews.showLoadingDialog(context: context);
                                  userProvider
                                      .updateEmailOrMobile(
                                      email: emailController.text)
                                      .whenComplete(() async {
                                    CustomViews.dismissDialog(context: context);

                                    if (userProvider
                                        .responseEmailOrMobile.status ==
                                        true) {
                                      analytics.setUserProperties(
                                          userRole:
                                          "Verfiy New Email or Mobile Screen");
                                      CustomViews.navigateTo(
                                          context,
                                          VerfiyNewEmailOrMobile(
                                            email: emailController.text,
                                          ),
                                          "Verfiy New Email or Mobile Screen");
                                    } else {

                                      CustomViews.showSnackBarView(
                                          title_status: false,
                                          backend_message: userProvider.responseEmailOrMobile.message!,
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
          ))),
    );
  }

  bool validateInputs(BuildContext context, {var scaffoldKey, var ctx}) {
    if (!EmailValidator.validate(emailController.text)) {
      CustomViews.showSnackBarView(
          title_status: false,
          message: KEnter_the_email_correctly,
          backgroundColor: CustomColors.RED_COLOR,
          success_icon: false
      );

      return false;
    }

    return true;
  }
}
