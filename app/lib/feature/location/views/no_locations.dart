import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoLocationsView extends StatelessWidget {
  const NoLocationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/images/no-locations.svg',
          width: AppStyle.noLocationsViewImageSize,
          height: AppStyle.noLocationsViewImageSize,
        ),
        SizedBox(height: AppStyle.verticalPadding24),
        Text(
          AppStrings.noLocationsTitle,
          style: TextStyle(
            color: AppStyle.textColor,
            fontSize: AppStyle.fontSize18,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: AppStyle.verticalPadding12),
        Text(
          AppStrings.noLocationsDescription,
          style: TextStyle(
            color: AppStyle.textColor.withOpacity(0.7),
            fontSize: AppStyle.fontSize14,
          ),
        ),
      ],
    ));
  }
}
