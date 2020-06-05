/**
 * @ClassName BarChart
 * @Author wushaohang
 * @Date 2020/6/5
 **/

/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' show Color;
import 'package:charts_common/common.dart' as commonCharts;
import 'package:flutter_module/components/screen_fit.dart';

class BarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  BarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with custom rounded bars.
  factory BarChart.withSampleData() {
    return new BarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    double barWidth = ScreenUtil().setWidth(24);
    return new charts.BarChart(
      seriesList,
      animate: animate,
      defaultRenderer: new charts.BarRendererConfig(
          cornerStrategy: const charts.ConstCornerStrategy(30),
      ),
      domainAxis: charts.OrdinalAxisSpec(
        scaleSpec: commonCharts.FixedPixelOrdinalScaleSpec(barWidth),
        showAxisLine: false,
        renderSpec: new charts.NoneRenderSpec()
      ),
      primaryMeasureAxis: new charts.NumericAxisSpec(
          renderSpec: new charts.NoneRenderSpec()
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2018', 25),
      new OrdinalSales('2020', 100),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2017', 75),
      new OrdinalSales('2019', 100),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => Color(r: 41, g: 217, b: 214),
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}