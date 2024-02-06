import 'package:app/feature/location/location-insights/overview/views/index.dart';
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
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppStyle.horizontalPadding16,
              vertical: AppStyle.verticalPadding16,
            ),
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
                SizedBox(height: AppStyle.verticalPadding20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ColumnSectionTitleView(
                      title: AppStrings.solarTrackersSectionTitle,
                      padding: false,
                    ),
                    if (viewModel.locationModel.amIOwner)
                      AddTextButtonView(
                        icon: Icons.add_rounded,
                        text: AppStrings.add,
                        onPressed: () async => await viewModel.addSolarTracker(),
                      )
                  ],
                ),
                SizedBox(height: AppStyle.verticalPadding4),
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
                SizedBox(height: AppStyle.verticalPadding12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ColumnSectionTitleView(
                      title: AppStrings.sharedWithSectionTitle,
                      padding: false,
                    ),
                    if (viewModel.locationModel.amIOwner)
                      AddTextButtonView(
                        icon: Icons.person_add_alt_outlined,
                        text: AppStrings.share,
                        onPressed: () {},
                      )
                  ],
                ),
                SizedBox(height: AppStyle.verticalPadding8),
                if (viewModel.locationModel.sharedWith.isEmpty)
                  const NotSharedCardView()
                else
                  ...viewModel.locationModel.sharedWith.map((user) {
                    return SharedWithInsightsView(
                      username: user.username,
                      email: user.email,
                    );
                  })
              ],
            ),
          ),
        );
      },
    );
  }
}
