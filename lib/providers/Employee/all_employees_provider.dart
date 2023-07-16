
import 'package:flutter/cupertino.dart';
import 'package:leen_alkhier_store/data/models/tokenPermissionsResponse.dart';
import 'package:leen_alkhier_store/data/responses/Branch/business_branches_response.dart';
import 'package:leen_alkhier_store/data/responses/Employee/all_employees_response.dart';
import 'package:leen_alkhier_store/repos/employees_repo.dart';

class AllEmployeesProvider extends ChangeNotifier{

  AllEmployeesListResponse? allEmployeesListResponse;
  late TokenPermissionsResponse tokenPermissionsRespnse;
  BusinessBranchesResponse? businessBranchesResponse;
  var selected_employee_branch_id;
  var selected_employee_branch_name;

  Branches? selectedBranch;

  void changeSelected_employee_branch({String? branch_id , String? branch_name}) {
    selected_employee_branch_id = branch_id;
    selected_employee_branch_name = branch_name;
    notifyListeners();
  }

  Future<AllEmployeesListResponse?> getAllEmployees()async{
    allEmployeesListResponse = await   EmployeesRepository.getEmployeesList();
    return allEmployeesListResponse;
  }

  Future<void> setUserPermissons({required var token}) async {
    await EmployeesRepository.decodeTokenForPermissons(token).then((value) {
      tokenPermissionsRespnse = value;
      tokenPermissionsRespnse.permissions!.forEach((element) {
        print("permission : ${element.name}");
      });

      notifyListeners();
    });
  }

  Future<void> remove_employee({var employee_id, var employee_status}) async {
    await EmployeesRepository.deleteEmployee(
      employee_id: employee_id,
      employee_status: employee_status
    );
    notifyListeners();
  }

  Future<BusinessBranchesResponse?> getEmployeeBranches()async{
    businessBranchesResponse = await EmployeesRepository.get_employee_branches();

    notifyListeners();
    return businessBranchesResponse;
  }


  clearBusinessBranches() {
    businessBranchesResponse!.branches!.clear();
    notifyListeners();
  }

  void changeBranch(Branches? branch) {
    selectedBranch = branch;
    notifyListeners();
  }

}