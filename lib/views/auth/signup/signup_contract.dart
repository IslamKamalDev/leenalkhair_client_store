import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:leen_alkhier_store/data/requests/contract_register_request.dart';
import 'package:leen_alkhier_store/data/responses/Pricing/contract_pricing_type_response.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/providers/Employee/all_employees_provider.dart';
import 'package:leen_alkhier_store/providers/Pricing/contract_pricing_provider.dart';
import 'package:leen_alkhier_store/providers/contract_products_cart_provider.dart';
import 'package:leen_alkhier_store/providers/create_contract_provider.dart';
import 'package:leen_alkhier_store/providers/delivery_timing_duration_provider.dart';
import 'package:leen_alkhier_store/providers/get/orderViewModel.dart';
import 'package:leen_alkhier_store/providers/user_all_contract_orders_provider.dart';
import 'package:leen_alkhier_store/utils/TokenUtil.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:leen_alkhier_store/views/widgets/signup_header.dart';
import 'package:leen_alkhier_store/views/widgets/title_text.dart';
import 'package:leen_alkhier_store/views/widgets/welcome_dialog.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

import '../../../utils/local_const.dart';

class SignupContract extends StatefulWidget {
  @override
  _SignupContractState createState() => _SignupContractState();
}

class _SignupContractState extends State<SignupContract> {
  final GlobalKey<ScaffoldState> signupContractScaffoldKey =
      GlobalKey<ScaffoldState>();

