import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:leen_alkhier_store/data/models/request_product_details_list.dart';
import 'package:leen_alkhier_store/data/responses/order_details.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/utils/Constants.dart';
import 'package:leen_alkhier_store/utils/Shared.dart';
import 'package:leen_alkhier_store/utils/analytics_service.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/Store/Orders/edit_quantity_screen.dart';
import 'package:leen_alkhier_store/views/auth/signup/Create_products.dart';
import 'package:leen_alkhier_store/views/index_screens/order_screens/photo_gallery.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:localize_and_translate/localize_and_translate.dart';


class OrderDetailsScreen extends StatefulWidget{
  final int? order_number;
  OrderDetailsScreen({this.order_number});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrderDetailsScreenState();
  }

}

class OrderDetailsScreenState extends State<OrderDetailsScreen>{

  var stockInProductRegisterNotesScaffoldKey = GlobalKey<ScaffoldState>();
  var po_numberFormKey = GlobalKey<FormState>();

  var noteController = TextEditingController();
  FocusNode fieldFocus = FocusNode();
  List<Images>? media;
  bool upload_image_status = false;
  List<ProductModel> products=[];
  @override
  void initState() {
    products = [
      ProductModel(
        name: "بقدونس",
        editable: false,
        price: 10.30,
        quantity: 4,
        image_url: "https://backend.leenalkhair.com/storage/files/neSLKzx23mlnskGQQbMrzDjgngUbIZvUF3N4QquO.jpg"
      ),
      ProductModel(
          name: "الهليون الأخضر صغير - مستورد",
          editable: false,
          price: 23,
          quantity: 25,
          image_url: "https://backend.leenalkhair.com/storage/files/RwWsdE4SFiL2IQL8pSbKIqvfpxLChTy6yJhYFPqe.jpg"
      ),
      ProductModel(
          name:  "بازيلاء",
          editable: true,
          price: 6.5,
          quantity: 8,
          image_url: "https://backend.leenalkhair.com/storage/files/WVXLGaMtfDFj4Ugz8yglyKxLgH9WFfIg20lvqw34.jpg"
      ),
    ];

    super.initState();
  }
  AnalyticsService analytics = AnalyticsService();
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
                title:orderDetails.tr(),
              draft_icon: true
            ),
            body: SingleChildScrollView(
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
                  child:  Text(
                        '${'order_number'.tr()}  ${widget.order_number} # ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                ))),

                  Padding(padding: EdgeInsets.symmetric(vertical: 10),
                    child: ListView.builder (
                        itemCount: products.length,
                        shrinkWrap: true,
                        itemBuilder: (context,index){

                          return InkWell(
                            onTap: (){
                              analytics
                                  .setUserProperties(
                                  userRole:
                                  "Signup Contract Screen");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          EditQuantityScreen(
                                            order_number: widget.order_number,
                                            productModel: products[index],
                                          )));
                            },
                            child: Padding(   padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
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
                                                    backgroundImage: NetworkImage(products[index].image_url!
                                                    ))),

                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    products[index].name!

                                                ),

                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  products[index].price!.toString() + " SAR/KG ",
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
                                                              products[index].quantity.toString(),
                                                              style: TextStyle(color: Colors.red),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: ScreenUtil.defaultSize.width * 0.1,),
                                                    products[index].editable!  ?    InkWell(
                                                      onTap: (){

                                                      },
                                                      child:  Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          color:CustomColors.RED_COLOR,
                                                        ),
                                                        child: Text(
                                                          keditable_quantity.tr(),
                                                          style: TextStyle(color: Colors.white, fontSize: 12),
                                                        ),
                                                      ),
                                                    ) : Container()
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            )

                                          ]))),
                            ),
                          );

                        })
                    ,),

                  SizedBox(
                    height: ScreenUtil.defaultSize.width * 0.1,
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          alignment: Alignment.center,
                          height: ScreenUtil().setHeight(40),
                          child: CustomRoundedButton(
                            fontSize: 15,
                            text: ksend_quantity_for_edit,
                            width: ScreenUtil().screenWidth * 0.90,
                            textColor: Colors.black,
                            backgroundColor: CustomColors.YELLOW,
                            borderColor: CustomColors.YELLOW,
                            pressed: () async {

                            },
                          ),),
                      ))
                ],
              ),
            )
        ));
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

class ProductModel {
  String? name;
  String? image_url;
  double? price;
  double? quantity;
  bool? editable;
  ProductModel({this.name,this.quantity,this.image_url,this.price,this.editable});
}