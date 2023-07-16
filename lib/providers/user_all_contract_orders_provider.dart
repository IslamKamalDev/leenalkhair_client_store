import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/data/responses/change_order_status_response.dart';
import 'package:leen_alkhier_store/data/responses/order_details.dart';
import 'package:leen_alkhier_store/data/responses/user_orders.dart';
import 'package:leen_alkhier_store/repos/order_repos.dart';

class UserAllContractOrderProvider extends ChangeNotifier {
  var ordersResponse = OrdersResponse(data: []);
  List orders = [];
  List orders2 = [];
  int? lastPage;
  OrderrDetails? order;
  bool loadingPages = true;

  int currentPage = 1;

  changeCurrentPage() {
    currentPage++;
    notifyListeners();
  }

  // bool loading=true;
  bool loading = false;
  changeLoadingPage(bool val) {
    loadingPages = val;
    notifyListeners();
  }

  clearContracOrders() {
    ordersResponse.data!.clear();
    notifyListeners();
  }

  updateItemStatuesinList(int orderId) {
    orders2[orders2.indexWhere((element) => element.id == orderId)].status =
        "Cancel";

    notifyListeners();
  }

  updateItemInList(int orderId, total) {
    orders2[orders2.indexWhere((element) => element.id == orderId)].total =
        total;

    notifyListeners();
  }

  clearValues() {
    orders = [];
    lastPage = null;
    notifyListeners();
  }

  changeLoadingStatues(bool val) {
    loading = val;
    notifyListeners();
  }

  Future<OrdersResponse> getContractOrders(String contractID) async {
    ordersResponse.data!.clear();
    ordersResponse.data = [];
    var rs = await OrdersRepository.getContractOrders(
      contractID: contractID,
    );
    int lastPage = rs.lastPage!;

////

    await Future.forEach(List.generate(lastPage, (index) => index),
        (dynamic element) async {
      rs = await OrdersRepository.getContractOrders(
          contractID: contractID, pageNumber: (element + 1));
      ordersResponse.data!.addAll(rs.data!);
    });

    return ordersResponse;
  }

  Future<List<dynamic>> getContractOrders2(String contractID,
      {int? pageNumber}) async {
    orders = [];
    var rs = await OrdersRepository.getContractOrders(
        contractID: contractID, pageNumber: pageNumber);
    lastPage = rs.lastPage;
    orders = [];
    orders.addAll(rs.data!);
    return orders;
  }

  Future<OrderrDetails?> getContractOrdersDetails(String orderID,
      {String? employee_id}) async {
    OrderrDetails orderDetails = await OrdersRepository.getContractOrderDetails(
        orderID,
        employee_id: employee_id);
    order = orderDetails;
    return order;
  }

  Future<ChangeOrderStatusResponse> cancelOrder(String orderID) async {
    return await OrdersRepository.cancelOrder(orderID: orderID);
  }

  void getOrders(String contractID, {int? pageNumber}) async {
    await getContractOrders2(contractID, pageNumber: pageNumber).then((value) {
      orders2.addAll(value);

      loading = false;
    });
    notifyListeners();
  }

  ////rate
  Future<void> rateOrder(String rate, String orderID) async {
    await OrdersRepository.rateOrderProducts(
      ///
      orderID: orderID,
      rate: rate,
    );
    notifyListeners();
  }
}
