import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leen_alkhier_store/data/responses/Sales_returns/returned_order_product_data_response.dart';
import 'package:leen_alkhier_store/data/responses/Sales_returns/sales_returned_reasons_model.dart';
import 'package:leen_alkhier_store/data/responses/user_orders.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/providers/Sales_Returns/sales_returns_provider.dart';
import 'package:leen_alkhier_store/repos/sales_returns_repo.dart';
import 'package:leen_alkhier_store/utils/Shared.dart';
import 'package:leen_alkhier_store/utils/analytics_service.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/index_screens/order_screens/order\'s_details.dart';
import 'package:leen_alkhier_store/views/index_screens/order_screens/photo_gallery.dart';
import 'package:leen_alkhier_store/views/index_screens/order_screens/uploaded_images.dart';
import 'package:leen_alkhier_store/views/widgets/Custom_appbar.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:leen_alkhier_store/views/widgets/custom_textfield.dart';

import 'package:leen_alkhier_store/views/widgets/signup_header.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

class SalesReturnsScreen extends StatefulWidget {
  Products? productModel;
  OrderModel? orderModel;
  String? employee_id;
  Widget? route;
  SalesReturnsScreen(
      {this.productModel, this.orderModel, this.employee_id, this.route});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SalesReturnsScreenState();
  }
}

class SalesReturnsScreenState extends State<SalesReturnsScreen> {
  var salesReturnscaffoldKey = GlobalKey<ScaffoldState>();
  var noteController = TextEditingController();
  var clientController = TextEditingController();

  FocusNode fieldFocus = FocusNode();
  final noteFormKey = GlobalKey<FormState>();
  TextEditingController QuantityController = TextEditingController();

  var quantityFormKey = GlobalKey<FormState>();
  bool upload_image_status = false;
  var sales_returns_quantity = 1;
  AnalyticsService analytics = AnalyticsService();

