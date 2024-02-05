import 'package:app/api/location/location_repository.dart';
import 'package:app/api/user/user_repository.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';

void clearRepositoriesData() {
  final userRepository = DependencyInjection.getIt<UserRepository>();
  final locationRepository = DependencyInjection.getIt<LocationRepository>();

  userRepository.clearData();
  locationRepository.clearData();
}
