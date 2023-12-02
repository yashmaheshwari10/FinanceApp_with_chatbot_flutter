import 'package:edi/bar_graph/Bardata.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarGraph extends StatelessWidget {
  final double maxY;
  final List weeklysummary;
  final int monday;
  final int tuesday;
  final int wednesday;
  final int thursday;
  final int friday;
  final int sat;
  final int sun;
  BarGraph(
      {super.key,
      required this.maxY,
      required this.weeklysummary,
      required this.monday,
      required this.tuesday,
      required this.wednesday,
      required this.thursday,
      required this.friday,
      required this.sat,
      required this.sun});
  List weekdays = [];
  List<BarChartGroupData> getBarGroups() {
    List<BarChartGroupData> barGroups = [];
    int i;
    int j = 0;
    while (j <= 6) {
      i = weekdays[j];
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: weeklysummary[j],
              width: 20,
            ),
          ],
        ),
      );

      j++;
    }

    return barGroups;
  }

  @override
  Widget build(BuildContext context) {
    weekdays = [monday, tuesday, wednesday, thursday, friday, sat, sun];
    BarData mybardata = BarData(
        oneamount: weeklysummary[0],
        twoamount: weeklysummary[1],
        threeamount: weeklysummary[2],
        fouramount: weeklysummary[3],
        fiveamount: weeklysummary[4],
        sixamount: weeklysummary[5],
        sevenamount: weeklysummary[6]);
    mybardata.init();
    return BarChart(
        BarChartData(maxY: maxY, minY: 0, barGroups: getBarGroups()));
  }
}
