import 'package:app/api/auth/index.dart';
import 'package:app/api/firebase/firebase_api.dart';
import 'package:app/api/location/index.dart';
import 'package:app/api/marketplace/index.dart';
import 'package:app/api/user/index.dart';
import 'package:app/util/api/index.dart';
import 'package:app/util/http/index.dart';
import 'package:app/util/route/index.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';

class DependencyInjection {
  DependencyInjection._();

  static GetIt getIt = GetIt.instance;

  static void configure() {
    getIt.registerSingleton<RouteGenerator>(RouteGenerator());
    getIt.registerLazySingleton<SnackbarService>(() => SnackbarService());
    getIt.registerLazySingleton<DialogService>(() => DialogService());
    getIt.registerLazySingleton<BottomSheetService>(() => BottomSheetService());
    getIt.registerSingleton<NavigationService>(NavigationService());

    getIt.registerSingleton<MobileAppApi>(MobileAppApi());
    getIt.registerSingleton<JwtStorage>(JwtStorage());
    getIt.registerSingleton<HttpService>(HttpService());

    getIt.registerLazySingleton<AuthService>(() => AuthService());
    getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());

    getIt.registerSingleton<UserService>(UserService());
    getIt.registerSingleton<UserRepository>(UserRepository());

    getIt.registerLazySingleton<LocationService>(() => LocationService());
    getIt.registerLazySingleton<LocationRepository>(() => LocationRepository());

    getIt.registerLazySingleton<MarketplaceService>(() => MarketplaceService());
    getIt.registerLazySingleton<MarketplaceRepository>(() => MarketplaceRepository());

    getIt.registerSingleton<FirebaseApi>(FirebaseApi());
  }
}
