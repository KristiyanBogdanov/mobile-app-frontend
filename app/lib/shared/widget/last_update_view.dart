import 'package:app/shared/constant/index.dart';
import 'package:app/util/extension/string_extensions.dart';
import 'package:flutter/material.dart';

class LastUpdateView extends StatelessWidget {
  final String date;
  final VoidCallback onRefresh;

  const LastUpdateView({
    super.key,
    required this.date,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${AppStrings.lastUpdate}: ${date.parseWithDateFormat('HH:mm dd MMM')}',
          style: TextStyle(
            fontSize: AppStyle.fontSize12,
            color: AppStyle.textColor,
          ),
        ),
        IconButton(
          onPressed: onRefresh,
          icon: Icon(
            Icons.refresh,
            size: AppStyle.iconSize20,
            color: AppStyle.textColor,
          ),
        ),
      ],
    );
  }
}
