import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leen_alkhier_store/data/responses/Sales_returns/returned_order_product_data_response.dart';
import 'package:leen_alkhier_store/data/responses/order_details.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/repos/order_repos.dart';
import 'package:leen_alkhier_store/utils/Shared.dart';
import 'package:leen_alkhier_store/utils/analytics_service.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/index_screens/order_screens/order\'s_details.dart';
import 'package:leen_alkhier_store/views/index_screens/order_screens/photo_gallery.dart';
import 'package:leen_alkhier_store/views/index_screens/order_screens/sales_returns.dart';
import 'package:leen_alkhier_store/views/widgets/Custom_appbar.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:leen_alkhier_store/views/widgets/custom_textfield.dart';
import 'package:leen_alkhier_store/views/widgets/signup_header.dart';
import 'package:leen_alkhier_store/data/responses/user_orders.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class OrderClientNotes extends StatefulWidget {
  OrderModel? orderModel;
  String? employee_id;
  Widget? route;
  Notes? notes;
  OrderClientNotes({this.orderModel, this.employee_id, this.route, this.notes});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrderClientNotesState();
  }
}

class OrderClientNotesState extends State<OrderClientNotes> {
  var clientnotesscaffoldKey = GlobalKey<ScaffoldState>();
  final noteFormKey = GlobalKey<FormState>();

  var noteController = TextEditingController();
  SalesData? salesData;
  List<Images>? media;
  bool upload_image_status = false;
  AnalyticsService analytics = AnalyticsService();

  @override
  void initState() {
    Shared.images_list = [];

    if (widget.notes == null) {
    } else {
      noteController.text = widget.notes!.message;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: clientnotesscaffoldKey,
      backgroundColor: CustomColors.GREY_COLOR_A,
      appBar: CustomAppBar(
        title: Text(
          '${"add_notes".tr()}',
          style: TextStyle(color: CustomColors.BLACK_COLOR, fontSize: 18),
        ),
      ),
      body: Directionality(
    textDirection: MyMaterial.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr,
    child:GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(14)),
                    height: ScreenUtil().screenHeight * 0.75,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CustomColors.WHITE_COLOR,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(15),
                                vertical: ScreenUtil().setWidth(15)),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${'order_number'.tr()}  ${widget.orderModel!.refrenceNumber} # ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: widget.orderModel!.status_en ==
                                            "Pending"
                                        ? CustomColors.BLUE_LIGHT_A
                                        : widget.orderModel!.status_en ==
                                                "Canceled"
                                            ? CustomColors.RED_LIGHT_A
                                            : widget.orderModel!.status_en ==
                                                    "Completed"
                                                ? CustomColors.GREEN_LIGHT_A
                                                : widget.orderModel!
                                                            .status_en ==
                                                        "Accepted"
                                                    ? CustomColors.BLUE_LIGHT_B
                                                    : widget.orderModel!
                                                                .status_en ==
                                                            "Packed"
                                                        ? CustomColors
                                                            .BRAWN_LIGHT
                                                        : widget.orderModel!
                                                                    .status_en ==
                                                                "Ontheway"
                                                            ? CustomColors
                                                                .GREEN_LIGHT
                                                            : widget.orderModel!
                                                                        .status_en ==
                                                                    "draft"
                                                                ? CustomColors
                                                                    .ORANGE_LIGHT
                                                                : CustomColors
                                                                    .PRIMARY_GREEN,
                                  ),
                                  child: Text(
                                    (translator.activeLanguageCode== 'en')
                                        ? widget.orderModel!.status_en!
                                        : widget.orderModel!.status_ar!,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                          ),

