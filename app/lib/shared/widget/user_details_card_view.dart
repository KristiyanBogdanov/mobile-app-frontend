import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';

class UserDetailsCardView extends StatelessWidget {
  final String username;
  final String email;

  const UserDetailsCardView({
    required this.username,
    required this.email,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppStyle.secondaryColor1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyle.borderRadius20),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppStyle.horizontalPadding16,
          vertical: AppStyle.verticalPadding12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                UserAvatarView(initial: username[0]),
                SizedBox(width: AppStyle.horizontalPadding20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: TextStyle(
                        fontSize: AppStyle.fontSize16,
                        fontWeight: FontWeight.w500,
                        color: AppStyle.textColor,
                      ),
                    ),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: AppStyle.fontSize12,
                        color: AppStyle.textColorWith07Opacity,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
