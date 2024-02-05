import 'package:app/feature/location/add-location/views/device_box_view.dart';
import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class DevicesRowView extends StatelessWidget {
  final bool isAddButtonVisible;
  final Function() onAddButtonPressed;
  final List<DeviceBoxView> devices;

  const DevicesRowView({
    this.isAddButtonVisible = true,
    required this.onAddButtonPressed,
    required this.devices,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppStyle.horizontalPadding8,
      runSpacing: AppStyle.verticalPadding8,
      // scrollDirection: Axis.horizontal,
      children: [
        if (isAddButtonVisible)
          IconButton(
            onPressed: onAddButtonPressed,
            icon: const Icon(
              Icons.add_rounded,
              color: AppStyle.iconColor,
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(AppStyle.deviceBoxHeight, AppStyle.deviceBoxHeight),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppStyle.borderRadius12),
                side: const BorderSide(
                  color: AppStyle.contrastColor1,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: AppStyle.horizontalPadding12),
            ),
          ),
        ...devices,
      ],
    );
  }
}
