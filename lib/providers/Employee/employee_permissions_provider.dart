import 'package:flutter/cupertino.dart';
import 'package:leen_alkhier_store/data/responses/Employee/employee_permissions_response.dart';
import 'package:leen_alkhier_store/repos/employees_repo.dart';

class EmployeePermissionsProvider extends ChangeNotifier{
  EmployeePermissionsResponse? employeePermissionsResponse;

  Future<EmployeePermissionsResponse?> getAllPermissions()async{
    employeePermissionsResponse = await   EmployeesRepository.getPermissions();
    notifyListeners();
   return employeePermissionsResponse;
  }


}