                          notes(context),
                          Attach_video_images(context),
                          Container(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).size.width * 0.2,
                                top: MediaQuery.of(context).size.width * 0.1),
                            child: CustomRoundedButton(
                                fontSize: 15,
                                backgroundColor: CustomColors.PRIMARY_GREEN,
                                borderColor: CustomColors.PRIMARY_GREEN,
                                text: ksend,
                                height: 50,
                                textColor: Colors.white,
                                pressed: () async {
                                  if (noteController.text.isEmpty) {
                                    CustomViews.showSnackBarView(
                                        title_status: false,
                                        message: 'enter_your_notes',
                                        backgroundColor: CustomColors.RED_COLOR,
                                        success_icon: false
                                    );

                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                              backgroundColor:
                                                  Colors.transparent,
                                              contentPadding: EdgeInsets.all(0),
                                              insetPadding: EdgeInsets.all(20),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              content: confirmation_dialog(
                                                cxt: ctx,
                                              ),
                                            ));
                                  }
                                }),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
      )  );
  }

  Widget Attach_video_images(BuildContext context) {

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      widget.notes == null || widget.notes!.images!.isEmpty
          ? Container()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    translator
                        .translate(kclientUploaded_images),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(right: 15, top: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: new BorderRadius.circular(5.0),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 2.5,
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: widget.notes!.images!.length,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 150,
                                childAspectRatio: 5 / 2,
                                mainAxisExtent: 100,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0),
                        itemBuilder: (context, index) {
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            child: FadeInImage.assetNetwork(
                              image: widget.notes!.images![index].imageUrl,
                              fit: BoxFit.cover,
                              placeholder: "assets/placeholder.png",
                            ),
                          );
                        }))
              ],
            ),
      SizedBox(
        height: 10,
      ),
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
      SizedBox(
        height: 15,
      ),
    ]);
  }

  Widget notes(BuildContext context,) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Form(
          key: noteFormKey,
          child: Container(
            child: Column(
              children: [
           Padding(padding: EdgeInsets.symmetric(vertical: 10),
           child:      Text("happy_add_notes".tr(),
             style: TextStyle(fontWeight: FontWeight.bold),),),

                TextFormField(
                  controller: noteController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Plz_enter_the_note";
                    }
                    return null;
                  },
                  onTap: (){
                    if(noteController.selection == TextSelection.fromPosition(TextPosition(offset: noteController.text.length -1))){
                      setState(() {
                        noteController.selection = TextSelection.fromPosition(TextPosition(offset: noteController.text.length));
                      });
                    }
                  },
                  minLines: 3,
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText:"Plz_enter_the_note".tr(),
                    hintStyle: TextStyle(
                        color: Colors.grey
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
              ],
            )

          ),
        ),
      ],
    );
  }

  Widget confirmation_dialog({required BuildContext cxt}) {
    return Directionality(
        textDirection: translator.activeLanguageCode == 'ar'
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(cxt).size.width * 0.5,
              width: MediaQuery.of(cxt).size.width * 0.8,
              decoration: BoxDecoration(
                  color: CustomColors.WHITE_COLOR,
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          color: CustomColors.WHITE_COLOR,
                          child: Text(
                            translator
                                .translate("Do you want to send your notes ?")!,
                            style: TextStyle(
                                color: CustomColors.BLACK_COLOR,
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: CustomRoundedButton(
                                  backgroundColor: CustomColors.PRIMARY_GREEN,
                                  borderColor: CustomColors.PRIMARY_GREEN,
                                  textColor: CustomColors.WHITE_COLOR,
                                  text: "accept",
                                  width: MediaQuery.of(context).size.width / 3,
                                  height:
                                      MediaQuery.of(context).size.width / 12,
                                  pressed: () async {
                                    Navigator.pop(cxt);
                                    CustomViews.showLoadingDialog(context: context);
                                    OrdersRepository.send_client_order_notes(
                                        images: Shared.images_list,
                                        businessRegisterRequest: BusinessRegisterRequest(
                                          order_id: widget.orderModel!.id.toString(),
                                          notes: noteController.text,
                                        )).then((value) {
                                      Shared.images_list = [];
                                      CustomViews.dismissDialog(context: context);
print("value : ${value}");
                                  /*   if(value.){
                                       CustomViews.showSnackBarView(
                                           title_status: true,
                                           message: 'employee_deleted',
                                           backgroundColor: CustomColors.PRIMARY_GREEN,
                                           success_icon: true
                                       );

                                     }else{
                                       CustomViews.showSnackBarView(
                                           title_status: false,
                                           message: ksend_client_notes_response,
                                           backgroundColor: CustomColors.RED_COLOR,
                                           success_icon: false
                                       );
                                     }*/


                                      Future.delayed(Duration(seconds: 1),
                                          () async {
                                        analytics.setUserProperties(userRole: "Order Details Screen");
                                        CustomViews.navigateToRepalcement(
                                            context,
                                            OrderDetails(
                                              orderModel: widget.orderModel,
                                              employee_id: widget.employee_id,
                                              id: widget.orderModel!.id,
                                              refrenceNumber: widget
                                                  .orderModel!.refrenceNumber
                                                  .toString(),
                                            ),
                                            "Order Details  Screen");

                                      });
                                    });
                                  }),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              child: CustomRoundedButton(
                                  text: "cancel",
                                  textColor: CustomColors.WHITE_COLOR,
                                  width: MediaQuery.of(context).size.width / 3,
                                  height:
                                      MediaQuery.of(context).size.width / 12,
                                  backgroundColor: CustomColors.RED_COLOR,
                                  borderColor: CustomColors.RED_COLOR,
                                  pressed: () async {
                                    Navigator.pop(cxt);
                                  }),
                            ),
                          ],
                        ),
                      ))
                ],
              )),
        ));
  }
}
