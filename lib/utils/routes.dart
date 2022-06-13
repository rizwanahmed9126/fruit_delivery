import 'package:flutter/material.dart';
import 'package:fruit_delivery_flutter/screens/create_vendor_profile.dart';
import 'package:fruit_delivery_flutter/screens/letschat_screen.dart';
import 'package:fruit_delivery_flutter/screens/vendor_edit_profile_screen.dart';
import 'package:fruit_delivery_flutter/screens/vendor_profile_screen.dart';

import '../screens/change_password_sucessfully_screen.dart';
import '../screens/create_profile_screen.dart';
import '../screens/email_verification_screen.dart';
import '../screens/language_screen.dart';
import '../screens/my_fruits_screen.dart';
import '../widgets/facebook_widget.dart';
import '../screens/driver_home_screen.dart';
import '../screens/create_route_form_notification_screen.dart';
import '../screens/create_route_form_screen.dart';
import '../screens/create_route_my_item_screen.dart';
import '../screens/driver_location_screen.dart';
import '../screens/notification_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/myprofile_screen.dart';
import '../screens/schedule_screen.dart';
import '../screens/trip_detail_screen.dart';
import '../screens/reset_screen.dart';
import '../screens/forget_password_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/login_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/trip_screen.dart';
import '../screens/home_screen.dart';
import '../screens/main_dashboard_screen.dart';
import '../screens/search_product_screen.dart';
import '../screens/create_route_screen.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/google_map_screen.dart';
import '../screens/add_fruit_screen.dart';
import '../screens/add_trip_item_screen.dart';

import '../screens/nofruit_item_screen.dart';
import '../screens/select_account.dart';
import '../screens/route_detail_screen.dart';

const SplashScreenRoute = '/splash-screen';
const LoginScreenRoute = '/login-screen';
const SignUpScreenRoute = '/signup-screen';
const ForgetPasswordScreenRoute = '/forgetPassword-Screen';
const CreateRouteFormScreenRoute = '/create_route_form_screen';
const LetsChatScreenRoute = '/letschat-Screen';
const ChatScreenRoute = '/chat-Screen';
const TripDetailScreenRoute = '/trip_detail_screen';
const HomeScreenRoute = '/home-Screen';
const ResetPasswordScreenRoute = '/reset-password-screen';
const MainDashboardScreenRoute = '/main-dashboard-screen';
const UserProfileTabScreenRoute = '/user-profile-screen';
const NotificationScreenRoute = '/notification-screen';
const TripScreenRoute = '/trip-screen';
const LocationScreenRoute = '/location-screen';
const SearchProductScreenRoute = '/search-product';
const CreateRouteScreenRoute = '/create-route-screen';
const SelectAccountScreenRoute = '/select-account-screen';
const ScheduleScreenRoute = '/schedule-screen';
const RouteDetailScreenRoute = '/route-detail-screen';
const MyProfileScreenRoute = '/myprofile-screen';
const EditProfileScreenRoute = '/edit-profile-screen';
//const MapSampleRoute = '/map-sample-screen';
const AddFruitScreenRoute = '/add-fruit-screen';
const CreateRouteFormNotificationScreenRoute =
    '/createrouteform-notification-screen';
const CreateRouteScreenMyItemsRoute = '/create-route-my-items-screen';
const AddItemScreenRoute = '/add-item-screen';
const NoFruitItemScreenRoute = '/nofruit-item-screen';
const LanguagesScreenRoute = '/language-screen';
const DriverLocationScreenRoute = '/driver-location-screen';
const DriverHomeScreenRoute = '/driver-home-screen';
const FacebookWidgetRoute = '/facebook-widget';
const MyFruitsScreenRoute = '/my-fruits-screen';
const EmailVerificationScreenRoute = '/emailVerification-screen';
const ChangePasswordSuccessfullyScreenRoute = '/changePassword-screen';
const CreateProfileScreenRoute = '/create-profile-screen';
const DriverLetsChatScreenRoute = '/drive-lets-chat-screen';
const CreateVendorProfileScreenRoute = '/create-vendor-profile-screen';
const VendorProfileScreenRoute = '/vendor-profile-screen';
const VendorEditProfileScreenRoute = '/vendor-edit-profile-screen';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => SplashScreen());
    case VendorEditProfileScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => VendorEditProfileScreen());
    case VendorProfileScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => VendorProfileScreen());

    case DriverHomeScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => DriverHomeScreen());
    case CreateProfileScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => CreateProfileScreen());

    case CreateVendorProfileScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => CreateVendorProfileScreen());

    case CreateRouteFormNotificationScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) =>
              CreateRouteFormNotificationScreen());
    // case MyFruitsScreenRoute:
    //   return MaterialPageRoute(
    //       builder: (BuildContext context) => MyFruitsScreen());

    case LoginScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen());

    case ForgetPasswordScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => ForgetPasswordScreen());
    case ChangePasswordSuccessfullyScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) =>
              ChangePasswordSuccessfullyScreen());

    case EmailVerificationScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => EmailVerificationScreen());

    case SignUpScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => SignUpScreen());

    case ResetPasswordScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => ResetPasswordScreen());

    case LetsChatScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => MainDashboardScreen(2));

    case DriverLetsChatScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => LetsChatScreen());

    case UserProfileTabScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => MainDashboardScreen(3));
    case MainDashboardScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => MainDashboardScreen(0));

    case ChatScreenRoute:
      return MaterialPageRoute(builder: (BuildContext context) => ChatScreen());

    case NotificationScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => NotificationScreen());

    case TripScreenRoute:
      return MaterialPageRoute(builder: (BuildContext context) => TripScreen());

    case TripDetailScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => TripDetailScreen());

    case LocationScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => MainDashboardScreen(1));

    case SearchProductScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => SearchProductScreen());

    case HomeScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => MainDashboardScreen(0));

    case CreateRouteScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => CreateRouteScreen());

    case RouteDetailScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => RouteDetailScreen());
          
    case SelectAccountScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => SelectAccountScreen());

    case ScheduleScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => ScheduleScreen());
    case MyProfileScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => MyProfileScreen());
    case EditProfileScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => EditProfileScreen());
    case CreateRouteFormScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => CreateRouteFormScreen());

    case AddFruitScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => AddFruitScreen());

    case NoFruitItemScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => NoFruitItemScreen());

    case CreateRouteScreenMyItemsRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => CreateRouteScreenMyItems());

    // case MapSampleRoute:
    //   return MaterialPageRoute(builder: (BuildContext context) => MapScreen());

    // case AddItemScreenRoute:
    //   return MaterialPageRoute(
    //       builder: (BuildContext context) => AddTripItemScreen());

    case LanguagesScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => LanguagesScreen());
    case DriverLocationScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => DriverLocationScreen());

    case FacebookWidgetRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => FacebookWidget());

    default:
      return MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen());
  }
}

class MapSamplen {}
