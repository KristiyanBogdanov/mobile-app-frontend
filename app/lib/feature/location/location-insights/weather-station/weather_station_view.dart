import 'package:app/feature/location/location-insights/root/location_insights_view_model.dart';
import 'package:app/feature/location/location-insights/weather-station/views/index.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:app/util/extension/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeatherStationView extends StatefulWidget {
  const WeatherStationView({
    super.key,
  });

  @override
  State<WeatherStationView> createState() => _WeatherStationViewState();
}

class _WeatherStationViewState extends State<WeatherStationView> {
  int? _currentLineChart = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationInsightsViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isWeatherStationLoading) {
          return const LoadingView();
        } else if (viewModel.weatherStationInsightsModel == null) {
          return NoContentView(
            svgAsset: 'assets/images/no-weather-station.svg',
            title: AppStrings.noWeatherStationInstalledTitle,
            description: viewModel.locationModel.amIOwner ? null : AppStrings.noWeatherStationInstalledDescription,
            onActionButtonPressed:
                viewModel.locationModel.amIOwner ? () async => await viewModel.addWeatherStation() : null,
          );
        } else {
          return RefreshIndicator(
            color: AppStyle.contrastColor1,
            onRefresh: () async => await viewModel.refreshWeatherStationInsights(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppStyle.horizontalPadding16,
                  vertical: AppStyle.verticalPadding16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LastUpdateCardView(
                      lastUpdate: viewModel.weatherStationInsightsModel!.lastUpdate,
                      temperature: viewModel.weatherStationInsightsModel!.currentTemperature,
                      windSpeed: viewModel.weatherStationInsightsModel!.currentWindSpeed,
                      windDirection: viewModel.weatherStationInsightsModel!.currentWindDirection,
                      onRefresh: () async => await viewModel.refreshWeatherStationInsights(),
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
                              '${viewModel.weatherStationInsightsModel!.sensorsStatus.count}',
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
                          assetName: 'assets/icons/solar-tracker-avatar.png',
                          sensorName: AppStrings.temperatureSensor,
                          isActive: viewModel.isWsTempSensorActive,
                        ),
                        SensorStatusCardView(
                          assetName: 'assets/icons/solar-tracker-avatar.png',
                          sensorName: AppStrings.anemometer,
                          isActive: viewModel.isWsAnemometerActive,
                        ),
                      ],
                    ),
                    SizedBox(height: AppStyle.verticalPadding12),
                    DropdownButton(
                      value: _currentLineChart,
                      onChanged: (value) => _onLineChartChanged(value),
                      dropdownColor: AppStyle.secondaryColor2,
                      style: TextStyle(
                        color: AppStyle.textColor,
                        fontFamily: 'Nunito',
                        fontSize: AppStyle.fontSize16,
                        fontWeight: FontWeight.w500,
                      ),
                      borderRadius: BorderRadius.circular(AppStyle.borderRadius16),
                      items: const [
                        DropdownMenuItem(
                          value: 0,
                          child: Text(
                            AppStrings.averageTemperature,
                          ),
                        ),
                        DropdownMenuItem(
                          value: 1,
                          child: Text(
                            AppStrings.averageWindSpeed,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppStyle.verticalPadding12),
                    if (_currentLineChart == 0)
                      LineChartView(
                        avgSensorValues: viewModel.weatherStationInsightsModel!.last24hAvgTemperature,
                        leftTitleUnit: (value) => AppStrings.temperatureValue(value, merge: true),
                      )
                    else if (_currentLineChart == 1)
                      LineChartView(
                        avgSensorValues: viewModel.weatherStationInsightsModel!.last24hAvgWindSpeed,
                        leftTitleUnit: (value) => AppStrings.windSpeedValue(value, merge: true),
                      ),
                    const ColumnSpacingView(),
                    Text(
                      AppStrings.installedOn(
                        viewModel.weatherStationInsightsModel!.installationDate.parseWithDateFormat('dd MMM yyyy'),
                      ),
                      style: TextStyle(
                        color: AppStyle.textColorWith07Opacity,
                        fontSize: AppStyle.fontSize14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  void _onLineChartChanged(int? value) {
    setState(() {
      _currentLineChart = value;
    });
  }
}
