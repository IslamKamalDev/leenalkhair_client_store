import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  String? text;
  EmptyWidget({this.text});
  @override
  Widget build(BuildContext context) {


    return       Container(
      height:MediaQuery.of(context).size.height-230,
      color: Colors.white12,
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(child:Center(
            child: Text(text!)
          )),
        ],
      ),
    );
  }
}
