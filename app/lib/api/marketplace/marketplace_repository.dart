import 'dart:io';

import 'package:app/api/marketplace/dto/index.dart';
import 'package:app/api/marketplace/marketplace_service.dart';
import 'package:app/api/marketplace/model/index.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';

class MarketplaceRepository {
  PublicationLimitsModel? limits;
  final _marketplaceService = DependencyInjection.getIt<MarketplaceService>();

  Future<void> fetchLimits() async {
    limits = await _marketplaceService.getPublicationLimits();
  }

  Future<GetPublicationsModel> getPublications(int page, int limit, PublicationsFiltersDto filters) async {
    return _marketplaceService.getPublications(page, limit, filters);
  }

  Future<void> postProduct(PostProductDto product, List<File> images) async {
    await _marketplaceService.postProduct(product, images);
  }

  Future<void> postService(PostServiceDto service, List<File> images) async {
    await _marketplaceService.postService(service, images);
  }

  Future<void> deletePublication(String publicationId) async {
    await _marketplaceService.deletePublication(publicationId);
  }
}
