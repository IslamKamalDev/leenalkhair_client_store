import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leen_alkhier_store/data/models/request_product_details_list.dart';
import 'package:leen_alkhier_store/data/responses/contract_products_response.dart';
import 'package:leen_alkhier_store/data/responses/order_details.dart';

import 'package:leen_alkhier_store/data/responses/user_orders.dart';
import 'package:leen_alkhier_store/providers/Employee/all_employees_provider.dart';
import 'package:leen_alkhier_store/providers/cart_product_item_provider.dart';
import 'package:leen_alkhier_store/providers/contract_products_cart_provider.dart';
import 'package:leen_alkhier_store/providers/contract_products_provider.dart';
import 'package:leen_alkhier_store/providers/get/orderViewModel.dart';
import 'package:leen_alkhier_store/providers/user_all_contract_orders_provider.dart';
import 'package:leen_alkhier_store/providers/user_orders_provider.dart';
import 'package:leen_alkhier_store/utils/Shared.dart';
import 'package:leen_alkhier_store/utils/analytics_service.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/index_screens/order_screens/draft_orders.dart';
import 'package:leen_alkhier_store/views/index_screens/order_screens/order_client_notes.dart';
import 'package:leen_alkhier_store/views/widgets/Custom_appbar.dart';
import 'package:leen_alkhier_store/views/widgets/cart_product_item.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:leen_alkhier_store/views/widgets/signup_header.dart';
import 'package:leen_alkhier_store/views/widgets/widget_bottomsheet.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../orders.dart';
import 'add_products.dart';
import 'dart:ui' as ui;

class OrderDetails extends StatefulWidget {
  OrderModel? orderModel;
  String? employee_id;
  String? refrenceNumber;
  var id;
  Widget? route;
  String? type;
  OrderDetails(
      {this.orderModel,
      this.id,
      this.employee_id,
      this.route,
      this.type,
      this.refrenceNumber});

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final OrderViewModel orderController = Get.put(OrderViewModel());
  var contractId;
  OrderrDetails? order;
  bool loading = true;
 // bool update_other_employees_Orders = false;
  var f = NumberFormat("###,###.00#", "en_US");
  AnalyticsService analytics = AnalyticsService();
  bool main_user_confirm_order = false;
  bool Confirme_Orders_status = false;
  @override
  void initState() {
    var allEmployeesProvider = Provider.of<AllEmployeesProvider>(context, listen: false);

    allEmployeesProvider.tokenPermissionsRespnse.permissions!.forEach((element) {
      if (element.name == "Confirme Orders") {
        main_user_confirm_order = true;
      }
    });
    print("main_user_confirm_order : ${main_user_confirm_order}");
    Shared.images_list = [];
    var cartProductsProvider = Provider.of<OrderDetailsCartProductItemProvider>(
        context,
        listen: false);
    var userAllContractOrderProvider =
        Provider.of<UserAllContractOrderProvider>(context, listen: false);
    Future.delayed(Duration(seconds: 0), () {
      userAllContractOrderProvider
          .getContractOrdersDetails(widget.id.toString(),
              employee_id: widget.employee_id)
          .then((value) {
        setState(() {
          order = value;
          loading = false;
          cartProductsProvider.setProducts(order!.products!);
          cartProductsProvider.setTotal(order!.total);

          cartProductsProvider.setCharge = (order!.charge);

          cartProductsProvider.setDiscount = (order!.discount);

          cartProductsProvider.setTax = (order!.tax);
          ////
          cartProductsProvider.ordersListFromApi = [];
          cartProductsProvider.ordersListFromApi.addAll(order!.products!);
        });
      });
    });
    super.initState();
  }

  var orderDetailsScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var cartProductsProvider =
        Provider.of<OrderDetailsCartProductItemProvider>(context);
    var userOrderProvider = Provider.of<UserOrderProvider>(context);
    var userAllContractOrderProvider =
        Provider.of<UserAllContractOrderProvider>(context, listen: false);
    var contractProducts =
        Provider.of<ContractProductsProvider>(context, listen: false);
    var contractsProductsCartProvider =
        Provider.of<ContractProductCartProductItemProvider>(context);

