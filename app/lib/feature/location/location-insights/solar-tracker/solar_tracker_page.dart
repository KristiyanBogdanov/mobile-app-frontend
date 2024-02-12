import 'package:app/api/firebase/firebase_api.dart';
import 'package:app/feature/location/location-insights/solar-tracker/solar_tracker_view_model.dart';
import 'package:app/feature/location/location-insights/solar-tracker/views/st_indicator_view.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SolarTrackerPage extends StatelessWidget {
  final SolarTrackerViewModel _viewModel;

  const SolarTrackerPage({
    required SolarTrackerViewModel viewModel,
    super.key,
  }) : _viewModel = viewModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Scaffold(
        backgroundColor: AppStyle.bgColor,
        appBar: AppBarView(
          title: _viewModel.solarTracker.serialNumber,
          actions: [
            if (_viewModel.location.amIOwner && _viewModel.isSolarTrackerInsightsAvailable)
              PopupMenuButton(
                onSelected: (value) async {
                  if (value == 0) {
                    await _viewModel.removeSolarTracker();
                  }
                },
                color: AppStyle.secondaryColor1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppStyle.borderRadius20),
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItemView(
                      value: 0,
                      text: AppStrings.deleteSolarTracker,
                    ),
                  ];
                },
              ),
          ],
        ),
        body: Consumer2<SolarTrackerViewModel, FirebaseApi>(
          builder: (context, viewModel, _, child) {
            if (!viewModel.isSolarTrackerInsightsAvailable) {
              return const NoContentView(
                svgAsset: 'assets/images/deleted.svg',
                title: AppStrings.deletedSolarTracker,
              );
            } else if (viewModel.isLoading) {
              return const LoadingView();
            } else {
              return RefreshIndicator(
                onRefresh: () async => await viewModel.refreshSolarTrackerInsights(),
                color: AppStyle.contrastColor1,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppStyle.horizontalPadding16,
                      vertical: AppStyle.verticalPadding16,
                    ),
                    child: Column(
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
                                    date: viewModel.solarTrackerInsightsModel.lastUpdate,
                                    onRefresh: () async => await viewModel.refreshSolarTrackerInsights(),
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
                                          value: viewModel.solarTrackerInsightsModel.currentAzimuth,
                                          deviation: viewModel.solarTrackerInsightsModel.azimuthDeviation,
                                        ),
                                        SizedBox(height: AppStyle.verticalPadding12),
                                        STIndicatorView(
                                          title: AppStrings.elevationIndicatorLabel,
                                          value: viewModel.solarTrackerInsightsModel.currentElevation,
                                          deviation: viewModel.solarTrackerInsightsModel.elevationDeviation,
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
                                  '${viewModel.solarTrackerInsightsModel.sensorsStatus.count}',
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
                              sensorName: AppStrings.irradianceSensor,
                              isActive: viewModel.isIrradianceSenssorActive,
                            ),
                            SensorStatusCardView(
                              assetName: 'assets/icons/solar-tracker-avatar.png',
                              sensorName: AppStrings.accelerometer,
                              isActive: viewModel.isAccelometerActive,
                            ),
                            SensorStatusCardView(
                              assetName: 'assets/icons/solar-tracker-avatar.png',
                              sensorName: AppStrings.azimuthMotor,
                              isActive: viewModel.isAzimuthMotorActive,
                            ),
                            SensorStatusCardView(
                              assetName: 'assets/icons/solar-tracker-avatar.png',
                              sensorName: AppStrings.elevationMotor,
                              isActive: viewModel.isElevationMotorActive,
                            ),
                          ],
                        ),
                        const ColumnSpacingView(),
                        const ColumnSectionTitleView(
                          title: AppStrings.averageIrradiance,
                        ),
                        LineChartView(
                          avgSensorValues: viewModel.solarTrackerInsightsModel.last24hAvgIrradiance,
                          leftTitleUnit: AppStrings.irradianceValue,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
