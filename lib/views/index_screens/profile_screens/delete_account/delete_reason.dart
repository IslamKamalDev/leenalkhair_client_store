import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/providers/user_provider.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/login_boarding.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:leen_alkhier_store/views/widgets/custom_textfield.dart';
import 'package:leen_alkhier_store/views/widgets/signup_header.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

class DeleteReason extends StatefulWidget {
  @override
  _DeleteReasonState createState() => _DeleteReasonState();
}

class _DeleteReasonState extends State<DeleteReason> {
  var reasonFormKey = GlobalKey<FormState>();

  var updateScaffoldKey = GlobalKey<ScaffoldState>();

  var reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        key: updateScaffoldKey,
        backgroundColor: CustomColors.GREY_COLOR_A,
        appBar : CustomViews.appBarWidget(
          context: context,
          title: "delete_account",
        ),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Form(
                key: reasonFormKey,
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
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${"delete_reason".tr()}',
                                  style:
                                      TextStyle(color: CustomColors.GREY_COLOR),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: CustomTextField(
                                controller: reasonController,
                                hasPassword: false,
                                // formKey: updateFormKey,
                                lablel: "reason",
                                isValidator: true,
                                errorMessage: 'enter_reason',
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
                                text: "sendd",
                                textColor: Colors.white,
                                backgroundColor: CustomColors.PRIMARY_GREEN,
                                borderColor: CustomColors.PRIMARY_GREEN,
                                pressed: () {
                                  if (reasonFormKey.currentState!.validate() &&
                                      reasonController.text.length != 0) {
                                    var userProvider =
                                        Provider.of<UserProvider>(context,
                                            listen: false);
                                    userProvider
                                        .remove_account()
                                        .whenComplete(() {
                                      if (userProvider.removeAccountResponse ==
                                          true) {
                                        Navigator.pushReplacement(
                                            navigatorKey.currentContext!,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginOnBoarding()));
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
