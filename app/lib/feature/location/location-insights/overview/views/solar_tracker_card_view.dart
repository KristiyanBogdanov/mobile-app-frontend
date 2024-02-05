import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';

class SolarTrackerCardView extends StatelessWidget {
  final String serialNumber;
  final int capacity;
  final bool isActive;
  final VoidCallback onTap;

  const SolarTrackerCardView({
    required this.serialNumber,
    required this.capacity,
    required this.isActive,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppStyle.secondaryColor1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyle.borderRadius20),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppStyle.borderRadius20),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppStyle.horizontalPadding16,
            vertical: AppStyle.verticalPadding12,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                serialNumber,
                style: TextStyle(
                  fontSize: AppStyle.fontSize16,
                  fontWeight: FontWeight.w500,
                  color: AppStyle.textColor,
                ),
              ),
              SizedBox(height: AppStyle.verticalPadding16),
              Row(
                children: [
                  PVSystemIndicatorView(
                    indicatorName: AppStrings.capacity,
                    indicatorValue: '$capacity ${AppStrings.slots}',
                    assetIcon: 'assets/icons/capacity.png',
                    iconSize: AppStyle.iconSize28,
                  ),
                  SizedBox(width: AppStyle.horizontalPadding20),
                  IsActiveView(isActive: isActive),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
