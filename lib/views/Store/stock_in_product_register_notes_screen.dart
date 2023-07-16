import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:leen_alkhier_store/data/responses/order_details.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/utils/Shared.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/views/auth/signup/Create_products.dart';
import 'package:leen_alkhier_store/views/index_screens/order_screens/photo_gallery.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../utils/local_const.dart';

class StockInProductRegisterNotesScreen extends StatefulWidget{
final String? product_name;


StockInProductRegisterNotesScreen({this.product_name});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StockInProductRegisterNotesScreenState();
  }

}

class StockInProductRegisterNotesScreenState extends State<StockInProductRegisterNotesScreen>{

  var stockInProductRegisterNotesScaffoldKey = GlobalKey<ScaffoldState>();
  var po_numberFormKey = GlobalKey<FormState>();

  var noteController = TextEditingController();
  FocusNode fieldFocus = FocusNode();
  List<Images>? media;
  bool upload_image_status = false;
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: MyMaterial.app_langauge == 'ar'
        ? TextDirection.rtl
            : TextDirection.ltr,
        child: Scaffold(
        key: stockInProductRegisterNotesScaffoldKey,
        backgroundColor: CustomColors.GREY_COLOR_A,
        appBar: CustomViews.appBarWidget(
        context: context,
        title: kwrite_a_note.tr()
    ),
    body: SingleChildScrollView(
      child: Column(
        children: [
         Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
         child:  Container(

           height: ScreenUtil.defaultSize.width * 0.2,
           decoration: BoxDecoration(
               color: CustomColors.WHITE_COLOR,
             borderRadius: BorderRadius.circular(10)
           ),
           padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
           child: Row(
             children: [
               Expanded(
                   flex: 1,
                   child: Text(kproduct.tr())),
               Expanded(
                   flex: 3,
                   child: Text(widget.product_name!,
                   textAlign: TextAlign.center,
                   maxLines: 3,)),
               Expanded(
                   flex: 3,
                   child: OutlinedButton(
                     onPressed: () {  },
                     style: OutlinedButton.styleFrom(
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10.0),
                       ),
                       backgroundColor: Shared.stock_type == "stock_in" ? CustomColors.GREEN_LIGHT_A : CustomColors.RED_COLOR,
                       side: BorderSide(width: 2,color:Shared.stock_type == "stock_in" ? CustomColors.GREEN_LIGHT_A : CustomColors.RED_COLOR,),
                     ),
                     child: Text(Shared.stock_type == "purchases" ? kstock_out.tr() : kpurchase.tr(),
                       maxLines: 3,
                       style: TextStyle(color: CustomColors.WHITE_COLOR),),
                   ))
             ],
           ),
         ),),
          Form(
            key: po_numberFormKey,
            child: Padding(padding: EdgeInsets.symmetric(vertical:10,horizontal: 10),
            child:    Container(
              color: CustomColors.WHITE_COLOR,
              child:  TextFormField(
                controller: noteController,
                onTap: (){
                  if(noteController.selection == TextSelection.fromPosition(TextPosition(offset: noteController.text.length -1))){
                    setState(() {
                      noteController.selection = TextSelection.fromPosition(TextPosition(offset: noteController.text.length));
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Plz_enter_the_note";
                  }
                  return null;
                },
                minLines: 8,
                maxLines: 10,

                keyboardType: TextInputType.multiline,
                focusNode: fieldFocus,
                decoration: InputDecoration(
                  hintText:"Plz_enter_the_note".tr(),
                  hintStyle: TextStyle(
                      color: Colors.grey
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0),),
                  ),
                ),
              ),
            ),
          )),
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
                      if (po_numberFormKey.currentState!.validate() &&
                          validateInputs(context,
                              scaffoldKey: stockInProductRegisterNotesScaffoldKey,
                              ctx: context)) {
                        CustomViews.navigateTo(
                            context,
                            CreateProducts(
                              islogin: false,
                              title: kproduct_register.tr() +
                                  " - ${Shared.supplier_name??''}",
                            ),
                            "Create Products");
                      }

                    },
                  ),),
              ))
        ],
      ),
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

  bool validateInputs(BuildContext context,
      {var scaffoldKey, required var ctx}) {


    if (noteController.text.isEmpty) {
      CustomViews.showSnackBarView(
          title_status: false,
          message: ksupplier_name_message.tr(),
          backgroundColor: CustomColors.RED_COLOR,
          success_icon: false
      );

      return false;
    }
    return true;
  }
}