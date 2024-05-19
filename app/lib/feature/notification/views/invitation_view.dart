import 'package:app/api/invitation/model/invitation_model.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';

class InvitationView extends StatelessWidget {
  final InvitationModel invitation;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const InvitationView({
    required this.invitation,
    required this.onAccept,
    required this.onReject,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppStyle.secondaryColor2,
      child: ListTile(
        leading: UserAvatarView(
          initial: invitation.ownerUsername[0],
          radius: AppStyle.iconSize20,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                AppStrings.invitationTitle(invitation.ownerUsername, invitation.locationName),
                style: TextStyle(
                  fontSize: AppStyle.fontSize14,
                  fontWeight: FontWeight.w500,
                  color: AppStyle.textColor,
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: onReject,
                  icon: Icon(
                    Icons.close_rounded,
                    color: AppStyle.negativeColor,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: AppStyle.negativeColor.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppStyle.borderRadius24),
                    ),
                    padding: EdgeInsets.all(AppStyle.verticalPadding10),
                  ),
                ),
                SizedBox(width: AppStyle.horizontalPadding4),
                IconButton(
                  onPressed: onAccept,
                  icon: const Icon(
                    Icons.check,
                    color: AppStyle.contrastColor1,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: AppStyle.contrastColor1.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppStyle.borderRadius24),
                    ),
                    padding: EdgeInsets.all(AppStyle.verticalPadding10),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
