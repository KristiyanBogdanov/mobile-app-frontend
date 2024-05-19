import 'package:app/api/firebase/firebase_api.dart';
import 'package:app/api/invitation/model/invitation_model.dart';
import 'package:app/feature/notification/notifications_view_model.dart';
import 'package:app/feature/notification/views/index.dart';
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
              Consumer2<NotificationsViewModel, FirebaseApi>(
                builder: (context, viewModel, _, child) {
                  return Expanded(
                    child: viewModel.notifications.isEmpty
                        ? const NoContentView(
                            svgAsset: AppImages.noNotifications,
                            title: AppStrings.noNotificationsTitle,
                            description: AppStrings.noNotificationsDescription,
                          )
                        : ListView.builder(
                            itemCount: viewModel.notifications.length,
                            itemBuilder: (context, index) {
                              final notification = viewModel.notifications[index];

                              if (notification is InvitationModel) {
                                return InvitationView(
                                  invitation: notification,
                                  onAccept: () async => await viewModel.acceptInvitation(notification),
                                  onReject: () async => await viewModel.rejectInvitation(notification),
                                );
                              }

                              return HwNotificationView(
                                notification: notification,
                                onDelete: (context) async => await viewModel.deleteNotification(notification),
                              );
                            },
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
