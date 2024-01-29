import 'package:app/feature/location/location-insights/root/location_insights_view_model.dart';
import 'package:app/feature/location/location-insights/root/views/index.dart';
import 'package:app/feature/location/location-insights/weather-station/weather_station_view.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationInsightsPage extends StatelessWidget {
  final LocationInsightsViewModel viewModel;

  const LocationInsightsPage({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: DefaultTabController(
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
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppStyle.horizontalPadding16,
                        vertical: AppStyle.verticalPadding16,
                      ),
                      child: TabBarView(
                        children: [
                          Center(
                            child: Text(
                              'TODO: Overview tab', // TODO: implement overview tab
                              style: TextStyle(
                                color: AppStyle.textColor,
                                fontSize: AppStyle.fontSize28,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            child: WeatherStationView(
                              weatherStationInsightsModel: viewModel.locationInsightsModel.weatherStation,
                            ),
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.code_off_rounded,
                                  size: AppStyle.iconSize40,
                                  color: AppStyle.iconColor,
                                ),
                                SizedBox(height: AppStyle.verticalPadding12),
                                Text(
                                  AppStrings.futureDevelopmentLabel,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppStyle.textColor,
                                    fontSize: AppStyle.fontSize24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
