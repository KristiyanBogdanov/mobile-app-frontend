import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';

class SensorStatusCardView extends StatelessWidget {
  final String assetName;
  final String sensorName;
  final bool isActive;

  const SensorStatusCardView({
    super.key,
    required this.assetName,
    required this.sensorName,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppStyle.secondaryColor1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyle.borderRadius16),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppStyle.horizontalPadding16,
          vertical: AppStyle.verticalPadding16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  assetName,
                  height: AppStyle.iconSize40,
                  width: AppStyle.iconSize40,
                ),
                SizedBox(width: AppStyle.horizontalPadding20),
                IsActiveView(isActive: isActive),
              ],
            ),
            SizedBox(height: AppStyle.verticalPadding8),
            Text(
              sensorName,
              overflow: TextOverflow.ellipsis, // TODO: reconsider
              style: TextStyle(
                color: AppStyle.textColor,
                fontSize: AppStyle.fontSize16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
