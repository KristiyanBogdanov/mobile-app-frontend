import 'package:app/feature/location/add-location/add_location_view_model.dart';
import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';

class AddLocationBottomSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const AddLocationBottomSheet({
    required this.request,
    required this.completer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddLocationViewModel(),
      child: Consumer<AddLocationViewModel>(
        builder: (context, viewModel, child) {
          return Container(
            color: Colors.white,
            child: Form(
              key: viewModel.formKey,
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) => viewModel.setName(value),
                    validator: (value) => viewModel.validateName(value),
                    decoration: InputDecoration(
                      labelText: AppStrings.locationNameLabel,
                      hintText: AppStrings.locationNameHint,
                      errorText: viewModel.nameError,
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) => viewModel.setLocation(value),
                    validator: (value) => viewModel.validateLocation(value),
                    decoration: const InputDecoration(
                      labelText: AppStrings.locationCoordinatesLabel,
                      hintText: AppStrings.locationCoordinatesHint,
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) => viewModel.setCapacity(int.parse(value)),
                    validator: (value) => viewModel.validateCapacity(value),
                    decoration: const InputDecoration(
                      labelText: AppStrings.capacityLabel,
                      hintText: AppStrings.capacityHint,
                    ),
                  ),
                  Column(
                    children: viewModel.solarTrackers.map((serialNumber) {
                      return Row(
                        children: [
                          Text(
                            serialNumber,
                            style: const TextStyle(
                              fontSize: 20,
                              backgroundColor: Colors.green,
                            ),
                          ),
                          IconButton(
                            onPressed: () => viewModel.removeSolarTracker(serialNumber),
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  ElevatedButton(
                    onPressed: () async => await viewModel.addSolarTracker(),
                    child: const Text(AppStrings.addSolarTrackerButton),
                  ),
                  Text(viewModel.weatherStation ?? ''),
                  ElevatedButton(
                    onPressed:
                        viewModel.isAddWSButtonEnabled() ? () async => await viewModel.addWeatherStation() : null,
                    child: const Text(AppStrings.addWeatherStationButton),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await viewModel.addNewLocation().then((result) {
                        if (result != null) {
                          completer(SheetResponse(confirmed: true, data: result));
                        }
                      });
                    },
                    child: const Text('Add Location'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
