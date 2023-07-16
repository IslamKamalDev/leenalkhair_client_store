import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:leen_alkhier_store/utils/Shared.dart';

import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/index_screens/more.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/signup_header.dart';

class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String? str = "";

    if (Shared.pages != null && Shared.pages!.length > 0) {
      if (Shared.pages![0].slug == "about") {
        str = Shared.pages![0].content;
      } else
        str = "";
    }

    return Scaffold(
        appBar: CustomViews.appBarWidget(
            context: context,
            title: kabout_app,
          route: More(),
        ) ,
        body: Column(
          children: [

        Flexible(
              child: Container(
                child: Scrollbar(
                  child:  Html(
                      data: str,
                    ),
                  ),
                ),
              ),

          ],
        ),

    );
  }
}
