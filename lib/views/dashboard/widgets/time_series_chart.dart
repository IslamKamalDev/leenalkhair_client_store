import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/main.dart';
import 'package:leen_alkhier_store/providers/Dashboard/dashboard_pages_provider.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

class SimpleTimeSeriesChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SimpleTimeSeriesChartState();
  }
}

class SimpleTimeSeriesChartState extends State<SimpleTimeSeriesChart> {
  @override
  Widget build(BuildContext context) {
    List<ChartData> chartData = [];
    var dashboard_pages_provider = Provider.of<DashboardPageProvider>(context);
    dashboard_pages_provider.dashboardAnalysisResponse!.receivedOrdersDays!
        .forEach((element) {
      chartData.add(ChartData(
          '${element.month.toString().tr()}',
          double.parse(element.count.toString())));
    });

    chartData.sort((a, b) => a.y.toString().compareTo(b.y.toString()));

    return chartData.isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    translator
                        .translate(kOrders_based_on_days),
                    style: TextStyle(
                        color: CustomColors.BLACK_COLOR,
                        fontWeight: FontWeight.bold),
                  )),
              Directionality(
                  textDirection: TextDirection.ltr,
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.5,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),

                    // )
                  )),
            ],
          );
  }
}

class ChartData {
  String? x;
  double? y;
  ChartData(this.x, this.y);
}
