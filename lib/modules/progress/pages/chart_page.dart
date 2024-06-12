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
      DateTime date = DateTime(now.year, now.month - i, 1);
      months.add(formatter.format(date));
    }
    return months;
  }

  @override
  Widget build(BuildContext context) {
    return widget.datas.isEmpty
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
                  child: LineChart(mainData(widget.datas)),
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

  Widget bottomTitleWidgets(double value, TitleMeta meta, List<String> months) {
    final style = AppTextStyles.styleF14WNormal();
    Widget text;
    int monthIndex = (value / 10).round();
    if (monthIndex >= 0 && monthIndex < months.length) {
      text = Text(months[monthIndex], style: style);
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
    const double maxX = 30.0;
    final double maxY = paddedData.where((element) => element != null).isEmpty
        ? 10
        : paddedData
            .where((element) => element != null)
            .reduce((a, b) => a! > b! ? a : b)!
            .toDouble();

    const double verticalInterval = 1;
    final double horizontalInterval = maxY / 5 == 0 ? 1 : maxY / 5;

    List<String> months = getLastFourMonths();

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
            interval: 10, // Interval to match the x-axis range
            getTitlesWidget: (value, meta) =>
                bottomTitleWidgets(value, meta, months),
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
