import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/network/ServicesURLs.dart';
import 'package:leen_alkhier_store/utils/Constants.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';


class VersionDetails extends StatefulWidget {
  String? version;
  String? buildNumber;
  VersionDetails({this.version, this.buildNumber});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VersionDetailsSate();
  }
}

class VersionDetailsSate extends State<VersionDetails> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: CustomViews.appBarWidget(
            context: context,
            title: kversion_details
        ) ,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                  padding: EdgeInsets.all(20),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                            "${ServicesURLs.development_environment.toString().split('.')[0]}"),
                        Text("${widget.version}"),
                        Text("${widget.buildNumber}"),
                        SelectableText("$fbToken")
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
