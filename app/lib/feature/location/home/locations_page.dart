import 'package:app/api/firebase/firebase_api.dart';
import 'package:app/feature/location/home/locations_view_model.dart';
import 'package:app/feature/location/home/views/index.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationsPage extends StatelessWidget {
  final _viewModel = LocationsViewModel();

  LocationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Scaffold(
        backgroundColor: AppStyle.bgColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppStyle.horizontalPadding16,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: AppStyle.verticalPadding16,
                    bottom: AppStyle.verticalPadding8,
                  ),
                  child: SizedBox(
                    height: AppStyle.customAppBarHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.locationsPageTitle,
                          style: TextStyle(
                            color: AppStyle.textColor,
                            fontSize: AppStyle.fontSize28,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        AddNewButtonView(
                          text: AppStrings.addNewLocationButton,
                          icon: Icons.add,
                          onPressed: () async => await _viewModel.addNewLocation(),
                        ),
                      ],
                    ),
                  ),
                ),
                Consumer2<LocationsViewModel, FirebaseApi>(
                  builder: (context, viewModel, _, child) {
                    return Expanded(
                      child: viewModel.locations.isEmpty
                          ? const NoContentView(
                              svgAsset: AppImages.noLocations,
                              title: AppStrings.noLocationsTitle,
                              description: AppStrings.noLocationsDescription,
                            )
                          : ListView.builder(
                              padding: EdgeInsets.symmetric(
                                vertical: AppStyle.verticalPadding12,
                              ),
                              itemCount: viewModel.locations.length,
                              itemBuilder: (context, index) {
                                final locationModel = viewModel.locations[index];
                                return LocationCardView(
                                  locationModel: locationModel,
                                  onTap: () async => await viewModel.navigateToLocation(locationModel),
                                );
                              },
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
