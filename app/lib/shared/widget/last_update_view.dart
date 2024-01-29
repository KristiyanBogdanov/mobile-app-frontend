import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
          '${AppStrings.lastUpdate}: ${_parseLastUpdate()}',
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

  String _parseLastUpdate() {
    final dateTime = DateTime.parse(date);
    final dateFormat = DateFormat('HH:mm dd MMM');

    return dateFormat.format(dateTime);
  }
}
