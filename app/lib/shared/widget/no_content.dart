import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoContentView extends StatelessWidget {
  final String svgAsset;
  final String title;
  final String description;

  const NoContentView({
    super.key,
    required this.svgAsset,
    required this.title,
    required this.description,
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
          SizedBox(height: AppStyle.verticalPadding12),
          Text(
            description,
            style: TextStyle(
              color: AppStyle.textColor.withOpacity(0.7),
              fontSize: AppStyle.fontSize14,
            ),
          ),
        ],
      ),
    );
  }
}
