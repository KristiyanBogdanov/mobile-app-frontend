import 'dart:io';

import 'package:app/api/hw-notification/index.dart';
import 'package:app/util/api/index.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/index.dart';

class HwNotificationService {
  final _httpService = DependencyInjection.getIt<HttpService>().instance;
  final _mobileAppApi = DependencyInjection.getIt<MobileAppApi>();

  Future<void> markAsSeen(String notificationId) async {
    final data = UpdateHwNotificationStatusDto(NotificationStatus.seen);

    final response = await _httpService.patch(_mobileAppApi.updateHwNotificationStatus(notificationId), data: data);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return;
      default:
        throw UnknownApiException();
    }
  }

  Future<void> delete(String notificationId) async {
    final response = await _httpService.delete(_mobileAppApi.deleteHwNotification(notificationId));

    switch (response.statusCode) {
      case HttpStatus.noContent:
        return;
      default:
        throw UnknownApiException();
    }
  }
}
