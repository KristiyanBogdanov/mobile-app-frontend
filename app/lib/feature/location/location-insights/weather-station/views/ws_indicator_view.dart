import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class WSIndicatorView extends StatelessWidget {
  final String assetName;
  final String title;
  final String value;

  const WSIndicatorView({
    super.key,
    required this.assetName,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          assetName,
          width: AppStyle.iconSize24,
          height: AppStyle.iconSize24,
        ),
        SizedBox(height: AppStyle.verticalPadding4),
        Text(
          title,
          style: TextStyle(
            fontSize: AppStyle.fontSize12,
            color: AppStyle.textColorWith07Opacity,
          ),
        ),
        SizedBox(height: AppStyle.verticalPadding8),
        Text(
          value,
          style: TextStyle(
            fontSize: AppStyle.fontSize14,
            fontWeight: FontWeight.bold,
            color: AppStyle.textColor,
          ),
        ),
      ],
    );
  }
}
