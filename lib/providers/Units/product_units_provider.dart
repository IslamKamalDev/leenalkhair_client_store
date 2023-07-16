import 'package:flutter/cupertino.dart';
import 'package:leen_alkhier_store/data/responses/Units/contract_product_unit_response.dart';
import 'package:leen_alkhier_store/data/responses/Units/remove_product_unit_response.dart';
import 'package:leen_alkhier_store/repos/units_repository.dart';

class ProductUnitsProvider extends ChangeNotifier{
   ContractProductUnitResponse? contractProductUnitResponse;
   Data? selectd_unit;



   Future<void> getContractProductUnits(
       {String? contract_id , String? product_id,String? branch_id}) async {
     contractProductUnitResponse = await UnitsRepository.getContractProductUnits(
         product_id: product_id,
       contract_id: contract_id,
       branch_id: branch_id
     );
     print("contractProductUnitResponse : ${contractProductUnitResponse!.toJson()}");
     notifyListeners();
   }

   void changeUnit(Data? unit) {
     selectd_unit = unit;
     notifyListeners();
   }

   Future<RemoveProductUnitResponse> removeProductUnit(
       {String? contract_id , String? product_id,String? unit_id}) async {

     return await UnitsRepository.remove_product_unit(
         product_id: product_id,
         contract_id: contract_id,
         unit_id: unit_id
     );
   }

}