import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/utils/colors.dart';

class TitleWithImage extends StatelessWidget {
  String text;
  String icon;
  Color iconcolor;
  Color backgroundcolor2;

  TitleWithImage({
    required this.text,
    required this.icon,
    required this.iconcolor,
    required this.backgroundcolor2,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
              border: Border.all(color: CustomColors.GREY_LIGHT_B_COLOR),
              borderRadius: BorderRadius.circular(30),
              color: backgroundcolor2),
          padding: EdgeInsets.all(5),
          child: ClipOval(
            child: Image.asset(
              icon,
              color: iconcolor,
            ),
          ),
        ),
        Text(text)
      ],
    );
  }
}
