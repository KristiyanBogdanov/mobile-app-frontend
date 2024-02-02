import 'package:app/api/user/user_repository.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/jwt_storage.dart';
import 'package:app/util/route/index.dart';
import 'package:app/util/stacked-services/dialog-service/index.dart';
import 'package:stacked_services/stacked_services.dart';

// TODO: update after remove global state entirely
Future<void> handleUnauthorized() async {
  final navigatonService = DependencyInjection.getIt<NavigationService>();
  final dialogService = DependencyInjection.getIt<DialogService>();
  final jwtStorage = DependencyInjection.getIt<JwtStorage>();
  final userRepository = DependencyInjection.getIt<UserRepository>();

  final response = await dialogService.showUnauthorizedDialog();

  if (response != null && response.confirmed) {
    jwtStorage.deleteTokens();
    userRepository.clearData();
    navigatonService.clearStackAndShow(RouteEnum.welcome.name);
  }
}
