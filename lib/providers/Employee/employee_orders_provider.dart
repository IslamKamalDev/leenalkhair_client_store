import 'package:flutter/cupertino.dart';
import 'package:leen_alkhier_store/data/responses/user_orders.dart';
import 'package:leen_alkhier_store/repos/employees_repo.dart';

class EmployeeOrdersProvider extends ChangeNotifier{
  OrdersResponse? ordersResponse;

  Future<OrdersResponse?> get_employee_orders_func({String? employee_id , String? branch_id,
    String? start , String? end,String? page})async{
    ordersResponse =   await EmployeesRepository.get_employee_orders(
        employee_id: employee_id,
        branch_id: branch_id,
      start: start,
      end: end,
      page: page
    );
    return ordersResponse;
  }
}