import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class IsActiveView extends StatelessWidget {
  final bool isActive;

  const IsActiveView({
    required this.isActive,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: AppStyle.iconSize12,
          color: isActive ? AppStyle.positiveColor : AppStyle.negativeColor,
        ),
        SizedBox(width: AppStyle.horizontalPadding8),
        Text(
          isActive ? AppStrings.active : AppStrings.inactive,
          style: TextStyle(
            fontSize: AppStyle.fontSize14,
            color: AppStyle.textColorWith07Opacity,
          ),
        ),
      ],
    );
  }
}
