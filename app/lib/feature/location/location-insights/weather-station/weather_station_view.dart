import 'package:app/api/location/index.dart';
import 'package:app/feature/location/location-insights/weather-station/views/index.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';

class WeatherStationView extends StatelessWidget {
  final WeatherStationInsightsModel? weatherStationInsightsModel;

  const WeatherStationView({
    super.key,
    required this.weatherStationInsightsModel,
  });

  @override
  Widget build(BuildContext context) {
    return weatherStationInsightsModel == null
        ? Container() // TODO: add no weather station view + add button

        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LastUpdateCardView(
                lastUpdate: weatherStationInsightsModel!.lastUpdate,
                temperature: weatherStationInsightsModel!.currentTemperature,
                windSpeed: weatherStationInsightsModel!.currentWindSpeed,
                windDirection: weatherStationInsightsModel!.currentWindDirection,
                onRefresh: () {},
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
                        '${weatherStationInsightsModel!.sensorsStatus.count}',
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
                    sensorName: AppStrings.temperatureSensor,
                    isActive: weatherStationInsightsModel!.sensorsStatus.temperatureSensor,
                  ),
                  SensorStatusCardView(
                    assetName: 'assets/icons/solar-trackers.png',
                    sensorName: AppStrings.anemometer,
                    isActive: weatherStationInsightsModel!.sensorsStatus.anemometer,
                  ),
                ],
              ),
              const ColumnSpacingView(),
              DropdownButton(
                value: 0,
                onChanged: (value) => {},
                dropdownColor: AppStyle.secondaryColor2,
                style: TextStyle(
                  color: AppStyle.textColor,
                  fontFamily: 'Nunito',
                  fontSize: AppStyle.fontSize16,
                  fontWeight: FontWeight.w500,
                ),
                borderRadius: BorderRadius.circular(AppStyle.borderRadius16),
                items: [
                  DropdownMenuItem(
                    child: Text(
                      'Average temperature',
                    ),
                    value: 0,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'Average wind speed',
                    ),
                    value: 1,
                  ),
                ],
              ),
              SizedBox(height: AppStyle.verticalPadding12),
              LineChartView(
                avgSensorValues: weatherStationInsightsModel!.last24hAvgTemperature,
                leftTitleUnit: (value) => AppStrings.temperatureValue(value, merge: true),
              ),
              const ColumnSpacingView(),
              const ColumnSectionTitleView(title: AppStrings.coordinatesSectionTitle),
            ],
          );
  }
}
