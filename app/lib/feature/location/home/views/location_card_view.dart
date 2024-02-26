import 'package:app/api/location/model/location_model.dart';
import 'package:app/feature/location/home/views/index.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';

class LocationCardView extends StatelessWidget {
  final VoidCallback onTap;
  final LocationModel locationModel;

  const LocationCardView({
    required this.onTap,
    required this.locationModel,
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
            vertical: AppStyle.verticalPadding16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                locationModel.name,
                style: TextStyle(
                  fontSize: AppStyle.fontSize18,
                  fontWeight: FontWeight.w600,
                  color: AppStyle.textColor,
                ),
              ),
              SizedBox(height: AppStyle.verticalPadding20),
              Row(
                children: [
                  DeviceAvailabilityIndicatorView(
                    assetName: AppStrings.weatherStation,
                    assetIcon: AppImages.weatherStation,
                    isAvailable: locationModel.weatherStation != null ? true : false,
                  ),
                  SizedBox(width: AppStyle.horizontalPadding16),
                  DeviceAvailabilityIndicatorView(
                    assetName: AppStrings.cctv,
                    assetIcon: AppImages.cctv,
                    isAvailable: locationModel.cctv != null ? true : false,
                  ),
                ],
              ),
              SizedBox(height: AppStyle.verticalPadding24),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PVSystemIndicatorView(
                      indicatorName: AppStrings.capacity,
                      indicatorValue: '${locationModel.capacity.toString()} ${AppStrings.slots}',
                      assetIcon: AppImages.capacityAvatar,
                      iconSize: AppStyle.iconSize40,
                    ),
                    SizedBox(width: AppStyle.horizontalPadding30),
                    VerticalDivider(
                      color: AppStyle.dividerColor,
                      thickness: AppStyle.dividerThickness,
                      indent: AppStyle.dividerIndent,
                      endIndent: AppStyle.dividerIndent,
                    ),
                    SizedBox(width: AppStyle.horizontalPadding30),
                    PVSystemIndicatorView(
                      indicatorName: AppStrings.installedSolarTrackers(locationModel.solarTrackers.length),
                      indicatorValue: '${locationModel.solarTrackers.length} ${AppStrings.installed}',
                      assetIcon: AppImages.solarTrackerAvatar,
                      iconSize: AppStyle.iconSize40,
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppStyle.verticalPadding24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SharedWithCardView(sharedWith: locationModel.sharedWith),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppStyle.iconColor,
                    size: AppStyle.iconSize20,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
