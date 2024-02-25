import 'package:app/api/firebase/firebase_api.dart';
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
    return Consumer2<LocationInsightsViewModel, FirebaseApi>(
      builder: (context, viewModel, _, child) {
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
                          viewModel.locationInsightsModel!.solarTrackers.entries.first.value.coordinates.latitude,
                          viewModel.locationInsightsModel!.solarTrackers.entries.first.value.coordinates.longitude,
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
                            ...viewModel.locationModel.solarTrackers.map((st) {
                              final stInsights = viewModel.locationInsightsModel!.solarTrackers[st.serialNumber]!;
                              return buildMapMarkerView(
                                stInsights.coordinates.latitude,
                                stInsights.coordinates.longitude,
                                AppImages.solarTrackerAvatar,
                                st.serialNumber,
                              );
                            }),
                            if (viewModel.isWeatherStationAvailable)
                              buildMapMarkerView(
                                viewModel.weatherStationInsightsModel.coordinates.latitude,
                                viewModel.weatherStationInsightsModel.coordinates.longitude,
                                AppImages.weatherStationAvatar,
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
                      final st = viewModel.locationModel.solarTrackers[index];
                      final stInsights = viewModel.locationInsightsModel!.solarTrackers[st.serialNumber]!;

                      return SolarTrackerCardView(
                        serialNumber: st.serialNumber,
                        capacity: st.capacity,
                        isActive: stInsights.isActive,
                        onTap: () => viewModel.navigateToSolarTracker(st, stInsights),
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
                        text: AppStrings.invite,
                        onPressed: () async => await viewModel.inviteUser(),
                      )
                  ],
                ),
                SizedBox(height: AppStyle.verticalPadding8),
                if (viewModel.locationModel.sharedWith.isEmpty)
                  const NotSharedCardView()
                else
                  ...viewModel.locationModel.sharedWith.map((user) {
                    return UserDetailsCardView(
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
