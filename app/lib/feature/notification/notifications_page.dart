import 'package:app/feature/notification/notifications_view_model.dart';
import 'package:app/feature/notification/views/notification.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/shared/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotificationsViewModel(),
      child: Scaffold(
        backgroundColor: AppStyle.bgColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  AppStyle.horizontalPadding16,
                  AppStyle.verticalPadding16,
                  AppStyle.horizontalPadding16,
                  AppStyle.verticalPadding8,
                ),
                child: SizedBox(
                  height: AppStyle.customAppBarHeight,
                  child: Text(
                    AppStrings.notificationsPageTitle,
                    style: TextStyle(
                      color: AppStyle.textColor,
                      fontSize: AppStyle.fontSize28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Consumer<NotificationsViewModel>(
                  builder: (context, viewModel, child) {
                    return viewModel.notifications.isEmpty
                        ? const NoContentView(
                            svgAsset: 'assets/images/no-notifications.svg',
                            title: AppStrings.noNotificationsTitle,
                            description: AppStrings.noNotificationsDescription,
                          )
                        : ListView.builder(
                            padding: EdgeInsets.symmetric(
                              vertical: AppStyle.verticalPadding12,
                            ),
                            itemCount: viewModel.notifications.length,
                            itemBuilder: (context, index) {
                              final notification = viewModel.notifications[index];
                              return NotificationView(
                                notification: notification,
                                onTap: () => viewModel.onNotificationTap(notification),
                                onDismissed: () => viewModel.deleteNotification(notification),
                              );
                            },
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
