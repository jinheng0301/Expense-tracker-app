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
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );

    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('01', style: style);
        break;
      case 1:
        text = Text('02', style: style);
        break;
      case 2:
        text = Text('03', style: style);
        break;
      case 3:
        text = Text('04', style: style);
        break;

      case 4:
        text = Text('05', style: style);
        break;
      case 5:
        text = Text('06', style: style);
        break;
      case 6:
        text = Text('07', style: style);
        break;
      case 7:
        text = Text('08', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      child: text,
      space: 16,
      axisSide: meta.axisSide,
    );
  }

  Widget leftTiles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );

    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('1k', style: style);
        break;
      case 1:
        text = Text('2k', style: style);
        break;
      case 2:
        text = Text('3k', style: style);
        break;
      case 3:
        text = Text('4k', style: style);
        break;

      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      child: text,
      space: 16,
      axisSide: meta.axisSide,
    );
  }

  List<BarChartGroupData> showingGroups() {
    return List.generate(8, (i) {
      switch (i) {
        case 0:
          return makeGroupData(0, 2);
        case 1:
          return makeGroupData(1, 3);
        case 2:
          return makeGroupData(2, 2);
        case 3:
          return makeGroupData(3, 4.5);
        case 4:
          return makeGroupData(4, 3.8);
        case 5:
          return makeGroupData(5, 1.5);
        case 6:
          return makeGroupData(6, 4);
        case 7:
          return makeGroupData(7, 3.8);
        default:
          return throw Error();
      }
    });
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 10,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 4,
            color: Colors.grey,
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
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
              reservedSize: 38,
              getTitlesWidget: leftTiles,
            ),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
              reservedSize: 38,
              getTitlesWidget: getTiles,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false),
        barGroups: showingGroups(),
      ),
    );
  }
}