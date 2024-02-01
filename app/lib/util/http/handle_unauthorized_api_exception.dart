import 'package:app/feature/global_state.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/route/index.dart';
import 'package:app/util/stacked-services/dialog-service/index.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> handleUnauthorizedApiException() async {
  final navigatonService = DependencyInjection.getIt<NavigationService>();
  final dialogService = DependencyInjection.getIt<DialogService>();
  final globalState = DependencyInjection.getIt<GlobalState>();

  final response = await dialogService.showUnauthorizedDialog();

  if (response != null && response.confirmed) {
    globalState.logout();
    navigatonService.clearStackAndShow(RouteEnum.welcome.name);
  }
}
