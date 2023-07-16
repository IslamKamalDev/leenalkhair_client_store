import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leen_alkhier_store/data/responses/order_details.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/utils/Shared.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/Store/stock_in_register_products_summery_screen.dart';
import 'package:leen_alkhier_store/views/index_screens/order_screens/photo_gallery.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../utils/colors.dart';

class PackageRecieveConfirmation extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PackageRecieveConfirmationState();
  }

}
class PackageRecieveConfirmationState extends State<PackageRecieveConfirmation>{
  List<Images>? media;
  bool upload_image_status = false;
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: MyMaterial.app_langauge == 'ar'
        ? TextDirection.rtl
            : TextDirection.ltr,
        child: Scaffold(
        backgroundColor: CustomColors.GREY_COLOR_A,
        appBar: CustomViews.appBarWidget(
        context: context,
        title:kpackage_recieve_confirmation.tr()
    ),
    body:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Attach_video_images(context),
        SizedBox(height: ScreenUtil.defaultSize.width * 0.1,),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Container(
                alignment: Alignment.center,
                height: ScreenUtil().setHeight(40),
                child: CustomRoundedButton(
                  fontSize: 15,
                  text: kSave,
                  width: ScreenUtil().screenWidth * 0.90,
                  textColor: Colors.white,
                  backgroundColor: CustomColors.PRIMARY_GREEN,
                  borderColor: CustomColors.PRIMARY_GREEN,
                  pressed: () async {

                      CustomViews.navigateTo(
                          context,
                          StockInProductRegisterSummeryScreen(

                          ),
                          "StockInProductRegisterSummeryScreen");


                  },
                ),),
            ))
      ],
    )
    ));
  }
  Widget Attach_video_images(BuildContext context) {

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: InkWell(
          onTap: () {
            setState(() {
              upload_image_status = !upload_image_status;
            });
          },
          child: DottedBorder(
            color: CustomColors.GREY_LIGHT_A_COLOR,
            strokeWidth: 1,
            radius: Radius.circular(12),
            dashPattern: [8],
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "${"upload_photo_file".tr()}"),
                    Image.asset(
                      ImageAssets.uploadFile,
                      width: 30,
                      height: 30,
                    ),
                  ],
                )),
          ),
        ),

      ),
      SizedBox(
        height: 15,
      ),
      upload_image_status
          ? PhotoGallery(
        label: kupload_documents.tr(),
        //sales_returns_images: images,
      )
          : Container(),

    ]);
  }
}