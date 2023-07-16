import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:intl/intl.dart' as ui;
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/providers/category_provider.dart';
import 'package:leen_alkhier_store/providers/home_tabs_provider.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/Store/Widgets/custom_financial_configuration_dropdpwn.dart';
import 'package:leen_alkhier_store/views/Store/Widgets/custom_invoice_id_dropdpwn.dart';
import 'package:leen_alkhier_store/views/Store/Widgets/custom_supplier_name_dropdpwn.dart';
import 'package:leen_alkhier_store/views/Store/Widgets/custom_warehouse_no_dropdpwn.dart';
import 'package:leen_alkhier_store/views/auth/signup/Create_products.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:leen_alkhier_store/views/widgets/custom_textfield.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

import '../../utils/Shared.dart';

class StockOnScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StockOnScreenState();
  }
}

class StockOnScreenState
    extends State<StockOnScreen> {
  var po_numberFormKey = GlobalKey<FormState>();
  var storeStockInSupplierScaffoldKey = GlobalKey<ScaffoldState>();

  FocusNode fieldFocus = FocusNode();


  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: MyMaterial.app_langauge == 'ar'
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Scaffold(
            key: storeStockInSupplierScaffoldKey,
            backgroundColor: CustomColors.GREY_COLOR_A,
            appBar: CustomViews.appBarWidget(
              context: context,
              title:   kstock_on,
            ),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                children: [
                  Form(
                      key: po_numberFormKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: ScreenUtil().screenWidth * 0.05,
                          ),
                          Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                    ScreenUtil().screenWidth * 0.05,
                                  ),
                                  child: CustomSupplierNameDropDown(
                                    hint: ksupplier_name.tr(),
                                  )),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                    ScreenUtil().screenWidth * 0.05,
                                    vertical:
                                    ScreenUtil().screenWidth * 0.05,
                                  ),
                                  child: CustomWarehouseNoDropDown(
                                    hint: kwarehouse_no.tr(),
                                  )),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                    ScreenUtil().screenWidth * 0.05,
                                    //      vertical:  ScreenUtil().screenWidth * 0.05,
                                  ),
                                  child:
                                  CustomFinancialConfigurationDropDown(
                                    hint: kfinancial_configuration.tr(),
                                  )),
                            ],
                          )

                        ],
                      )),
                  Expanded(
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              alignment: Alignment.center,
                              height: ScreenUtil().setHeight(40),
                              child: CustomRoundedButton(
                                fontSize: 15,
                                text: knext,
                                width: ScreenUtil().screenWidth * 0.90,
                                textColor: Colors.white,
                                backgroundColor: CustomColors.BLACK_COLOR,
                                borderColor: CustomColors.BLACK_COLOR,
                                pressed: () async {
                                  if (po_numberFormKey.currentState!
                                      .validate() /*&&
                                      validateInputs(context,
                                          scaffoldKey:
                                              storeStockInSupplierScaffoldKey,
                                          ctx: context)*/) {
                                    var homeTabsProvider =
                                    Provider.of<HomeTabsProvider>(context,
                                        listen: false);
                                    var categoriesProvider =
                                    Provider.of<CategoryProvider>(context,
                                        listen: false);
                                    categoriesProvider.getAllCategories();
                                    homeTabsProvider.setCategory(
                                        categoriesProvider
                                            .allCategoriesResponse!.data!
                                            .firstWhere((element) =>
                                        element.id ==
                                            (homeTabsProvider
                                                .categoryModel ==
                                                null
                                                ? 1
                                                : homeTabsProvider
                                                .categoryModel!.id!)));

                                    CustomViews.navigateTo(
                                        context,
                                        CreateProducts(
                                          islogin: false,
                                          title: kproduct_register.tr() +
                                              " - ${Shared.supplier_name??''}",
                                        ),
                                        "Create Products");
                                  }
                                },
                              ),
                            ),
                          )))
                ],
              ),
            )));
  }

  bool validateInputs(BuildContext context,
      {var scaffoldKey, required var ctx}) {
    if (Shared.supplier_name == null) {
      CustomViews.showSnackBarView(
          title_status: false,
          message: ksupplier_name_message.tr(),
          backgroundColor: CustomColors.RED_COLOR,
          success_icon: false);

      return false;
    }
    return true;
  }
}
