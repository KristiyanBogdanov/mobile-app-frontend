import 'dart:math';

import 'package:app/api/user/model/brief_user_info_model.dart';
import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class SharedWithRowView extends StatelessWidget {
  final List<BriefUserInfoModel> sharedWith;
  final List<BriefUserInfoModel> _firstFewSharedWith = [];
  late final bool _isSharedWithMoreThanTwo;
  final List _colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.orange,
    Colors.indigoAccent,
    Colors.teal,
    Colors.brown,
    Colors.blueGrey
  ];

  SharedWithRowView({
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
                return _buildAvatar(user.username[0].toUpperCase(), null);
              }),
              _isSharedWithMoreThanTwo
                  ? _buildAvatar('+${sharedWith.length - AppStyle.maxSharedWith}', AppStyle.textColor)
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

  Widget _buildAvatar(String initial, Color? color) {
    return Align(
      alignment: Alignment.centerLeft,
      widthFactor: AppStyle.avatarWidthFactor,
      child: CircleAvatar(
        radius: AppStyle.borderRadius18,
        backgroundColor: color ?? _colors[Random().nextInt(_colors.length)],
        child: Text(
          initial,
          style: TextStyle(
            color: color != null ? Colors.black : Colors.white,
            fontSize: AppStyle.fontSize12,
          ),
        ),
      ),
    );
  }
}
