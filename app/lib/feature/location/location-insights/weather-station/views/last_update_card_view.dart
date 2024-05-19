import 'package:app/feature/location/location-insights/weather-station/views/index.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';

class LastUpdateCardView extends StatelessWidget {
  final String lastUpdate;
  final double? temperature;
  final double? windSpeed;
  final String? windDirection;
  final VoidCallback onRefresh;

  const LastUpdateCardView({
    super.key,
    required this.lastUpdate,
    required this.temperature,
    required this.windSpeed,
    required this.windDirection,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppStyle.secondaryColor1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyle.borderRadius20),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppStyle.horizontalPadding16,
          AppStyle.verticalPadding8,
          AppStyle.horizontalPadding16,
          AppStyle.verticalPadding16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LastUpdateView(
              date: lastUpdate,
              onRefresh: onRefresh,
            ),
            SizedBox(height: AppStyle.verticalPadding20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WSIndicatorView(
                  assetName: 'assets/icons/temp.png',
                  title: AppStrings.temperature,
                  value: temperature != null ? AppStrings.temperatureValue(temperature!) : AppStrings.na,
                ),
                WSIndicatorView(
                  assetName: 'assets/icons/wind-speed.png',
                  title: AppStrings.windSpeed,
                  value: windSpeed != null ? AppStrings.windSpeedValue(windSpeed!) : AppStrings.na,
                ),
                WSIndicatorView(
                  assetName: 'assets/icons/wind-direction.png',
                  title: AppStrings.windDirection,
                  value: windDirection ?? AppStrings.na,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
