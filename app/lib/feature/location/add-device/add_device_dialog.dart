import 'package:app/feature/location/add-device/index.dart';
import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';

class AddDeviceDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  final AddDeviceViewModel _viewModel;

  AddDeviceDialog({
    required this.request,
    required this.completer,
    super.key,
  }) : _viewModel = request.data as AddDeviceViewModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Dialog(
        child: Column(
          children: [
            Consumer<AddDeviceViewModel>(
              builder: (context, viewModel, child) {
                return TextField(
                  onChanged: (value) => viewModel.setSerialNumber(value),
                  decoration: InputDecoration(
                    labelText: viewModel.deviceType == DeviceType.solarTracker
                        ? AppStrings.solarTrackerLabel
                        : AppStrings.weatherStationLabel,
                    hintText: viewModel.deviceType == DeviceType.solarTracker
                        ? AppStrings.solarTrackerHint
                        : AppStrings.weatherStationHint,
                    errorText: viewModel.serialNumberError,
                  ),
                );
              },
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  onPressed: () => completer(DialogResponse(confirmed: false)),
                  child: Text(
                    AppStrings.cancelButton,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                MaterialButton(
                  onPressed: () async {
                    await _viewModel.addDevice().then((serialNumber) {
                      if (serialNumber != null) {
                        completer(DialogResponse(confirmed: true, data: serialNumber));
                      }
                    });
                  },
                  child: Text(
                    AppStrings.addDeviceButton,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
