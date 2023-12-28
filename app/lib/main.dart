import 'package:app/shared/constant/index.dart';
import 'package:app/util/dependency_injection/index.dart';
import 'package:app/util/http/index.dart';
import 'package:app/util/route/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  DependencyInjection.configure();

  final initialRoute = await _getInitialRoute();
  FlutterNativeSplash.remove();

  runApp(MyApp(initialRoute: initialRoute));
}

Future<RouteEnum> _getInitialRoute() async {
  final jwtStorage = DependencyInjection.getIt<JwtStorage>();
  final jwt = await jwtStorage.getToken();

  // TODO: uncomment this line to enable authentication
  // return jwt.isNotEmpty ? RouteEnum.home : RouteEnum.signin;
  return RouteEnum.signin;
}

class MyApp extends StatelessWidget {
  final RouteEnum initialRoute;

  const MyApp({required this.initialRoute, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: initialRoute.name,
      onGenerateRoute: DependencyInjection.getIt<RouteGenerator>().generateRoute,
    );
  }
}
