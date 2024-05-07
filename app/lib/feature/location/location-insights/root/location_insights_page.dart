import 'package:app/api/firebase/firebase_api.dart';
import 'package:app/feature/location/location-insights/cctv/cctv_view.dart';
import 'package:app/feature/location/location-insights/overview/overview_view.dart';
import 'package:app/feature/location/location-insights/root/location_insights_view_model.dart';
import 'package:app/feature/location/location-insights/root/views/index.dart';
import 'package:app/feature/location/location-insights/weather-station/weather_station_view.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationInsightsPage extends StatelessWidget {
  final LocationInsightsViewModel viewModel;

  const LocationInsightsPage({
    required this.viewModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<FirebaseApi>(
        builder: (context, firebaseChangeNotifier, child) {
          return !viewModel.isLocationAvailable
              ? Scaffold(
                  backgroundColor: AppStyle.bgColor,
                  appBar: AppBarView(title: viewModel.locationModel.name),
                  body: NoContentView(
                    svgAsset: AppImages.deletedModel,
                    title: firebaseChangeNotifier.message,
                  ),
                )
              : DefaultTabController(
                  length: 3,
                  child: Scaffold(
                    backgroundColor: AppStyle.bgColor,
                    appBar: AppBar(
                      // TODO: why I can't use AppBar from shared/widget/index.dart?
                      backgroundColor: AppStyle.bgColor,
                      foregroundColor: AppStyle.iconColor,
                      shape: const Border(
                        bottom: BorderSide(color: AppStyle.secondaryColor2),
                      ),
                      title: Text(
                        viewModel.locationModel.name,
                        style: const TextStyle(
                          color: AppStyle.textColor,
                        ),
                      ),
                      actions: [
                        if (viewModel.locationModel.amIOwner)
                          PopupMenuButton(
                            onSelected: (value) async {
                              if (value == 0) {
                                await viewModel.deleteWeatherStation();
                              } else if (value == 1) {
                                await viewModel.deleteLocation();
                              }
                            },
                            color: AppStyle.secondaryColor1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppStyle.borderRadius20),
                            ),
                            itemBuilder: (context) {
                              return [
                                if (viewModel.isWeatherStationAvailable)
                                  PopupMenuItemView(
                                    value: 0,
                                    text: AppStrings.deleteWeatherStation,
                                  ),
                                PopupMenuItemView(
                                  value: 1,
                                  text: AppStrings.deleteLocation,
                                ),
                              ];
                            },
                          ),
                      ],
                      bottom: TabBar(
                        indicatorColor: AppStyle.contrastColor1,
                        labelColor: AppStyle.textColor,
                        unselectedLabelColor: AppStyle.textColorWith05Opacity,
                        labelPadding: EdgeInsets.zero,
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                        tabs: const [
                          TabView(title: AppStrings.overviewTabTitle),
                          TabView(title: AppStrings.weatherStationTabTitle),
                          TabView(title: AppStrings.cctvTabTitle),
                        ],
                      ),
                    ),
                    body: Consumer<LocationInsightsViewModel>(
                      builder: (context, viewModel, child) {
                        return viewModel.isLoading
                            ? const LoadingView()
                            : const TabBarView(
                                children: [
                                  OverviewView(),
                                  WeatherStationView(),
                                  CCTVView(),
                                ],
                              );
                      },
                    ),
                  ),
                );
        },
      ),
    );
  }
}
