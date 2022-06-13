import 'dart:convert';

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fruit_delivery_flutter/models/getallvender_model.dart';
import 'package:fruit_delivery_flutter/models/trip_detail_route_user.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
import 'package:fruit_delivery_flutter/providers/g_data_provider.dart';
import 'package:fruit_delivery_flutter/screens/email_verification_screen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

import '../../services/http_service.dart';
import '../../services/storage_service.dart';
import '../../services/util_service.dart';
import '../../models/user.dart';
import '../../services/firebase_service.dart';
import '../../services/navigation_service.dart';
import '../../utils/routes.dart';
import '../../utils/service_locator.dart';
import '../../widgets/enums.dart';
import '../../screens/change_password_sucessfully_screen.dart';
import '../../screens/select_account.dart';

class UserProvider with ChangeNotifier {
  NavigationService? navigationService = locator<NavigationService>();
  UtilService? utilService = locator<UtilService>();
  StorageService? storageService = locator<StorageService>();
  HttpService? http = locator<HttpService>();
  FirebaseService? _firebase = locator<FirebaseService>();
  List<TripDetailRouteUser> routeIdData = [];
  List<GetVendor> vendersData = [];
  bool isLoadingProgress = false;
  List<Placemark>? fromAddress;

  String? token;
  String? _password;
  String? phoneNumber;
  AppUser? user;
  bool _isRemeber = false;

  AppUser get userData {
    return this.user!;
  }

  setuser(AppUser user) {
    this.user = user;
  }

  setIsRemeber(bool val) async {
    await this.storageService!.setBoolData('isRemember', val);
    this._isRemeber = val;
  }

  Future<bool> getIsRemember() async {
    var data = await this.storageService!.getBoolData('isRemember');
    return data ?? false;
  }

  Future<void> resendVerificationEmail() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var user = _auth.currentUser!;
    user.sendEmailVerification();
    utilService!.showToast("A verification email has been sent.");
  }

  Future<void> createUserProfile({
    String? name,
    String? email,
    String? imageUrl,
    String? phoneNumber,
    String? address,
    BuildContext? context,
  }) async {
    try {
      Map<String, dynamic> data = {
        "profilePicture": imageUrl,
        "fullName": name,
        "email": email,
        "address": address,
        "phoneNumber": phoneNumber,
      };
      var response = await this.http!.editUserProfileInformation(data);
      var result = response.data;
      // var data = this._user;
      this.user = AppUser.fromJson(result['data']);
      await this
          .storageService!
          .setData(StorageKeys.user.toString(), this.user);

      notifyListeners();
    } catch (err) {
      utilService!.showToast(err.toString());
    }
  }

  Future<void> getAddress(BuildContext context) async {
    fromAddress = await placemarkFromCoordinates(
        Provider.of<GMapsProvider>(context, listen: false)
            .currentLocation!
            .latitude!,
        Provider.of<GMapsProvider>(context, listen: false)
            .currentLocation!
            .longitude!);
  }



