import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class TabView extends StatelessWidget {
  final String title;

  const TabView({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        title,
        style: TextStyle(
          fontSize: AppStyle.fontSize14,
        ),
      ),
    );
  }
}
