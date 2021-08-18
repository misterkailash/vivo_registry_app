import 'package:charts_flutter/flutter.dart' as charts;

class VivoBarChartModel {
  final String month;
  final int financial;
  final charts.Color barcolor;

  VivoBarChartModel(
      {required this.month, required this.financial, required this.barcolor});
}
