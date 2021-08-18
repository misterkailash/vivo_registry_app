import 'package:flutter/material.dart';
import 'package:vivo_registry/models/chart_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;

final List<VivoBarChartModel> data = [
  VivoBarChartModel(
    month: "Jan",
    financial: 50000,
    barcolor: charts.ColorUtil.fromDartColor(Colors.blue),
  ),
  VivoBarChartModel(
    month: "Feb",
    financial: 30000,
    barcolor: charts.ColorUtil.fromDartColor(Colors.red),
  ),
  VivoBarChartModel(
    month: "Mar",
    financial: 77000,
    barcolor: charts.ColorUtil.fromDartColor(Colors.green),
  ),
  VivoBarChartModel(
    month: "Apr",
    financial: 57700,
    barcolor: charts.ColorUtil.fromDartColor(Colors.yellow),
  ),
  VivoBarChartModel(
    month: "May",
    financial: 17000,
    barcolor: charts.ColorUtil.fromDartColor(Colors.pink),
  ),
  VivoBarChartModel(
    month: "Jun",
    financial: 81000,
    barcolor: charts.ColorUtil.fromDartColor(Colors.orange),
  ),
  VivoBarChartModel(
    month: "Jul",
    financial: 12000,
    barcolor: charts.ColorUtil.fromDartColor(Colors.blueAccent),
  ),
];
