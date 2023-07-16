import 'package:flutter/cupertino.dart';
import 'package:leen_alkhier_store/data/models/general_model.dart';
import 'package:leen_alkhier_store/repos/employees_repo.dart';

class AddEmployeeProvider extends ChangeNotifier{
  GeneralModel? generalModel;

  Future<GeneralModel?> saveEmployeeFun(
      {var employee_id,var first_name,var last_name , var email
        , var mobile_number , var city_id , var business_info_id ,  required List branches , required List permissions , var type}) async {
    generalModel =  await EmployeesRepository.saveEmployee(
      employee_id: employee_id,
        business_info_id: business_info_id,
        branches: branches,
        city_id: city_id,
        email: email,
        first_name: first_name,
        last_name: last_name,
        mobile_number: mobile_number,
        permissions: permissions,
      type: type
    );
    notifyListeners();
    return generalModel;
  }
}