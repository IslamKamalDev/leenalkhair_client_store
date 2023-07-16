
import 'package:flutter/material.dart';
class ButtonDialog extends StatelessWidget {

  final String? text1;
  final Function? ontap;
  final Color? color;
  ButtonDialog({this.text1, this.ontap,this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        primary: color,
        // minimumSize: Size(88, 36),
        padding: EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      child: Text(text1!),
      onPressed: ontap as void Function()?
    );
  }
}
