import 'package:app/feature/location/home/locations_view_model.dart';
import 'package:app/feature/location/home/views/index.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocationsViewModel(),
      child: Consumer<LocationsViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: AppStyle.bgColor,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  snap: true,
                  floating: true,
                  backgroundColor: AppStyle.bgColor,
                  surfaceTintColor: Colors.transparent,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(AppStyle.addinationHeight),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: AppStyle.horizontalPadding16,
                        right: AppStyle.horizontalPadding16,
                        bottom: AppStyle.verticalPadding8,
                      ),
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
                          AddNewLocationButtonView(
                            onPressed: viewModel.addNewLocation,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppStyle.horizontalPadding16,
                    vertical: AppStyle.verticalPadding12,
                  ),
                  sliver: viewModel.locations.isEmpty
                      ? const SliverFillRemaining(
                          hasScrollBody: false,
                          child: NoContentView(
                            svgAsset: 'assets/images/no-locations.svg',
                            title: AppStrings.noLocationsTitle,
                            description: AppStrings.noLocationsDescription,
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final locationModel = viewModel.locations[index];
                              return LocationCardView(
                                locationModel: locationModel,
                                callback: () => viewModel.navigateToLocation(locationModel),
                              );
                            },
                            childCount: viewModel.locations.length,
                          ),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
