import 'package:app/feature/location/add-location/views/device_box_view.dart';
import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class DevicesRowView extends StatelessWidget {
  final Function()? onAddButtonPressed;
  final List<DeviceBoxView> devices;

  const DevicesRowView({
    required this.onAddButtonPressed,
    required this.devices,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppStyle.deviceRowHeight,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          IconButton(
            onPressed: onAddButtonPressed,
            icon: const Icon(
              Icons.add_rounded,
              color: AppStyle.iconColor,
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppStyle.borderRadius12),
                side: BorderSide(
                  color: onAddButtonPressed == null ? Colors.grey.withOpacity(0.5) : AppStyle.contrastColor1,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: AppStyle.horizontalPadding12),
            ),
          ),
          ...devices,
        ],
      ),
    );
  }
}