  bool pricing_method_status = false;
  String? pricing_method_en;
  String? pricing_method_ar;
  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    var contractProvider =
        Provider.of<CreateContractProvider>(context, listen: false);
    Future.delayed(Duration(seconds: 0), () {
      contractProvider.clear();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userAllContractOrderProvider =
        Provider.of<UserAllContractOrderProvider>(context, listen: false);
    final OrderViewModel orderController = Get.put(OrderViewModel());

    var contractProductProvider =
        Provider.of<ContractProductCartProductItemProvider>(context);

    var deliveryProvider = Provider.of<DeliveryTimingDurationProvider>(context);
    var contractProvider = Provider.of<CreateContractProvider>(context);
    var contractPricingProvider = Provider.of<ContractPricingProvider>(context);

    return Scaffold(
      key: signupContractScaffoldKey,
      backgroundColor: CustomColors.GREY_COLOR_A,
      appBar : CustomViews.appBarWidget(
        context: context,
        title:kCreate_a_contract,
      ),
      body: Directionality(
        textDirection: MyMaterial.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child:GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(14)),
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TitleWithImage(
                                icon: ImageAssets.contractAdd,
                                text: translator
                                    .translate(kcontract_info),
                                iconcolor: CustomColors.WHITE_COLOR,
                                backgroundcolor2: CustomColors.PRIMARY_GREEN,
                              ),
                              //
                              Column(
                                children: [
                                  Container(
                                    height: 1,
                                    width: 90.w,
                                    color: CustomColors.GREY_COLOR,
                                  ),
                                  Text("")
                                ],
                              ),
                              TitleWithImage(
                                icon: ImageAssets.productsinfo,
                                text: translator
                                    .translate(kproduct_info)!,
                                iconcolor: CustomColors.BLACK_COLOR,
                                backgroundcolor2: CustomColors.WHITE_COLOR,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: CustomRoundedButton(
                                  isKey: true,
                                  fontSize: 15,
                                  backgroundColor: Colors.white,
                                  borderColor: CustomColors.GREY_LIGHT_B_COLOR,
                                  textColor: CustomColors.PRIMARY_GREEN,
                                  pressed: () {
                                    DatePicker.showDatePicker(context,
                                        showTitleActions: true,
                                        locale:
                                        translator.activeLanguageCode == "ar"
                                                ? LocaleType.ar
                                                : LocaleType.en,
                                        minTime: DateTime.now(),
                                        onConfirm: (date) {
                                      contractProvider.setFromDate(date);
                                    });
                                  },
                                  icon: Icon(
                                    Icons.date_range,
                                    color: Colors.white,
                                  ),
                                  text: (contractProvider.fromDate == null)
                                      ? translator
                                          .translate(kContract_start_date)!
                                      : '${contractProvider.fromDate.toString().split(' ')[0]}',
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: CustomRoundedButton(
                                  isKey: true,
                                  fontSize: 15,
                                  backgroundColor: Colors.white,
                                  borderColor: CustomColors.GREY_LIGHT_B_COLOR,
                                  textColor: CustomColors.PRIMARY_GREEN,
                                  pressed: () {
                                    DatePicker.showDatePicker(context,
                                        showTitleActions: true,
                                        locale:
                                            translator.activeLanguageCode == "ar"
                                                ? LocaleType.ar
                                                : LocaleType.en,
                                        minTime: (contractProvider.fromDate ==
                                                null)
                                            ? DateTime.now()
                                                .add(Duration(days: 1))
                                            : contractProvider.fromDate!
                                                .add(Duration(days: 1)),
                                        onConfirm: (date) {
                                      contractProvider.setToDate(date);
                                    });
                                  },
                                  icon: Icon(
                                    Icons.date_range,
                                    color: Colors.white,
                                  ),
                                  text: (contractProvider.toDate == null)
                                      ? translator
                                          .translate(kContract_end_date)
                                      : '${contractProvider.toDate.toString().split(' ')[0]}',
                                ),
                              ),
                            ],
                          ),
                          // (contractProvider.fromDate == null)
                          //     ? SizedBox(
                          //         height: 15,
                          //       )
                          //     : Text(
                          //         '${contractProvider.fromDate.toString().split(' ')[0]}'),

                          // CustomRoundedButton(
                          //   fontSize: 15,
                          //   backgroundColor: Colors.white,
                          //   borderColor: CustomColors.PRIMARY_GREEN,
                          //   textColor: CustomColors.PRIMARY_GREEN,
                          //   pressed: () {
                          //     DatePicker.showDatePicker(context,
                          //         showTitleActions: true,
                          //         locale: local.locale.languageCode == "ar"
                          //             ? LocaleType.ar
                          //             : LocaleType.en,
                          //         minTime: (contractProvider.fromDate == null)
                          //             ? DateTime.now().add(Duration(days: 1))
                          //             : contractProvider.fromDate!
                          //                 .add(Duration(days: 1)),
                          //         onConfirm: (date) {
                          //       contractProvider.setToDate(date);
                          //     });
                          //   },
                          //   icon: Icon(
                          //     Icons.date_range,
                          //     color: Colors.white,
                          //   ),
                          //   text: (contractProvider.toDate == null)
                          //       ? kContract_end_date
                          //       : '$kThe_end_date_set',
                          // ),
                          // (contractProvider.toDate == null)
                          //     ? Container()
                          //     : Text(
                          //         '${contractProvider.toDate.toString().split(' ')[0]}'),
                          SizedBox(
                            height: 20,
                          ),
                          contractProvider.deliveryDuration != null
                              ? Row(
                                  children: [
                                    Text(translator
                                        .translate(kDelivery_days)!),
                                  ],
                                )
                              : Container(),
                          Container(
                            height: ScreenUtil().setHeight(35),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: CustomColors.WHITE_COLOR,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: CustomColors.GREY_LIGHT_B_COLOR)),
                            child: DropdownButton(
                                value: contractProvider.deliveryDuration,
                                hint: Text(translator
                                    .translate(kDelivery_days)),
                                underline: Container(),
                                isExpanded: true,
                                items: deliveryProvider
                                    .deliveryDurationResponse.data!
                                    .map((e) => DropdownMenuItem(
                                          child: Text(e.name!),
                                          value: e,
                                        ))
                                    .toList(),
                                onChanged: (dynamic v) {
                                  contractProvider.changeDuration(v);
                                }),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          contractProvider.deliveryTiming != null
                              ? Row(
                                  children: [
                                    Text(translator
                                        .translate(kDelivery_time)!),
                                  ],
                                )
                              : Container(),

                          Container(
                            height: ScreenUtil().setHeight(35),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: CustomColors.WHITE_COLOR,
                                border: Border.all(
                                    color: CustomColors.GREY_LIGHT_B_COLOR)),
                            child: DropdownButton(
                                value: contractProvider.deliveryTiming,
                                hint: Text(translator
                                    .translate(kDelivery_time)),
                                underline: Container(),
                                isExpanded: true,
                                items: deliveryProvider
                                    .deliveryTimingResponse.data!
                                    .map((e) => DropdownMenuItem(
                                          child: Text(e.name!),
                                          value: e,
                                        ))
                                    .toList(),
                                onChanged: (dynamic v) {
                                  contractProvider.changeTiming(v);
                                }),
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          //get contact pricing types
                          Container(
                            height: ScreenUtil().setHeight(35),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: CustomColors.WHITE_COLOR,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: CustomColors.GREY_LIGHT_B_COLOR)),
                            child: DropdownButton(
                                value: contractPricingProvider.pricing_type,
                                hint: Text(translator
                                    .translate(kPricing_type)!),
                                underline: Container(),
                                isExpanded: true,
                                items: contractPricingProvider
                                    .contractPricingResponse!.data!
                                    .map((e) => DropdownMenuItem(
                                          child: Text(
                                              (translator.activeLanguageCode ==
                                                      'en')
                                                  ? e.name!
                                                  : e.nameAr!),
                                          value: e,
                                        ))
                                    .toList(),
                                onChanged: (Data? v) {
                                  contractPricingProvider.changePriceType(v);
                                  if (v!.id == 1) {
                                    setState(() {
                                      pricing_method_status = true;
                                    });
                                  } else {
                                    setState(() {
                                      pricing_method_status = false;
                                    });
                                  }
                                }),
                          ),

                          SizedBox(
                            height: 15,
                          ),

                          // get pricing types depend on Daily price lists
                          pricing_method_status
                              ? Container(
                                  height: ScreenUtil().setHeight(35),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: CustomColors.WHITE_COLOR,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color:
                                              CustomColors.GREY_LIGHT_B_COLOR)),
                                  child: (translator.activeLanguageCode == 'en')
                                      ? DropdownButton<String>(
                                          value: contractPricingProvider
                                              .pricing_method,
                                          hint: Text(
                                              translator
                                                  .translate(kPricing_method)),
                                          underline: Container(),
                                          isExpanded: true,
                                          items: contractPricingProvider
                                              .contractPricingMethodResponse
                                              .types!
                                              .subTypes!
                                              .map((e) => DropdownMenuItem(
                                                    child: Text(e!),
                                                    value: e,
                                                  ))
                                              .toList(),
                                          onChanged: (dynamic v) {
                                            contractPricingProvider
                                                .changePriceTypeMethod(v);
                                            pricing_method_en = contractPricingProvider
                                                .contractPricingMethodResponse
                                                .types!
                                                .subTypesAr!
                                                .elementAt(contractPricingProvider
                                                    .contractPricingMethodResponse
                                                    .types!
                                                    .subTypes!
                                                    .indexOf(v));
                                          })
                                      : DropdownButton<String>(
                                          value: contractPricingProvider
                                              .pricing_method,
                                          hint: Text(
                                              translator
                                                  .translate(kPricing_method)!),
                                          underline: Container(),
                                          isExpanded: true,
                                          items: contractPricingProvider
                                              .contractPricingMethodResponse
                                              .types!
                                              .subTypesAr!
                                              .map((e) => DropdownMenuItem(
                                                    child: Text(e!),
                                                    value: e,
                                                  ))
                                              .toList(),
                                          onChanged: (dynamic v) {
                                            contractPricingProvider
                                                .changePriceTypeMethod(v);

                                            pricing_method_ar = contractPricingProvider
                                                .contractPricingMethodResponse
                                                .types!
                                                .subTypes!
                                                .elementAt(contractPricingProvider
                                                    .contractPricingMethodResponse
                                                    .types!
                                                    .subTypesAr!
                                                    .indexOf(v));
                                          }),
                                )
                              : Container(),

                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: ScreenUtil().setHeight(35),
                            child: CustomRoundedButton(
                              fontSize: 15,
                              text: kCreate_a_contract,
                              textColor: Colors.white,
                              backgroundColor: CustomColors.PRIMARY_GREEN,
                              borderColor: CustomColors.PRIMARY_GREEN,
                              pressed: () async {
                                contractProductProvider.localStorageProducts =
                                    [];
                                contractProductProvider.allProducts = [];
                                orderController.orders2 = [];
                                userAllContractOrderProvider.orders2 = [];
                                if (validateInputs(
                                    context, signupContractScaffoldKey)) {
                                  CustomViews.showLoadingDialog(
                                      context: context);
                                  await contractProvider.createContract(
                                      CreateContractRequest(
                                          startDate: contractProvider.fromDate.toString().split(" ")[0],
                                          endDate: contractProvider.toDate.toString().split(" ")[0],
                                          deliveryTimeId: contractProvider.deliveryTiming!.id.toString(),
                                          deliveryDurationId: contractProvider.deliveryDuration!.id.toString(),
                                          pricing_type_id: contractPricingProvider.pricing_type!.id.toString(),
                                          pricing_sub_type: (translator.activeLanguageCode == 'en') ?
                                          contractPricingProvider.pricing_method : pricing_method_ar,
                                      pricing_sub_type_ar: (translator.activeLanguageCode == 'ar') ?
                                      contractPricingProvider.pricing_method : pricing_method_en)
                                  ).whenComplete(() => CustomViews.dismissDialog(context: context))
                                      .then((value) {
                                    if (contractProvider.contractRegisterResponse != null &&
                                        contractProvider.contractRegisterResponse!.status!) {
                                      CustomViews.showSnackBarView(
                                          title_status: true,
                                          message: ksuccessfully_recorded_data,
                                          backgroundColor: CustomColors.PRIMARY_GREEN,
                                          success_icon: true
                                      );
                                      Future.delayed(Duration(seconds: 1), () {
                                        //get and save user permissions
                                        var allEmployeesProvider = Provider.of<AllEmployeesProvider>(context, listen: false);
                                        allEmployeesProvider.setUserPermissons(
                                            token: TokenUtil.getTokenFromMemory());
                                        Navigator.pop(context);
                                        showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) =>
                                              WelcomeDialog(
                                            context: context,
                                          ),
                                        );
                                      });
                                    } else {
                                      CustomViews.showSnackBarView(
                                          title_status: false,
                                          backend_message: contractProvider.contractRegisterResponse!.message!,
                                          backgroundColor: CustomColors.RED_COLOR,
                                          success_icon: false
                                      );
                                      return;
                                    }
                                  });
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          )),)
    );
  }


  bool validateInputs(BuildContext context, var key) {
    var contractProvider =
        Provider.of<CreateContractProvider>(context, listen: false);

    if (contractProvider.fromDate == null) {

      CustomViews.showSnackBarView(
          title_status: false,
          message: kRenew_the_contract_start_date,
          backgroundColor: CustomColors.RED_COLOR,
          success_icon: false
      );

      return false;
    }
    if (contractProvider.toDate == null) {
      CustomViews.showSnackBarView(
          title_status: false,
          message: kRenew_the_contract_end_date,
          backgroundColor: CustomColors.RED_COLOR,
          success_icon: false
      );


      return false;
    }

    if (contractProvider.toDate!.isBefore(contractProvider.fromDate!)) {
      CustomViews.showSnackBarView(
          title_status: false,
          message: kThe_contract_end_date_is_incorrect,
          backgroundColor: CustomColors.RED_COLOR,
          success_icon: false
      );

      return false;
    }
    if (contractProvider.deliveryDuration == null) {
      CustomViews.showSnackBarView(
          title_status: false,
          message: kSelect_the_delivery_days,
          backgroundColor: CustomColors.RED_COLOR,
          success_icon: false
      );
      return false;
    }
    if (contractProvider.deliveryTiming == null) {
      CustomViews.showSnackBarView(
          title_status: false,
          message: kSelect_the_delivery_times,
          backgroundColor: CustomColors.RED_COLOR,
          success_icon: false
      );

      return false;
    }
    return true;
  }
}
