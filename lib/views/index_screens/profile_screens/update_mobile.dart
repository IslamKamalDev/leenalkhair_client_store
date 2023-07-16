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

class UpdateMobile extends StatefulWidget {
  @override
  _UpdateMobileState createState() => _UpdateMobileState();
}

class _UpdateMobileState extends State<UpdateMobile> {
  var phoneController = TextEditingController();
  var updateMobilFormKey = GlobalKey<FormState>();
  var updateMobileScaffoldKey = GlobalKey<ScaffoldState>();
  AnalyticsService analytics = AnalyticsService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var userInfoProvider = Provider.of<UserInfoProvider>(context, listen: false);

    phoneController.text = userInfoProvider.userInfoResponse!.data!.mobileNumber!;
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
              key: updateMobileScaffoldKey,
              appBar: CustomViews.appBarWidget(
                  context: context,
                  title: 'update_mobile'
              ) ,
              body: Directionality(
                  textDirection: MyMaterial.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                  child:SafeArea(
                child: SingleChildScrollView(
                  child: Form(
                    key: updateMobilFormKey,
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
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Container(
                                  child: CustomTextField(
                                    controller: phoneController,
                                  lablel: "Enter_phone",
                                    isEditable: true,
                                    errorMessage: kEnter_phone,
                                    isMobile: true,
                                    icon: Icon(Icons.phone_android),
                                    isPhoneCode: true,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: CustomRoundedButton(
                                  fontSize: 15,
                                  text: kupdate,
                                  textColor: Colors.white,
                                  backgroundColor: CustomColors.PRIMARY_GREEN,
                                  borderColor: CustomColors.PRIMARY_GREEN,
                                  pressed: () {
                                    if (updateMobilFormKey.currentState!
                                        .validate()) {
                                      CustomViews.showLoadingDialog(
                                          context: context);
                                      userProvider
                                          .updateEmailOrMobile(
                                          email: phoneController.text)
                                          .whenComplete(() async {
                                        CustomViews.dismissDialog(context: context);

                                        if (userProvider.responseEmailOrMobile.status == true) {

                                          print("phoneController.text : ${phoneController.text}");
                                          analytics.setUserProperties(
                                              userRole: "Verfiy New Email or Mobile Screen");
                                          CustomViews.navigateTo(
                                              context,
                                              VerfiyNewEmailOrMobile(email: phoneController.text,
                                              ), "Verfiy New Email or Mobile Screen");
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
              )))),
    );
  }
}
