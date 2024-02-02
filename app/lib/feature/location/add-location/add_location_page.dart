import 'package:app/feature/location/add-location/add_location_view_model.dart';
import 'package:app/feature/location/add-location/views/index.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddLocationPage extends StatelessWidget {
  const AddLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddLocationViewModel(),
      child: Consumer<AddLocationViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: AppStyle.bgColor,
            appBar: const AppBarView(
              title: AppStrings.addNewLocationPageTitle,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppStyle.horizontalPadding16,
                vertical: AppStyle.verticalPadding16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ColumnSectionTitleView(title: AppStrings.locationNameSectionTitle),
                      TextFieldView(
                        onChanged: (value) => viewModel.setName(value),
                        errorText: viewModel.nameError,
                      ),
                      const ColumnSpacingView(),
                      const ColumnSectionTitleView(title: AppStrings.capacitySectionTitle),
                      TextFieldView(
                        keyboardType: TextInputType.number,
                        onChanged: (value) => viewModel.setCapacity(value),
                        errorText: viewModel.capacityError,
                      ),
                      const ColumnSpacingView(),
                      const ColumnSectionTitleView(title: AppStrings.locationCoordinatesSectionTitle),
                      const ColumnSpacingView(),
                      const ColumnSectionTitleView(title: AppStrings.solarTrackersSectionTitle),
                      DevicesRowView(
                        onAddButtonPressed: viewModel.addSolarTracker,
                        devices: viewModel.solarTrackers.map((serialNumber) {
                          return DeviceBoxView(
                            label: serialNumber,
                            onRemovePressed: () => viewModel.removeSolarTracker(serialNumber),
                          );
                        }).toList(),
                      ),
                      const ColumnSpacingView(),
                      const ColumnSectionTitleView(title: AppStrings.weatherStationSectionTitle),
                      DevicesRowView(
                        isAddButtonVisible: viewModel.isAddWSButtonEnabled,
                        onAddButtonPressed: () async => await viewModel.addWeatherStation(),
                        devices: viewModel.weatherStation != null
                            ? [
                                DeviceBoxView(
                                  label: viewModel.weatherStation!,
                                  onRemovePressed: viewModel.removeWeatherStation,
                                ),
                              ]
                            : [],
                      ),
                    ],
                  ),
                  PrimaryButton(
                    text: AppStrings.addLocationButton,
                    onPressed: () async => await viewModel.addNewLocation(),
                    isDisabled: viewModel.isAddLocationButtonDisabled,
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
