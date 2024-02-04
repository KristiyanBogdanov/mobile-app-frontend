// Design size iphone 13
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyle {
  AppStyle._();

  // Design size iphone 13
  static const double designWidth = 390;
  static const double designHeight = 844;

  // Colors
  static const Color bgColor = Color(0xFF070710);
  static const Color secondaryColor1 = Color(0xFF0A0D14);
  static const Color secondaryColor2 = Color(0xFF1E1D2B);
  static const Color contrastColor1 = Color(0xFF005EEC);
  static const Color contrastColor2 = Color(0xFF3BFF49);
  static const Color textColor = Colors.white;
  static final Color textColorWith05Opacity = textColor.withOpacity(0.5);
  static final Color textColorWith07Opacity = textColor.withOpacity(0.7);
  static const Color iconColor = Colors.white;
  static const Color dividerColor = Colors.white;
  static const Color positiveColor = Colors.green;
  static final Color negativeColor = Colors.red.withOpacity(0.8);
  static const Color lineChartMainGridLineColor = Colors.white10;

  // Padding
  static final double horizontalPadding4 = 4.w;
  static final double horizontalPadding8 = 8.w;
  static final double horizontalPadding12 = 12.w;
  static final double horizontalPadding16 = 16.w;
  static final double horizontalPadding20 = 20.w;
  static final double horizontalPadding30 = 30.w;
  static final double verticalPadding4 = 4.h;
  static final double verticalPadding8 = 8.h;
  static final double verticalPadding10 = 10.h;
  static final double verticalPadding12 = 12.h;
  static final double verticalPadding16 = 16.h;
  static final double verticalPadding20 = 20.h;
  static final double verticalPadding24 = 24.h;
  static final double verticalPadding28 = 28.h;
  static final double verticalPadding32 = 32.h;
  static final double verticalPadding40 = 40.h;

  // Border radius
  static final double borderRadius4 = 4.r;
  static final double borderRadius8 = 8.r;
  static final double borderRadius12 = 12.r;
  static final double borderRadius16 = 16.r;
  static final double borderRadius18 = 18.r;
  static final double borderRadius20 = 20.r;

  // Border width
  static final double borderWidth1 = 1.w;

  // Font sizes
  static final double fontSize8 = 8.sp;
  static final double fontSize10 = 10.sp;
  static final double fontSize12 = 12.sp;
  static final double fontSize14 = 14.sp;
  static final double fontSize16 = 16.sp;
  static final double fontSize18 = 18.sp;
  static final double fontSize20 = 20.sp;
  static final double fontSize24 = 24.sp;
  static final double fontSize28 = 28.sp;

  // Icons
  static final double iconSize12 = 12.w;
  static final double iconSize20 = 20.w;
  static final double iconSize24 = 24.w;
  static final double iconSize40 = 40.w;

  // Divider
  static final double dividerIndent = 4.h;
  static final double dividerThickness = 1.w;

  // WelcomePage
  static final double welcomePageImageSize = 250.w;

  // CustomAppBar
  static final double customAppBarHeight = 40.h;

  // SharedWithRow
  static const int maxSharedWith = 2;
  static final double avatarWidthFactor = 0.8.w;

  // BottomNavigationBar
  static const double gNavGap = 8.0;

  // PrimaryButton
  static final double primaryButtonHeight = 50.h;

  // DeviceRow
  static final double deviceBoxHeight = 50.h;

  // AddDeviceBottomSheet
  static final double addDeviceBottomSheetHeight = 550.h;
  static final double successAnimationSize = 200.w;
  static final double qrScannerViewWidth = 300.w;
  static final double qrScannerViewHeight = 300.h;
  static final double qrScannerViewBorderRadius = 8.r;
  static final double qrScannerViewBorderWidth = 8.w;
  static final double qrScannerViewBorderLength = 16.w;

  // NoContentView
  static final double noContentViewImageSize = 200.w;

  // SensorStatusCardView & grid
  static final double sensorStatusCardViewWidth = 175.w;
  static final double sensorStatusCardViewHeight = 130.h;
  static const double sensorsStatusGridAspectRatio = 1.4;

  // LineChartView
  static const double lineChartAspectRatio = 1.7;
  static final double lineChartMainGridLineStrokeWidth = 1.w;
  static final double lineChartBarWidth = 4.w;
  static final double lineChartBottomTitlesReservedSize = 30.h;
  static final double lineChartBottomTitlesInterval = 1.w;
  static final double lineChartLeftTitlesReservedSize = 42.w;
  static final double lineChartLeftTitlesInterval = 1.w;
  static final double noDataLineChartHeight = 200.h;

  // SolarTrackerView
  static final double solarTrackerSketchWidth = 220.w;
  static final double solarTrackerSketchHeight = 220.w;
}
