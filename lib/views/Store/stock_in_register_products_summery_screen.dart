import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:leen_alkhier_store/data/responses/order_details.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/utils/Constants.dart';
import 'package:leen_alkhier_store/utils/Shared.dart';
import 'package:leen_alkhier_store/utils/analytics_service.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/views/auth/signup/Create_products.dart';
import 'package:leen_alkhier_store/views/index.dart';
import 'package:leen_alkhier_store/views/index_screens/order_screens/photo_gallery.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../utils/local_const.dart';
import '../dashboard/dashboard_screen.dart';

class StockInProductRegisterSummeryScreen extends StatefulWidget{
  final String? product_name;
  StockInProductRegisterSummeryScreen({this.product_name});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StockInProductRegisterSummeryScreenState();
  }

}

class StockInProductRegisterSummeryScreenState extends State<StockInProductRegisterSummeryScreen>{

  var stockInProductRegisterNotesScaffoldKey = GlobalKey<ScaffoldState>();
  var po_numberFormKey = GlobalKey<FormState>();
  AnalyticsService analytics = AnalyticsService();

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
                title:kregister_products_summery.tr()+
                    " - ${Shared.supplier_name??''}"
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [

                 Padding(padding: EdgeInsets.symmetric(vertical: 10),
                 child: Container(
                   height: ScreenUtil.defaultSize.width,
                   child:  ListView.builder(
                       itemCount: contractProductsList.length,
                       itemBuilder: (context,index){

                         return Padding(   padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                           child:   Container(

                               decoration: BoxDecoration(
                                 color: CustomColors.WHITE_COLOR,
                                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                 // border: Border.all(color: CustomColors.PRIMARY_GREEN)
                               ),
                               child: SingleChildScrollView(
                                   child: Row(
                                       mainAxisSize: MainAxisSize.min,
                                       children: [
                                         Padding(   padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                                             child:     CircleAvatar(
                                                 backgroundColor: Colors.white,
                                                 radius: MediaQuery.of(context).size.width * 0.1,
                                                 backgroundImage: NetworkImage(contractProductsList[index].product_image
                                                 ))),

                                         Column(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Text(
                                                 contractProductsList[index].product_name

                                             ),

                                             SizedBox(
                                               height: 5,
                                             ),

                                             contractProductsList[index].units!.length > 1
                                                 ? Text(" ${kMultiple_quantity.tr()} ", style: TextStyle(color: Colors.black),)
                                                 :    Row(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children: [
                                                 Text(
                                                   kunit.tr()  + " : ",
                                                   style: TextStyle(color: Colors.teal),
                                                 ),
                                                 SizedBox(
                                                   width:ScreenUtil.defaultSize.width * 0.008,
                                                 ),
                                                 Text(
                                                   "KG",
                                                   style: TextStyle(color: Colors.red),
                                                 ),
                                               ],
                                             ),

                                             SizedBox(
                                               height: 5,
                                             ),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children: [
                                                 Text(
                                                   kquantity.tr() + " : ",
                                                   style: TextStyle(color: Colors.teal),
                                                 ),
                                                 SizedBox(
                                                   width:ScreenUtil.defaultSize.width * 0.008,
                                                 ),
                                                 Container(
                                                   decoration: BoxDecoration(
                                                       borderRadius: BorderRadius.circular(10),
                                                       border: Border.all(color: CustomColors.GREY_LIGHT_A_COLOR)
                                                   ),
                                                   width: ScreenUtil.defaultSize.width * 0.15,
                                                   height: ScreenUtil.defaultSize.width * 0.07,
                                                   alignment: Alignment.center,
                                                   child: Text(
                                                     contractProductsList[index].units![0].unit_id.toString(),
                                                     style: TextStyle(color: Colors.red),
                                                   ),
                                                 ),
                                               ],
                                             )
                                           ],
                                         )

                                       ]))),
                         );

                       }),
                 )
                   ,),

                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
            children: [
              Padding(padding: EdgeInsets.symmetric(horizontal: ScreenUtil.defaultSize.width * 0.05,vertical: 5),
                  child:   Container(
                      decoration: BoxDecoration(
                        color: CustomColors.WHITE_COLOR,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        // border: Border.all(color: CustomColors.PRIMARY_GREEN)
                      ),
                      child: Column(
                        children: [
                          Padding(padding: EdgeInsets.symmetric(horizontal: ScreenUtil.defaultSize.width * 0.1),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("اسم مركز التشغيل"),
                                Text("المركز الرئيسى")
                              ],
                            ),),
                          Padding(padding: EdgeInsets.symmetric(horizontal: ScreenUtil.defaultSize.width * 0.1),
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("تاريخ التسجيل"),
                                  Text("22/2/2024")
                                ],
                              )  ),
                        ],
                      )
                  )),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  alignment: Alignment.center,
                  height: ScreenUtil().setHeight(40),
                  child: CustomRoundedButton(
                    fontSize: 15,
                    text: ksend,
                    width: ScreenUtil().screenWidth * 0.90,
                    textColor: Colors.white,
                    backgroundColor: CustomColors.PRIMARY_GREEN,
                    borderColor: CustomColors.PRIMARY_GREEN,
                    pressed: () async {
                      analytics
                          .setUserProperties(
                          userRole:
                          "Index Screen");

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) =>
                                  DashboardScreen(

                                  )));

                    },
                  ),),
              )
            ],
          )


                )
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