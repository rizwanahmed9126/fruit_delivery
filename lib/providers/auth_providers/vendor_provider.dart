import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';
import 'package:fruit_delivery_flutter/providers/g_data_provider.dart';
import 'package:fruit_delivery_flutter/providers/route_provider.dart';
import 'package:fruit_delivery_flutter/models/getallvender_model.dart';
import 'package:fruit_delivery_flutter/models/trip_routes_model.dart';
import 'package:fruit_delivery_flutter/screens/email_verification_screen.dart';
import 'package:fruit_delivery_flutter/screens/login_screen.dart';
import 'package:fruit_delivery_flutter/utils/authentication.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

import '../../services/http_service.dart';
import '../../services/storage_service.dart';
import '../../services/util_service.dart';
import '../../services/firebase_service.dart';
import '../../services/navigation_service.dart';
import '../../utils/routes.dart';
import '../../utils/service_locator.dart';
import '../../widgets/enums.dart';
import '../../models/vendor.dart';
import '../../screens/change_password_sucessfully_screen.dart';
import '../../providers/products_provider.dart';
import '../../screens/select_account.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart' as apple;

class VendorProvider with ChangeNotifier {
  NavigationService? navigationService = locator<NavigationService>();
  UtilService? utilService = locator<UtilService>();
  StorageService? storageService = locator<StorageService>();
  HttpService? http = locator<HttpService>();
  FirebaseService? _firebase = locator<FirebaseService>();
  final _firebaseAuth=FirebaseAuth.instance;

  bool isLoadingProgress = false;

  String? token;
  String? _password;
  String? phoneNumber;
  VendorUser? _vendor;
  bool _isRemeber = false;
  List<Placemark>? fromAddress;







  VendorUser? get vendorData {
    return this._vendor;
  }

  setVendor(VendorUser user) {
    this._vendor = user;
  }

  setVendorProducts(var data) async {
    this._vendor!.products = data;
    await this.storageService!.setData('vendor', this._vendor);
  }

  setVendorIsRemeber(bool val) async {
    await this.storageService!.setBoolData('isRemember', val);
    this._isRemeber = val;
  }

  Future<bool> getVendorIsRemember() async {
    var data = await this.storageService!.getBoolData('isRemember');
    return data ?? false;
  }

