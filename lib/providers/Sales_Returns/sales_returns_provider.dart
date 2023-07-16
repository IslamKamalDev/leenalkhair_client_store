import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:leen_alkhier_store/data/responses/Sales_returns/returned_order_product_data_response.dart';
import 'package:leen_alkhier_store/data/responses/Sales_returns/sales_returned_reasons_model.dart';
import 'package:leen_alkhier_store/network/ServicesURLs.dart';
import 'package:leen_alkhier_store/repos/sales_returns_repo.dart';
import 'package:leen_alkhier_store/utils/TokenUtil.dart';
import 'package:http/http.dart' as http;
class SalesReturnsProvider extends ChangeNotifier{
  SalesReturnedReasonsModel? salesReturnedReasonsModel;
  Data? selectedReason;
  ReturnedOrderProductDataResponse? returnedOrderProductDataResponse;

  void changeReturned_reasons(Data? reason) {
    selectedReason = reason;
    notifyListeners();
  }

  Future<SalesReturnedReasonsModel?> get_all_sales_returns_reasons({var business_info_id})async{
    salesReturnedReasonsModel = await SalesReturnsRepo.get_returned_reasons(
    );
    notifyListeners();
    return salesReturnedReasonsModel;
  }
/*
  Future<ReturnedOrderProductDataResponse> get_all_sales_returned_data(
      {var order_id, var product_id}) async{

    returnedOrderProductDataResponse = await SalesReturnsRepo.get_sales_returned_data(
      order_id: order_id,
      product_id: product_id
    );
    notifyListeners();
    return returnedOrderProductDataResponse;
  }*/


  Future<ReturnedOrderProductDataResponse?> get_sales_returned_data({var order_id, var product_id,var unit_id}) async {
    String? Token=TokenUtil.getTokenFromMemory();
    http.Response response = await http.get(
      Uri.parse('${ServicesURLs.development_environment_scheme}://${ServicesURLs.development_environment_without_http}'
          '/api/v4/get_returnes_product?order_id=$order_id&product_id=$product_id&unit_id=$unit_id'),
      headers: <String, String>{
        'Authorization': 'Bearer $Token',
      },
    );
    if (response.statusCode == 200) {
      try {
        var body = jsonDecode(response.body);
        returnedOrderProductDataResponse = ReturnedOrderProductDataResponse.fromJson(body);
        notifyListeners();
        return returnedOrderProductDataResponse;
      } catch (e) {
      }
    } else {
    }
    return null;
  }




}