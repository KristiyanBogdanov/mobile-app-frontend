import 'package:app/api/location/index.dart';
import 'package:app/shared/constant/index.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartView extends StatefulWidget {
  final List<AverageSensorValueModel>? avgSensorValues;
  final Function(num) leftTitleUnit;

  const LineChartView({
    super.key,
    required this.avgSensorValues,
    required this.leftTitleUnit,
  });

  @override
  State<LineChartView> createState() => _LineChartViewState();
}

class _LineChartViewState extends State<LineChartView> {
  final double _minX = 1;
  final double _minY = 0;
  final List<Color> _gradientColors = [
    AppStyle.contrastColor2,
    AppStyle.contrastColor1,
  ];

  @override
  Widget build(BuildContext context) {
    return widget.avgSensorValues == null
        ? SizedBox(
            height: AppStyle.noDataCardHeight,
            child: Card(
              color: AppStyle.secondaryColor1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppStyle.borderRadius16),
              ),
              child: Center(
                child: Text(
                  AppStrings.noData,
                  style: TextStyle(
                    fontSize: AppStyle.fontSize16,
                    fontWeight: FontWeight.w500,
                    color: AppStyle.textColorWith07Opacity,
                  ),
                ),
              ),
            ),
          )
        : AspectRatio(
            aspectRatio: AppStyle.lineChartAspectRatio,
            child: Padding(
              padding: EdgeInsets.only(
                top: AppStyle.verticalPadding8,
                right: AppStyle.horizontalPadding12,
              ),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    horizontalInterval: null,
                    verticalInterval: null,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: AppStyle.lineChartMainGridLineColor,
                        strokeWidth: AppStyle.lineChartMainGridLineStrokeWidth,
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: AppStyle.lineChartMainGridLineColor,
                        strokeWidth: AppStyle.lineChartMainGridLineStrokeWidth,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: AppStyle.lineChartBottomTitlesReservedSize,
                        interval: AppStyle.lineChartBottomTitlesInterval,
                        getTitlesWidget: bottomTitleWidgets,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: AppStyle.lineChartLeftTitlesReservedSize,
                        interval: AppStyle.lineChartLeftTitlesInterval,
                        getTitlesWidget: leftTitleWidgets,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    border: Border.all(color: AppStyle.secondaryColor2),
                  ),
                  lineTouchData: const LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: AppStyle.secondaryColor2,
                    ),
                  ),
                  minX: _minX,
                  maxX: maxX,
                  minY: _minY,
                  maxY: maxY,
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      gradient: LinearGradient(
                        colors: _gradientColors,
                      ),
                      barWidth: AppStyle.lineChartBarWidth,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(
                        show: false,
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: _gradientColors.map((color) => color.withOpacity(0.3)).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final percentages = [0.3, 0.6, 0.9];
    String? text;

    for (double percentage in percentages) {
      if (value.toInt() == (percentage * maxY).toInt()) {
        text = widget.leftTitleUnit((percentage * maxY).toInt());
        break;
      }
    }

    if (text == null) {
      return SideTitleWidget(
        axisSide: AxisSide.left,
        child: Container(),
      );
    }

    return SideTitleWidget(
      axisSide: AxisSide.left,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: AppStyle.fontSize12,
            fontWeight: FontWeight.w500,
            color: AppStyle.textColorWith05Opacity,
          ),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    Widget child;

    if ((value.toInt()) % 3 == 0) {
      final hoursToSubtract = (maxX.toInt() - value.toInt()) * (widget.avgSensorValues!.length ~/ maxX) + 1;
      final hour = DateTime.now().subtract(Duration(hours: hoursToSubtract)).hour;

      child = Text(
        AppStrings.hours(hour),
        style: TextStyle(
          fontSize: AppStyle.fontSize12,
          fontWeight: FontWeight.w500,
          color: AppStyle.textColorWith05Opacity,
        ),
      );
    } else {
      child = Container();
    }

    return SideTitleWidget(axisSide: AxisSide.bottom, child: child);
  }

  List<FlSpot> get spots {
    final spots = <FlSpot>[];

    for (int i = 0; i < maxX; ++i) {
      final sensorValue = widget.avgSensorValues![i];

      if (sensorValue.average != null) {
        spots.add(FlSpot(maxX - i.toDouble() + _minX, sensorValue.average!));
      }
    }

    return spots;
  }

  double get maxX => widget.avgSensorValues!.length.toDouble();

  // TODO: optimise this
  double get maxY {
    double maxY = _minY;

    for (int i = 0; i < maxX; ++i) {
      final sensorValue = widget.avgSensorValues![i];

      if (sensorValue.average != null && sensorValue.average! > maxY) {
        maxY = sensorValue.average!;
      }
    }

    return maxY;
  }
}

// TODO: add view model