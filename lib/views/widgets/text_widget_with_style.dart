import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/utils/colors.dart';

class TextWidgetwithStyle extends StatelessWidget {
  const TextWidgetwithStyle({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            color: CustomColors.GREY_LIGHT_A_COLOR,
            fontSize: 14,
            fontWeight: FontWeight.normal));
  }
}
