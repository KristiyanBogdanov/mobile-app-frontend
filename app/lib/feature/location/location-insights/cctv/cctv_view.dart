import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class CCTVView extends StatelessWidget {
  const CCTVView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.code_off_rounded,
            size: AppStyle.iconSize40,
            color: AppStyle.iconColor,
          ),
          SizedBox(height: AppStyle.verticalPadding12),
          Text(
            AppStrings.futureDevelopmentLabel,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppStyle.textColor,
              fontSize: AppStyle.fontSize24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