    var allEmployeesProvider = Provider.of<AllEmployeesProvider>(context);
    allEmployeesProvider.tokenPermissionsRespnse.permissions!
        .forEach((element) {
   /*   if (element.name == "update other employees Orders") {
        update_other_employees_Orders = true;
      }else*/ if (element.name == "Confirme Orders") {
        Confirme_Orders_status = true;
        print("Confirme_Orders_status : ${Confirme_Orders_status}");
      }

    });

    return Consumer<OrderDetailsCartProductItemProvider>(
        builder: (context, controller, _) {

      return Scaffold(
          key: orderDetailsScaffoldKey,
          backgroundColor: CustomColors.GREY_COLOR_A,
          appBar: CustomAppBar(
            title: Text(
              '${translator.activeLanguageCode == "ar" ?   "تفاصيل الطلب" :  "order_details"}',
              style: TextStyle(color: CustomColors.BLACK_COLOR, fontSize: 18),
            ),
          ),
          body: Directionality(
            textDirection: translator.activeLanguageCode == 'ar' ? ui.TextDirection.rtl : ui.TextDirection.ltr,
            child: Container(
              padding: EdgeInsets.only(top: 10, left: 15, right: 15),
              width: double.infinity,
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
                            '${translator.activeLanguageCode == "ar" ? "رقم الطلب" : "Order Number"}  ${widget.orderModel!.refrenceNumber} # ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: widget.orderModel!.status_en == "Pending"
                                  ? CustomColors.BLUE_LIGHT_A
                                  : widget.orderModel!.status_en == "Canceled"
                                      ? CustomColors.RED_LIGHT_A
                                      : widget.orderModel!.status_en ==
                                              "Completed"
                                          ? CustomColors.GREEN_LIGHT_A
                                          : widget.orderModel!.status_en ==
                                                  "Accepted"
                                              ? CustomColors.BLUE_LIGHT_B
                                              : widget.orderModel!.status_en ==
                                                      "Packed"
                                                  ? CustomColors.BRAWN_LIGHT
                                                  : widget.orderModel!
                                                              .status_en ==
                                                          "Ontheway"
                                                      ? CustomColors.GREEN_LIGHT
                                                      : widget.orderModel!
                                                                  .status_en ==
                                                              "draft"
                                                          ? CustomColors
                                                              .ORANGE_LIGHT
                                                          : CustomColors
                                                              .PRIMARY_GREEN,
                            ),
                            child: Text(
                              (translator.activeLanguageCode == 'en')
                                  ? widget.orderModel!.status_en!
                                  : widget.orderModel!.status_ar!,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 5,
                    ),

                    loading == true
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(10),
                                vertical: ScreenUtil().setWidth(10)),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ))
                        : Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(0)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                ...cartProductsProvider.allProducts
                                    .map((e) => CartProductItem(
                                          productModel: e,
                                          orderStatus: order!.status,
                                          orderModel: widget.orderModel,
                                          employee_id: widget.employee_id,
                                        ))
                                    .toList(),

                                SizedBox(
                                  height: 10,
                                ),

                                (order!.status == "Pending" || order!.status == "draft")
                                    ?Row(
                                  children: [
                                    Expanded(
                                      child: CustomRoundedButton(
                                        fontSize: 15,
                                        //backgroundColor: Color(0xFF18856E).withOpacity(0.2),
                                        backgroundColor: Color(0xFFD0E7E2),
                                        borderColor: Color(0xFF18856E).withOpacity(0.2),
                                        text: 'add_products',
                                        textColor: Colors.black,
                                        pressed: () async {
                                          controller.allProductsDetails = [];
                                          contractsProductsCartProvider.allProducts.map((e) {

                                            bool price_not_null = e.units!.where((element) => element.price != null).isEmpty;
                                            if (e.availabe == true && !price_not_null) {
                                              controller.allProductsDetails.add(e);
                                            }
                                          }).toList();

                                          controller.ordersListFromApi.map((e) {
                                            controller.updateProductsInAllProduct(
                                                e.pivot!.productId,
                                                e.pivot!.quantity);
                                          }).toList();

                                          analytics.setUserProperties(userRole: "Add Products Screen");
                                          CustomViews.navigateTo(context,
                                              AddProducts(
                                                order: order,
                                                branch: order!.branch,
                                                order_details_screen:
                                                OrderDetails(
                                                  refrenceNumber: widget.refrenceNumber,
                                                  orderModel: widget.orderModel,
                                                  employee_id: widget.employee_id,
                                                  id: widget.id,
                                                  route: widget.route,
                                                ),
                                                type: widget.type,
                                              ),
                                              "Add Products Screen");
                                        },
                                      ),
                                    ),
                                  ],
                                )
                                    : Container(),

                                SizedBox(
                                  height: 10,
                                ),

                                (order!.status == "Completed")
                                    ? InkWell(
                                        onTap: () {
                                          analytics.setUserProperties(
                                              userRole:
                                                  "Order Client Notes Screen");
                                          CustomViews.navigateTo(
                                              context,
                                              OrderClientNotes(
                                                employee_id: widget.employee_id,
                                                orderModel: widget.orderModel,
                                                notes: order!.notes,
                                                route: OrderDetails(
                                                  orderModel: widget.orderModel,
                                                  employee_id:
                                                      widget.employee_id,
                                                  id: widget.id,
                                                  refrenceNumber: widget
                                                      .orderModel!
                                                      .refrenceNumber
                                                      .toString(),
                                                ),
                                              ),
                                              "Order Client Notes Screen");
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20),
                                            decoration: BoxDecoration(
                                                color: CustomColors.YELLOW,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                              child: Text(
                                                  translator
                                                      .translate(
                                                          "order_notes"),
                                                  style: TextStyle(
                                                      color: CustomColors
                                                          .GREY_COLOR,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),

                                SizedBox(
                                  height: 15,
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
                                      order!.branch == null
                                          ? Container()
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextWidgetwithStyle(
                                                    text: translator.activeLanguageCode == "ar" ?
                                                    "اسم الفرع" : "Branch Name" ),
                                                TextWidgetwithStyle(
                                                    text: order!.branch!),
                                              ],
                                            ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextWidgetwithStyle(
                                              text:  translator.activeLanguageCode == "ar" ? "تاريخ الطلب": "Order's Date"),
                                          TextWidgetwithStyle(
                                              text: order!.orderDate!
                                                  .split("T")[0]),
                                        ],
                                      ),
                                      (translator.activeLanguageCode == "en")
                                          ? SizedBox(
                                              height: ScreenUtil().setWidth(12),
                                            )
                                          : SizedBox(
                                              height: 1,
                                            ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextWidgetwithStyle(
                                              text:  translator.activeLanguageCode == "ar" ? "تاريخ التوصيل" : "Delivery Date "
                                              ),
                                          TextWidgetwithStyle(
                                              text: order!.deliveryDate!
                                                  .split(" ")[0]),

                                        ],
                                      ),
                                      (translator.activeLanguageCode == "en")
                                          ? SizedBox(
                                              height: ScreenUtil().setWidth(12))
                                          : SizedBox(
                                              height: 1,
                                            ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextWidgetwithStyle(
                                              text: translator.activeLanguageCode == "ar" ? "موعد التوصيل": "Delivery time"
                                             ),
                                          TextWidgetwithStyle(
                                              text: (translator.activeLanguageCode ==
                                                      'en')
                                                  ? order!.timingName2!.en!
                                                  : order!.timingName2!.ar!),
                                        ],
                                      ),
                                      (translator.activeLanguageCode==
                                          "en")
                                          ? SizedBox(
                                              height: ScreenUtil().setWidth(12),
                                            )
                                          : SizedBox(
                                              height: 1,
                                            ),
                             /*         Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextWidgetwithStyle(
                                              text: translator.translate(
                                                  'extra_discount')!),
                                          TextWidgetwithStyle(
                                              text: cartProductsProvider
                                                      .discount!
                                                      .toStringAsFixed(2) +
                                                  " %"),
                                        ],
                                      ),
                                      (translator
                                                  .locale
                                                  .languageCode ==
                                              "en")
                                          ? SizedBox(
                                              height: ScreenUtil().setWidth(12))
                                          : SizedBox(
                                              height: 1,
                                            ),*/
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextWidgetwithStyle(
                                              text: translator.activeLanguageCode == "ar" ? "قيمة الضريبة" : "Tax amount"
                                             ),
                                          TextWidgetwithStyle(
                                              text: cartProductsProvider.tax!
                                                      .toStringAsFixed(2) +
                                                  " %"),

                                        ],
                                      ),
                            /*          (translator.activeLanguageCode == "en")
                                          ? SizedBox(
                                              height: ScreenUtil().setWidth(12))
                                          : SizedBox(
                                              height: 1,
                                            ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextWidgetwithStyle(
                                              text: translator.translate('charge')),
                                          GestureDetector(
                                              onTap: () {},
                                              child: TextWidgetwithStyle(
                                                  text: cartProductsProvider
                                                          .charge!
                                                          .toStringAsFixed(2) +
                                                      " %")),
                                        ],
                                      ),*/
                                      (translator.activeLanguageCode == "en")
                                          ? SizedBox(
                                              height: ScreenUtil().setWidth(12))
                                          : SizedBox(
                                              height: 1,
                                            ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextWidgetwithStyle(
                                              text: translator.activeLanguageCode == "ar" ? "قيمة الطلب" : "Total"
                                            ),
                                          TextWidgetwithStyle(
                                              text: f.format(double.parse(
                                                      cartProductsProvider
                                                          .total!
                                                          .toStringAsFixed(
                                                              2))) +
                                                  " ${translator.activeLanguageCode == "ar" ? "ر س" : "SAR"
                                                  }"),
                                        ],
                                      ),
                                      (translator.activeLanguageCode ==
                                              "en")
                                          ? SizedBox(
                                              height: ScreenUtil().setWidth(12))
                                          : SizedBox(height: 1),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: 20,
                                ),

                                (order!.status == "draft")
                                    ? Row(
                                        children: [
                                        Confirme_Orders_status ?     Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                child: CustomRoundedButton(
                                                  fontSize: 15,
                                                  backgroundColor: CustomColors
                                                      .PRIMARY_GREEN,
                                                  borderColor: CustomColors
                                                      .PRIMARY_GREEN,
                                                  height: 50,
                                                  text: 'confirm_order',
                                                  textColor: Colors.white,
                                                  pressed: () async {
                                                    showDialog(
                                                        context: context,
                                                        builder: (ctx) =>
                                                            AlertDialog(
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(0),
                                                              insetPadding:
                                                                  EdgeInsets
                                                                      .all(20),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15)),
                                                              content:
                                                                  confirmation_dialog(
                                                                      cxt: ctx,
                                                                      type:
                                                                          'confirm order'),
                                                            ));
                                                  },
                                                ),
                                              )) : Container(),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              child: CustomRoundedButton(
                                                fontSize: 15,
                                                backgroundColor: CustomColors.GREEN_LIGHT_A,
                                                borderColor: CustomColors.GREEN_LIGHT_A,
                                                height: 50,
                                                text: 'update',
                                                textColor: Colors.white,
                                                pressed: () async {
                                              /*    if (!update_other_employees_Orders) {
                                                    CustomViews.showSnackBarView(
                                                        title_status: false,
                                                        message: kno_permission,
                                                        backgroundColor: CustomColors.RED_COLOR,
                                                        success_icon: false
                                                    );
                                                  } else {*/
                                                    CustomViews.showLoadingDialog(context: context);

                                                    List<ProductDetails>products = [];

                                                    cartProductsProvider.allProducts.map((e) {
                                                      List<Units> uints_list = [];
                                                      cartProductsProvider.allProducts.forEach((element) {
                                                        if(element.id == e.id){
                                                          uints_list.add(Units(
                                                            unitId: element.unitId,
                                                            unit: element.unit_name_en,
                                                            unitAr: element.unit_name_ar,
                                                            quantityPerUnit: element.pivot!.quantity,
                                                            price: element.pivot!.price,
                                                          ));

                                                        }
                                                      });

                                                      uints_list.removeWhere((element) => element.quantityPerUnit == ""
                                                          || element.quantityPerUnit == "0" || element.price == null);

                                                      products.add(
                                                          ProductDetails(
                                                              order_id: order!.id,
                                                              product_id: e.pivot!.productId,
                                                              prod_units: uints_list
                                                          ));
                                                    }).toList();

                                                    if (products.length == 0) {
                                                      CustomViews.dismissDialog(context: context);
                                                      CustomViews.showSnackBarView(
                                                          title_status: false,
                                                          message: 'can_not_create_order',
                                                          backgroundColor: CustomColors.RED_COLOR,
                                                          success_icon: false
                                                      );

                                                    } else {
                                                      orderController.updateItemInList(
                                                          order!.id,
                                                              cartProductsProvider.total);

                                                      await userOrderProvider.updateOrder(
                                                              contract_id: order!.contractId.toString(),
                                                              orderId: order!.id.toString(),
                                                              products: products
                                                      ).whenComplete(() =>
                                                          CustomViews.dismissDialog(context: context))
                                                          .then((value) {
                                                        if (!value.status!) {
                                                          CustomViews.showSnackBarView(
                                                              title_status: false,
                                                              backend_message: value.message!,
                                                              backgroundColor: CustomColors.RED_COLOR,
                                                              success_icon: false
                                                          );

                                                        } else{
                                                          CustomViews.showSnackBarView(
                                                              title_status: true,
                                                              message: 'order_success_update',
                                                              backgroundColor: CustomColors.PRIMARY_GREEN,
                                                              success_icon: true
                                                          );
                                                        }

                                                      }).catchError((e) {
                                                        log("ErrorUpdateOrder:$e");
                                                      });
                                                    }
                                                  }
                                               // },
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                child: CustomRoundedButton(
                                                  fontSize: 15,
                                                  backgroundColor:
                                                      CustomColors.ORANGE,
                                                  borderColor:
                                                      CustomColors.ORANGE,
                                                  height: 50,
                                                  text: 'cancel_order',
                                                  textColor: Colors.white,
                                                  pressed: () async {
                                                    showDialog(
                                                        context: context,
                                                        builder: (ctx) =>
                                                            AlertDialog(
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(0),
                                                              insetPadding:
                                                                  EdgeInsets
                                                                      .all(20),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15)),
                                                              content:
                                                                  confirmation_dialog(
                                                                      cxt: ctx,
                                                                      type:
                                                                          'cancel order'),
                                                            ));
                                                  },
                                                ),
                                              )),
                                        ],
                                      )
                                    : (order!.status != "Pending")
                                        ? Container()
                                        : Row(
                                            children: [
                                              Expanded(
                                                child: CustomRoundedButton(
                                                  fontSize: 15,
                                                  backgroundColor: CustomColors.GREEN_LIGHT_A,
                                                  borderColor: CustomColors.GREEN_LIGHT_A,
                                                  text: 'update',
                                                  height: 50,
                                                  textColor: Colors.white,
                                                  pressed: () async {
                                           /*         if (!update_other_employees_Orders) {
                                                      CustomViews.showSnackBarView(
                                                          title_status: false,
                                                          message: kno_permission,
                                                          backgroundColor: CustomColors.RED_COLOR,
                                                          success_icon: false
                                                      );

                                                    }
                                                    else {*/
                                                      CustomViews.showLoadingDialog(context: context);
                                                      List<ProductDetails>products = [];

                                                      cartProductsProvider.allProducts.map((e) {
                                                        List<Units> uints_list = [];
                                                        cartProductsProvider.allProducts.forEach((element) {
                                                          if(element.id == e.id){
                                                            uints_list.add(Units(
                                                              unitId: element.unitId,
                                                              unit: element.unit_name_en,
                                                              unitAr: element.unit_name_ar,
                                                              quantityPerUnit: element.pivot!.quantity,
                                                              price: element.pivot!.price,
                                                            ));

                                                          }
                                                        });

                                                        uints_list.removeWhere((element) => element.quantityPerUnit == ""
                                                            || element.quantityPerUnit == "0" || element.price == null);

                                                        products.add(
                                                            ProductDetails(
                                                                order_id: order!.id,
                                                                product_id: e.pivot!.productId,
                                                                prod_units: uints_list,)
                                                        );
                                                      }).toList();

                                                      if (products.length == 0) {
                                                        CustomViews.dismissDialog(context: context);
                                                        CustomViews.showSnackBarView(
                                                            title_status: false,
                                                            message: 'can_not_create_order',
                                                            backgroundColor: CustomColors.RED_COLOR,
                                                            success_icon: false
                                                        );

                                                      } else {
                                                        orderController.updateItemInList(
                                                            order!.id, cartProductsProvider.total);

                                                        await userOrderProvider.updateOrder(
                                                                contract_id: order!.contractId.toString(),
                                                                orderId: order!.id.toString(),
                                                                products: products)
                                                            .whenComplete(() =>
                                                                CustomViews.dismissDialog(context: context))
                                                            .then((value) {
                                                          if (!value.status!) {
                                                            CustomViews.showSnackBarView(
                                                                title_status: false,
                                                                backend_message: value.message!,
                                                                backgroundColor: CustomColors.RED_COLOR,
                                                                success_icon: false
                                                            );

                                                          } else
                                                          CustomViews.showSnackBarView(
                                                              title_status: true,
                                                              message:   'order_success_update',
                                                              backgroundColor: CustomColors.PRIMARY_GREEN,
                                                              success_icon: true
                                                          );
                                                        }).catchError((e) {
                                                          log("ErrorUpdateOrder:$e");
                                                        });
                                                      }
                                                  //  }

                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: CustomRoundedButton(
                                                  fontSize: 15,
                                                  backgroundColor:
                                                      CustomColors.ORANGE,
                                                  borderColor:
                                                      CustomColors.ORANGE,
                                                  text: kRemove_order,
                                                  height: 50,
                                                  textColor: Colors.white,
                                                  pressed: () async {
                                                    showDialog(
                                                        context: context,
                                                        builder: (ctx) =>
                                                            AlertDialog(
                                                              backgroundColor: Colors.transparent,
                                                              contentPadding: EdgeInsets.all(0),
                                                              insetPadding: EdgeInsets.all(20),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(15)),
                                                              content: confirmation_dialog(
                                                                      cxt: ctx,
                                                                      type: 'cancel order'),
                                                            ));
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),

                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                              ],
                            ),
                          )
                  ],
                ),
              ),
            ),
          ));
    });
  }

  showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ScreenUtil.defaultSize.width * 0.1),
                topRight:Radius.circular( ScreenUtil.defaultSize.width * 0.1)
            )
        ),
        builder: (BuildContext bc) {
          return Container(
            padding: EdgeInsets.only(top: 4),
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(children: [
              Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[600]),
              ),
              //Spacer(),
              SizedBox(
                height: 50,
              ),

              _buildBottomSheetButton(),

              SizedBox(
                height: 20,
              ),
            ]),
          );
        });
  }

  _buildBottomSheetButton() {
    var contractsProductsCartProvider =
        Provider.of<ContractProductCartProductItemProvider>(context);
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...contractsProductsCartProvider.allProducts.map((e) {
              return BottomSheetWidget(
                productModel: e,
              );
            }).toList(),
          ],
          //child: BottomSheetWidget()
        ),
      ),
    );
  }

  Widget confirmation_dialog({required BuildContext cxt, var type}) {
    var userOrderProvider = Provider.of<UserOrderProvider>(context);

    return Directionality(
        textDirection: translator.activeLanguageCode == 'ar'
            ? ui.TextDirection.rtl
            : ui.TextDirection.ltr,
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

                                type == 'cancel order'
                                    ? translator.activeLanguageCode == "ar" ?
                                "هل ترغب بحذف الطلب ؟" : "Do you want to remove order?"
                                    : translator.activeLanguageCode == "ar" ?
                                "هل ترغب فى تاكيد الطلب ؟" : "Do you want to confirm order?"
                            ,
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
                                  height: MediaQuery.of(context).size.width / 12,
                                  pressed: () async {
                                    Navigator.pop(cxt);
                                    CustomViews.showLoadingDialog(context: context);
                                    if (type == 'cancel order') {
                                      await userOrderProvider.cancelOrder(order!.id.toString()).then((value) {
                                        if (value.status!) {
                                          CustomViews.dismissDialog(context: context);
                                          if(type == 'cancel order' ){
                                            CustomViews.showSnackBarView(
                                                title_status: false,
                                                message: 'order_success_cancel',
                                                backgroundColor: CustomColors.RED_COLOR,
                                                success_icon: false
                                            );
                                          }else{
                                            CustomViews.showSnackBarView(
                                                title_status: true,
                                                message:'order_success_confirmed',
                                                backgroundColor: CustomColors.PRIMARY_GREEN,
                                                success_icon: true
                                            );

                                          }



                                          Future.delayed(Duration(seconds: 1), () {
                                            type == 'cancel order'
                                                ? orderController
                                                    .updateItemStatuesinList(
                                                        order!.id)
                                                : '';
                                            Navigator.pop(context);
                                          });
                                        } else {
                                          CustomViews.showSnackBarView(
                                              title_status: false,
                                              backend_message:  value.message!,
                                              backgroundColor: CustomColors.RED_COLOR,
                                              success_icon: false
                                          );

                                        }
                                      }).catchError((e) {
                                        log("ErrorCancelOrder:$e");
                                      });
                                    } else {
                                      await userOrderProvider
                                          .confirmDraftOrder(
                                              order!.id.toString())
                                          .then((value) {
                                        if (value.status!) {
                                          CustomViews.dismissDialog(
                                              context: context);
                                          if(type == 'cancel order' ){
                                            CustomViews.showSnackBarView(
                                                title_status: false,
                                                message: 'order_success_cancel',
                                                backgroundColor: CustomColors.RED_COLOR,
                                                success_icon: false
                                            );
                                          }else{
                                            CustomViews.showSnackBarView(
                                                title_status: true,
                                                message:'order_success_confirmed',
                                                backgroundColor: CustomColors.PRIMARY_GREEN,
                                                success_icon: true
                                            );

                                          }

                                          Future.delayed(Duration(seconds: 1),
                                              () {
                                            type == 'confirm order'
                                                ? orderController
                                                    .updateItemStatuesinList(
                                                        order!.id,
                                                        type: 'confirm order')
                                                : '';

                                            Navigator.pop(context);
                                          });
                                        } else {
                                          CustomViews.showSnackBarView(
                                              title_status: false,
                                              backend_message: value.message!,
                                              backgroundColor: CustomColors.RED_COLOR,
                                              success_icon: false
                                          );


                                        }
                                      }).catchError((e) {
                                        log("ErrorCancelOrder:$e");
                                      });
                                    }
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

class TextWidgetwithStyle extends StatelessWidget {
  const TextWidgetwithStyle({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            color: CustomColors.GREY_LIGHT_A_COLOR,
            fontSize: 14,

            fontWeight: FontWeight.normal));
  }
}
