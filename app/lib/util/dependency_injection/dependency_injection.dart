import 'package:app/api/auth/index.dart';
import 'package:app/feature/auth/auth_validator.dart';
import 'package:app/feature/global_state.dart';
import 'package:app/util/api/index.dart';
import 'package:app/util/http/index.dart';
import 'package:app/util/route/index.dart';
import 'package:get_it/get_it.dart';

class DependencyInjection {
  DependencyInjection._();

  static GetIt getIt = GetIt.instance;

  static void configure() {
    getIt.registerSingleton<RouteGenerator>(RouteGenerator());
    getIt.registerLazySingleton<AuthValidator>(() => AuthValidator());

    getIt.registerSingleton<JwtStorage>(JwtStorage());
    getIt.registerSingleton<HttpService>(HttpService());
    getIt.registerSingleton<MobileAppApi>(MobileAppApi());

    getIt.registerSingleton<AuthService>(AuthService());
    getIt.registerSingleton<AuthRepository>(AuthRepository());

    getIt.registerSingleton<GlobalState>(GlobalState());
  }
}
