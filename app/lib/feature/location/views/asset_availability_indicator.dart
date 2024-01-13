import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class AssetAvailabilityIndicatorView extends StatelessWidget {
  final String assetName;
  final String assetIcon;
  final bool isAvailable;

  const AssetAvailabilityIndicatorView({
    required this.assetName,
    required this.assetIcon,
    required this.isAvailable,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageIcon(
          AssetImage(assetIcon),
          color: AppStyle.iconColor,
        ),
        SizedBox(width: AppStyle.horizontalPadding8),
        Text(
          assetName,
          style: TextStyle(
            fontSize: AppStyle.fontSize12,
            color: AppStyle.textColor,
          ),
        ),
        SizedBox(width: AppStyle.horizontalPadding8),
        ImageIcon(
          AssetImage(
            isAvailable ? 'assets/icons/available.png' : 'assets/icons/non-available.png',
          ),
          size: AppStyle.iconSize20,
          color: isAvailable ? Colors.green : Colors.red,
        )
      ],
    );
  }
}
