import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class NotSharedCardView extends StatelessWidget {
  const NotSharedCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppStyle.notSharedCardHeight,
      child: Card(
        color: AppStyle.secondaryColor1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppStyle.borderRadius20),
        ),
        child: Center(
          child: Text(
            AppStrings.notSharedWithAnyoneYet,
            style: TextStyle(
              fontSize: AppStyle.fontSize16,
              fontWeight: FontWeight.w500,
              color: AppStyle.textColorWith07Opacity,
            ),
          ),
        ),
      ),
    );
  }
}
