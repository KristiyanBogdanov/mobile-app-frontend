import 'package:app/feature/location/location-insights/overview/views/index.dart';
import 'package:app/feature/location/location-insights/overview/views/solar_tracker_card_view.dart';
import 'package:app/feature/location/location-insights/root/location_insights_view_model.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class OverviewView extends StatelessWidget {
  const OverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationInsightsViewModel>(
      builder: (context, viewModel, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppStyle.mapHeight,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppStyle.borderRadius20),
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(
                        viewModel.locationInsightsModel.solarTrackers.entries.first.value.coordinates.latitude,
                        viewModel.locationInsightsModel.solarTrackers.entries.first.value.coordinates.longitude,
                      ),
                      initialZoom: AppStyle.mapInitialZoom,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: dotenv.env['MAPBOX_URL']!,
                        userAgentPackageName: 'com.example.app',
                      ),
                      MarkerLayer(
                        markers: [
                          ...viewModel.locationModel.solarTrackers.map((serialNumber) {
                            final solarTracker = viewModel.locationInsightsModel.solarTrackers[serialNumber]!;
                            return buildMapMarkerView(
                              solarTracker.coordinates.latitude,
                              solarTracker.coordinates.longitude,
                              'assets/icons/solar-tracker-avatar.png',
                              serialNumber,
                            );
                          }),
                          if (viewModel.locationInsightsModel.weatherStation != null)
                            buildMapMarkerView(
                              viewModel.locationInsightsModel.weatherStation!.coordinates.latitude,
                              viewModel.locationInsightsModel.weatherStation!.coordinates.longitude,
                              'assets/icons/weather-station-avatar.png',
                              viewModel.locationModel.weatherStation!,
                            ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const ColumnSpacingView(),
              const ColumnSectionTitleView(
                title: AppStrings.solarTrackersSectionTitle,
              ),
              SizedBox(
                height: AppStyle.solarTrackerCardHeight,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: viewModel.locationModel.solarTrackers.length,
                  itemBuilder: (context, index) {
                    final serialNumber = viewModel.locationModel.solarTrackers[index];
                    final solarTracker = viewModel.locationInsightsModel.solarTrackers[serialNumber]!;

                    return SolarTrackerCardView(
                      serialNumber: serialNumber,
                      capacity: solarTracker.capacity,
                      isActive: solarTracker.isActive,
                      onTap: () => viewModel.navigateToSolarTracker(serialNumber, solarTracker),
                    );
                  },
                ),
              ),
              const ColumnSpacingView(),
              const ColumnSectionTitleView(
                title: AppStrings.sharedWithSectionTitle,
              ),
              if (viewModel.locationModel.sharedWith.isEmpty)
                SizedBox(
                  height: AppStyle.noDataCardHeight,
                  child: Card(
                    color: AppStyle.secondaryColor1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppStyle.borderRadius16),
                    ),
                    child: Center(
                      child: Text(
                        'Not shared with anyone yet.',
                        style: TextStyle(
                          fontSize: AppStyle.fontSize16,
                          fontWeight: FontWeight.w500,
                          color: AppStyle.textColorWith07Opacity,
                        ),
                      ),
                    ),
                  ),
                )
              else
                ...viewModel.locationModel.sharedWith.map((user) {
                  return SharedWithInsightsView(
                    username: user.username,
                    email: user.email,
                  );
                })
            ],
          ),
        );
      },
    );
  }
}
