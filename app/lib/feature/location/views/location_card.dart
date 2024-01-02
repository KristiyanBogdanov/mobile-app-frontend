import 'package:app/api/location/model/location_model.dart';
import 'package:flutter/material.dart';

class LocationCardView extends StatelessWidget {
  final VoidCallback callback;
  final LocationModel locationModel;

  const LocationCardView({
    required this.callback,
    required this.locationModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: callback,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
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
      ),
    );
  }
}
