import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class DeviceBoxView extends StatelessWidget {
  final String label;
  final Function() onRemovePressed;

  const DeviceBoxView({
    required this.label,
    required this.onRemovePressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppStyle.deviceBoxHeight,
      padding: EdgeInsets.only(left: AppStyle.horizontalPadding12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppStyle.borderRadius12),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppStyle.textColor,
              fontSize: AppStyle.fontSize14,
            ),
          ),
          IconButton(
            onPressed: onRemovePressed,
            icon: Icon(
              Icons.close_rounded,
              color: AppStyle.iconColor,
              size: AppStyle.iconSize20,
            ),
          ),
        ],
      ),
    );
  }
}
