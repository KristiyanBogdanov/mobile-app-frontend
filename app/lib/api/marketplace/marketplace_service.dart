import 'dart:io';

import 'package:app/api/marketplace/dto/index.dart';
import 'package:app/api/marketplace/model/index.dart';
import 'package:app/util/api/mobile_app_api.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/index.dart';
import 'package:dio/dio.dart';

class MarketplaceService {
  final _httpService = DependencyInjection.getIt<HttpService>();
  final _mobileAppApi = DependencyInjection.getIt<MobileAppApi>();

  Future<PublicationLimitsModel> getPublicationLimits() async {
    final response = await _httpService.get(_mobileAppApi.getPublicationLimits());
    return PublicationLimitsModel.fromJson(response.data);
  }

  Future<GetPublicationsModel> getPublications(
    int page,
    int limit,
    PublicationsFiltersDto filters, {
    areLimitsFetched = true,
  }) async {
    Object? data;

    if (areLimitsFetched) {
      data = filters;
    }

    final response = await _httpService.get(_mobileAppApi.getPublications(page, limit), data: data);
    return GetPublicationsModel.fromJson(response.data);
  }

  Future<void> _createPublication(String apiEndpoint, dynamic data, List<File> images) async {
    final formData = FormData.fromMap({
      ...data.toJson(),
      'images': await Future.wait(
        images.map(
          (image) async => await MultipartFile.fromFile(image.path),
        ),
      ),
    });

    await _httpService.post(
      apiEndpoint,
      data: formData,
      customExceptions: {
        HttpStatus.badRequest: BadRequestApiException(),
      },
    );
  }

  Future<void> postProduct(PostProductDto product, List<File> images) async {
    await _createPublication(_mobileAppApi.postProduct(), product, images);
  }

  Future<void> postService(PostServiceDto service, List<File> images) async {
    await _createPublication(_mobileAppApi.postService(), service, images);
  }

  Future<void> deletePublication(String publicationId) async {
    await _httpService.delete(_mobileAppApi.deletePublication(publicationId));
  }
}
