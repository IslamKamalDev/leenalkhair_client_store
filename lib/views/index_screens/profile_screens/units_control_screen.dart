import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leen_alkhier_store/data/responses/Units/contract_product_unit_response.dart';
import 'package:leen_alkhier_store/providers/Employee/all_employees_provider.dart';
import 'package:leen_alkhier_store/providers/Units/product_units_provider.dart';
import 'package:leen_alkhier_store/repos/units_repository.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/widgets/button_dialog.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

import '../../../main.dart';
class UnitsControlScreen extends StatefulWidget{
  String? contract_id;
  String? product_id;
  String? branch_id;
  UnitsControlScreen({this.contract_id,this.product_id,this.branch_id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UnitsControlScreenState();
  }

}

class UnitsControlScreenState extends State<UnitsControlScreen>{
  @override
  void initState() {

    var product_units_provider = Provider.of<ProductUnitsProvider>(context, listen: false);
    product_units_provider.selectd_unit = null;
    product_units_provider.getContractProductUnits(
        product_id: widget.product_id!.toString(),
        contract_id: widget.contract_id!.toString(),
      branch_id: widget.branch_id!.toString(),
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var allEmployeesProvider = Provider.of<AllEmployeesProvider>(context);

    var futureBuilder = new FutureBuilder<ContractProductUnitResponse>(
      future:   UnitsRepository.getContractProductUnits(
        product_id: widget.product_id!.toString(),
        contract_id: widget.contract_id!.toString(),
        branch_id: allEmployeesProvider.businessBranchesResponse!.branches!
            .firstWhere((element) => element.id != 0).id.toString(),
    ),
      builder: (ctx, snap) {
        switch (snap.connectionState) {
          case ConnectionState.none:
            return Center(
              child: Text(kNo_connection),
            );

          case ConnectionState.waiting:
            return Container(
              height: ScreenUtil.defaultSize.width,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case ConnectionState.active:

          case ConnectionState.done:
            return Padding(padding: EdgeInsets.all(20),
              child: snap.data!.data!.isEmpty ?
              Container(
                height: ScreenUtil.defaultSize.width,
                alignment: Alignment.center,
                child: Text(
                  translator.activeLanguageCode == "ar" ?  "لا توجد وحدات متاحة للمنتج" : "There are no units available for the product",
                  textAlign: TextAlign.center,
                ),
              )
              : ListView.builder(
                  itemCount: snap.data!.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {

                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: CustomColors.WHITE_COLOR,
                      ),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(10),
                          vertical: ScreenUtil().setWidth(5)),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 8,
                                child: Text(
                                  "${translator.activeLanguageCode== 'ar' ?
                                     snap.data!.data![index].nameAr
                                      : snap.data!.data![index].name}"
                                      " ${snap.data!.data![index].weight == 1 ? "" : snap.data!.data![index].weight}",
                                  style: TextStyle(
                                      color: CustomColors.GREY_COLOR,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: IconButton(
                                    onPressed: () {
                                      //Check If user has contract add and edit permission or not
                                      bool add_contract_status = false;
                                      var all_employees_provider = Provider.of<AllEmployeesProvider>(context, listen: false);


                                      all_employees_provider.tokenPermissionsRespnse.permissions!.forEach((element) {
                                        if (element.name == "add and edit contract") {
                                          add_contract_status = true;
                                        }
                                      });
                                      if (add_contract_status) {
                                        showAlertDialogx(
                                            context:context,
                                            product_unit_id:snap.data!.data![index].id.toString(),
                                        );
                                      } else {
                                        CustomViews.showSnackBarView(
                                            title_status: false,
                                            message: kno_permission,
                                            backgroundColor: CustomColors.RED_COLOR,
                                            success_icon: false
                                        );

                                      }
                                    },
                                    icon: Icon(
                                    Icons.cancel,
                                    color: Colors.redAccent,
                                  ),
                                  )
                              ),

                            ],
                          ),

                        ],
                      ),
                    );
                  }));

          default:
            return Container();
        }
      },
    );

    return Directionality(
        textDirection: MyMaterial.app_langauge == 'ar' ? ui.TextDirection.rtl : ui.TextDirection.ltr,
        child: Scaffold(
        appBar : CustomViews.appBarWidget(
          context: context,
          title:kUints,
        ),

        body: SafeArea(
          child: SingleChildScrollView(
          child: futureBuilder


      ),
        ) ));
  }


  showAlertDialogx({BuildContext? context ,String? product_unit_id}) {

    // set up the buttons
    Widget cancelButton = ButtonDialog(
      text1: translator.activeLanguageCode == 'ar' ? "لا":  'no',
      color: Colors.red,
      ontap: () {
        Get.back();
      },
    );

    Widget continueButton = ButtonDialog(
      text1: translator.activeLanguageCode == 'ar' ? "نعم" :  'yes',
      color: Colors.green,
      ontap: () async {
        CustomViews.dismissDialog(context: context!);
        CustomViews.showLoadingDialog(context: context);
        var product_units_provider = Provider.of<ProductUnitsProvider>(context,listen: false);
        product_units_provider.removeProductUnit(
            product_id : widget.product_id,
            unit_id:  product_unit_id,
            contract_id: widget.contract_id.toString()
        ).then((value){
          CustomViews.dismissDialog(context: context);
          setState(() {
          });

        });

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      title: Text(translator.activeLanguageCode == 'ar' ? "حذف الوحدات":  "Delete UNits",

          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      //delete_product_content_dialog
      content: Text(
          translator.activeLanguageCode == 'ar' ? " هل تريد حذف وحدة المنتج من العقد؟": " Do You Want To Delete Product unit ?",
       ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}