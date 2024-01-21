import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';

class AppBarView extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const AppBarView({
    required this.title,
    this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppStyle.bgColor,
      foregroundColor: AppStyle.iconColor,
      shape: const Border(
        bottom: BorderSide(color: AppStyle.secondaryColor2),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppStyle.textColor,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
