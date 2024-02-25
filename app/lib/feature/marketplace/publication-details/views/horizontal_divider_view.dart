import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class HorizontalDividerView extends StatelessWidget {
  const HorizontalDividerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppStyle.verticalPadding8),
      child: const Divider(
        color: AppStyle.lineChartMainGridLineColor,
      ),
    );
  }
}