Future<void> userSignInWithApple(BuildContext context) async {
    try {
      //final authService = Provider.of<AuthService>(context, listen: false);
      final user = await Provider.of<VendorProvider>(context, listen: false).signInWithApple(
          scopes: [Scope.email, Scope.fullName]);
      // print('uid: ${user.uid}');
      // print('uid: ${user.getIdToken()}');
      // print('uid: ${user.email??""}');
      // print('uid: ${user.displayName??""}');
      // print('uid: ${user.emailVerified??""}');

      var token = await user.getIdToken();
      print(token);
      this.token = token;
      await this.storageService!.setData(StorageKeys.token.toString(), this.token);
      await this.http!.signUp({
        "id": user.uid,
        "fullName": user.displayName,
        "email": user.email,
      });
      var userByIdData = await this.http!.getUserById(user.uid);
      var response = userByIdData.data;
      if (user.emailVerified) {
        this.user = AppUser(
          id: user.uid,
          email: user.email,
          fullName: user.displayName,
        );

        await getAddress(context);
        var addressData = {
          "country": "${fromAddress![0].country}",
          "city": "${fromAddress![0].subAdministrativeArea}",
          "lat": Provider.of<GMapsProvider>(context, listen: false).currentLocation!.latitude!,
          "long": Provider.of<GMapsProvider>(context, listen: false).currentLocation!.longitude!,
          "address": "${fromAddress![0].street}, ${fromAddress![0].thoroughfare}, ${fromAddress![0].subAdministrativeArea}",
        };

        await this.http!.addUserCurrentLocation(addressData);

        if (this._isRemeber) {
          await this.storageService!.setData("userEmail", this.user!.email);
          await this.storageService!.setData("password", this._password);
          await this.storageService!.setBoolData("rememberMe", this._isRemeber);
        } else {
          await this.storageService!.setBoolData("rememberMe", this._isRemeber);
        }
        this.user!.isEmailVerified = user.emailVerified;

        this.user!.fullName = response['data']['fullName'] ?? user.displayName;
        this.user!.phoneNumber = response['data']['phoneNumber'];
        this.user!.profilePicture = response['data']['profilePicture'];
        this.user!.address = response['data']['address'];

        this.storageService!.setData(StorageKeys.user.toString(), this.user);
        await this.getFCMToken();
        if (this.user!.phoneNumber != "") {
          navigationService!.navigateTo(MainDashboardScreenRoute);
        } else {
          navigationService!.navigateTo(CreateProfileScreenRoute);
        }
      } else {
        await _firebase!.sendEmailVerification();
        this.user = AppUser(
          email: user.email,
          id: user.uid,
          fullName: user.displayName,
        );

        navigationService!.navigateTo(EmailVerificationScreenRoute);
        return;
      }



    }on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        utilService!.showToast('The account already exists with a different credential');

      } else if (e.code == 'invalid-credential') {
        utilService!.showToast('Error occurred while accessing credentials. Try again.');


      }
    }
    catch (e) {
      utilService!.showToast('Fail to sign in');
      print(e);
    }
  }


  Future<void> userSigninWithFacebook(context)async{
    //FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final LoginResult result = await FacebookAuth.instance.login();
    // Once signed in, return the UserCredential
    final OAuthCredential facebookCredential = FacebookAuthProvider.credential(result.accessToken!.token);

   //  final GoogleSignIn googleSignIn = GoogleSignIn();
   //
   //  final GoogleSignInAccount? googleSignInAccount =
   //  await googleSignIn.signIn();
   //
   // // if (googleSignInAccount != null) {
   //    final GoogleSignInAuthentication googleSignInAuthentication =
   //    await googleSignInAccount.authentication;
   //
   //    final AuthCredential credential = GoogleAuthProvider.credential(
   //      accessToken: googleSignInAuthentication.accessToken,
   //      idToken: googleSignInAuthentication.idToken,
   //    );

      try{

        final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookCredential);


        user = userCredential.user;

        var token = await user!.getIdToken();
        this.token = token;
        await this.storageService!.setData(StorageKeys.token.toString(), this.token);
        await this.http!.signUp({
          "id": user.uid,
          "fullName":user.displayName,
          "email": user.email,
        });
        var userByIdData = await this.http!.getUserById(user.uid);
        var response = userByIdData.data;
        if (user.emailVerified) {
          this.user = AppUser(
            id: user.uid,
            email: user.email,
          );

          await getAddress(context);
          var addressData = {
            "country": "${fromAddress![0].country}",
            "city": "${fromAddress![0].subAdministrativeArea}",
            "lat": Provider.of<GMapsProvider>(context, listen: false).currentLocation!.latitude!,
            "long": Provider.of<GMapsProvider>(context, listen: false).currentLocation!.longitude!,
            "address": "${fromAddress![0].street}, ${fromAddress![0].thoroughfare}, ${fromAddress![0].subAdministrativeArea}",
          };

          await this.http!.addUserCurrentLocation(addressData);

          if (this._isRemeber) {
            await this.storageService!.setData("userEmail", this.user!.email);
            await this.storageService!.setData("password", this._password);
            await this.storageService!.setBoolData("rememberMe", this._isRemeber);
          } else {
            await this.storageService!.setBoolData("rememberMe", this._isRemeber);
          }
          this.user!.isEmailVerified = user.emailVerified;

          this.user!.fullName = response['data']['fullName'];
          this.user!.phoneNumber = response['data']['phoneNumber'];
          this.user!.profilePicture = response['data']['profilePicture'];
          this.user!.address = response['data']['address'];

          this.storageService!.setData(StorageKeys.user.toString(), this.user);
          await this.getFCMToken();
          if (this.user!.phoneNumber != "") {
            navigationService!.navigateTo(MainDashboardScreenRoute);
          } else {
            navigationService!.navigateTo(CreateProfileScreenRoute);
          }
        } else {
          await _firebase!.sendEmailVerification();
          this.user = AppUser(
            email: user.email,
            id: user.uid,
            // fullName: user.displayName,
          );

          navigationService!.navigateTo(EmailVerificationScreenRoute);
          return;
        }


      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          print('The account already exists with a different credential',);
          // ScaffoldMessenger.of(context).showSnackBar(
          //   Authentication.customSnackBar(
          //     content:
          //     'The account already exists with a different credential',
          //   ),
          // );
        } else if (e.code == 'invalid-credential') {
          print('Error occurred while accessing credentials. Try again.',);
          // ScaffoldMessenger.of(context).showSnackBar(
          //   Authentication.customSnackBar(
          //     content:
          //     'Error occurred while accessing credentials. Try again.',
          //   ),
          // );
        }
      } catch (e) {
        print('Error occurred using Google Sign In. Try again.',);

        // ScaffoldMessenger.of(context).showSnackBar(
        //   Authentication.customSnackBar(
        //     content: 'Error occurred using Google Sign In. Try again.',
        //   ),
        // );
      }


   // }
  }

  Future<void> userSigninWithGoogle(context)async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try{

        final UserCredential userCredential = await auth.signInWithCredential(credential);


        user = userCredential.user;

        var token = await user!.getIdToken();
        this.token = token;
        await this.storageService!.setData(StorageKeys.token.toString(), this.token);
        await this.http!.signUp({
          "id": user.uid,
          "fullName":user.displayName,
          "email": user.email,
        });

        var userByIdData = await this.http!.getUserById(user.uid);
        var response = userByIdData.data;
        
        if (user.emailVerified) {
          this.user = AppUser(
            id: user.uid,
            email: user.email,

            
            profilePicture: user.photoURL
          );

          await getAddress(context);
          var addressData = {
            "country": "${fromAddress![0].country}",
            "city": "${fromAddress![0].subAdministrativeArea}",
            "lat": Provider.of<GMapsProvider>(context, listen: false).currentLocation!.latitude!,
            "long": Provider.of<GMapsProvider>(context, listen: false).currentLocation!.longitude!,
            "address": "${fromAddress![0].street}, ${fromAddress![0].thoroughfare}, ${fromAddress![0].subAdministrativeArea}",
          };

          await this.http!.addUserCurrentLocation(addressData);

          if (this._isRemeber) {
            await this.storageService!.setData("userEmail", this.user!.email);
            await this.storageService!.setData("password", this._password);
            await this.storageService!.setBoolData("rememberMe", this._isRemeber);
          } else {
            await this.storageService!.setBoolData("rememberMe", this._isRemeber);
          }
          this.user!.isEmailVerified = user.emailVerified;

          this.user!.fullName = response['data']['fullName'];
          this.user!.phoneNumber = response['data']['phoneNumber'];
          this.user!.profilePicture = response['data']['profilePicture'];
          this.user!.address = response['data']['address'];

          this.storageService!.setData(StorageKeys.user.toString(), this.user);
          await this.getFCMToken();
          if (this.user!.phoneNumber != "") {
            navigationService!.navigateTo(MainDashboardScreenRoute);
          } else {
            this.user!.email=user.email;
            this.user!.fullName=user.displayName;
            this.user!.profilePicture=user.photoURL;
            navigationService!.navigateTo(CreateProfileScreenRoute);
          }
        } else {
          await _firebase!.sendEmailVerification();
          this.user = AppUser(
            email: user.email,
            id: user.uid,
            // fullName: user.displayName,
          );

          navigationService!.navigateTo(EmailVerificationScreenRoute);
          return;
        }


      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          print('The account already exists with a different credential',);
          // ScaffoldMessenger.of(context).showSnackBar(
          //   Authentication.customSnackBar(
          //     content:
          //     'The account already exists with a different credential',
          //   ),
          // );
        } else if (e.code == 'invalid-credential') {
          print('Error occurred while accessing credentials. Try again.',);
          // ScaffoldMessenger.of(context).showSnackBar(
          //   Authentication.customSnackBar(
          //     content:
          //     'Error occurred while accessing credentials. Try again.',
          //   ),
          // );
        }
      } catch (e) {
        print('Error occurred using Google Sign In. Try again.',);

        // ScaffoldMessenger.of(context).showSnackBar(
        //   Authentication.customSnackBar(
        //     content: 'Error occurred using Google Sign In. Try again.',
        //   ),
        // );
      }


  }
  }


  Future<void> signinUserWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      this._password = password;
      await storageService!
          .setData(StorageKeys.password.toString(), this._password);

      var dataIsremember = await storageService!.haveData('isRemember');
      if (dataIsremember) {
        this._isRemeber = await storageService!.getBoolData('isRemember');
      }
      final user = await _firebase!.signinWithEmailAndPassword(email, password);

      var token = await user.getIdToken();
      this.token = token;
      await this
          .storageService!
          .setData(StorageKeys.token.toString(), this.token);
      var userByIdData = await this.http!.getUserById(user.uid);
      var response = userByIdData.data;
      if (response['message'] == "User does not exist,") {
        utilService!.showToast("User does not exist,");
      } else {
        if (user.emailVerified) {
          this.user = AppUser(
            id: user.uid,
            email: user.email,
          );

          await getAddress(context);
          var addressData = {
            "country": "${fromAddress![0].country}",
            "city": "${fromAddress![0].subAdministrativeArea}",
            "lat": Provider.of<GMapsProvider>(context, listen: false)
                .currentLocation!
                .latitude!,
            "long": Provider.of<GMapsProvider>(context, listen: false)
                .currentLocation!
                .longitude!,
            "address":
                "${fromAddress![0].street}, ${fromAddress![0].thoroughfare}, ${fromAddress![0].subAdministrativeArea}",
          };

          await this.http!.addUserCurrentLocation(addressData);

          if (this._isRemeber) {
            await this.storageService!.setData("userEmail", this.user!.email);
            await this.storageService!.setData("password", this._password);
            await this
                .storageService!
                .setBoolData("rememberMe", this._isRemeber);
          } else {
            await this
                .storageService!
                .setBoolData("rememberMe", this._isRemeber);
          }
          this.user!.isEmailVerified = user.emailVerified;

          this.user!.fullName = response['data']['fullName'];
          this.user!.phoneNumber = response['data']['phoneNumber'];
          this.user!.profilePicture = response['data']['profilePicture'];
          this.user!.address = response['data']['address'];

          this.storageService!.setData(StorageKeys.user.toString(), this.user);
          await this.getFCMToken();
          if (this.user!.phoneNumber != "") {
            navigationService!.navigateTo(MainDashboardScreenRoute);
          } else {
            navigationService!.navigateTo(CreateProfileScreenRoute);
          }
        } else {
          await _firebase!.sendEmailVerification();
          this.user = AppUser(
            email: email,
            id: user.uid,
            // fullName: user.displayName,
          );

          navigationService!.navigateTo(EmailVerificationScreenRoute);
          return;
        }
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'user-not-found') {
        utilService?.showToast('Invalid email.');
      } else if (err.code == 'network-request-failed') {
        utilService?.showToast("network error");
      } else if (err.code == 'too-many-requests') {
        utilService?.showToast(
            "We have blocked all requests from this device due to unusual activity. Try again later.");
      } else if (err.code == 'email-already-in-use') {
        utilService?.showToast(
            "The email address is already in use by another account.");
      } else if (err.code == 'invalid-email') {
        utilService?.showToast('Invalid email.');
      } else if (err.code == 'wrong-password') {
        utilService?.showToast('Invalid password.');
      } else if (user == null) {
        utilService?.showToast(err.toString());
      } else {
        utilService?.showToast(err.toString());
      }
    }
  }

  refreshToken() async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      var user = _auth.currentUser!;
      var token = await user.getIdToken(true);
      await storageService!.setData(StorageKeys.token.toString(), token);
    } catch (e) {
      navigationService!.navigateTo(SelectAccountScreenRoute);
    }
  }

  Future<void> getFCMToken() async {
    try {
      final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
      _firebaseMessaging.requestPermission();
      _firebaseMessaging.setForegroundNotificationPresentationOptions(
        sound: true,
        badge: true,
        alert: true,
      );
      String? token = await _firebaseMessaging.getToken();
      Map<String, dynamic> data = {
        "fcmToken": token,
        "userId": this.user!.id,
        "type": Platform.isAndroid ? "android" : "ios"
      };
      await this.http!.userRegisterDevice(data);
    } catch (err) {
      print(err);
    }
  }

  Future<void> createUserWithEmailPassword(
      {String? email,
      String? password,
      String? userName,
      String? selectedAccount,
      BuildContext? context}) async {
    try {
      final user =
          await _firebase!.createUserWithEmailAndPassword(email!, password!);
      var token = await user.getIdToken();
      await this
          .storageService!
          .setData(StorageKeys.token.toString(), token.toString());
      this.user = AppUser(
        id: user.uid,
        fullName: userName,
        email: user.email,
      );
      // await user!.sendEmailVerification(); // ye yaha se hate ga
      await this.http!.signUp({
        "id": user.uid,
        "fullName": userName,
        "email": user.email,
      });
      await user!.sendEmailVerification(); // ye uncommitn ho ga

      Navigator.of(context!).push(MaterialPageRoute(
          builder: (context) => EmailVerificationScreen(
                selectAccount: selectedAccount,
              )));
      // navigationService!.navigateTo(EmailVerificationScreenRoute);
    } on FirebaseAuthException catch (err) {
      if (err.code == 'user-not-found') {
        utilService?.showToast('Invalid email.');
      } else if (err.code == 'network-request-failed') {
        utilService?.showToast("network error");
      } else if (err.code == 'too-many-requests') {
        utilService?.showToast(
            "We have blocked all requests from this device due to unusual activity. Try again later.");
      } else if (err.code == 'email-already-in-use') {
        utilService?.showToast(
            "The email address is already in use by another account.");
      } else if (err.code == 'invalid-email') {
        utilService?.showToast('Invalid email.');
      } else if (err.code == 'wrong-password') {
        utilService?.showToast('Invalid password.');
      } else if (user == null) {
        utilService?.showToast(err.toString());
      } else {
        utilService?.showToast(err.toString());
      }
    }
  }

  Future<void> changePassword(
      {String? oldPassword, String? newPassword, BuildContext? context}) async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final authResult = await _auth.signInWithEmailAndPassword(
          email: this.user!.email!.trim(), password: oldPassword!.trim());

      final user = authResult.user;
      await user!.updatePassword(newPassword!);
      // navigationService!.navigateTo(ChangePasswordSuccessfullyScreenRoute);
      showDialog(
          context: context!,
          barrierDismissible: false,
          builder: (_) {
            return ChangePasswordSuccessfullyScreen(
              title: 'Successfully changed your password',
              routeName: HomeScreenRoute,
            );
          });
    } on FirebaseAuthException catch (err) {
      if (err.code == 'user-not-found') {
        utilService!.showToast('Wrong password provided for that user.');
      } else if (err.code == 'wrong-password') {
        utilService!.showToast(
            "The old password is invalid or the user does not have a password.");
      } else {
        utilService!.showToast(err.toString());
      }
    }
  }

  Future<void> logoutFirebaseUser(BuildContext context) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final AccessToken? accessToken = await FacebookAuth.instance.accessToken;

    if (accessToken != null) {
      await FacebookAuth.instance.logOut();
    }
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _auth.signOut();
    var sharedPreferences = await SharedPreferences.getInstance();
    // stopStream();
    try {
      final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
      _firebaseMessaging.requestPermission(
          //     const IosNotificationSettings(sound: true, badge: true, alert: true));
          // _firebaseMessaging.onIosSettingsRegistered
          //     .listen((IosNotificationSettings settings) {
          //   print("Settings registered: $settings");
          //
          // }
          );

      _firebaseMessaging.setForegroundNotificationPresentationOptions(
        sound: true,
        badge: true,
        alert: true,
      );
      String? token = await _firebaseMessaging.getToken();
      var data = {
        "UserId": this.user!.id,
        "DeviceId": token,
        "type": Platform.isAndroid ? "android" : "ios"
      };
      await this.http!.unRegisterDevice(data);
      var rememberMe = await this.storageService!.getBoolData("rememberMe");
      if (rememberMe ?? false) {
        // sharedPreferences.remove("token");
        // sharedPreferences.remove("StorageKeys.token");
        sharedPreferences.remove("route");
        sharedPreferences.remove("selectAccount");
        sharedPreferences.remove(StorageKeys.token.toString());
        sharedPreferences.remove(StorageKeys.user.toString());
      } else {
        sharedPreferences.clear();
      }
      Navigator.pushReplacement<void, void>(
        // this use is account switch problem
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => SelectAccountScreen(),
        ),
      );
      // navigationService!.navigateTo(SelectAccountScreenRoute);
    } catch (err) {
      print(err);
    }

    navigationService!.navigateTo(SelectAccountScreenRoute);
    // Navigator.pushReplacement<void, void>(
    //   // this use is account switch problem
    //   context,
    //   MaterialPageRoute<void>(
    //     builder: (BuildContext context) => SelectAccountScreen(),
    //   ),
    // );
  }

  Future<void> forgotPassword(String email) async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      await _auth.sendPasswordResetEmail(email: email);
      utilService!.showToast(
          "An email has been sent please follow the instructions and recover your password.");
      navigationService!.navigateTo(LoginScreenRoute);
    } catch (err) {
      utilService!.showToast(err.toString());
    }
  }

