import 'package:app/feature/location/locations_view_model.dart';
import 'package:app/feature/location/views/index.dart';
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
        appBar: AppBarWidget(
          title: AppStrings.locationsPageTitle,
          actions: [
            IconButton(
              onPressed: () => _viewModel.addNewLocation(),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: Consumer<LocationsViewModel>(
          builder: (context, viewModel, child) {
            return ListView(
              scrollDirection: Axis.vertical,
              children: [
                ...viewModel.locations.map(
                  (locationModel) => LocationCardView(
                    locationModel: locationModel,
                    callback: () => viewModel.navigateToLocation(locationModel),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
