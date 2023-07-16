import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../index_screens/order_screens/all_orders.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  Widget? title;
  Widget? onbackscreen;
  CustomAppBar({
    Key? key,
    this.onbackscreen,
    this.title,
  })  : preferredSize = Size.fromHeight(60),
        super(key: key);
  @override
  final Size preferredSize;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColors.WHITE_COLOR,
      toolbarHeight: 60,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      centerTitle: true,
      title: title,
      leading: IconButton(
        onPressed: () {
        onbackscreen ==null ?  Navigator.of(context).pop() :
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AllOrders()));
        },
        icon: translator.activeLanguageCode == "ar"
            ? Image.asset(ImageAssets.rightBack)
            : Image.asset(ImageAssets.leftback),
      ),
    );
  }
}
