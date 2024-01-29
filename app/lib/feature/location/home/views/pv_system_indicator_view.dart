import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class PVSystemIndicatorView extends StatelessWidget {
  final String indicatorName;
  final String indicatorValue;
  final String assetIcon;

  const PVSystemIndicatorView({
    required this.indicatorName,
    required this.indicatorValue,
    required this.assetIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          assetIcon,
          width: AppStyle.iconSize40,
          height: AppStyle.iconSize40,
        ),
        SizedBox(width: AppStyle.horizontalPadding8),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              indicatorValue,
              style: TextStyle(
                color: AppStyle.textColor,
                fontSize: AppStyle.fontSize10,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: AppStyle.verticalPadding4),
            Text(
              indicatorName,
              style: TextStyle(
                color: AppStyle.textColor,
                fontSize: AppStyle.fontSize10,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
