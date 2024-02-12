import 'package:app/api/hw-notification/index.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/util/extension/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HwNotificationView extends StatelessWidget {
  final HwNotificationModel notification;
  final Function(BuildContext) onDelete;

  const HwNotificationView({
    super.key,
    required this.notification,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(notification.id),
      endActionPane: ActionPane(
        extentRatio: AppStyle.hwNotificationExtentRatio,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: onDelete,
            backgroundColor: AppStyle.negativeColor,
            foregroundColor: AppStyle.iconColor,
            icon: Icons.delete_rounded,
            label: AppStrings.delete,
          ),
        ],
      ),
      child: ListTile(
        leading: Image.asset(
          notification.deviceType == DeviceType.solarTracker
              ? AppImages.solarTrackerAvatar
              : AppImages.weatherStationAvatar,
          width: AppStyle.iconSize40,
          height: AppStyle.iconSize40,
        ),
        title: title,
        subtitle: Padding(
          padding: EdgeInsets.only(top: AppStyle.verticalPadding10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  notification.advice,
                  style: TextStyle(
                    color: AppStyle.textColorWith07Opacity,
                    fontSize: AppStyle.fontSize12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(width: AppStyle.horizontalPadding4),
              Text(
                notification.timestamp.parseTimestamp,
                style: TextStyle(
                  fontSize: AppStyle.fontSize12,
                  color: AppStyle.textColorWith07Opacity,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get title {
    if (notification.message.contains(notification.serialNumber)) {
      return RichText(
        text: TextSpan(
          style: TextStyle(
            fontFamily: 'Nunito',
            color: AppStyle.textColor,
            fontSize: AppStyle.fontSize14,
          ),
          children: [
            TextSpan(
              text: '[${notification.parseImportance}] ${notification.message.split(notification.serialNumber)[0]}',
            ),
            TextSpan(
              text: notification.serialNumber,
              style: const TextStyle(
                color: AppStyle.contrastColor1,
                fontWeight: FontWeight.w600,
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
        '[${notification.parseImportance}] ${notification.message}',
        style: TextStyle(
          color: AppStyle.textColor,
          fontSize: AppStyle.fontSize14,
        ),
      );
    }
  }
}

//TODO: add IntrinsicHeight if needed (row 46)