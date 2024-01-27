import 'dart:io';

import 'package:app/api/hw-notification/index.dart';
import 'package:app/util/api/index.dart';
import 'package:app/util/dependency_injection/index.dart';
import 'package:app/util/http/index.dart';

class HwNotificationService {
  final _httpService = DependencyInjection.getIt<HttpService>();
  final _mobileAppApi = DependencyInjection.getIt<MobileAppApi>();

  Future<void> markAsSeen(String notificationId) async {
    final dto = UpdateHwNotificationStatusDto(NotificationStatus.seen);

    final response = await _httpService.patch(
      _mobileAppApi.updateHwNotificationStatus(notificationId),
      dto.toJson(),
    );

    switch (response.statusCode) {
      case HttpStatus.ok:
        return;
      default:
        throw UnknownApiException();
    }
  }

  Future<void> delete(String notificationId) async {
    final response = await _httpService.delete(
      _mobileAppApi.deleteHwNotification(notificationId),
    );

    switch (response.statusCode) {
      case HttpStatus.noContent:
        return;
      default:
        throw UnknownApiException();
    }
  }
}
