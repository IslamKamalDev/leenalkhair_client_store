import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:leen_alkhier_store/data/responses/change_order_status_response.dart';
import 'package:leen_alkhier_store/data/responses/order_details.dart';
import 'package:leen_alkhier_store/data/responses/user_orders.dart';
import 'package:leen_alkhier_store/repos/draft_orders_repository.dart';
import 'package:leen_alkhier_store/repos/order_repos.dart';
import 'package:leen_alkhier_store/views/index_screens/order_screens/draft_orders.dart';

class OrderViewModel extends GetxController {
  var ordersResponse = OrdersResponse(data: []);
  List orders = [];
  List orders2 = [];
  List draftorders = [];
  List draftorders2 = [];
  int? lastPage;
  int? draftlastPage;
  OrderrDetails? order;
  bool loadingPages = true;

  int currentPage = 1;

  changeCurrentPage() {
    currentPage++;
    update();
  }

  // bool loading=true;
  bool loading = false;
  changeLoadingPage(bool val) {
    loadingPages = val;
    update();
  }

  clearContracOrders() {
    ordersResponse.data!.clear();
    update();
  }

  updateItemStatuesinList(int? orderId, {String? type}) {
    if (type == 'confirm order') {
      orders2[orders2.indexWhere((element) => element.id == orderId)]
          .status = "Confirmed";
      orders2[orders2.indexWhere((element) => element.id == orderId)]
          .status_ar = "تم التاكيد ";
    } else {
      orders2[orders2.indexWhere((element) => element.id == orderId)]
          .status = "Canceled";
      orders2[orders2.indexWhere((element) => element.id == orderId)]
          .status_ar = "تم الالغاء ";
    }

    update();
  }

  updateItemInList(int? orderId, total) {
    try {
      orders2[orders2.indexWhere((element) => element.id == orderId)].total =
          total;
    } catch (e) {}
    update();
  }

  clearValues() {
    orders = [];
    lastPage = null;
    update();
  }

  changeLoadingStatues(bool val) {
    loading = val;
    update();
  }

  Future<List<dynamic>> getContractOrders2(
      {String? contractID, List? branch_id, int? pageNumber}) async {

    orders = [];
    var rs = await OrdersRepository.getMainUserOrders(
        contractID: contractID,
        branch_id: branch_id,
        pageNumber: pageNumber.toString());
    lastPage = rs.lastPage;
    orders = [];
    orders.addAll(rs.data!);

    return orders;
  }

  Future<ChangeOrderStatusResponse> cancelOrder(String orderID) async {
    return await OrdersRepository.cancelOrder(orderID: orderID);
  }

  void getOrders({String? contractID, List? branch_id, int? pageNumber}) async {
    try {
      await getContractOrders2(
              contractID: contractID,
              branch_id: branch_id,
              pageNumber: pageNumber)
          .then((value) {
        orders2.addAll(value);

        // loading = false;
        changeLoadingStatues(false);
      });
    } catch (e) {
      changeLoadingStatues(false);
    }

    update();
  }

  void getDraftOrders(
      {String? contractID, List? branch_id, int? pageNumber}) async {
    try {
      draftorders = [];

      var rs = await DraftOrdersRepository.getDraftOrders(
          contractID: contractID,
          branch_id: branch_id,
          pageNumber: pageNumber.toString());
      draftlastPage = rs.lastPage;
      draftorders = [];
      draftorders.addAll(rs.data!);
      draftorders2.addAll(draftorders);

      // loading = false;
      changeLoadingStatues(false);
    } catch (e) {
      changeLoadingStatues(false);
    }

    update();
  }
}
