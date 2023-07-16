import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/src/text_style.dart' as style;
import 'package:charts_flutter/src/text_element.dart' as charts_text;
import 'package:leen_alkhier_store/providers/Dashboard/dashboard_pages_provider.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

class ColumnChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ColumnChartState();
  }
}

class ColumnChartState extends State<ColumnChart> {
  bool? show_chart;
  @override
  Widget build(BuildContext context) {
    List<BarChartModel> data = [];
    var dashboardPagesProvider =
        Provider.of<DashboardPageProvider>(context, listen: false);

    dashboardPagesProvider.dashboardAnalysisResponse!.receivedOrders!
        .forEach((element) {
      data.add(BarChartModel(
        year: "${element.month.toString().substring(0, 3)}",
        financial: element.count,
        color: charts.ColorUtil.fromDartColor(Colors.teal.shade200),
      ));
    });
    List<charts.Series<BarChartModel, String>> series = [
      charts.Series(
        id: "financial",
        data: data,
        domainFn: (BarChartModel series, _) => series.year!,
        measureFn: (BarChartModel series, _) => series.financial,
        colorFn: (BarChartModel series, _) => series.color!,
      ),
    ];

    return data.isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  translator
                      .translate(ktotal_order_received_based_on_months),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.width * 0.5,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: charts.BarChart(series, animate: true, behaviors: [
                  LinePointHighlighter(
                      symbolRenderer:
                          CustomCircleSymbolRenderer() // add this line in behaviours
                      )
                ], selectionModels: [
                  SelectionModelConfig(changedListener: (SelectionModel model) {
                    if (model.hasDatumSelection) {
                      final value = model.selectedSeries[0]
                          .measureFn(model.selectedDatum[0].index);
                      CustomCircleSymbolRenderer.value =
                          value.toString(); // paints the tapped value
                    }
                  })
                ]),
              )
            ],
          );
  }
}

class BarChartModel {
  String? year;
  int? financial;
  final charts.Color? color;

  BarChartModel({
    this.year,
    this.financial,
    this.color,
  });
}

class CustomCircleSymbolRenderer extends CircleSymbolRenderer {
  static String? value;
  @override
  void paint(ChartCanvas canvas, Rectangle<num> bounds,
      {List<int>? dashPattern,
      Color? fillColor,
      FillPatternType? fillPattern,
      Color? strokeColor,
      double? strokeWidthPx}) {
    super.paint(canvas, bounds,
        dashPattern: dashPattern,
        fillColor: fillColor,
        fillPattern: fillPattern,
        strokeColor: strokeColor,
        strokeWidthPx: strokeWidthPx);
    canvas.drawRect(
        Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 10,
            bounds.height + 10),
        fill: Color.white);
    var textStyle = style.TextStyle();
    textStyle.color = Color.black;
    textStyle.fontSize = 15;
    canvas.drawText(charts_text.TextElement("$value", style: textStyle),
        (bounds.left).round(), (bounds.top - 28).round());
  }
}
