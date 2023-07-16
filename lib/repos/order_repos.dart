import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lecle_flutter_absolute_path/lecle_flutter_absolute_path.dart';
import 'package:leen_alkhier_store/data/models/request_product_details_list.dart';
import 'package:leen_alkhier_store/data/responses/change_order_status_response.dart';
import 'package:leen_alkhier_store/data/responses/delete_order_product_response.dart';
import 'package:leen_alkhier_store/data/responses/order_details.dart';
import 'package:leen_alkhier_store/data/responses/rate_order_response.dart';
import 'package:leen_alkhier_store/data/responses/update_order_product_response.dart';
import 'package:leen_alkhier_store/data/responses/user_orders.dart';
import 'package:leen_alkhier_store/network/ServicesURLs.dart';
import 'package:leen_alkhier_store/network/networkCallback/NetworkCallback.dart';
import 'package:leen_alkhier_store/utils/Enums.dart';
import 'package:leen_alkhier_store/utils/TokenUtil.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/index_screens/order_screens/sales_returns.dart';
import 'package:http/http.dart' as http;
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:path/path.dart';
import 'package:http/http.dart';

class OrdersRepository {
  static Future<OrdersResponse> getContractOrders(
      {String? contractID,
      String? branch_id,
      String? start,
      String? end,
      int? pageNumber}) async {
    return OrdersResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v3/get_contract_order",
        method: HttpMethod.GET,
        queryParams: {
          "contract_id": contractID,
          "branch_id": branch_id,
          "start": start,
          "end": end,
          "page": pageNumber.toString(),
        })));
  }

  static Future<OrdersResponse> getMainUserOrders(
      {String? contractID, List? branch_id, String? pageNumber}) async {

    return OrdersResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v3/get_order",
        method: HttpMethod.GET,
        queryParams: {
          "contract_id": contractID,
          "branch_id": branch_id
                  .toString()
                  .substring(1, branch_id.toString().length - 1)
                  .isEmpty
              ? "0"
              : branch_id
                  .toString()
                  .substring(1, branch_id.toString().length - 1),
          "page": pageNumber,
        })));
  }

  static Future<OrderrDetails> getContractOrderDetails(String orderID,
      {String? pageNumber, String? employee_id}) async {
    return OrderrDetails.fromJson(await (NetworkCall.makeCall(
        endPoint: employee_id == null
            ? "api/v4/get_order_details/$orderID"
            : "api/v4/get_order_details/$orderID/$employee_id",
        method: HttpMethod.GET,
        queryParams: {"page": pageNumber})));
  }

  static Future<ChangeOrderStatusResponse> cancelOrder(
      {String? orderID}) async {
     return ChangeOrderStatusResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v3/set_status/$orderID",
        method: HttpMethod.POST,
        requestBody: jsonEncode({"status": "Cancel"}))
     )
     );
  }

  static Future<UpdateOrderProductResponse> updateOrderProducts(
      {String? contract_id,
      String? orderId,
      required List<ProductDetails> products}) async {

    var idSet = <String>{};
    var distinct_products = <ProductDetails>[];
    for (var d in products) {
      if (idSet.add(d.product_id.toString())) {
        distinct_products.add(d);
      }
    }


    return UpdateOrderProductResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v4/update_product_quantity",
        method: HttpMethod.POST,
        requestBody: jsonEncode({
          "contract_id": contract_id,
          "order_id": orderId,
          "products": distinct_products
              .map((e) => {
            "product_id": e.product_id,
            "units": e.prod_units!.map((u) =>{
              "id" : u.unitId,
              "quantity_per_unit" : u.quantityPerUnit
            }).toList()
          }).toList()

        }))));
  }

  static Future<DeleteOrderProductResponse> deleteOrderProducts(
      {String? productId, String? orderID}) async {
    return DeleteOrderProductResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v3/delete_product/$productId",
        method: HttpMethod.POST,
        requestBody: jsonEncode({
          "order_id": orderID,
        }))));
  }

  // rate order
  static Future<RateOrderResponse> rateOrderProducts(
      {String? rate, String? orderID}) async {
    return RateOrderResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v3/set_rating",
        method: HttpMethod.POST,
        requestBody: jsonEncode({
          "order_id": orderID,
          "rate": rate,
        }))));
  }

  static Future<String?> send_client_order_notes(
      {List? images,
      required BusinessRegisterRequest businessRegisterRequest}) async {
    String? status;
    String? Token = TokenUtil.getTokenFromMemory();

    var uri = Uri.parse(
        '${ServicesURLs.development_environment_scheme}://${ServicesURLs.development_environment_without_http}'
            '/api/v3/add_order_notes');

    http.MultipartRequest request = new http.MultipartRequest('POST', uri);
    request.headers.addAll({'Authorization': 'Bearer $Token'});
    request.fields['order_id'] = businessRegisterRequest.order_id!;
    request.fields['message'] = businessRegisterRequest.notes!;
    List<http.MultipartFile> newList = [];
    for (int i = 0; i < images!.length; i++) {
      var path2 = await LecleFlutterAbsolutePath.getAbsolutePath(images[i].identifier);
      // FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
      File imageFile = File(path2!);
      final bytes = imageFile.readAsBytesSync().lengthInBytes;
      final kb = bytes / 1024;
      final mb = kb / 1024;

      double imageDesiredWidth = 500;

      double getAspectRatio(double originalSize, double desiredSize) => desiredSize / originalSize;
      final aspectRatio = getAspectRatio(images[i].originalWidth.toDouble(), imageDesiredWidth);
      ByteData byteData = await images[i].getThumbByteData(
          (images[i].originalWidth * aspectRatio).round(),
          (images[i].originalHeight * aspectRatio).round(),
          quality: 85);
      var multipartFile = new http.MultipartFile.fromBytes(
          "images[]", byteData.buffer.asUint8List(),
          filename: basename(imageFile.path));

      newList.add(multipartFile);
    }
    request.files.addAll(newList);
    await request.send().then((value) {
      if (value.statusCode == 200) {
        print("Image Uploaded : $value");
      } else {
        print("Upload Failed");
      }
      value.stream.transform(utf8.decoder).listen((value) {
       if(jsonDecode(value)['status']){
         CustomViews.showSnackBarView(
             title_status: true,
             message: ksend_client_notes_response,
             backgroundColor: CustomColors.PRIMARY_GREEN,
             success_icon: true
         );
       }else{
         CustomViews.showSnackBarView(
             title_status: false,
             message: jsonDecode(value)['message'],
             backgroundColor: CustomColors.RED_COLOR,
             success_icon: false
         );
       }
      });
    });
  }
}
