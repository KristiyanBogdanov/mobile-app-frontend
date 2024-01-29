import 'package:app/api/location/index.dart';
import 'package:app/feature/location/location-insights/solar-tracker/views/st_indicator_view.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';

class SolarTrackerView extends StatelessWidget {
  final SolarTrackerInsightsModel solarTrackerInsightsModel;

  const SolarTrackerView({
    super.key,
    required this.solarTrackerInsightsModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          color: AppStyle.secondaryColor1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppStyle.borderRadius20),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              0,
              AppStyle.verticalPadding8,
              AppStyle.horizontalPadding8,
              AppStyle.verticalPadding16,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: AppStyle.horizontalPadding16),
                  child: LastUpdateView(
                    date: solarTrackerInsightsModel.lastUpdate,
                    onRefresh: () {},
                  ),
                ),
                SizedBox(height: AppStyle.verticalPadding4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/images/solar-tracker-sketch.png',
                      width: AppStyle.solarTrackerSketchWidth,
                      height: AppStyle.solarTrackerSketchHeight,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        STIndicatorView(
                          title: AppStrings.azimuthIndicatorLabel,
                          value: solarTrackerInsightsModel.currentAzimuth,
                          deviation: solarTrackerInsightsModel.azimuthDeviation,
                        ),
                        SizedBox(height: AppStyle.verticalPadding12),
                        STIndicatorView(
                          title: AppStrings.elevationIndicatorLabel,
                          value: solarTrackerInsightsModel.currentElevation,
                          deviation: solarTrackerInsightsModel.elevationDeviation,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const ColumnSpacingView(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ColumnSectionTitleView(title: AppStrings.sensorsSectionTitle, padding: false),
            SizedBox(width: AppStyle.horizontalPadding8),
            Container(
              height: AppStyle.iconSize24,
              width: AppStyle.iconSize24,
              decoration: BoxDecoration(
                color: AppStyle.contrastColor1,
                borderRadius: BorderRadius.circular(AppStyle.borderRadius8),
              ),
              child: Center(
                child: Text(
                  '${solarTrackerInsightsModel.sensorsStatus.count}',
                  style: TextStyle(
                    color: AppStyle.textColor,
                    fontSize: AppStyle.fontSize14,
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: AppStyle.verticalPadding12),
        GridView.count(
          shrinkWrap: true,
          childAspectRatio: AppStyle.sensorsStatusGridAspectRatio,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          children: [
            SensorStatusCardView(
              assetName: 'assets/icons/solar-trackers.png',
              sensorName: AppStrings.irradianceSensor,
              isActive: solarTrackerInsightsModel.sensorsStatus.irradianceSensor,
            ),
            SensorStatusCardView(
              assetName: 'assets/icons/solar-trackers.png',
              sensorName: AppStrings.accelerometer,
              isActive: solarTrackerInsightsModel.sensorsStatus.accelerometer,
            ),
            SensorStatusCardView(
              assetName: 'assets/icons/solar-trackers.png',
              sensorName: AppStrings.azimuthMotor,
              isActive: solarTrackerInsightsModel.sensorsStatus.azimuthMotor,
            ),
            SensorStatusCardView(
              assetName: 'assets/icons/solar-trackers.png',
              sensorName: AppStrings.elevationMotor,
              isActive: solarTrackerInsightsModel.sensorsStatus.elevationMotor,
            ),
          ],
        ),
        const ColumnSpacingView(),
        const ColumnSectionTitleView(
          title: AppStrings.averageIrradiance,
        ),
        LineChartView(
          avgSensorValues: solarTrackerInsightsModel.last24hAvgIrradiance,
          leftTitleUnit: AppStrings.irradianceValue,
        ),
      ],
    );
  }
}
