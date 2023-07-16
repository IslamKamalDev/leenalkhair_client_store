import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:intl/intl.dart' as ui;
import 'package:leen_alkhier_store/data/responses/Branch/business_branches_response.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/providers/Branch/business_branches_provider.dart';
import 'package:leen_alkhier_store/providers/Employee/all_employees_provider.dart';
import 'package:leen_alkhier_store/providers/Orders/orders_providers.dart';
import 'package:leen_alkhier_store/providers/contract_info_provider.dart';

import 'package:leen_alkhier_store/providers/contract_products_cart_provider.dart';
import 'package:leen_alkhier_store/providers/contract_products_provider.dart';
import 'package:leen_alkhier_store/providers/get/draftOrderViewModel.dart';
import 'package:leen_alkhier_store/providers/get/orderViewModel.dart';
import 'package:leen_alkhier_store/providers/user_all_contract_orders_provider.dart';
import 'package:leen_alkhier_store/providers/user_info_provider.dart';
import 'package:leen_alkhier_store/utils/Constants.dart';

import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/Store/Orders/stock_orders_screen.dart';
import 'package:leen_alkhier_store/views/index_screens/order_screens/BranchListBottomSheet.dart';
import 'package:leen_alkhier_store/views/index_screens/order_screens/all_orders.dart';
import 'package:leen_alkhier_store/views/index_screens/order_screens/draft_orders.dart';
import 'package:leen_alkhier_store/views/widgets/branch_list_radio.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';

import 'package:leen_alkhier_store/views/widgets/empty_widget.dart';
import 'package:leen_alkhier_store/views/widgets/order_item.dart';
import 'package:leen_alkhier_store/views/widgets/orders_branch_selector.dart';
import 'package:leen_alkhier_store/views/widgets/signup_header.dart';
import 'package:leen_alkhier_store/utils/sized_config.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class Orders extends StatefulWidget {
  final String? type;
  final int? tabNum;
  Orders({this.type, this.tabNum});
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  ScrollController scrollController = ScrollController();
  final OrderViewModel orderController = Get.put(OrderViewModel());
  final DraftOrderViewModel draftorderController =
      Get.put(DraftOrderViewModel());

  bool currentOrdersFound = false;
  bool firstFound = false;
  Future<BusinessBranchesResponse>? employee_branches;
  SharedPreferences? sharedPreferences;

  bool Confirme_Orders_status = false;
  TextEditingController dateinput = TextEditingController();
  //text editing controller for text field

  @override
  void initState() {
    String formattedDate = ui.DateFormat('yyyy-MM-dd').format(DateTime.now());
    dateinput.text = formattedDate; //set the initial value of text field

    var allEmployeesProvider =
        Provider.of<AllEmployeesProvider>(context, listen: false);
    allEmployeesProvider.tokenPermissionsRespnse.permissions!
        .forEach((element) {
      if (element.name == "Confirme Orders") {
        Confirme_Orders_status = true;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    branchsID = [];
    SizeConfig().init(context);

    var userInfoProvider = Provider.of<UserInfoProvider>(context);
    var tabedProvider = Provider.of<OrderProvider>(context, listen: true);
    return Directionality(
        textDirection: MyMaterial.app_langauge == 'ar'
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            backgroundColor: CustomColors.GREY_COLOR_A,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: ScreenUtil.defaultSize.width * 0.03,
                  ),
                  date_selector(),
                  SizedBox(
                    height: ScreenUtil.defaultSize.width * 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InkWell(
                                  onTap: () {
                                    tabedProvider.setIndex(0);
                                  },
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.46,
                                      color: tabedProvider.tabNumber == 0
                                          ? CustomColors.WHITE_COLOR
                                          : CustomColors.GREY_COLOR_A,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            "${kstock_out.tr()}",
                                            style: tabedProvider.tabNumber == 0
                                                ? Theme.of(context)
                                                    .textTheme
                                                    .labelLarge
                                                : TextStyle(
                                                    // color: CustomColors.,
                                                    fontWeight:
                                                        FontWeight.normal),
                                          ),
                                        ],
                                      ))),
                            ),
                            Expanded(
                                child: InkWell(
                                    onTap: () {
                                      tabedProvider.setIndex(1);
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.46,
                                        color: tabedProvider.tabNumber == 1
                                            ? CustomColors.WHITE_COLOR
                                            : CustomColors.GREY_COLOR_A,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              "${kpurchase.tr()}",
                                              style: tabedProvider.tabNumber ==
                                                      1
                                                  ? Theme.of(context)
                                                      .textTheme
                                                      .labelLarge
                                                  : TextStyle(
                                                      color: CustomColors
                                                          .GREY_COLOR,
                                                      fontWeight:
                                                          FontWeight.normal),
                                            ),
                                          ],
                                        )))),
                          ],
                        ),
                        Container(
                          height: 5,
                          color: CustomColors.PRIMARY_GREEN,
                          // width: 25.w,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  tabedProvider.tabNumber == 0
                      ? StockOrdersScreen(
                          type: "purchases",
                        )
                      : StockOrdersScreen(
                          type: "stock_out",
                        ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget date_selector() {
    return InkWell(
            onTap: () {
              showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${kselect_date.tr()}",
                        style: TextStyle(
                            color: CustomColors.PRIMARY_GREEN,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),

                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Center(
                              child: TextField(
                            controller: dateinput,
                            textAlign: TextAlign.center,
                            decoration: new InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 0.0),
                              ),
                              border: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 0.0),
                              ),
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(
                                      2000), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101));

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    ui.DateFormat('yyyy-MM-dd')
                                        .format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement

                                setState(() {
                                  dateinput.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                          ))),
                      SizedBox(
                        height: 15,
                      ),
                      // Spacer(),
                      Container(
                        height: ScreenUtil().setHeight(45),
                        child: CustomRoundedButton(
                          fontSize: 15,
                          text: kadd.tr(),
                          textColor: CustomColors.WHITE_COLOR,
                          backgroundColor: CustomColors.PRIMARY_GREEN,
                          borderColor: CustomColors.PRIMARY_GREEN,
                          pressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // dontHaveAnAccount()
                    ],
                  ),
                ),
              );


            },
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: ScreenUtil().setHeight(35),
                  //   width: MediaQuery.of(context).size.width * 0.75,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: CustomColors.WHITE_COLOR,
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(color: CustomColors.GREY_LIGHT_B_COLOR)),
                  child: Row(
                    children: [
                      //
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(dateinput.text),
                                  Row(
                                    children: [
                                      Icon(Icons.keyboard_arrow_down),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          // height: 40,
                                          width: 2,
                                          color:
                                              CustomColors.GREY_LIGHT_B_COLOR,
                                        ),
                                      ),
                                      Image.asset(ImageAssets.selectBranch),
                                    ],
                                  )
                                ]),
                          ))
                    ],
                  ),
                )),
          );
  }
}
