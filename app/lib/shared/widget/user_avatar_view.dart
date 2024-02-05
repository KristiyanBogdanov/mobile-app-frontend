import 'dart:math';

import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class UserAvatarView extends StatelessWidget {
  final String initial;
  final Color? color;
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

  UserAvatarView({
    required this.initial,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      widthFactor: AppStyle.avatarWidthFactor,
      child: CircleAvatar(
        radius: AppStyle.borderRadius18,
        backgroundColor: color ?? _colors[Random().nextInt(_colors.length)],
        child: Text(
          initial,
          style: TextStyle(
            fontSize: AppStyle.fontSize12,
            fontWeight: FontWeight.w500,
            color: color != null ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