// Facebook auth //

  // Future<void> signinWithfacebook(BuildContext context) async {
  //   try {
  //     final FirebaseAuth _auth = FirebaseAuth.instance;

  //     final LoginResult result = await FacebookAuth.instance.login(
  //       permissions: [
  //         'public_profile',
  //         'email',
  //       ],
  //     ); // by default we request the email and the public profile
  //     // if (result.status == LoginStatus.success) {
  //     //   // you are logged
  //     //   final AccessToken? accessToken = result.accessToken;
  //     // }

  //     this._accessToken = result.accessToken!.token;
  //     await storageService!.setData("facebooktoken", this._accessToken);
  //     AuthCredential credential =
  //         FacebookUserProvider.credential(result.accessToken!.token);
  //     print(result);
  //     var user = await _auth.signInWithCredential(credential);

  //     // var profile = json.encode(user.additionalUserInfo.profile);
  //     // var profileJSON = json.decode(profile);
  //     //  var profileUrl = user.user!.photoURL! + "?width=300&height=300";
  //     this._user = AppUser(
  //       email: user.user!.email,
  //       fullName: user.user!.displayName,
  //       id: user.user!.uid,
  //     );
  //     this._user!.isEmailVerified = true;
  //     var token = await user.user!.getIdToken(true);
  //     this.token = token;
  //     await this.storageService!.setData("token", this.token);
  //     this.storageService!.setData(StorageKeys.user.toString(), this._user);
  //     await this.getFCMToken();
  //     await Provider.of<BusinessProvider>(context, listen: false)
  //         .fetchAllCategory();
  //     await Provider.of<LanguagesProvider>(context, listen: false)
  //         .fetchAllLanguages();
  //     if (SelectAccount.isInfluencers) {
  //       await Provider.of<InfluencerProvider>(context, listen: false)
  //           .setInfluencerUserData(user.user!.uid);
  //     } else {
  //       await Provider.of<BusinessProvider>(context, listen: false)
  //           .setBusinessUserData(user.user!.uid);
  //     }
  //   } catch (err) {
  //     this._user = null;
  //     print(err);
  //     utilService!.showToast(err.toString());
  //   }
  // }

