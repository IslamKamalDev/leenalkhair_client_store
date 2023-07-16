
import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/data/models/general_model.dart';
import 'package:leen_alkhier_store/data/models/request_product_details_list.dart';
import 'package:leen_alkhier_store/data/responses/change_order_status_response.dart';
import 'package:leen_alkhier_store/data/responses/update_order_product_response.dart';
import 'package:leen_alkhier_store/data/responses/user_orders.dart';
import 'package:leen_alkhier_store/repos/draft_orders_repository.dart';
import 'package:leen_alkhier_store/repos/order_repos.dart';

class UserOrderProvider extends ChangeNotifier {
  var ordersResponse = OrdersResponse(data: []);

  clearContracOrders() {
    ordersResponse.data!.clear();
    notifyListeners();
  }

  Future<ChangeOrderStatusResponse> cancelOrder(String orderID) async {
    return await OrdersRepository.cancelOrder(orderID: orderID);
  }



  Future<UpdateOrderProductResponse> updateOrder(
      {String? contract_id,String? orderId, required List<ProductDetails> products}) async {
    return await OrdersRepository.updateOrderProducts(
      contract_id:contract_id ,
        orderId: orderId,
        products: products);
  }


  Future<GeneralModel>confirmDraftOrder(String orderID) async {
    return await DraftOrdersRepository.confirmDraftOrder(orderID: orderID);
  }
}
