import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:leen_alkhier_store/utils/Shared.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';

import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/index_screens/more.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/signup_header.dart';

class Privacy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String? str = "";

    if (Shared.pages != null && Shared.pages!.length > 0) {
      for (int i = 0; i < Shared.pages!.length; i++) {
        if (Shared.pages![i].slug == "privacy") {
          str = Shared.pages![i].content;
        }
      }
    }

    return Scaffold(
      backgroundColor: CustomColors.GREY_COLOR_A,
      appBar: CustomViews.appBarWidget(
        context: context,
          title: kprivacy
      ) ,
      body: SafeArea(
        bottom: false,
        child:  Column(
          children: [

            Flexible(
              child: Container(
                child: Scrollbar(
                  child: Html(
                    data: str,
                    style: {
                      "body": Style(
                          fontSize: FontSize(18.0),
                          fontWeight: FontWeight.bold,
                          color: CustomColors.GREY_COLOR),
                    },
                  ),
                ),
              ),
            ),

          ],
        ),
  /*      Expanded(
          child: Container(
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Html(
                  data: str,
                  style: {
                    "body": Style(
                        fontSize: FontSize(18.0),
                        fontWeight: FontWeight.bold,
                        color: CustomColors.GREY_COLOR),
                  },
                ),
              ),
            ),
          ),
        ),*/
      ),
    );
  }
}
