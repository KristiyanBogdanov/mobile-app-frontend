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
          appBar: const AppBarView(
            title: AppStrings.notificationsPageTitle,
          ),
          body: Consumer<NotificationsViewModel>(
            builder: (context, viewModel, child) {
              return viewModel.notifications.isEmpty
                  ? const NoContentView(
                      svgAsset: 'assets/images/no-notifications.svg',
                      title: AppStrings.noNotificationsTitle,
                      description: AppStrings.noNotificationsDescription,
                    )
                  : ListView.builder(
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
          )),
    );
  }
}
