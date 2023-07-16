import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/providers/user_provider.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/index_screens/profile_screens/delete_account/delete_reason.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:leen_alkhier_store/views/widgets/custom_textfield.dart';
import 'package:leen_alkhier_store/views/widgets/signup_header.dart';
import 'package:provider/provider.dart';

class EnterPass extends StatefulWidget {
  @override
  _EnterPassState createState() => _EnterPassState();
}

class _EnterPassState extends State<EnterPass> {
  var passFormKey = GlobalKey<FormState>();

  var updateScaffoldKey = GlobalKey<ScaffoldState>();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        key: updateScaffoldKey,
        backgroundColor: CustomColors.GREY_COLOR_A,
        appBar : CustomViews.appBarWidget(
          context: context,
          title:"delete_account",
        ),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Form(
                key: passFormKey,
                child: Column(
                  children: [

                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(14)),
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: CustomTextField(
                                controller: passwordController,
                                hasPassword: true,
                                // formKey: updateFormKey,
                                lablel: kPassword,
                                isValidator: true,
                                errorMessage: 'Enter_password',
                                // icon: Icon(
                                //   Icons.lock,
                                // )
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              height: ScreenUtil().setHeight(45),
                              child: CustomRoundedButton(
                                fontSize: 15,
                                text: kaccept,
                                textColor: Colors.white,
                                backgroundColor: CustomColors.PRIMARY_GREEN,
                                borderColor: CustomColors.PRIMARY_GREEN,
                                pressed: () {
                                  // CustomViews.navigateTo(context,
                                  //     DeleteReason(), "Delete Password Reason");
                                  if (passFormKey.currentState!.validate() &&
                                      passwordController.text.length != 0) {
                                    var userProvider =
                                        Provider.of<UserProvider>(context,
                                            listen: false);
                                    userProvider
                                        .checkPass(passwordController.text)
                                        .whenComplete(() {
                                      if (userProvider.correctPassResponse ==
                                          true) {
                                        // Navigator.pop(context);
                                        CustomViews.navigateTo(
                                            context,
                                            DeleteReason(),
                                            "Delete Password Reason");
                                      } else {
                                        FocusScope.of(context).unfocus();
                                        CustomViews.showSnackBarView(
                                            title_status: false,
                                            message: 'wrong_pass',
                                            backgroundColor: CustomColors.RED_COLOR,
                                            success_icon: false
                                        );

                                      }
                                    });
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
