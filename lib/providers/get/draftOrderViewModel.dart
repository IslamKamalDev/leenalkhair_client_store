import 'package:get/get.dart';
import 'package:leen_alkhier_store/data/responses/order_details.dart';
import 'package:leen_alkhier_store/data/responses/user_orders.dart';
import 'package:leen_alkhier_store/repos/draft_orders_repository.dart';

class DraftOrderViewModel extends GetxController {
  var ordersResponse = OrdersResponse(data: []);
  List draftorders = [];
  List draftorders2 = [];
  int? draftlastPage;
  OrderrDetails? draftorder;
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
      draftorders2[draftorders2.indexWhere((element) => element.id == orderId)]
          .status = "Confirmed";
      draftorders2[draftorders2.indexWhere((element) => element.id == orderId)]
          .status_ar = "تم التاكيد ";
    } else {
      draftorders2[draftorders2.indexWhere((element) => element.id == orderId)]
          .status = "Canceled";
      draftorders2[draftorders2.indexWhere((element) => element.id == orderId)]
          .status_ar = "تم الالغاء ";
    }

    update();
  }

  updateItemInList(int? orderId, total) {
    try {
      draftorders2[draftorders2.indexWhere((element) => element.id == orderId)]
          .total = total;
    } catch (e) {}
    update();
  }

  clearValues() {
    draftorders = [];
    draftlastPage = null;
    update();
  }

  changeLoadingStatues(bool val) {
    loading = val;
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
