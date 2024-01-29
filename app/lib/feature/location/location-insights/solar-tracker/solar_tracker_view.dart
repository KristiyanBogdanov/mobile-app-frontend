import 'package:app/api/location/index.dart';
import 'package:app/feature/location/location-insights/weather-station/views/index.dart';
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
              AppStyle.horizontalPadding8,
              AppStyle.verticalPadding8,
              AppStyle.horizontalPadding8,
              AppStyle.verticalPadding16,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: AppStyle.horizontalPadding8),
                  child: Row(
                    children: [
                      Text(
                        '${AppStrings.lastUpdate}: 12:00 Jan',
                        style: TextStyle(
                          fontSize: AppStyle.fontSize12,
                          color: AppStyle.textColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.refresh,
                          size: AppStyle.iconSize20,
                          color: AppStyle.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppStyle.verticalPadding4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/images/solar-tracker-sketch.png',
                      height: 230,
                      width: 230,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Azimuth:',
                              style: TextStyle(
                                color: AppStyle.textColor.withOpacity(0.7),
                                fontSize: AppStyle.fontSize14,
                              ),
                            ),
                            SizedBox(height: AppStyle.verticalPadding4),
                            Text(
                              '${solarTrackerInsightsModel.currentAzimuth}° (+1°σ)',
                              style: TextStyle(
                                color: AppStyle.textColor,
                                fontSize: AppStyle.fontSize14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppStyle.verticalPadding12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Elevation:',
                              style: TextStyle(
                                color: AppStyle.textColor.withOpacity(0.7),
                                fontSize: AppStyle.fontSize14,
                              ),
                            ),
                            SizedBox(height: AppStyle.verticalPadding4),
                            Text(
                              '${solarTrackerInsightsModel.currentElevation}° (+1°σ)',
                              style: TextStyle(
                                color: AppStyle.textColor,
                                fontSize: AppStyle.fontSize14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: AppStyle.verticalPadding24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // TODO: reuse widget from location view
            Text(
              AppStrings.sensorsSectionTitle,
              style: TextStyle(
                color: AppStyle.textColor,
                fontSize: AppStyle.fontSize16,
                fontWeight: FontWeight.w500,
              ),
            ),
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
          childAspectRatio: 1.4,
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
        SizedBox(height: AppStyle.verticalPadding24),
        Text(
          'Average irradiance',
          style: TextStyle(
            color: AppStyle.textColor,
            fontSize: AppStyle.fontSize16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: AppStyle.verticalPadding12),
        LineChartSample2(),
        SizedBox(height: AppStyle.verticalPadding24),
        Text(
          'Coordinates',
          style: TextStyle(
            color: AppStyle.textColor,
            fontSize: AppStyle.fontSize16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: AppStyle.verticalPadding12),
      ],
    );
  }
}
