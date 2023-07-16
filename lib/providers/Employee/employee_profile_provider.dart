import 'package:flutter/cupertino.dart';
import 'package:leen_alkhier_store/data/responses/Employee/employee_profile_response.dart';
import 'package:leen_alkhier_store/repos/employees_repo.dart';

class EmployeeProfileProvider extends ChangeNotifier{
  EmployeeProfileResponse? employeeProfileResponse;
  Branches? selectedBranch;

  Future<EmployeeProfileResponse?> get_employee_profile_data({var emp_id})async{
    employeeProfileResponse =   await EmployeesRepository.getEmployeeProfileData(
      employee_id: emp_id
    );
    return employeeProfileResponse;
  }

  void changeBranch(Branches branch) {
    selectedBranch = branch;
    notifyListeners();
  }

}