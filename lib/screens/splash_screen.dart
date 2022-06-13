import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fruit_delivery_flutter/constants/select_account.dart';
import 'package:fruit_delivery_flutter/models/user.dart';
import 'package:fruit_delivery_flutter/models/vendor.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/user_provider.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
import 'package:fruit_delivery_flutter/providers/g_data_provider.dart';
import 'package:fruit_delivery_flutter/providers/products_provider.dart';
import 'package:fruit_delivery_flutter/providers/route_provider.dart';
import 'package:fruit_delivery_flutter/screens/create_route_screen.dart';
import 'package:fruit_delivery_flutter/widgets/enums.dart';
import 'package:provider/provider.dart';
import '../services/storage_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';
import '../utils/routes.dart';
import '../services/navigation_service.dart';
import '../utils/service_locator.dart';
// import '../widgets/exit_alert_dialog.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var navigationService = locator<NavigationService>();
  var storageService = locator<StorageService>();

  final firestoreInstance = FirebaseFirestore.instance;

  loadData1() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    if (!kIsWeb) {
      var token = await FirebaseMessaging.instance.getToken();
      print('this is the token--${token.toString()}');
      if (token!.isNotEmpty) {
        print("toe: $token");
        //Provider.of<AuthProvider>(context,listen: false).callPushNotification("Greetings","Hello from app","${token.toString()}");

        //Provider.of<AuthProvider>(context,listen: false).callFcmToken(token.toString());
        //Provider.of<AuthProvider>(context,listen: false).saveFcmToken(token.toString());
      }

      AndroidNotificationChannel channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        //'This channel is used for important notifications.', // description
        importance: Importance.high,
      );

      await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
      await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }



    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print(message.notification!.title);
      print(message.notification!.body);

      // firestoreInstance.collection('notificationsData'). add({
      //   'title': '${message.notification!.title}',
      //   'body':'${message.notification!.body}',
      // });

      // if (Platform.isAndroid)
      flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title,
          message.notification!.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'High Importance Notifications',
              //'This channel is used for important notifications.',
              importance: Importance.high,
              priority: Priority.high,
            ),
            iOS: IOSNotificationDetails(),
          ));
      // if(Platform.isIOS)
      //   flutterLocalNotificationsPlugin.show(
      //       0,
      //       message.notification!.title,
      //       message.notification!.body,
      //       NotificationDetails(
      //         android: AndroidNotificationDetails(
      //           'high_importance_channel',
      //           'High Importance Notifications',
      //           //'This channel is used for important notifications.',
      //           importance: Importance.high,
      //           priority: Priority.high,
      //         ),
      //         iOS: IOSNotificationDetails(
      //
      //         ),
      //       ));
    });

    // await Provider.of<AuthProvider>(context, listen: false).callUserInfo(context).then((value) async {
    //   Provider.of<AuthProvider>(context, listen: false).saveUid(value.uid.toString());
    //
    //   await Provider.of<AuthProvider>(context, listen: false).callAdvert().then((value) {
    //     navigationService.navigateTo(HomeScreenRoute);
    //   });
    // });
  }

  tripApiCall() async {
    await Provider.of<RouteProvider>(context, listen: false).fetchAllRoute().then((value) {
      if (Provider.of<RouteProvider>(context, listen: false).tripData.isNotEmpty) {
        navigationService.navigateTo(ScheduleScreenRoute);
      } else {
        navigationService.navigateTo(CreateRouteScreenRoute);
      }
    });
  }

  @override
  void initState() {
    loadData1();
    try {
      Timer(Duration(seconds: 3), () async {
        var token = await this.storageService.getData(StorageKeys.token.toString());
        Provider.of<GMapsProvider>(context, listen: false).getCurrentLocation();

        if (token != null) {
          var driver = await this.storageService.getData("selectAccount");
          SelectAccount.selectAccount = driver ?? "";
          await Provider.of<UserProvider>(context, listen: false)
              .refreshToken();
          if (driver == 'SelectAccountEnum.Driver') {
            await Provider.of<VendorProvider>(context, listen: false).refreshToken();
            var vendorData = await this.storageService.getData("vendor");
            if (vendorData != null) {
              var vendorUser = VendorUser.fromJson(vendorData);
              Provider.of<VendorProvider>(context, listen: false).setVendor(vendorUser);
              await Provider.of<VendorProvider>(context, listen: false).getFCMToken();
              Provider.of<ProductsProvider>(context, listen: false,).setAlreadyAddedProducts(vendorUser.products ?? []);
              if (vendorUser.phoneNumber == "") {
                navigationService.navigateTo(CreateVendorProfileScreenRoute);
                return;
              } else {
                // Navigator.pushReplacement<void, void>(
                //   // this use is account switch problem
                //   context,
                //   MaterialPageRoute<void>(
                //     builder: (BuildContext context) => CreateRouteScreen(),
                //   ),
                // );
                // return;
                tripApiCall();

                //navigationService.navigateTo(CreateRouteScreenRoute);
              }
            } else {
              navigationService.navigateTo(SelectAccountScreenRoute);
              return;
            }
          } else {
            // await Provider.of<UserProvider>(context, listen: false)
            //     .refreshToken();
            var userData =
                await this.storageService.getData(StorageKeys.user.toString());
            if (userData != null) {
              var user = AppUser.fromJson(userData);
              Provider.of<UserProvider>(context, listen: false).setuser(user);
              await Provider.of<UserProvider>(context, listen: false)
                  .getFCMToken();
              if (userData["phoneNumber"] == "") {
                navigationService.navigateTo(CreateProfileScreenRoute);
              } else {
                navigationService.navigateTo(MainDashboardScreenRoute);
              }
              return;
            } else {
              navigationService.navigateTo(SelectAccountScreenRoute);
              return;
            }
          }
        } else {
          navigationService.navigateTo(SelectAccountScreenRoute);
          return;
        }

        // }
      });
    } catch (e) {
      navigationService.navigateTo(SelectAccountScreenRoute);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Future<bool> _onBackPressed() {
    //   return showDialog(
    //         context: context,
    //         builder: (context) => ExitAlertDialog(),
    //       ) ??
    //       false;
    // }

    return WillPopScope(
      onWillPop: null,
      child: Stack(
          // fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/splash.png'),
                    fit: BoxFit.cover),
              ),
            ),
            // Positioned(
            //   child: Align(
            //       alignment: FractionalOffset.center,
            //       child: Container(
            //         child:
            //             // Container(child: Image.asset('assets/images/Logo1.png')),
            //             ShowUpAnimation(
            //           delayStart: Duration(milliseconds: 200),
            //           animationDuration: Duration(seconds: 1),
            //           curve: Curves.bounceIn,
            //           direction: Direction.vertical,
            //           offset: 0.7,
            //           child: Image.asset(
            //             'assets/images/splash-logo.png',
            //             scale: 3.5,
            //           ),
            //         ),
            //       )),
            // ),
          ]),
    );
  }
}
