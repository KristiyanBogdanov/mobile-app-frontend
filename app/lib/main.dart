import 'package:app/api/firebase/firebase_api.dart';
import 'package:app/api/user/user_repository.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/http/jwt_storage.dart';
import 'package:app/util/route/index.dart';
import 'package:app/util/stacked-services/index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// TODO: expiriment with the order of statements in main (run app before splash screen is removed)
Future main() async {
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  DependencyInjection.configure();

  setupBottomSheetUi();
  setupDialogUi();
  setupSnackbarUi();

  final initialRoute = await _getInitialRoute();
  FlutterNativeSplash.remove();

  runApp(MyApp(initialRoute: initialRoute));

  await DependencyInjection.getIt<FirebaseApi>().initNotifications();
}

Future<RouteEnum> _getInitialRoute() async {
  final jwtStorage = DependencyInjection.getIt<JwtStorage>();
  final hasTokens = await jwtStorage.hasTokens();

  if (!hasTokens) {
    return RouteEnum.welcome;
  }

  try {
    final userRepository = DependencyInjection.getIt<UserRepository>();
    await userRepository.fetchData();
    return RouteEnum.home;
  } catch (e) {
    return RouteEnum.welcome;
  }
}

class MyApp extends StatelessWidget {
  final RouteEnum initialRoute;

  const MyApp({required this.initialRoute, super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(AppStyle.designWidth, AppStyle.designHeight),
      minTextAdapt: true,
      child: ChangeNotifierProvider(
        create: (context) => DependencyInjection.getIt<FirebaseApi>(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appTitle,
          theme: ThemeData(
            fontFamily: 'Nunito',
            brightness: Brightness.dark,
            dialogBackgroundColor: AppStyle.secondaryColor1,
          ),
          navigatorKey: StackedService.navigatorKey,
          initialRoute: initialRoute.name,
          onGenerateRoute: DependencyInjection.getIt<RouteGenerator>().generateRoute,
        ),
      ),
    );
  }
}

// TODO: finish notification design and fix delete issue
// TODO: add shared widget for the padding of every page (rename padding16 in AppStyle to defaultAppPadding)
// TODO: test with two different phones (remove, add, update, delete) and update
// TODO: change the theme
// TODO: Delete the google-services.json and google.plist files if you had these installed before: https://stackoverflow.com/questions/70404936/missing-firebase-options-dart-file-in-course-get-to-know-firebase-for-flutter