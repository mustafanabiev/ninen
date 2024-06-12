import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ninen/theme/app_colors.dart';
import 'package:ninen/theme/app_text_styles.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({super.key, required this.datas});

  final List<int> datas;

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  bool showAvg = false;

  List<String> getLastFourMonths() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('MMM');
    List<String> months = [];
    for (int i = 3; i >= 0; i--) {
      DateTime date = DateTime(now.year, now.month + i, now.day);
      months.add(formatter.format(date));
    }
    return months.reversed.toList();
  }

  List<int?> padData(List<int> data) {
    List<int?> paddedData = List<int?>.filled(4, null);
    for (int i = 0; i < data.length && i < 4; i++) {
      paddedData[i + (4 - data.length)] = data[i];
    }
    return paddedData;
  }

  @override
  Widget build(BuildContext context) {
    List<int?> paddedData = padData(widget.datas);

    return paddedData.isEmpty
        ? Center(
            child: Text(
              'No data available',
              style: AppTextStyles.styleF14WNormal(),
            ),
          )
        : Stack(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 2,
                child: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: LineChart(mainData(paddedData)),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: SizedBox(
                  width: 60,
                  height: 34,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        showAvg = !showAvg;
                      });
                    },
                    child: Text(
                      'avg',
                      style: TextStyle(
                        fontSize: 12,
                        color: showAvg
                            ? Colors.white.withOpacity(0.5)
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final style = AppTextStyles.styleF14WNormal();
    List<String> months = getLastFourMonths();

    Widget text;
    if (value.toInt() >= 0 && value.toInt() < months.length) {
      text = Text(months[value.toInt()], style: style);
    } else {
      text = Text('', style: style);
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final style = AppTextStyles.styleF14WNormal();
    return Text(
      value.toInt().toString(),
      style: style,
      textAlign: TextAlign.left,
    );
  }

  LineChartData mainData(List<int?> paddedData) {
    const double maxX = 3.0;
    final double maxY = paddedData.where((element) => element != null).isEmpty
        ? 10
        : paddedData
            .where((element) => element != null)
            .reduce((a, b) => a! > b! ? a : b)!
            .toDouble();

    const double verticalInterval = 1;
    final double horizontalInterval = maxY / 5 == 0 ? 1 : maxY / 5;

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: horizontalInterval,
        verticalInterval: verticalInterval,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: AppColors.grey,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: AppColors.grey,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 42,
            interval: 1, // Fixed interval for the last four months
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: horizontalInterval,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          color: AppColors.grey,
          width: 1,
        ),
      ),
      minX: 0,
      maxX: maxX,
      minY: 0,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: paddedData
              .asMap()
              .entries
              .map((entry) => entry.value != null
                  ? FlSpot(entry.key.toDouble(), entry.value!.toDouble())
                  : FlSpot(entry.key.toDouble(), 0))
              .toList(),
          isCurved: true,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          color: AppColors.red,
          belowBarData: BarAreaData(show: false),
        ),
      ],
    );
  }
}