  SalesReturnedReasonsModel? salesReturnedReasonsModel;
  SalesData? salesData;
  List<Media>? media;
  bool isView = false;
  late bool loading;
  @override
  void initState() {
    loading = true;
    Provider.of<SalesReturnsProvider>(context, listen: false)
        .get_all_sales_returns_reasons()
        .then((value) {
      setState(() {
        salesReturnedReasonsModel = value;
      });
    });
    Future.delayed(Duration(seconds: 1), () {
      Provider.of<SalesReturnsProvider>(context, listen: false)
          .get_sales_returned_data(
        order_id: widget.orderModel!.id.toString(),
        product_id: widget.productModel!.pivot!.productId.toString(),
        unit_id: widget.productModel!.pivot!.unit_id.toString(),
      )
          .then((value) {
        if (value == null) {
          Provider.of<SalesReturnsProvider>(context, listen: false)
              .changeReturned_reasons(null);
          setState(() {
            loading = false;
          });
        } else {
          print("value.data : ${value.data!.toJson()}");
          salesData = value.data;
          QuantityController.text = salesData!.quantity.toString();
          noteController.text = salesData!.notes.toString();
          clientController.text = salesData!.clientNotes.toString();
          Provider.of<SalesReturnsProvider>(context, listen: false)
              .changeReturned_reasons(Provider.of<SalesReturnsProvider>(context,
                      listen: false)
                  .salesReturnedReasonsModel!
                  .data!
                  .firstWhere(
                      (element) => element.id == salesData!.returnedReasonId));
          media = salesData!.media;

          setState(() {
            loading = false;
          });
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: salesReturnscaffoldKey,
      backgroundColor: CustomColors.GREY_COLOR_A,
      appBar: CustomAppBar(
        title: Text(
          '${"product_returns".tr()}',
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
                Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(14)),
                    height: ScreenUtil().screenHeight * 0.75,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              color: CustomColors.WHITE_COLOR,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(15),
                                vertical: ScreenUtil().setWidth(15)),
                            width: double.infinity,
                            child: Column(
                              children: [
                                product_data(
                                    title: "product_name",
                                    name: (translator.activeLanguageCode == 'en')
                                        ? widget.productModel!.timeName!.en
                                        : widget.productModel!.timeName!.ar,
                                    context: context),
                                product_data(
                                    title: "product_size",
                                    name: (translator.activeLanguageCode == 'en')
                                        ? widget.productModel!.unit_name_en
                                        : widget.productModel!.unit_name_ar,
                                    context: context),
                                product_data(
                                    title: "order_quantity",
                                    quantity: widget.productModel!.pivot!
                                                .returnedQuantity ==
                                            null
                                        ? widget.productModel!.pivot!.quantity
                                        : widget.productModel!.pivot!.quantity -
                                            widget.productModel!.pivot!
                                                .returnedQuantity,
                                    unit: (translator.activeLanguageCode == 'en')
                                        ? widget.productModel!.unit_name_en
                                        : widget.productModel!.unit_name_ar,
                                    context: context),
                                product_data(
                                    title: "returns_order",
                                    quantity: QuantityController.text,
                                    unit: '',
                                    context: context),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // Attach_video_images(context),
                          loading
                              ? CustomViews.spinkit
                              : sales_returned_reasons(context),
                          SizedBox(
                            height: 10,
                          ),
                          DottedBorder(
                            color: CustomColors.GREY_LIGHT_A_COLOR,
                            strokeWidth: 1,
                            radius: Radius.circular(12),
                            dashPattern: [8],
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isView = !isView;
                                });
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: CustomColors.PRIMARY_GREEN,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "${"view_att".tr()}"),
                                    ],
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          isView ? Attach_video_images(context) : SizedBox(),
                          SizedBox(
                            height: 10,
                          ),
                          notes(context),

                          InkWell(
                            onTap: () {
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.width * 0.02,
                                  top: MediaQuery.of(context).size.width * 0.1),
                              child: CustomRoundedButton(
                                  fontSize: 15,
                                  backgroundColor: CustomColors.PRIMARY_GREEN,
                                  borderColor: CustomColors.PRIMARY_GREEN,
                                  text: ksend,
                                  height: 50,
                                  textColor: Colors.white,
                                  pressed: () async {
                                    FocusScope.of(context).unfocus();
                                    var returnedReasonsProvider =
                                        Provider.of<SalesReturnsProvider>(
                                            context,
                                            listen: false);
                                    if (returnedReasonsProvider
                                            .selectedReason ==
                                        null) {
                                      CustomViews.showSnackBarView(
                                          title_status: false,
                                          message:
                                              "please chosse one of Product Returns Reasons",
                                          backgroundColor:
                                              CustomColors.RED_COLOR,
                                          success_icon: false);
                                    } else if (QuantityController
                                        .text.isEmpty) {
                                      CustomViews.showSnackBarView(
                                          title_status: false,
                                          message:
                                              "please enter returned quanity",
                                          backgroundColor:
                                              CustomColors.RED_COLOR,
                                          success_icon: false);
                                    } else if (int.parse(
                                            QuantityController.value.text) >
                                        widget.productModel!.pivot!.quantity) {
                                      CustomViews.showSnackBarView(
                                          title_status: false,
                                          message:
                                              "please enter returned quanity less than product quantity",
                                          backgroundColor:
                                              CustomColors.RED_COLOR,
                                          success_icon: false);
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                                backgroundColor:
                                                    Colors.transparent,
                                                contentPadding:
                                                    EdgeInsets.all(0),
                                                insetPadding:
                                                    EdgeInsets.all(20),
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
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),)
    );
  }

  Widget sales_returned_reasons(BuildContext context) {
    var salesReturnsProvider = Provider.of<SalesReturnsProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          salesReturnsProvider.salesReturnedReasonsModel != null
              ? Row(
                  children: [
                    Text(
                      "Sales Returns Reasons".tr(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount:
                  salesReturnsProvider.salesReturnedReasonsModel!.data!.length,
              itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: CustomColors.GREY_LIGHT_A_COLOR,
                            ),
                            borderRadius: BorderRadius.circular(0),
                            color: CustomColors.WHITE_COLOR,
                          ),
                          padding: EdgeInsets.all(4),
                          child: salesData!.returnedReasonId ==
                                  salesReturnsProvider
                                      .salesReturnedReasonsModel!
                                      .data![index]
                                      .id
                              ? Container(
                                  width: 25,
                                  height: 25,
                                  color: CustomColors.PRIMARY_GREEN,
                                )
                              : SizedBox(),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          translator.activeLanguageCode ==
                                  'ar'
                              ? salesReturnsProvider.salesReturnedReasonsModel!
                                  .data![index].reasonAr
                              : salesReturnsProvider.salesReturnedReasonsModel!
                                  .data![index].reasonEn,
                          style: TextStyle(
                            color: CustomColors.BLACK_COLOR,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ))),
        ],
      ),
    );
  }

  Widget product_data(
      {var title,
      var name,
      var quantity,
      var unit,
      bool returns = false,
      required BuildContext context}) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("${title.toString().tr()}",
            style: TextStyle(
                color: CustomColors.GREY_LIGHT_A_COLOR,
                fontSize: 14,
                fontWeight: FontWeight.normal)),
        name == null
            ? Text("$quantity   $unit",
                style: TextStyle(
                    color: CustomColors.GREY_LIGHT_A_COLOR,
                    fontSize: 14,
                    fontWeight: FontWeight.normal))
            : Text("$name",
                maxLines: 3,
                style: TextStyle(
                    color: CustomColors.GREY_LIGHT_A_COLOR,
                    fontSize: 14,
                    fontWeight: FontWeight.normal)),
      ],
    );
  }

  Widget Attach_video_images(BuildContext context) {

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      salesData == null
          ? Container()
          : media == null
              ? CircularProgressIndicator()
              : media!.isEmpty
                  ? Container()
                  : UploadedImages(
                      media: media,
                    ),
    ]);
  }

  bool validateInputs(BuildContext context, {var scaffoldKey, var ctx}) {
    try {
      if (QuantityController.text.contains('-')) {
        CustomViews.showSnackBarView(
            title_status: false,
            message: 'enter_valid_number',
            backgroundColor: CustomColors.RED_COLOR,
            success_icon: false);

        return false;
      } else {
        double num = double.parse(QuantityController.text);
        return true;
      }
    } catch (e) {
      CustomViews.showSnackBarView(
          title_status: false,
          message: 'enter_valid_number',
          backgroundColor: CustomColors.RED_COLOR,
          success_icon: false);

      return false;
    }
  }

  Widget notes(
    BuildContext context,
  ) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        noteController.text == 'null' || noteController.text == ''
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Text(
                      "deiver_notes".tr(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
               //     height: ScreenUtil.defaultSize.width * 0.2,
                    width:ScreenUtil.defaultSize.width ,
                    decoration: BoxDecoration(
                      border: Border.all(color: CustomColors.BLACK_COLOR)
                    ),
                    padding: EdgeInsets.all(5),
                    child: Text(
                    noteController.text,
                      maxLines: 10,
                    ),
                  ),
                /*  CustomTextField(
                    isNotes: true,
                    lablel: "kkk",
                    controller: noteController,
                    isEditable: false,

                    //  focusNode: fieldFocus,
                  ),*/
                ],
              ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          child: Text(
       "write_a_note".tr(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Form(
          key: noteFormKey,
          child: TextFormField(
            controller: clientController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Plz_enter_the_note";
              }
              return null;
            },
            onTap: (){
              if(clientController.selection == TextSelection.fromPosition(TextPosition(offset: clientController.text.length -1))){
                setState(() {
                  clientController.selection = TextSelection.fromPosition(TextPosition(offset: clientController.text.length));
                });
              }
            },
            minLines: 6,
            maxLines: 10,
            keyboardType: TextInputType.multiline,
            focusNode: fieldFocus,
            decoration: InputDecoration(
              hintText: "Plz_enter_the_note".tr(),
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
          /*     child: Container(
            margin: EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: CustomTextField(
              isNotes: true,
              controller: clientController,
              errorMessage: "Plz_enter_the_note",
             lablel: "Plz_enter_the_note",
              //  focusNode: fieldFocus,
            ),
          ),*/
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
                           "Do you want to send returns data?".tr(),
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
                                  text: "accept",
                                  textColor: CustomColors.WHITE_COLOR,
                                  width: MediaQuery.of(context).size.width / 3,
                                  height:
                                      MediaQuery.of(context).size.width / 12,
                                  pressed: () async {
                                    Navigator.pop(cxt);
                                    CustomViews.showLoadingDialog(
                                        context: context);
                                    SalesReturnsRepo.send_product_returns(
                                        images: Shared.images_list,
                                        businessRegisterRequest:
                                            BusinessRegisterRequest(
                                          order_id: widget.orderModel!.id.toString(),
                                          product_id: widget.productModel!.pivot!.productId.toString(),
                                          unit_id: widget.productModel!.pivot!.unit_id.toString(),
                                          returned_reason_id:
                                              Provider.of<SalesReturnsProvider>(context, listen: false).selectedReason!.id.toString(),
                                          quantity: QuantityController.text,
                                          client_notes: clientController.text,
                                        )).then((value) {
                                      Shared.images_list = [];
                                      CustomViews.dismissDialog(
                                          context: context);

                                      analytics.setUserProperties(
                                          userRole: "Order Details Screen");
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
                                          "Order Details Screen");
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

class BusinessRegisterRequest {
  String? order_id;
  String? product_id;
  String? unit_id;
  String? returned_reason_id;
  String? quantity;
  String? notes;
  String? client_notes;
  String? images;

  BusinessRegisterRequest(
      {this.order_id,
      this.product_id,
        this.unit_id,
      this.returned_reason_id,
      this.quantity,
      this.notes,
      this.images,
      this.client_notes});

  Map<String, String?> toMap() => {
        "order_id": order_id,
        "product_id": product_id,
        "unit_id": unit_id,
        "returned_reason_id": returned_reason_id,
        "quantity": quantity,
        "notes": notes,
        "images": images,

        "client_notes": client_notes
      };
}