//SIGN IN KA Function
  // Future<void> googleUserProvider(BuildContext context) async {
  //   try {
  //     final FirebaseAuth _auth = FirebaseAuth.instance;
  //     final GoogleSignIn _googleSignIn = GoogleSignIn(
  //       scopes: ['email'],
  //     );
  //     if (await _googleSignIn.isSignedIn()) {
  //       _googleSignIn.disconnect();
  //     }
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser!.authentication;
  //     this._googleId = googleAuth.idToken;
  //     this._googleToken = googleAuth.accessToken;
  //     await storageService!.setData("googleId", this._googleId);
  //     await storageService!.setData("googleToken", this._googleToken);
  //     final AuthCredential credential = GoogleUserProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     final user = await _auth.signInWithCredential(credential);

  //     print("signed in " + user.user!.displayName!);
  //     this._user = AppUser(
  //       email: user.user!.email,
  //       fullName: user.user!.displayName,
  //       id: user.user!.uid,
  //     );

  //     this._user!.isEmailVerified = user.user!.emailVerified;
  //     var token = await user.user!.getIdToken();
  //     this.token = token;
  //     await this
  //         .storageService!
  //         .setData(StorageKeys.token.toString(), this.token);
  //     this.storageService!.setData(StorageKeys.user.toString(), this._user);
  //     await this.getFCMToken();
  //     await Provider.of<BusinessProvider>(context, listen: false)
  //         .fetchAllCategory();
  //     await Provider.of<LanguagesProvider>(context, listen: false)
  //         .fetchAllLanguages();
  //     if (SelectAccount.isInfluencers) {
  //       await Provider.of<InfluencerProvider>(context, listen: false)
  //           .setInfluencerUserData(user.user!.uid);
  //     } else {
  //       await Provider.of<BusinessProvider>(context, listen: false)
  //           .setBusinessUserData(user.user!.uid);
  //     }
  //   } catch (err) {
  //     this._user = null;
  //     utilService!.showToast(err.toString());
  //   }
  // }

  // Future<void> signInWithApple(BuildContext context) async {
  //   try {
  //     final FirebaseAuth _auth = FirebaseAuth.instance;
  //     final rawNonce = generateNonce();
  //     final nonce = sha256ofString(rawNonce);
  //     final appleCredential = await SignInWithApple.getAppleIDCredential(
  //       scopes: [
  //         AppleIDAuthorizationScopes.email,
  //         AppleIDAuthorizationScopes.fullName,
  //       ],
  //       nonce: nonce,
  //     );
  //     final oauthCredential = OUserProvider("apple.com").credential(
  //       idToken: appleCredential.identityToken,
  //       rawNonce: rawNonce,
  //     );
  //     final user = await _auth.signInWithCredential(oauthCredential);
  //     print("signed in " + user.user!.displayName!);
  //     this._user = AppUser(
  //       email: user.user!.email,
  //       fullName: user.user!.displayName,
  //       id: user.user!.uid,
  //     );
  //     this._user!.isEmailVerified = user.user!.emailVerified;
  //     var token = await user.user!.getIdToken();
  //     this.token = token;
  //     await this
  //         .storageService!
  //         .setData(StorageKeys.token.toString(), this.token);
  //     this.storageService!.setData(StorageKeys.user.toString(), this._user);
  //     await this.getFCMToken();
  //     await Provider.of<BusinessProvider>(context, listen: false)
  //         .fetchAllCategory();
  //     await Provider.of<LanguagesProvider>(context, listen: false)
  //         .fetchAllLanguages();
  //     if (SelectAccount.isInfluencers) {
  //       await Provider.of<InfluencerProvider>(context, listen: false)
  //           .setInfluencerUserData(user.user!.uid);
  //     } else {
  //       await Provider.of<BusinessProvider>(context, listen: false)
  //           .setBusinessUserData(user.user!.uid);
  //     }
  //   } catch (err) {
  //     this._user = null;
  //     utilService!.showToast(err.toString());
  //   }
  // }

