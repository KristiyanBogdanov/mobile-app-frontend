import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class STIndicatorView extends StatelessWidget {
  final String title;
  final num? value;
  final num? deviation;

  const STIndicatorView({
    super.key,
    required this.title,
    required this.value,
    required this.deviation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppStyle.textColorWith07Opacity,
            fontSize: AppStyle.fontSize14,
          ),
        ),
        SizedBox(height: AppStyle.verticalPadding4),
        Text(
          value == null ? AppStrings.na : '${value!}° (${AppStrings.deviation(deviation ?? 0)})',
          style: TextStyle(
            color: AppStyle.textColor,
            fontSize: AppStyle.fontSize14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
