import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';
import 'package:fruit_delivery_flutter/providers/app_language_provider.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/chat_provider.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/user_provider.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
import 'package:fruit_delivery_flutter/providers/g_data_provider.dart';
import 'package:fruit_delivery_flutter/providers/products_provider.dart';
import 'package:fruit_delivery_flutter/providers/route_provider.dart';
import 'package:fruit_delivery_flutter/screens/vendor_profile_screen.dart';
import 'package:fruit_delivery_flutter/utils/authentication.dart';
import 'package:fruit_delivery_flutter/utils/routes.dart';
import 'package:provider/provider.dart';
import './services/navigation_service.dart';
import './utils/routes.dart';
import './utils/service_locator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  await Firebase.initializeApp();
  setupLocator();
 


  runApp(
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) =>
    MyApp(appLanguage: appLanguage),
    //  ),
  );
}

class MyApp extends StatelessWidget {
  final AppLanguage? appLanguage;
  MyApp({this.appLanguage});

  //final plugin = FacebookLogin();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () => MultiProvider(
        providers: [
          ChangeNotifierProvider<ProductsProvider>(
            create: (_) => ProductsProvider(),
          ),
          ChangeNotifierProvider<UserProvider>(
            create: (_) => UserProvider(),
          ),
          ChangeNotifierProvider<VendorProvider>(
            create: (_) => VendorProvider(),
          ),
          ChangeNotifierProvider<GMapsProvider>(
            create: (_) => GMapsProvider(),
          ),
          ChangeNotifierProvider<RouteProvider>(
            create: (_) => RouteProvider(),
          ),
          ChangeNotifierProvider<AppLanguage>(
            create: (_) => appLanguage!,
          ),
          ChangeNotifierProvider<ChatProvider>(
            create: (_) => ChatProvider(),
          ),
        ],
        child: Consumer<AppLanguage>(
          builder: (context, model, child) {
            return MaterialApp(
              supportedLocales: [
                Locale('en', 'US'),
                Locale('es', 'ES'),
                Locale('vi', 'VIE'),
                Locale('km', 'KHMER'),
                Locale('pt', 'POR'),
                Locale('hi', 'HIN'),
              ],
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate
              ],
              // builder: DevicePreview.appBuilder,
              locale: model.appLocal,
              title: 'Fruit Delivery',
              color: Theme.of(context).backgroundColor,
              debugShowCheckedModeBanner: false,
              // locale: DevicePreview.locale(context),
              navigatorKey: locator<NavigationService>().navigatorKey,
              theme: ThemeData(
                backgroundColor: Color.fromRGBO(63, 190, 144, 1),
//                       // primaryColor: Color.fromRGBO(7, 29, 89, 1),
                accentColor: Color.fromRGBO(63, 190, 144, 1),
                visualDensity: VisualDensity.adaptivePlatformDensity,

                // Define the default font family.
                fontFamily: 'Roboto',
              ),
              onGenerateRoute: onGenerateRoute,
              initialRoute: SplashScreenRoute,
              //home: Data(),
            );
          },
        ),
      ),
    );
  }
}
