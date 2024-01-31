import 'dart:convert';
import 'dart:io';

import 'package:app/api/location/index.dart';
import 'package:app/api/user/exception/index.dart';
import 'package:app/api/user/model/index.dart';
import 'package:app/shared/constant/app_strings.dart';
import 'package:app/util/api/index.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/index.dart';

class UserService {
  final _httpService = DependencyInjection.getIt<HttpService>();
  final _mobileAppApi = DependencyInjection.getIt<MobileAppApi>();

  Future<UserModel> fetchData() async {
    final response = await _httpService.get(_mobileAppApi.fetchUserData());

    final jsonBody = jsonDecode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return UserModel.fromJson(jsonBody);
      case HttpStatus.unauthorized || HttpStatus.notFound:
        throw UnauthorizedApiException();
      default:
        throw UnknownApiException();
    }
  }

  Future<LocationModel> addNewLocation(NewLocationDto data) async {
    final response = await _httpService.post(
      _mobileAppApi.addNewLocation(),
      data.toJson(),
    );

    final jsonBody = jsonDecode(response.body);

    switch (response.statusCode) {
      case HttpStatus.created:
        return LocationModel.fromJson(jsonBody);
      case HttpStatus.unauthorized || HttpStatus.notFound:
        throw UnauthorizedApiException();
      case HttpStatus.conflict:
        throw STSerialNumberAlreadyUsedException();
      case HttpStatus.badRequest:
        // throw BadRequestApiException(jsonBody, AppStrings.addNewLocationBadRequest);
      default:
        throw UnknownApiException();
    }
  }

  Future<LocationModel> addExistingLocation(String locationUuid) async {
    final response = await _httpService.post(
      _mobileAppApi.addExistingLocation(locationUuid),
      null,
    );

    final jsonBody = jsonDecode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return LocationModel.fromJson(jsonBody);
      case HttpStatus.unauthorized || HttpStatus.notFound:
        throw UnauthorizedApiException();
      case HttpStatus.conflict:
        throw LocationAlreadyAddedException();
      case HttpStatus.badRequest:
        // throw BadRequestApiException(jsonBody, AppStrings.addExistingLocationBadRequest);
      default:
        throw UnknownApiException();
    }
  }
}
