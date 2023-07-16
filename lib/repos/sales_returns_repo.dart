import 'dart:async';
import 'dart:convert';
import 'dart:io';

// import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:lecle_flutter_absolute_path/lecle_flutter_absolute_path.dart';
import 'package:leen_alkhier_store/data/responses/Sales_returns/returned_order_product_data_response.dart';
import 'package:leen_alkhier_store/data/responses/Sales_returns/sales_returned_reasons_model.dart';
import 'package:leen_alkhier_store/network/ServicesURLs.dart';
import 'package:leen_alkhier_store/network/networkCallback/NetworkCallback.dart';
import 'package:leen_alkhier_store/utils/Enums.dart';
import 'package:leen_alkhier_store/utils/TokenUtil.dart';
import 'package:leen_alkhier_store/views/index_screens/order_screens/sales_returns.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class SalesReturnsRepo {
  static Future<SalesReturnedReasonsModel> get_returned_reasons() async {
    return SalesReturnedReasonsModel.fromJson(await (NetworkCall.makeCall(
      endPoint: "/api/v3/get_reasons",
      method: HttpMethod.GET,
    )));
  }

  static Future<ReturnedOrderProductDataResponse?> get_sales_returned_data(
      {var order_id, var product_id}) async {
    String? Token = TokenUtil.getTokenFromMemory();
    await http.get(
      Uri.parse(
          '${ServicesURLs.development_environment_scheme}://${ServicesURLs.development_environment_without_http}/api/v3/driver/get_returnes_product?order_id=$order_id&product_id=$product_id'),
      headers: <String, String>{
        'Authorization': 'Bearer $Token',
      },
    ).then((value) {
      if (value.statusCode == 200) {
        try {
          var body = jsonDecode(value.body);

        } catch (e) {
          print('catch: $e');
        }
      } else {
      }
    });
    return null;
  }

  static Future<String?> send_product_returns(
      {List? images,
      required BusinessRegisterRequest businessRegisterRequest}) async {
    String? Token = TokenUtil.getTokenFromMemory();

    var uri = Uri.parse(
        '${ServicesURLs.development_environment_scheme}://${ServicesURLs.development_environment_without_http}/api/v3/add_return');
    http.MultipartRequest request = new http.MultipartRequest('POST', uri);
    request.headers.addAll({'Authorization': 'Bearer $Token'});
    request.fields['order_id'] = businessRegisterRequest.order_id!;
    request.fields['product_id'] = businessRegisterRequest.product_id!;
    request.fields['unit_id'] = businessRegisterRequest.unit_id!;
    request.fields['returned_reason_id'] =
        businessRegisterRequest.returned_reason_id!;
    request.fields['quantity'] = businessRegisterRequest.quantity!;
    request.fields['client_notes'] = businessRegisterRequest.client_notes!;
    request.fields['type'] = "customer";
    List<http.MultipartFile> newList = [];
    for (int i = 0; i < images!.length; i++) {
      var path2 = await LecleFlutterAbsolutePath.getAbsolutePath(images[i].identifier);
      File imageFile = File(path2!);
      var stream = new http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      var multipartFile = new http.MultipartFile("images[]", stream, length,
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
      value.stream.transform(utf8.decoder).listen((value) {});
    });
    return null;
  }
}