  Future<void> resendVerificationEmail() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var user = _auth.currentUser!;
    user.sendEmailVerification();
    utilService!.showToast("A verification email has been sent.");
  }

  Future<void> createVendorProfile({
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
      var response = await this.http!.editVendorProfileInformation(data);
      var result = response.data["data"];
      // var data = this._vendor;
      this._vendor = VendorUser(
          address: result["address"],
          email: result["email"],
          fullName: result["fullName"],
          id: result["id"],
          phoneNumber: result["phoneNumber"],
          profilePicture: result["profilePicture"],
          products: result["products"]["products"],
          isEmailVerified: result["isEmailVerified"]);
      await this.storageService!.setData('vendor', this._vendor);

      notifyListeners();
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
      } else if (_vendor == null) {
      
        utilService?.showToast(err.toString());
      } else {
        
        utilService?.showToast(err.toString());
      }
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

Future<User> signInWithApple({List<Scope> scopes = const []}) async {
    // 1. perform the sign-in request
    //final TheAppleSignIn abc=TheAppleSignIn();

    final result = await apple.TheAppleSignIn.performRequests(
        [apple.AppleIdRequest(requestedScopes: scopes)]);
    // 2. check the result
    switch (result.status) {
      case apple.AuthorizationStatus.authorized:
        final appleIdCredential = result.credential!;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken!),
          accessToken:
          String.fromCharCodes(appleIdCredential.authorizationCode!),
        );
        final userCredential =
        await _firebaseAuth.signInWithCredential(credential);

        final firebaseUser = userCredential.user!;
        if (scopes.contains(Scope.fullName)) {
          final fullName = appleIdCredential.fullName;
          if (fullName != null && fullName.givenName != null && fullName.familyName != null) {
            final displayName = '${fullName.givenName} ${fullName.familyName}';
            await firebaseUser.updateDisplayName(displayName);
          }
        }
        return firebaseUser;
      case apple.AuthorizationStatus.error:
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );

      case apple.AuthorizationStatus.cancelled:
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      default:
        throw UnimplementedError();
    }
  }


  Future<void> vendorSignInWithApple(BuildContext context) async {
    try {
      //final authService = Provider.of<AuthService>(context, listen: false);
      final user = await signInWithApple(scopes: [Scope.email, Scope.fullName]);
      // print('uid: ${user.uid}');
      // print('uid: ${user.getIdToken()}');
      // print('uid: ${user.email??""}');
      // print('uid: ${user.displayName??""}');
      // print('uid: ${user.emailVerified??""}');

      var token = await user.getIdToken();
      this.token = token;
      await this.storageService!.setData(StorageKeys.token.toString(), this.token);
      await this.http!.vendorSignUp({
        "id": user.uid,
        "fullName": user.displayName,
        "email": user.email,
      });
      print(token);


      await this.storageService!.setData(StorageKeys.token.toString(), this.token);
      print(user.uid);
      var userByIdData = await this.http!.getVendorById(user.uid);
      var response = userByIdData.data;
      if (user.emailVerified) {
        this._vendor = VendorUser(
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

        await this.http!.addVendorCurrentLocation(addressData);

        if (this._isRemeber) {
          await this.storageService!.setData("userEmail", this._vendor!.email);
          await this.storageService!.setData("password", this._password);
          await this.storageService!.setBoolData("rememberMe", this._isRemeber);
        } else {
          await this.storageService!.setBoolData("rememberMe", this._isRemeber);
        }
        // if(respo)
        if (response['message'] != "Vendor does not exist,") {
          this._vendor!.isEmailVerified = user.emailVerified;




          this._vendor!.fullName = response['data']['fullName'];
          this._vendor!.phoneNumber = response['data']['phoneNumber'];
          this._vendor!.profilePicture = response['data']['profilePicture'];
          this._vendor!.address = response['data']['address'];
          this._vendor!.products = response['data']['products'] ?? [];
          Provider.of<ProductsProvider>(
            context,
            listen: false,
          ).setAlreadyAddedProducts(this._vendor!.products ?? []);

          print(_vendor!.profilePicture);

          this.storageService!.setData("vendor", this._vendor);
        } else {
          // this._vendor!.email=user.email;
          // this._vendor!.fullName=user.displayName;
          // this._vendor!.profilePicture=user.photoURL;
          // this._vendor!.phoneNumber="";
          //
          // this.storageService!.setData("vendor", this._vendor);

          utilService!.showToast("Vendor does not exist");
          return;
        }

        await this.getFCMToken();
        if (this._vendor!.phoneNumber != "") {
          await Provider.of<RouteProvider>(context, listen: false).fetchAllRoute().then((value) {
            if (Provider.of<RouteProvider>(context, listen: false).tripData.isNotEmpty) {
              navigationService!.navigateTo(ScheduleScreenRoute);
            } else {
              navigationService!.navigateTo(CreateRouteScreenRoute);
            }
          });
          //navigationService!.navigateTo(CreateRouteScreenRoute);
          return;
        } else {
          this._vendor!.email=user.email;
          this._vendor!.fullName=user.displayName;
          this._vendor!.profilePicture=user.photoURL;
          navigationService!.navigateTo(CreateVendorProfileScreenRoute);
          return;
        }
      } else {
        await _firebase!.sendEmailVerification();
        this._vendor = VendorUser(
            email: user.email,
            id: user.uid,
            profilePicture: user.photoURL
          // fullName: user.displayName,
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




  Future<void> vendorSignInWithFacebook({required BuildContext context}) async {

    User? user;

    final LoginResult result = await FacebookAuth.instance.login();
    // Once signed in, return the UserCredential
    final OAuthCredential facebookCredential = FacebookAuthProvider.credential(result.accessToken!.token);
    // final userCredential = await FirebaseAuth.instance.signInWithCredential(facebookCredential).then((value)async{
    //   var token = await value.user!.getIdToken();
    //   print('$token');
    //   print('${value.user!.displayName}');
    //   print('${value.user!.photoURL}');
    //
    //   print('${value.user!.email}');
    // });




    try {
        final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookCredential);



        user = userCredential.user;
        var token = await user!.getIdToken();
        this.token = token;
        await this.storageService!.setData(StorageKeys.token.toString(), this.token);
        await this.http!.vendorSignUp({
          "id": user.uid,
          "fullName": user.displayName,
          //"email": user.email,
        });
        print(token);


        await this.storageService!.setData(StorageKeys.token.toString(), this.token);
        print(user.uid);
        var userByIdData = await this.http!.getVendorById(user.uid);
        var response = userByIdData.data;
       // if (user.emailVerified) {
          this._vendor = VendorUser(
              id: user.uid,
              //email: user.email,
              //profilePicture: user.photoURL
          );

          await getAddress(context);
          var addressData = {
            "country": "${fromAddress![0].country}",
            "city": "${fromAddress![0].subAdministrativeArea}",
            "lat": Provider.of<GMapsProvider>(context, listen: false).currentLocation!.latitude!,
            "long": Provider.of<GMapsProvider>(context, listen: false).currentLocation!.longitude!,
            "address": "${fromAddress![0].street}, ${fromAddress![0].thoroughfare}, ${fromAddress![0].subAdministrativeArea}",
          };

          await this.http!.addVendorCurrentLocation(addressData);

          if (this._isRemeber) {
            await this.storageService!.setData("userEmail", this._vendor!.email);
            await this.storageService!.setData("password", this._password);
            await this.storageService!.setBoolData("rememberMe", this._isRemeber);
          } else {
            await this.storageService!.setBoolData("rememberMe", this._isRemeber);
          }
          // if(respo)
          if (response['message'] != "Vendor does not exist,") {
            this._vendor!.isEmailVerified = user.emailVerified;




            this._vendor!.fullName = response['data']['fullName'];
            this._vendor!.phoneNumber = response['data']['phoneNumber'];
            this._vendor!.profilePicture = response['data']['profilePicture'];
            this._vendor!.address = response['data']['address'];
            this._vendor!.products = response['data']['products'] ?? [];
            Provider.of<ProductsProvider>(
              context,
              listen: false,
            ).setAlreadyAddedProducts(this._vendor!.products ?? []);

            print(_vendor!.profilePicture);

            this.storageService!.setData("vendor", this._vendor);
          } else {
            // this._vendor!.email=user.email;
            // this._vendor!.fullName=user.displayName;
            // this._vendor!.profilePicture=user.photoURL;
            // this._vendor!.phoneNumber="";
            //
            // this.storageService!.setData("vendor", this._vendor);

            utilService!.showToast("Vendor does not exist");
            return;
          }

          await this.getFCMToken();
          if (this._vendor!.phoneNumber != "") {
            await Provider.of<RouteProvider>(context, listen: false).fetchAllRoute().then((value) {
              if (Provider.of<RouteProvider>(context, listen: false).tripData.isNotEmpty) {
                navigationService!.navigateTo(ScheduleScreenRoute);
              } else {
                navigationService!.navigateTo(CreateRouteScreenRoute);
              }
            });
            //navigationService!.navigateTo(CreateRouteScreenRoute);
            return;
          } else {
            // this._vendor!.email=user.email;
            // this._vendor!.fullName=user.displayName;
            // this._vendor!.profilePicture=user.photoURL;
            navigationService!.navigateTo(CreateVendorProfileScreenRoute);
            return;
          }
        // } else {
        //   await _firebase!.sendEmailVerification();
        //   this._vendor = VendorUser(
        //       email: user.email,
        //       id: user.uid,
        //       profilePicture: user.photoURL
        //     // fullName: user.displayName,
        //   );
        //
        //   navigationService!.navigateTo(EmailVerificationScreenRoute);
        //   return;
        // }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          utilService!.showToast('The account already exists with a different credential');

        } else if (e.code == 'invalid-credential') {
          utilService!.showToast('Error occurred while accessing credentials. Try again.');


        }
      } catch (e) {
        utilService!.showToast('Error occurred using Google Sign In. Try again.');

      }


    //return user;
  }

  Future<void> vendorSignInWithGoogle({required BuildContext context}) async {
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

      try {
        final UserCredential userCredential = await auth.signInWithCredential(credential);



        user = userCredential.user;
        var token = await user!.getIdToken();
        this.token = token;
        await this.storageService!.setData(StorageKeys.token.toString(), this.token);
        await this.http!.vendorSignUp({
          "id": user.uid,
          "fullName": user.displayName,
          "email": user.email,
        });
        print(token);


        await this.storageService!.setData(StorageKeys.token.toString(), this.token);
        print(user.uid);
        var userByIdData = await this.http!.getVendorById(user.uid);
        var response = userByIdData.data;
        if (user.emailVerified) {
          this._vendor = VendorUser(
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

          await this.http!.addVendorCurrentLocation(addressData);

          if (this._isRemeber) {
            await this.storageService!.setData("userEmail", this._vendor!.email);
            await this.storageService!.setData("password", this._password);
            await this.storageService!.setBoolData("rememberMe", this._isRemeber);
          } else {
            await this.storageService!.setBoolData("rememberMe", this._isRemeber);
          }
          // if(respo)
          if (response['message'] != "Vendor does not exist,") {
            this._vendor!.isEmailVerified = user.emailVerified;




            this._vendor!.fullName = response['data']['fullName'];
            this._vendor!.phoneNumber = response['data']['phoneNumber'];
            this._vendor!.profilePicture = response['data']['profilePicture'];
            this._vendor!.address = response['data']['address'];
            this._vendor!.products = response['data']['products'] ?? [];
            Provider.of<ProductsProvider>(
              context,
              listen: false,
            ).setAlreadyAddedProducts(this._vendor!.products ?? []);

            print(_vendor!.profilePicture);

            this.storageService!.setData("vendor", this._vendor);
          } else {
            // this._vendor!.email=user.email;
            // this._vendor!.fullName=user.displayName;
            // this._vendor!.profilePicture=user.photoURL;
            // this._vendor!.phoneNumber="";
            //
            // this.storageService!.setData("vendor", this._vendor);

            utilService!.showToast("Vendor does not exist");
            return;
          }

          await this.getFCMToken();
          if (this._vendor!.phoneNumber != "") {
            await Provider.of<RouteProvider>(context, listen: false).fetchAllRoute().then((value) {
              if (Provider.of<RouteProvider>(context, listen: false).tripData.isNotEmpty) {
                navigationService!.navigateTo(ScheduleScreenRoute);
              } else {
                navigationService!.navigateTo(CreateRouteScreenRoute);
              }
            });
            //navigationService!.navigateTo(CreateRouteScreenRoute);
            return;
          } else {
            this._vendor!.email=user.email;
            this._vendor!.fullName=user.displayName;
            this._vendor!.profilePicture=user.photoURL;
            navigationService!.navigateTo(CreateVendorProfileScreenRoute);
            return;
          }
        } else {
          await _firebase!.sendEmailVerification();
          this._vendor = VendorUser(
            email: user.email,
            id: user.uid,
            profilePicture: user.photoURL
            // fullName: user.displayName,
          );

          navigationService!.navigateTo(EmailVerificationScreenRoute);
          return;
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          utilService!.showToast('The account already exists with a different credential');

        } else if (e.code == 'invalid-credential') {
          utilService!.showToast('Error occurred while accessing credentials. Try again.');


        }
      } catch (e) {
        utilService!.showToast('Error occurred using Google Sign In. Try again.');

      }
    }

    //return user;
  }




  Future<void> signinVendorWithEmailAndPassword(String email, String password, BuildContext context) async {
    try {
      this._password = password;
      await storageService!.setData("password", this._password);

      var dataIsremember = await storageService!.haveData('isRemember');
      if (dataIsremember) {
        this._isRemeber = await storageService!.getBoolData('isRemember');
      }
      final user = await _firebase!.signinWithEmailAndPassword(email, password);

      var token = await user.getIdToken();
      this.token = token;
      await this.storageService!.setData(StorageKeys.token.toString(), this.token);
      var userByIdData = await this.http!.getVendorById(user.uid);
      var response = userByIdData.data;
      if (response['message'] == "User does not exist,") {
        utilService!.showToast("User does not exist,");
      } else {
        if (user.emailVerified) {
          this._vendor = VendorUser(
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

          await this.http!.addVendorCurrentLocation(addressData);

          if (this._isRemeber) {
            await this
                .storageService!
                .setData("userEmail", this._vendor!.email);
            await this.storageService!.setData("password", this._password);
            await this
                .storageService!
                .setBoolData("rememberMe", this._isRemeber);
          } else {
            await this
                .storageService!
                .setBoolData("rememberMe", this._isRemeber);
          }
          // if(respo)
          if (response['message'] != "Vendor does not exist,") {
            this._vendor!.isEmailVerified = user.emailVerified;

            this._vendor!.fullName = response['data']['fullName'];
            this._vendor!.phoneNumber = response['data']['phoneNumber'];
            this._vendor!.profilePicture = response['data']['profilePicture'];
            this._vendor!.address = response['data']['address'];
            this._vendor!.products = response['data']['products'] ?? [];
            Provider.of<ProductsProvider>(
              context,
              listen: false,
            ).setAlreadyAddedProducts(this._vendor!.products ?? []);

            this.storageService!.setData("vendor", this._vendor);
          } else {
            utilService!.showToast("Vendor does not exist");
            return;
          }

          await this.getFCMToken();
          if (this._vendor!.phoneNumber != "") {
            await Provider.of<RouteProvider>(context, listen: false)
                .fetchAllRoute()
                .then((value) {
              if (Provider.of<RouteProvider>(context, listen: false)
                  .tripData
                  .isNotEmpty) {
                navigationService!.navigateTo(ScheduleScreenRoute);
              } else {
                navigationService!.navigateTo(CreateRouteScreenRoute);
              }
            });
            //navigationService!.navigateTo(CreateRouteScreenRoute);
            return;
          } else {
            navigationService!.navigateTo(CreateVendorProfileScreenRoute);
            return;
          }
        } else {
          await _firebase!.sendEmailVerification();
          this._vendor = VendorUser(
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
      } else if (_vendor == null) {
      
        utilService?.showToast(err.toString());
      } else {
        
        utilService?.showToast(err.toString());
      }
    }
  }

  refreshToken() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var user = _auth.currentUser!;
    var token = await user.getIdToken(true);
    await storageService!.setData(StorageKeys.token.toString(), token);
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
        "userId": this._vendor!.id,
        "type": Platform.isAndroid ? "android" : "ios"
      };
      await this.http!.vendorRegisterDevice(data);
    } catch (err) {
      print(err);
    }
  }

  Future<void> createVendorWithEmailPassword({
    String? selectedAccount,
    BuildContext? context,
    String? email,
    String? password,
    String? userName,
  }) async {
    try {
      final user = await _firebase!.createUserWithEmailAndPassword(email!, password!);
      var token = await user.getIdToken();
      await this.storageService!.setData(StorageKeys.token.toString(), token.toString());
      this._vendor = VendorUser(
        id: user.uid,
        fullName: userName,
        email: user.email,
      );
      // await user!.sendEmailVerification(); // ye yaha se hate ga
      await this.http!.vendorSignUp({
        "id": user.uid,
        "fullName": userName,
        "email": user.email,
      });
      await user!.sendEmailVerification();
      Navigator.of(context!).push(MaterialPageRoute(
          builder: (context) => EmailVerificationScreen(
                selectAccount: selectedAccount,
              )));

      // ye uncommitn ho ga
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
      } else if (_vendor == null) {
      
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
          email: this._vendor!.email!.trim(), password: oldPassword!.trim());

      final user = authResult.user;
      await user!.updatePassword(newPassword!);
      // navigationService!.navigateTo(ChangePasswordSuccessfullyScreenRoute);
      showDialog(
          context: context!,
          barrierDismissible: false,
          builder: (_) {
            return ChangePasswordSuccessfullyScreen(
              title: AppLocalizations.of(context)
                  .translate('ChangePasswordPopupText'),
              //  'Successfully changed your password',
              routeName: DriverHomeScreenRoute,
            );
          });
    } on FirebaseAuthException catch (err) {
      if (err.code == 'user-not-found') {
        utilService!.showToast('Invalid password');
      } else if (err.code == 'wrong-password') {
        utilService!.showToast(
            "The old password is invalid or the user does not have a password.");
      } else {
        utilService!.showToast(err.toString());
      }
    }
  }
  // Future<void> changePassword(String oldPassword, String newPassword) async {
  //   try {
  //     final FirebaseAuth _auth = FirebaseAuth.instance;
  //     final authResult = await _auth.signInWithEmailAndPassword(
  //         email: this._vendor!.email!.trim(), password: oldPassword.trim());

  //     final user = authResult.user;
  //     await user!.updatePassword(newPassword);
  //     navigationService!.navigateTo(ChangePasswordSuccessfullyScreenRoute);
  //   } catch (err) {
  //     utilService!.showToast(err.toString());
  //   }
  // }




  Future<void> logoutFirebaseVendor(BuildContext context) async {
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
      print("old token$token");
      var data = {
        "UserId": this._vendor!.id,
        "DeviceId": token,
        "type": Platform.isAndroid ? "android" : "ios"
      };
      await this.http!.vendorUnRegisterDevice(data);
      var rememberMe = await this.storageService!.getBoolData("rememberMe");
      if (rememberMe ?? false) {
        // sharedPreferences.remove("token");
        // sharedPreferences.remove("StorageKeys.token");
        sharedPreferences.remove(StorageKeys.token.toString());
        sharedPreferences.remove("selectAccount");

        sharedPreferences.remove("route");

        sharedPreferences.remove("vendor");
        sharedPreferences.remove(StorageKeys.user.toString());
      } else {
        sharedPreferences.clear();
      }
      context.read<RouteProvider>().tripData.clear();

      Navigator.pushReplacement<void, void>(
        // this use is account switch problem
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => SelectAccountScreen(),
        ),
      );
    } catch (err) {
      print(err);
    }
    Navigator.pushReplacement<void, void>(
      // this use is account switch problem
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => SelectAccountScreen(),
      ),
    );
    // navigationService!.navigateTo(SelectAccountScreenRoute);
  }

  Future<void> forgotPassword(
      String email, String selectedAccount, BuildContext context) async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      await _auth.sendPasswordResetEmail(email: email);
      utilService!.showToast(
          "An email has been sent please follow the instructions and recover your password.");
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoginScreen(
            selectAccount: selectedAccount,
          ),
        ),
      );
      // navigationService!.navigateTo(LoginScreenRoute);
    } on FirebaseAuthException catch (err) {
      if (err.code == 'user-not-found') {
        utilService!.showToast('Email Address not found.');
      } else {
        utilService!.showToast('${err.toString()}');
      }
    }
  }

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
  // Future<void> getAddress({
  //   String? name,

  // }) async {
  //   try {

  //     await this
  //         .storageService!
  //         .setData(StorageKeys.token.toString(), token.toString());

  //     // await user!.sendEmailVerification(); // ye yaha se hate gaye uncommitn ho ga
  //     // navigationService!.navigateTo(EmailVerificationScreenRoute);
  //   } catch (err) {
  //     utilService!.showToast(err.toString());
  //   }
  // }

//   List productList = [];

//  //---------Adding contoller to list

//  productProvider.getAll(user.guid).forEach((element) {//---List<Product>
//  final TextEditingController quantityController =
//  TextEditingController(text: element.quantity);
//  quantityControllers.add(quantityController);
//  });

//    //-------Adding list of products to list
//   List<Map<String, dynamic>> productItems = [];
//    List<Product> productOriginalList =
//    productProvider.getAll(user.guid);
//    for (int i = 0; i < productOriginalList.length; i++) {
//    final Product product = productOriginalList[i];
//    if (selection.contains(product.equipmentId)) {

//    productItems.add(product.toJson(quantityControllers[i].text));
//               }

}
