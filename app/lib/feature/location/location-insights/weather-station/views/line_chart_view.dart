import 'package:app/api/location/index.dart';
import 'package:app/shared/constant/index.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class _LineChartView extends StatelessWidget {
  final double maxX;
  final double maxY;
  final List<AverageSensorValueModel>? avgSensorValues;
  final double minX = 1;
  final double minY = 0;
  final List<Color> gradientColors = [AppColors.contentColorBlue, AppColors.contentColorGreen];

  _LineChartView({
    super.key,
    required this.maxX,
    required this.maxY,
    required this.avgSensorValues,
  });

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          horizontalInterval: null,
          verticalInterval: null,
          getDrawingHorizontalLine: (value) {
            return const FlLine(
              color: AppColors.mainGridLineColor,
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return const FlLine(
              color: AppColors.mainGridLineColor,
              strokeWidth: 1,
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
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: bottomTitleWidgets,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: leftTitleWidgets,
              reservedSize: 42,
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
        minX: minX,
        maxX: maxX,
        minY: minY,
        maxY: maxY,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            gradient: LinearGradient(
              colors: gradientColors,
            ),
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: const FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final percentages = [0.3, 0.6, 0.9];
    String? text;

    for (double percentage in percentages) {
      if (value.toInt() == (percentage * maxY).toInt()) {
        text = AppStrings.temperatureValue((percentage * maxY).toInt(), merge: true);
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
            color: AppStyle.textColor.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    Widget child;

    if ((value.toInt()) % 3 == 0) {
      final hoursToSubtract = (maxX.toInt() - value.toInt()) * (avgSensorValues!.length ~/ maxX) + 1;
      final hour = DateTime.now().subtract(Duration(hours: hoursToSubtract)).hour;

      child = Text(
        AppStrings.hours(hour),
        style: TextStyle(
          fontSize: AppStyle.fontSize12,
          fontWeight: FontWeight.w500,
          color: AppStyle.textColor.withOpacity(0.5),
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
      final sensorValue = avgSensorValues![i];

      if (sensorValue.average != null) {
        spots.add(FlSpot(i.toDouble() + minX, sensorValue.average!));
      }
    }

    return spots;
  }
}

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    AppColors.contentColorGreen,
    AppStyle.contrastColor1,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8,
          right: 12,
        ),
        child: _LineChartView(maxX: 24, maxY: 40, avgSensorValues: [
          AverageSensorValueModel(1, 10),
          AverageSensorValueModel(2, 30),
          AverageSensorValueModel(3, 40),
          AverageSensorValueModel(4, 30),
          AverageSensorValueModel(5, 35),
          AverageSensorValueModel(6, 37),
          AverageSensorValueModel(7, 38),
          AverageSensorValueModel(8, 36),
          AverageSensorValueModel(9, 30),
          AverageSensorValueModel(10, 25),
          AverageSensorValueModel(11, 20),
          AverageSensorValueModel(12, 15),
          AverageSensorValueModel(13, 0),
          AverageSensorValueModel(14, 20),
          AverageSensorValueModel(15, 0),
          AverageSensorValueModel(16, 23),
          AverageSensorValueModel(17, 6),
          AverageSensorValueModel(18, 8),
          AverageSensorValueModel(19, 9),
          AverageSensorValueModel(20, null),
          AverageSensorValueModel(21, null),
          AverageSensorValueModel(22, null),
          AverageSensorValueModel(23, null),
          AverageSensorValueModel(24, null),
        ]),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final style = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppStyle.textColor.withOpacity(0.5),
    );
    Widget text;
    // I want to get what the hour was before the hour represented by the value
    final hour = DateTime.now().subtract(Duration(hours: (8 - value.toInt()) * 3 + 1)).hour;

    // switch (value.toInt()) {
    //   case 1:
    //     text = const Text('1h', style: style);
    //     break;
    //   case 2:
    //     text = const Text('MAR', style: style);
    //     break;
    //   case 5:
    //     text = const Text('JUN', style: style);
    //     break;
    //   case 8:
    //     text = const Text('SEP', style: style);
    //     break;
    //   default:
    //     text = const Text('', style: style);
    //     break;
    // }
    text = Text('${hour}h', style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final style = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppStyle.textColor.withOpacity(0.5),
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return SideTitleWidget(
          axisSide: meta.axisSide,
          child: Container(),
        );
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        horizontalInterval: null,
        verticalInterval: null,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
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
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 1,
      maxX: 8,
      minY: 1,
      maxY: 80,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(4, 3.1),
            FlSpot(3, 5),
            FlSpot(2, 2),
            FlSpot(1, 3),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}
