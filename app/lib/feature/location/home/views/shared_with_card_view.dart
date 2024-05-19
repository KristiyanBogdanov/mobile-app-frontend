import 'package:app/api/user/model/brief_user_info_model.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';

class SharedWithCardView extends StatelessWidget {
  final List<BriefUserInfoModel> sharedWith;
  final List<BriefUserInfoModel> _firstFewSharedWith = [];
  late final bool _isSharedWithMoreThanTwo;

  SharedWithCardView({
    required this.sharedWith,
    super.key,
  }) {
    _isSharedWithMoreThanTwo = sharedWith.length > AppStyle.maxSharedWith;

    for (int i = 0; i < (_isSharedWithMoreThanTwo ? AppStyle.maxSharedWith : sharedWith.length); ++i) {
      _firstFewSharedWith.add(sharedWith[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return sharedWith.isEmpty
        ? Text(
            AppStrings.notShared,
            style: TextStyle(
              color: AppStyle.textColor,
              fontSize: AppStyle.fontSize12,
            ),
          )
        : Row(
            children: [
              ..._firstFewSharedWith.map((user) {
                return UserAvatarView(
                  initial: user.username[0].toUpperCase(),
                  widthFactor: AppStyle.avatarWidthFactor,
                );
              }),
              _isSharedWithMoreThanTwo
                  ? UserAvatarView(
                      initial: '+${sharedWith.length - AppStyle.maxSharedWith}',
                      color: AppStyle.textColor,
                      widthFactor: AppStyle.avatarWidthFactor,
                    )
                  : const SizedBox(),
              SizedBox(width: AppStyle.horizontalPadding20),
              Text(
                AppStrings.sharedWith(sharedWith.length),
                style: TextStyle(
                  color: AppStyle.textColor,
                  fontSize: AppStyle.fontSize12,
                ),
              ),
            ],
          );
  }
}
