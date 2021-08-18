import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:vivo_registry/models/chart_model.dart';

class SalesBarChart extends StatelessWidget {
  final List<VivoBarChartModel> data;

  const SalesBarChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<VivoBarChartModel, String>> series = [
      charts.Series(
          id: "Vivo Sales",
          data: data,
          domainFn: (VivoBarChartModel series, _) => series.month,
          measureFn: (VivoBarChartModel series, _) => series.financial,
          colorFn: (VivoBarChartModel series, _) => series.barcolor)
    ];
    return charts.BarChart(series, animate: true);
  }
}
