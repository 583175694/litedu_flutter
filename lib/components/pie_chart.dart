import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' show Color;
import 'package:flutter_module/components/screen_fit.dart';

class PieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  PieChart(this.seriesList, {this.animate});

  factory PieChart.withSampleData() {
    return new PieChart(
      _createSampleData(),
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(
      seriesList,
      animate: animate,
      defaultRenderer: new charts.ArcRendererConfig(
        arcWidth: ScreenUtil().setWidth(20).toInt()
      )
    );
  }

  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 200),
      new LinearSales(1, 35),
      new LinearSales(2, 25),
    ];

    final List<Color> colors = [
      Color(r: 41, g: 217, b: 214),
      Color(r: 252, g: 79, b: 77),
      Color(r: 255, g: 169, b: 56),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        colorFn: (_, __) => colors[__]
      )
    ];
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}