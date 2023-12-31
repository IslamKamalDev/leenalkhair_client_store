import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../utils/local_const.dart';

class NetworkIndicator extends StatefulWidget {
  final Widget? child;
  const NetworkIndicator({this.child});
  @override
  _NetworkIndicatorState createState() => _NetworkIndicatorState();
}

class _NetworkIndicatorState extends State<NetworkIndicator> {
  double _height = 0;

  Widget _buildBodyItem() {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: _height * 0.2,
            ),
            Icon(
              Icons.signal_wifi_off,
              size: _height * 0.25,
              color: Colors.grey[400],
            ),
            Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "عفواً ... لايوجد اتصال بالإنترنت",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.w400),
                )),
            Container(
                margin: EdgeInsets.only(top: _height * 0.025),
                child: Text(
                  "إفحص جهاز الراوتر الخاص بك",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[400],
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.w400),
                )),
            Container(
                margin: EdgeInsets.only(top: _height * 0.025),
                child: Text(
                  "أعد الاتصال بالشبكة",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[400],
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.w400),
                )),
            Container(
                height: _height * 0.09,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.25,
                    vertical: _height * 0.02),
                child: Builder(
                    builder: (context) => RaisedButton(
                          onPressed: () {},
                          elevation: 500,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(25.0)),
                          color: CustomColors.PRIMARY_GREEN,
                          child: Container(
                              alignment: Alignment.center,
                              child: new Text(
                                "تحديث الصفحة",
                                style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20.0),
                              )),
                        )))
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        if (connectivity == ConnectivityResult.none) {
          final appBar = AppBar(
              backgroundColor: CustomColors.PRIMARY_GREEN,
              automaticallyImplyLeading: true,
              title: Text(
                "${kapp_name.tr()}",
                style: TextStyle(
                    color: Color(0xffFFFFFF),
                    fontFamily: 'Cairo',
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
              centerTitle: true,
              actions: <Widget>[]);
          _height = MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top;
          return Scaffold(
            appBar: appBar,
            body: _buildBodyItem(),
          );
        } else {
          return child;
        }
      },
      builder: (BuildContext context) {
        return widget.child!;
      },
    );
  }
}