//for Apple sign in
  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

//for Apple sign in
  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> editUsersLocation({
    List<String>? value,
    BuildContext? context,
  }) async {
    try {
      await this
          .storageService!
          .setData(StorageKeys.user.toString(), this.user);

      SharedPreferences pref = await SharedPreferences.getInstance();

      pref.setStringList("location", value!);
      if (value.length > 5) {
        value.removeAt(0);
        pref.setStringList("location", value);
      }

      // await storageService!.setData("location", "$value");

      notifyListeners();
    } catch (err) {
      utilService!.showToast(err.toString());
    }
  }

Future<void> notificationToggle({
    bool? value,
    BuildContext? context,
  }) async {
    try {
      await this
          .storageService!
          .setData(StorageKeys.user.toString(), this.user);

      SharedPreferences pref = await SharedPreferences.getInstance();

      pref.setBool("notification", value!);
    
      // await storageService!.setData("location", "$value");

      notifyListeners();
    } catch (err) {
      utilService!.showToast(err.toString());
    }
  }
  Future<void> fetchVendorsRoutebyId(String id) async {
    try {
      var response = await http!.getTripDetailRoute(id);
      routeIdData.clear();
      if (response.statusCode == 200) {
        var body = response.data["data"];

        // id = response.data["data"]["id"];
        print(body);
        // for (var abc in body) {
        routeIdData.add(TripDetailRouteUser.fromJson(body));

        print(routeIdData.length);
        // }
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> fetchActiveVendor() async {
    try {
      var response = await http!.getActiveVendor();
      vendersData.clear();
      if (response.statusCode == 200) {
        var body = response.data["data"]["list"]; //["data"]["list"];
        print('this is the body--${body}');
        for (var abc in body) {
          vendersData.add(GetVendor.fromJson(abc));
          print("lengthcbv${vendersData.length}");
        }
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
  }
}
