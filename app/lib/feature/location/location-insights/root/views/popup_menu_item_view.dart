import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class PopupMenuItemView extends PopupMenuItem {
  final int value;
  final String text;

  PopupMenuItemView({
    required this.value,
    required this.text,
    super.key,
  }) : super(
          value: value,
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppStyle.negativeColor,
            ),
          ),
        );
}
