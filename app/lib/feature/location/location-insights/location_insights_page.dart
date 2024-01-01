import 'package:app/api/location/model/location_model.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';

class LocationInsightsPage extends StatelessWidget {
  final LocationModel locationModel;

  const LocationInsightsPage({required this.locationModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: locationModel.name),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(locationModel.name),
            Text(locationModel.location),
            Text(locationModel.capacity.toString()),
            Text(locationModel.solarTrackers.toString()),
            Text(locationModel.weatherStation.toString()),
            Text(locationModel.cctv.toString()),
            Text(locationModel.amIOwner.toString()),
            Text(locationModel.sharedWith.toString()),
          ],
        ),
      ),
    );
  }
}
