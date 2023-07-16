import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:leen_alkhier_store/data/responses/user_orders.dart';
import 'package:leen_alkhier_store/providers/cart_product_item_provider.dart';
import 'package:leen_alkhier_store/utils/analytics_service.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/index_screens/order_screens/sales_returns.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

class CartProductItem extends StatelessWidget {
  Products? productModel;
  String? orderStatus;
  OrderModel? orderModel;
  String? employee_id;
  Widget? route;
  CartProductItem(
      {this.productModel,
      this.orderStatus,
      this.employee_id,
      this.orderModel,
      this.route});

  AnalyticsService analytics = AnalyticsService();

  @override
  Widget build(BuildContext context) {
    var cartProductsProvider = Provider.of<OrderDetailsCartProductItemProvider>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: CustomColors.WHITE_COLOR,
      ),
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(5),
          vertical: ScreenUtil().setWidth(5)),
      width: double.infinity,
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(productModel!.imageUrl!)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              (translator.activeLanguageCode== 'en')
                  ? productModel!.timeName!.en!
                  : productModel!.timeName!.ar!,
              style: TextStyle(
                  color: CustomColors.GREY_COLOR,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            (orderStatus == "Pending" || orderStatus == "draft")
                ? Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            cartProductsProvider.removeProduct(productModel);
                          },
                          child: Icon(
                            Icons.cancel,
                            color: CustomColors.BLACK_COLOR,
                          ))
                    ],
                  )
                : Container()
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            (translator.activeLanguageCode == 'en')
                ? Text(
                    '${productModel!.pivot!.price.toString().split('.')[0]} ${'currency'.tr()} '
                        '/ ${productModel!.unit_name_en} ${productModel!.weight ==1 ? '' : productModel!.weight}',
                    style: TextStyle(
                        color: CustomColors.GREY_LIGHT_A_COLOR,
                        fontSize: 12,
                        fontWeight: FontWeight.normal))
                : Text(
                    '${productModel!.pivot!.price.toString().split('.')[0]} ${'currency'.tr()} '
                        '/ ${productModel!.unit_name_ar} ${productModel!.weight ==1 ? '' : productModel!.weight}',
                    style: TextStyle(
                        color: CustomColors.GREY_LIGHT_A_COLOR,
                        fontSize: 12,
                        fontWeight: FontWeight.normal)),
            (orderStatus == "Pending" || orderStatus == "draft")
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${'quantity'.tr()} : ',
                                  style: TextStyle(
                                      color: CustomColors.GREY_COLOR,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.add_circle,
                                    color: CustomColors.PRIMARY_GREEN,
                                  ),
                                  onPressed: () async {
                                    //     CustomViews.showLoadingDialog(context: context);
                                    cartProductsProvider
                                        .incrementQuantity(productModel);
                                    // CustomViews.dismissDialog(context: context);
                                    // Navigator.pop(context);
                                  }),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(10)),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: CustomColors.GREY_LIGHT_B_COLOR),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                    productModel!.pivot!.lastQuantity == null ?
                                    productModel!.pivot!.quantity.toString().split('.')[0]
                                        : productModel!.pivot!.lastQuantity.toString().split('.')[0]
                                ),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.remove_circle,
                                    color: CustomColors.ORANGE,
                                  ),
                                  onPressed: () async {
                                    if (productModel!.pivot!.quantity > 1) {
                                      //  CustomViews.showLoadingDialog(context: context);

                                      cartProductsProvider
                                          .decrementQuantity(productModel);

                                      // Navigator.pop(context);

                                      return;
                                    }
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                : (orderStatus == "Completed" &&
                        productModel!.pivot!.returnedQuantity != null)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('${'quantity'.tr()} : ',
                                  style: TextStyle(
                                      color: CustomColors.GREY_COLOR,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(10)),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: CustomColors.GREY_LIGHT_B_COLOR),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(productModel!.pivot!.returnedQuantity == null
                                    ?   productModel!.pivot!.lastQuantity == null ?
                                          productModel!.pivot!.quantity.toString().split('.')[0]
                                          : productModel!.pivot!.lastQuantity.toString().split('.')[0]

                                    : ( ( productModel!.pivot!.lastQuantity == null ?
                                      productModel!.pivot!.quantity : productModel!.pivot!.lastQuantity )
                                      - productModel!.pivot!.returnedQuantity)
                                        .toString().split('.')[0]),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: CustomRoundedButton(
                            fontSize: 15,
                            backgroundColor: CustomColors.ORANGE,
                            borderColor: CustomColors.ORANGE,
                            text: kproduct_returns,
                            textColor: Colors.white,
                            height: 30,
                            pressed: () {
                              analytics.setUserProperties(
                                  userRole: "Sales ReturnsScreen Screen");
                              CustomViews.navigateToRepalcement(
                                  context,
                                  SalesReturnsScreen(
                                    productModel: productModel,
                                    employee_id: employee_id,
                                    orderModel: orderModel,
                                    route: route,
                                  ),
                                  "Sales ReturnsScreen Screen");
                            },
                          ))
                        ],
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${'quantity'.tr()} : ',
                              style: TextStyle(
                                  color: CustomColors.GREY_COLOR,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(10)),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: CustomColors.GREY_LIGHT_B_COLOR),
                                borderRadius: BorderRadius.circular(5)),
                            child:
                                Text(productModel!.pivot!.lastQuantity == null ?
                                productModel!.pivot!.quantity.toString().split('.')[0]
                                :    productModel!.pivot!.lastQuantity.toString().split('.')[0]),
                          ),
                        ],
                      )
          ],
        ),
      ),
    );
  }
}
