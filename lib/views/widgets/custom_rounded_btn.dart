import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:localize_and_translate/localize_and_translate.dart';

class CustomRoundedButton extends StatelessWidget {
  String? text;
  Function? pressed;
  Color? backgroundColor;
  Color? textColor;
  Color? borderColor;
  Icon? icon;
  double? fontSize;
  double? border;
  double? width;
  double? height;
  bool? isKey;
  CustomRoundedButton(
      {this.pressed,
      this.text,
      this.backgroundColor,
      this.borderColor,
      this.icon,
      this.textColor,
      this.fontSize,
      this.border,
      this.width,
      this.height,
      this.isKey});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 40,
      width: width ?? ScreenUtil().screenWidth,
      child: RaisedButton(
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 0),
        shape: RoundedRectangleBorder(
            // borderRadius:border==null? BorderRadius.circular(20):BorderRadius.circular(border),
            borderRadius: BorderRadius.circular(border ?? 5),
            side: BorderSide(color: borderColor!)),
        color: backgroundColor,
        onPressed: pressed as void Function()?,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: OrientationBuilder(builder: (context, orientation) {
                return Text(
                  isKey == true
                      ? text!
                      : text!.tr(),

                  // translator.translate(text)!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: textColor,
                      fontSize: fontSize == null
                          ? (orientation == Orientation.portrait)
                              ? 10
                              : 10
                          : fontSize),
                );
              }),
              fit: FlexFit.loose,
            ),
            (icon == null) ? Container() : icon!
          ],
        ),
      ),
    );
  }
}
