import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leen_alkhier_store/data/responses/order_details.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/utils/analytics_service.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/Store/Orders/order_details_screen.dart';
import 'package:leen_alkhier_store/views/index_screens/order_screens/photo_gallery.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
class EditQuantityScreen extends StatefulWidget{
  final int? order_number;
  ProductModel? productModel;
  EditQuantityScreen({this.order_number,this.productModel});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditQuantityScreenState();
  }

}

class EditQuantityScreenState extends State<EditQuantityScreen>{
  List<Images>? media;
  bool upload_image_status = false;
  var noteController = TextEditingController();
  FocusNode fieldFocus = FocusNode();
  var po_numberFormKey = GlobalKey<FormState>();
  AnalyticsService analytics = AnalyticsService();

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
                title:kedit_quantity.tr(),
            ),
            body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child:SingleChildScrollView(
              child: Column(
                children: [

                  Padding(
                      padding: const EdgeInsets.symmetric(vertical:10,horizontal: 10),
                      child:Directionality(textDirection: translator.activeLanguageCode == 'ar'? TextDirection.rtl : TextDirection.ltr,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: CustomColors.WHITE_COLOR,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(15),
                                vertical: ScreenUtil().setWidth(15)),
                            width: double.infinity,
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${'order_number'.tr()}  ${widget.order_number} # ',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color:CustomColors.RED_COLOR,
                                  ),
                                  child: Text(
                                    krequest_edit.tr(),
                                    style: TextStyle(color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ))),

                  Padding(   padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                    child:   Container(
                        decoration: BoxDecoration(
                          color: CustomColors.WHITE_COLOR,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          // border: Border.all(color: CustomColors.PRIMARY_GREEN)
                        ),
                        child: SingleChildScrollView(
                            child: Row(
                                children: [
                                  Padding(   padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                                      child:     CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: MediaQuery.of(context).size.width * 0.1,
                                          backgroundImage: NetworkImage(widget.productModel!.image_url!
                                          ))),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          widget.productModel!.name!

                                      ),

                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                         " Unit : " + "KG" ,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                            color: Colors.grey.shade700
                                        ),
                                      ),

                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  kinput_quantity.tr() + " : ",
                                                  style: TextStyle(color: Colors.teal),
                                                ),
                                                SizedBox(
                                                  width:ScreenUtil.defaultSize.width * 0.008,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      border: Border.all(color: CustomColors.GREY_LIGHT_A_COLOR)
                                                  ),
                                                  width: ScreenUtil.defaultSize.width * 0.25,
                                                  height: ScreenUtil.defaultSize.width * 0.07,
                                                  alignment: Alignment.center,
                                                  child: TextField(
                                                    textAlign: TextAlign.center,
                                                    autofocus: false,

                                                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly ,
                                                      FilteringTextInputFormatter.deny(RegExp(r'^0+')),],
                                                    decoration: InputDecoration(
                                                      hintText: kSelectQuantity.tr(),
                                                      border: OutlineInputBorder(
                                                        borderSide:
                                                        BorderSide(color: Colors.grey),
                                                        borderRadius:
                                                        BorderRadius.circular(5.0),
                                                      ),
                                                      contentPadding: EdgeInsets.all(5),
                                                    ),
                                                    keyboardType: TextInputType.number,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  keditable_quantity.tr() + " : ",
                                                  style: TextStyle(color: Colors.teal),
                                                ),
                                                SizedBox(
                                                  width:ScreenUtil.defaultSize.width * 0.008,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      border: Border.all(color: CustomColors.GREY_LIGHT_A_COLOR)
                                                  ),
                                                  width: ScreenUtil.defaultSize.width * 0.15,
                                                  height: ScreenUtil.defaultSize.width * 0.07,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    widget.productModel!.quantity.toString(),
                                                    style: TextStyle(color: Colors.red),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  )

                                ]))),
                  ),
                  SizedBox(
                    height: ScreenUtil.defaultSize.width * 0.1,
                  ),
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
                            minLines: 5,
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
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          alignment: Alignment.center,
                          height: ScreenUtil().setHeight(40),
                          child: CustomRoundedButton(
                            fontSize: 15,
                            text: ksend_modification,
                            width: ScreenUtil().screenWidth * 0.90,
                            textColor: Colors.black,
                            backgroundColor: CustomColors.PRIMARY_GREEN,
                            borderColor: CustomColors.PRIMARY_GREEN,
                            pressed: () async {

                              analytics
                                  .setUserProperties(
                                  userRole:
                                  "Signup Contract Screen");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          OrderDetailsScreen(
                                            order_number: widget.order_number,
                                          )));
                            },
                          ),),
                      ))
                ],
              ),
            ))
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