import 'dart:io';

import 'package:app/api/invitation/dto/respond_to_invitation_dto.dart';
import 'package:app/api/location/index.dart';
import 'package:app/api/user/dto/invite_user_to_location_dto.dart';
import 'package:app/api/user/index.dart';
import 'package:app/util/api/mobile_app_api.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/index.dart';

class UserService {
  final _httpService = DependencyInjection.getIt<HttpService>();
  final _mobileAppApi = DependencyInjection.getIt<MobileAppApi>();

  Future<UserModel> fetchData() async {
    final response = await _httpService.get(_mobileAppApi.fetchUserData());
    return UserModel.fromJson(response.data);
  }

  Future<LocationModel> addNewLocation(NewLocationDto data) async {
    final response = await _httpService.post(
      _mobileAppApi.addNewLocation(),
      data: data,
      customExceptions: {
        HttpStatus.badRequest: BadRequestApiException(),
      },
    );

    return LocationModel.fromJson(response.data);
  }

  Future<void> inviteUserToLocation(String locationId, String email) async {
    final inviteUserDto = InviteUserToLocationDto(invitedUserEmail: email, locationId: locationId);
    await _httpService.post(
      _mobileAppApi.inviteUserToLocation(),
      data: inviteUserDto,
      customExceptions: {
        HttpStatus.notFound: UserNotFoundException(),
      },
    );
  }

  Future<void> respondToInvitation(String invitationId, String locationId, bool accepted) async {
    final respondDto = RespondToInvitationDto(locationId: locationId, accepted: accepted);
    await _httpService.delete(_mobileAppApi.respondToInvitation(invitationId), data: respondDto);
  }

  Future<void> removeUserFromLocation(String locationId, String userId) async {
    await _httpService.delete(_mobileAppApi.removeUserFromLocation(locationId, userId));
  }

  Future<void> deleteHwNotification(String notificationId) async {
    await _httpService.delete(_mobileAppApi.deleteHwNotification(notificationId));
  }

  Future<void> deleteLocation(String locationUuid) async {
    await _httpService.delete(_mobileAppApi.removeLocation(locationUuid));
  }
}
