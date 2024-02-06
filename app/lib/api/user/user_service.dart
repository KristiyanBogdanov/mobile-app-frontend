import 'dart:io';

import 'package:app/api/location/index.dart';
import 'package:app/api/user/exception/index.dart';
import 'package:app/api/user/model/index.dart';
import 'package:app/util/api/mobile_app_api.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/index.dart';
import 'package:dio/dio.dart';

class UserService {
  final _httpService = DependencyInjection.getIt<HttpService>().authRequiredInstance;
  final _mobileAppApi = DependencyInjection.getIt<MobileAppApi>();

  Future<UserModel> fetchData() async {
    try {
      final response = await _httpService.get(_mobileAppApi.fetchUserData());
      return UserModel.fromJson(response.data);
    } on UnauthorizedDioException {
      throw UnauthorizedApiException();
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case HttpStatus.unauthorized:
          throw UnauthorizedApiException();
        default:
          throw UnknownApiException();
      }
    }
  }

  Future<LocationModel> addNewLocation(NewLocationDto data) async {
    try {
      final response = await _httpService.post(_mobileAppApi.addNewLocation(), data: data);
      return LocationModel.fromJson(response.data);
    } on UnauthorizedDioException {
      throw UnauthorizedApiException();
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case HttpStatus.conflict:
          throw STSerialNumberAlreadyUsedException();
        case HttpStatus.badRequest:
          throw BadRequestApiException();
        default:
          throw UnknownApiException();
      }
    }
  }

  // TODO: refactor
  Future<LocationModel> addExistingLocation(String locationUuid) async {
    final response = await _httpService.post(_mobileAppApi.addExistingLocation(locationUuid));

    switch (response.statusCode) {
      case HttpStatus.ok:
        return LocationModel.fromJson(response.data);
      case HttpStatus.notFound:
      // throw InvalidTokenApiException();
      case HttpStatus.conflict:
        throw LocationAlreadyAddedException();
      case HttpStatus.badRequest:
        throw BadRequestApiException();
      default:
        throw UnknownApiException();
    }
  }

  Future<void> removeLocation(String locationUuid) async {
    try {
      await _httpService.delete(_mobileAppApi.removeLocation(locationUuid));
      return;
    } on UnauthorizedDioException {
      throw UnauthorizedApiException();
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        default:
          throw UnknownApiException();
      }
    }
  }
}
