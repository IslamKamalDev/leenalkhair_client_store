import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lecle_flutter_absolute_path/lecle_flutter_absolute_path.dart';
import 'package:leen_alkhier_store/data/models/general_model.dart';
import 'package:leen_alkhier_store/data/models/request_product_details_list.dart';
import 'package:leen_alkhier_store/data/responses/Draft_Orders/draf_orders_response.dart';
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
import 'package:leen_alkhier_store/views/index_screens/order_screens/sales_returns.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:http/http.dart';

class DraftOrdersRepository {
  static Future<OrdersResponse> getDraftOrders(
      {String? contractID, List? branch_id, String? pageNumber}) async {

    return OrdersResponse.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v3/draft_orders",
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

  static Future<GeneralModel> confirmDraftOrder({String? orderID}) async {
    return GeneralModel.fromJson(await (NetworkCall.makeCall(
        endPoint: "api/v3/confirm_order",
        method: HttpMethod.POST,
        requestBody: jsonEncode({"order_id": "$orderID"}))));
  }
}
