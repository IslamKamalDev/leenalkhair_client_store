// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class WelcomeDialog extends StatefulWidget {
  BuildContext context;
  WelcomeDialog({
    required this.context,
    Key? key,
  }) : super(key: key);

  @override
  State<WelcomeDialog> createState() => _WelcomeDialogState();
}

class _WelcomeDialogState extends State<WelcomeDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(15),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      backgroundColor: CustomColors.WHITE_COLOR,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Builder(builder: (context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 0.7,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        ImageAssets.info,
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        // height: ,
                        child: Text(
                            "${"welcome_message".tr()}",
                            style: TextStyle(
                                color: CustomColors.GREY_LIGHT_A_COLOR,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                            // ),
                            textAlign: TextAlign.center),
                      ),

                      // // Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        // CustomViews.navigateToRepalcement(context,
                        //     LoginOnBoarding(), "Login OnBoarding Screen");
                      },
                      child: Icon(
                        Icons.close,
                      )),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
