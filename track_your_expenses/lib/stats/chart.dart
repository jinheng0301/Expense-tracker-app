import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyChart extends StatefulWidget {
  const MyChart({super.key});

  @override
  State<MyChart> createState() => _MyChartState();
}

class _MyChartState extends State<MyChart> {
  Widget getTiles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );

    switch (value.toInt()) {
      case 0:
        return Text('01', style: style);
      case 1:
        return Text('02', style: style);
      case 2:
        return Text('03', style: style);
      case 3:
        return Text('04', style: style);
      case 4:
        return Text('05', style: style);
      case 5:
        return Text('06', style: style);
      case 6:
        return Text('07', style: style);
      case 7:
        return Text('08', style: style);
      default:
        return Text('', style: style);
    }
  }

  Widget leftTiles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );

    switch (value.toInt()) {
      case 0:
        return Text('1k', style: style);
      case 1:
        return Text('2k', style: style);
      case 2:
        return Text('3k', style: style);
      case 3:
        return Text('4k', style: style);
      default:
        return Text('', style: style);
    }
  }

  List<BarChartGroupData> showingGroups() {
    return List.generate(8, (i) {
      return makeGroupData(i, (i % 5 + 1).toDouble() * 1.5);
    });
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 12,
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(4),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 6,
            color: Colors.grey[300],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: leftTiles,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: getTiles,
            ),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 1,
          checkToShowHorizontalLine: (value) => value % 1 == 0,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.grey[300],
            strokeWidth: 1,
          ),
        ),
        barGroups: showingGroups(),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey, width: 1),
        ),
      ),
    );
  }
}
