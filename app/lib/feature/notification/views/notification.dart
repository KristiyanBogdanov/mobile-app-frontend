import 'package:app/api/hw-notification/index.dart';
import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' hide DeviceType;

class NotificationView extends StatelessWidget {
  final HwNotificationModel notification;
  final VoidCallback onTap;
  final VoidCallback onDismissed;

  const NotificationView({
    super.key,
    required this.notification,
    required this.onTap,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(notification.id),
      onDismissed: (_) => onDismissed(),
      child: ListTile(
        tileColor: notification.status == NotificationStatus.active ? AppStyle.secondaryColor2 : AppStyle.bgColor,
        onTap: onTap,
        leading: Image.asset(
          notification.deviceType == DeviceType.solarTracker
              ? 'assets/icons/solar-trackers.png'
              : 'assets/icons/weather-station-avatar.png',
          width: AppStyle.iconSize40,
          height: AppStyle.iconSize40,
        ),
        title: title,
        subtitle: Padding(
          padding: EdgeInsets.only(top: AppStyle.verticalPadding10),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    notification.parseImportance,
                    style: TextStyle(
                      color: AppStyle.textColor.withOpacity(0.7), // TODO: change to importanceColor (see below
                      fontSize: AppStyle.fontSize12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: AppStyle.horizontalPadding8,
                //     vertical: AppStyle.verticalPadding4,
                //   ),
                //   // decoration: BoxDecoration(
                //   //   color: importanceColor,
                //   //   borderRadius: BorderRadius.circular(AppStyle.borderRadius18),
                //   // ),
                //   child: Text(
                //     notification.parseImportance,
                //     style: TextStyle(
                //       color: AppStyle.textColor,
                //       fontSize: AppStyle.fontSize12,
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                // ),
                SizedBox(width: AppStyle.horizontalPadding4),
                Text(
                  notification.parseTimestamp,
                  style: TextStyle(
                    fontSize: AppStyle.fontSize12,
                    color: AppStyle.textColor.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color get importanceColor {
    switch (notification.importance) {
      case HwNotificationImportance.information:
        return AppStyle.contrastColor1;
      case HwNotificationImportance.warning:
        return Colors.yellow[900]!.withOpacity(0.85);
      case HwNotificationImportance.critical:
        return Colors.red[800]!.withOpacity(0.85);
    }
  }

  String get importanceAsset {
    switch (notification.importance) {
      case HwNotificationImportance.information:
        return 'assets/icons/info.png';
      case HwNotificationImportance.warning:
        return 'assets/icons/warning.png';
      case HwNotificationImportance.critical:
        return 'assets/icons/critical.png';
    }
  }

  IconData get importanceIcon {
    switch (notification.importance) {
      case HwNotificationImportance.information:
        return Icons.info_rounded;
      case HwNotificationImportance.warning:
        return Icons.warning_rounded;
      case HwNotificationImportance.critical:
        return Icons.error_rounded;
    }
  }

  Widget get title {
    if (notification.message.contains(notification.serialNumber)) {
      return RichText(
        text: TextSpan(
          style: TextStyle(
            color: AppStyle.textColor,
            fontSize: AppStyle.fontSize14,
          ),
          children: [
            TextSpan(
              text:
                  '${notification.importance.name.toUpperCase()}: ${notification.message.split(notification.serialNumber)[0]}',
            ),
            TextSpan(
              text: notification.serialNumber,
              style: const TextStyle(
                color: AppStyle.contrastColor1,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: notification.message.split(notification.serialNumber)[1],
            ),
          ],
        ),
      );
    } else {
      return Text(
        '${notification.importance.name.toUpperCase()} ${notification.message}',
        style: TextStyle(
          color: AppStyle.textColor,
          fontSize: AppStyle.fontSize14,
        ),
      );
    }
  }
}
