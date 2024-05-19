import 'package:app/util/common/clear_repositories_data.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/jwt_storage.dart';
import 'package:app/util/route/index.dart';
import 'package:app/util/stacked-services/dialog-service/index.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> handleUnauthorized() async {
  final navigatonService = DependencyInjection.getIt<NavigationService>();
  final dialogService = DependencyInjection.getIt<DialogService>();
  final jwtStorage = DependencyInjection.getIt<JwtStorage>();

  final response = await dialogService.showUnauthorizedDialog();

  if (response != null && response.confirmed) {
    jwtStorage.deleteTokens();
    clearRepositoriesData();
    navigatonService.clearStackAndShow(RouteEnum.welcome.name);
  }
}
