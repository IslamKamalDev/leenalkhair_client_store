import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leen_alkhier_store/data/responses/Dashboard/dashboard_analysis_response.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/providers/Dashboard/dashboard_pages_provider.dart';
import 'package:leen_alkhier_store/providers/Employee/all_employees_provider.dart';
import 'package:leen_alkhier_store/providers/contract_info_provider.dart';
import 'package:leen_alkhier_store/utils/Shared.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/dashboard/widgets/branch_checkbox_list.dart';
import 'package:leen_alkhier_store/views/dashboard/widgets/column_chart.dart';
import 'package:leen_alkhier_store/views/dashboard/widgets/contract_radio_list.dart';
import 'package:leen_alkhier_store/views/dashboard/widgets/time_series_chart.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

class DashboardAnalysisScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DashboardAnalysisScreenState();
  }
}

class DashboardAnalysisScreenState extends State<DashboardAnalysisScreen> {
  List<String> branch_id_list = [];

  @override
  void initState() {
    var contractInfoProvider =
        Provider.of<ContractInfoProvider>(context, listen: false);
    var dashboardPagesProvider =
        Provider.of<DashboardPageProvider>(context, listen: false);

    Provider.of<AllEmployeesProvider>(context, listen: false)
        .businessBranchesResponse!
        .branches!
        .forEach((element) {
      if (element.id.toString() != "0")
        branch_id_list.add(element.id.toString());
    });
    contractInfoProvider.getContract().then((value) {
      value!.data!.forEach((element) {
        if (element.status == "Approved") {
          Shared.contract_id = element.id.toString();
          dashboardPagesProvider.getDashboardStatistics(
              contract_id: Shared.contract_id, branch_id: branch_id_list);
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    Shared.chossed_branches = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var dashboardPagesProvider = Provider.of<DashboardPageProvider>(context);

    // TODO: implement build
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Directionality(
                textDirection: MyMaterial.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                child:dashboardPagesProvider.dashboardAnalysisResponse == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(14)),
                            height: ScreenUtil().screenHeight * 0.75,
                            child: SingleChildScrollView(
                                child: Column(
                              children: [
                                select_branch_or_contract_widget(),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                      children: [
                                        dashboard_item_shape(
                                            title: translator
                                                .translate(kPurchases),
                                            amount:
                                                "${dashboardPagesProvider.dashboardAnalysisResponse!.purchases}",
                                            color: Color(0xFFF0F3FD)),
                                        dashboard_item_shape(
                                            title: translator
                                                .translate(kTax),
                                            amount:
                                                "${dashboardPagesProvider.dashboardAnalysisResponse!.taxes}",
                                            color: Color(0xFFECFAFC)),
                                        dashboard_item_shape(
                                            title: translator
                                                .translate(kReturns),
                                            amount:
                                                "${dashboardPagesProvider.dashboardAnalysisResponse!.returnes}",
                                            color: Color(0xFFF4F4F4)),
                                      ],
                                    )),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 5),
                                          decoration: BoxDecoration(
                                              color: Color(0xFFE5F6F1),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                translator
                                                    .translate(korder_count)!,
                                                style: TextStyle(
                                                  color:
                                                      CustomColors.BLACK_COLOR,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "${dashboardPagesProvider.dashboardAnalysisResponse!.ordersNumber}",
                                                style: TextStyle(
                                                    color: CustomColors
                                                        .BLACK_COLOR,
                                                    fontSize: 20),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                dashboardPagesProvider.dashboardAnalysisResponse!.ordersNumber == 0
                                    ? Container()
                                    : Selector<DashboardPageProvider,
                                            DashboardAnalysisResponse?>(
                                        selector: (_, provider) =>
                                            provider.dashboardAnalysisResponse,
                                        builder: (context, number2, child) {
                                          return ColumnChart();
                                        }),

                                dashboardPagesProvider.dashboardAnalysisResponse!.ordersNumber ==
                                        0
                                    ? Container()
                                    : Selector<DashboardPageProvider,
                                            DashboardAnalysisResponse?>(
                                        selector: (_, provider) =>
                                            provider.dashboardAnalysisResponse,
                                        builder: (context, number2, child) {
                                          return SimpleTimeSeriesChart();
                                        }),

                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  children: [
                                    best_Products_Request(
                                      title: translator
                                          .translate(kBest_Products_Request),
                                    ),
                                    branch_requests(
                                      title: translator
                                          .translate(kBranch_requests),
                                    ),
                                    requests_at_the_city_level(
                                      title: translator
                                          .translate(
                                              kTotal_requests_at_the_city_level),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.2,
                                )
                              ],
                            )))
                      ]),
                    )))));
  }

  Widget dashboard_item_shape({var title, required var amount, Color? color}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$title",
              style: TextStyle(
                  color: CustomColors.BLACK_COLOR, fontWeight: FontWeight.bold),
            ),
            Text(
              "${double.parse(amount).toStringAsFixed(2)} ${"SAR".tr()}",
              style: TextStyle(color: CustomColors.BLACK_COLOR),
            ),
          ],
        ),
      ),
    );
  }

  Widget best_Products_Request({var title}) {
    var dashboardPagesProvider = Provider.of<DashboardPageProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title",
          style: TextStyle(
              color: CustomColors.BLACK_COLOR, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                                "${kproduct.tr()}"))),
                    Expanded(
                        flex: 2,
                        child: Text(
                            "${kquantity.tr()}")),
                    Expanded(
                        child: Text(
                            "${kprice.tr()}"))
                  ],
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1.0,
                ),
                dashboardPagesProvider
                        .dashboardAnalysisResponse!.products!.isEmpty
                    ? Center(
                        child: Text(translator
                            .translate("no_products")!),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: dashboardPagesProvider
                            .dashboardAnalysisResponse!.products!.length,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: EdgeInsets.symmetric(vertical: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                            "${translator.activeLanguageCode == 'ar' ? dashboardPagesProvider.dashboardAnalysisResponse!.products![index].name!.ar : dashboardPagesProvider.dashboardAnalysisResponse!.products![index].name!.en}"),
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                          "${dashboardPagesProvider.dashboardAnalysisResponse!.products![index].quantity}")),
                                  Expanded(
                                      child: Text(
                                          "${dashboardPagesProvider.dashboardAnalysisResponse!.products![index].total}"))
                                ],
                              ));
                        })
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget branch_requests({var title}) {
    var dashboardPagesProvider = Provider.of<DashboardPageProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title",
          style: TextStyle(
              color: CustomColors.BLACK_COLOR, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                                "${kbranch.tr()}"))),
                    Expanded(
                        flex: 2,
                        child: Text(
                            "${kquantity.tr()}")),
                    Expanded(
                        child: Text(
                            "${ktotal.tr()}"))
                  ],
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1.0,
                ),
                dashboardPagesProvider
                        .dashboardAnalysisResponse!.branches!.isEmpty
                    ? Center(
                        child: Text(translator
                            .translate("no_branches")!),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: dashboardPagesProvider
                            .dashboardAnalysisResponse!.branches!.length,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                          "${dashboardPagesProvider.dashboardAnalysisResponse!.branches![index].name}"),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                        "${dashboardPagesProvider.dashboardAnalysisResponse!.branches![index].quantity}")),
                                Expanded(
                                    child: Text(
                                        "${dashboardPagesProvider.dashboardAnalysisResponse!.branches![index].total}"))
                              ],
                            ),
                          );
                        })
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget requests_at_the_city_level({var title}) {
    var dashboardPagesProvider = Provider.of<DashboardPageProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title",
          style: TextStyle(
              color: CustomColors.BLACK_COLOR, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                                "${kcity.tr()}"))),
                    Expanded(
                        flex: 2,
                        child: Text(
                            "${korder_number.tr()}")),
                    Expanded(
                        child: Text(
                            "${ktotal.tr()}"))
                  ],
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1.0,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: dashboardPagesProvider
                        .dashboardAnalysisResponse!.cities!.length,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: EdgeInsets.symmetric(vertical: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                        "${dashboardPagesProvider.dashboardAnalysisResponse!.cities![index].name}"),
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                      "${dashboardPagesProvider.dashboardAnalysisResponse!.cities![index].numberOrders}")),
                              Expanded(
                                  child: Text(
                                      "${dashboardPagesProvider.dashboardAnalysisResponse!.cities![index].total}"))
                            ],
                          ));
                    })
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget select_branch_or_contract_widget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomRoundedButton(
              fontSize: 13,
              backgroundColor: CustomColors.WHITE_COLOR,
              borderColor: CustomColors.PRIMARY_GREEN,
              height: MediaQuery.of(context).size.width * 0.08,
              pressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          backgroundColor: Colors.transparent,
                          contentPadding: EdgeInsets.all(0),
                          insetPadding: EdgeInsets.all(20),
                          content: CheckBoxInListView(),
                        ));
              },
              text: kselect_branch,
              textColor: Colors.black,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: CustomRoundedButton(
              fontSize: 13,
              borderColor: CustomColors.PRIMARY_GREEN,
              backgroundColor: CustomColors.WHITE_COLOR,
              height: MediaQuery.of(context).size.width * 0.08,
              pressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          backgroundColor: Colors.transparent,
                          contentPadding: EdgeInsets.all(0),
                          insetPadding: EdgeInsets.all(20),
                          content: ContractRadioList(),
                        ));
              },
              text: kselect_contract,
              textColor: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y1);
  final int x;
  final double y;
  final double y1;
}
