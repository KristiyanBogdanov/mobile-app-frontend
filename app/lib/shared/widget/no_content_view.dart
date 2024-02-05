import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoContentView extends StatelessWidget {
  final String svgAsset;
  final String title;
  final String? description;
  final Function()? onActionButtonPressed;

  const NoContentView({
    super.key,
    required this.svgAsset,
    required this.title,
    this.description,
    this.onActionButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgAsset,
            width: AppStyle.noContentViewImageSize,
            height: AppStyle.noContentViewImageSize,
          ),
          SizedBox(height: AppStyle.verticalPadding24),
          Text(
            title,
            style: TextStyle(
              color: AppStyle.textColor,
              fontSize: AppStyle.fontSize18,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (description != null)
            Padding(
              padding: EdgeInsets.only(top: AppStyle.verticalPadding12),
              child: Text(
                description!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppStyle.textColorWith07Opacity,
                  fontSize: AppStyle.fontSize14,
                ),
              ),
            ),
          if (onActionButtonPressed != null)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppStyle.horizontalPadding30,
                vertical: AppStyle.verticalPadding28,
              ),
              child: PrimaryButton(
                text: AppStrings.addWeatherStationButtonLabel,
                onPressed: onActionButtonPressed!,
              ),
            ),
        ],
      ),
    );
  }
}
