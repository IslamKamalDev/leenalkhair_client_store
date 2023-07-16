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

class StoreStockInSupplierScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StoreStockInSupplierScreenState();
  }
}

class StoreStockInSupplierScreenState
    extends State<StoreStockInSupplierScreen> {
  var po_numberFormKey = GlobalKey<FormState>();
  var storeStockInSupplierScaffoldKey = GlobalKey<ScaffoldState>();

  var po_numberController = TextEditingController();
  var warehouse_numController = TextEditingController();
  var client_nameController = TextEditingController();
  FocusNode fieldFocus = FocusNode();
  TextEditingController dateinput = TextEditingController();
  String? tax;
  String? currency;

  @override
  void initState() {
    String formattedDate = ui.DateFormat('yyyy-MM-dd').format(DateTime.now());
    dateinput.text = formattedDate;
    super.initState();
  }

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
              title:  Shared.stock_type == "purchases"
                  ? kpurchase_products : kstock_out,
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
                          Shared.stock_type == "purchases"
                              ? Column(
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
                              : Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ScreenUtil().screenWidth * 0.05,
                                        ),
                                        child: CustomInvoiceIdDropDown(
                                          hint: kinvoice_id.tr(),
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                          ScreenUtil().screenWidth * 0.05,
                                          vertical:
                                          ScreenUtil().screenWidth * 0.05,
                                        ),
                                        child: TextFormField(
                                      controller: client_nameController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return kclient_name_message.tr();
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.text,
                                      focusNode: fieldFocus,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 10),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: kclient_name.tr(),
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5.0),
                                          ),
                                        ),
                                      ),
                                    ))
                                  ],
                                ),
                          Shared.stock_type == "purchases"
                              ? Column(
                                  children: [
                                    /*       Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().screenWidth * 0.05,
                                    vertical: ScreenUtil().screenWidth * 0.05,
                                  ),
                                  child:  TextFormField(
                                    controller: warehouse_numController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return kwarehouse_no_message.tr();
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    focusNode: fieldFocus,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: kwarehouse_no.tr(),
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5.0),
                                        ),
                                      ),
                                    ),
                                  )

                              ),*/

                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ScreenUtil().screenWidth * 0.05,
                                          vertical:
                                              ScreenUtil().screenWidth * 0.1,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "${kpurchase_date.tr()}",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                )),
                                            Expanded(
                                                flex: 2,
                                                child: TextField(
                                                  controller: dateinput,
                                                  textAlign: TextAlign.center,
                                                  decoration:
                                                      new InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.grey,
                                                              width: 0.0),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.grey,
                                                              width: 0.0),
                                                    ),
                                                  ),
                                                  readOnly: true,
                                                  onTap: () async {
                                                    DateTime? pickedDate =
                                                        await showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                DateTime.now(),
                                                            firstDate: DateTime(
                                                                2000), //DateTime.now() - not to allow to choose before today.
                                                            lastDate:
                                                                DateTime(2101));

                                                    if (pickedDate != null) {
                                                      print(
                                                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                      String formattedDate =
                                                          ui.DateFormat(
                                                                  'yyyy-MM-dd')
                                                              .format(
                                                                  pickedDate);
                                                      print(
                                                          formattedDate); //formatted date output using intl package =>  2021-03-16
                                                      //you can implement different kind of Date Format here according to your requirement

                                                      setState(() {
                                                        dateinput.text =
                                                            formattedDate; //set output date to TextField value.
                                                      });
                                                    } else {
                                                      print(
                                                          "Date is not selected");
                                                    }
                                                  },
                                                )),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ScreenUtil().screenWidth * 0.05,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                kTax.tr(),
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 2,
                                                child: RadioListTile(
                                                  title: Text(kyes.tr()),
                                                  value: "yes",
                                                  groupValue: tax,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      tax = value.toString();
                                                    });
                                                  },
                                                )),
                                            Expanded(
                                                flex: 2,
                                                child: RadioListTile(
                                                  title: Text(kno.tr()),
                                                  value: "no",
                                                  groupValue: tax,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      tax = value.toString();
                                                    });
                                                  },
                                                )),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ScreenUtil().screenWidth * 0.05,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                kcurrency_type.tr(),
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 2,
                                                child: RadioListTile(
                                                  title: Text("currency".tr()),
                                                  value: "sar",
                                                  groupValue: currency,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      currency =
                                                          value.toString();
                                                    });
                                                  },
                                                )),
                                            Expanded(
                                                flex: 2,
                                                child: RadioListTile(
                                                  title: Text(kdollar.tr()),
                                                  value: "dollar",
                                                  groupValue: currency,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      currency =
                                                          value.toString();
                                                    });
                                                  },
                                                )),
                                          ],
                                        )),
                                  ],
                                )
                              : Container(),
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
