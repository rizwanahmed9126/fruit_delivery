// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';

// import 'package:flutter/material.dart';

// import 'package:crypto/crypto.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../services/http_service.dart';
// import '../services/storage_service.dart';
// import '../services/util_service.dart';
// import '../constants/select_account.dart';
// import '../models/user.dart';
// import '../services/firebase_service.dart';
// import '../services/navigation_service.dart';
// import '../utils/routes.dart';
// import '../utils/service_locator.dart';
// import '../widgets/enums.dart';

// class AuthProvider with ChangeNotifier {
//   NavigationService? navigationService = locator<NavigationService>();
//   UtilService? utilService = locator<UtilService>();
//   StorageService? storageService = locator<StorageService>();
//   HttpService? http = locator<HttpService>();
//   FirebaseService? _firebase = locator<FirebaseService>();

//   bool isLoadingProgress = false;

//   String? token;
//   String? _password;
//   String? phoneNumber;
//   AppUser? _user;
//   bool _isRemeber = false;
//   String? _accessToken;

//   String? _googleId;
//   String? _googleToken;

//   Map<String, dynamic> createBusinessdata = {};
//   Map<String, dynamic> updateBusinessdata = {};
//   Map<String, dynamic> createInfluencerdata = {};

//   get getCreateBusinessProfileData {
//     return this.createBusinessdata;
//   }

//   get getCreateInfluencerProfileData {
//     return this.createInfluencerdata;
//   }

//   get userData {
//     return this._user;
//   }

//   setuser(AppUser user) {
//     this._user = user;
//   }

//   setIsRemeber(bool val) async {
//     await this.storageService!.setBoolData('isRemember', val);
//     this._isRemeber = val;
//   }

//   Future<bool> getIsRemember() async {
//     var data = await this.storageService!.getBoolData('isRemember');
//     return data ?? false;
//   }

//   Future<void> resendVerificationEmail() async {
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//     var user = _auth.currentUser!;
//     user.sendEmailVerification();
//     utilService!.showToast("A verification email has been sent.");
//   }

//   Future<void> createProfile({
//     String? name,
//     String? email,
//     String? imageUrl,
//     String? contact,
//     String? dateOfBirth,
//     BuildContext? context,
//   }) async {
//     try {
//       Map<String, dynamic> data = {
//         "profilePicture": imageUrl,
//         "fullName": name,
//         "email": email,
//         "address": dateOfBirth,
//         "contact": contact,
//       };
//       var response = await this.http!.editProfileInformation(data);
//       var result = response.data;
//       // var data = this._user;
//       // this._user = FlutterUser.fromJson(result['data']);
//       // await this.storageService.setData('user', this._user);
//       // await Provider.of<CategoryProvider>(context, listen: false)
//       //     .fetchAllCategories();
//       notifyListeners();
//       navigationService!.navigateTo(MainDashboardScreenRoute);
//     } catch (err) {
//       utilService!.showToast(err.toString());
//     }
//   }

//   Future<void> signinWithEmailAndPassword(
//       String email, String password, BuildContext context) async {
//     try {
//       this._password = password;
//       await storageService!
//           .setData(StorageKeys.password.toString(), this._password);

//       var dataIsremember = await storageService!.haveData('isRemember');
//       if (dataIsremember) {
//         this._isRemeber = await storageService!.getBoolData('isRemember');
//       }
//       final user = await _firebase!.signinWithEmailAndPassword(email, password);
//       var userByIdData = await this.http!.getUserById(user.uid);
//       var response = userByIdData.data;
//       if (user.emailVerified) {
//         this._user = AppUser(
//           id: user.uid,
//           email: user.email,
//         );

//         if (this._isRemeber) {
//           await this.storageService!.setData("userEmail", this._user!.email);
//           await this.storageService!.setData("password", this._password);
//           await this.storageService!.setBoolData("rememberMe", this._isRemeber);
//         } else {
//           await this.storageService!.setBoolData("rememberMe", this._isRemeber);
//         }
//         this._user!.isEmailVerified = user.emailVerified;
//         var token = await user.getIdToken();
//         this.token = token;
//         await this
//             .storageService!
//             .setData(StorageKeys.token.toString(), this.token);
//         this._user!.fullName = response['data']['fullName'];
//         this.storageService!.setData(StorageKeys.user.toString(), this._user);

//         await getFCMToken();

//         if (SelectAccount.selectAccount ==
//             SelectAccountEnum.Driver.toString()) {
//           navigationService!.navigateTo(DriverHomeScreenRoute);
//         } else {
//           navigationService!.navigateTo(CreateProfileScreenRoute);
//         }
//       } else {
//         await _firebase!.sendEmailVerification();
//         this._user = AppUser(
//           email: email,
//           id: user.uid,
//           // fullName: user.displayName,
//         );

//         navigationService!.navigateTo(EmailVerificationScreenRoute);
//         return;
//       }
//     } catch (err) {
//       if (userData == null)
//         utilService!.showToast("This account does not exist");
//       else
//         utilService!.showToast(err.toString());
//     }
//   }

//   refreshToken() async {
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//     var user = _auth.currentUser!;
//     var token = await user.getIdToken(true);
//     await storageService!.setData(StorageKeys.token.toString(), token);
//   }

//   Future<void> getFCMToken() async {
//     try {
//       final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//       _firebaseMessaging.requestPermission();
//       _firebaseMessaging.setForegroundNotificationPresentationOptions(
//         sound: true,
//         badge: true,
//         alert: true,
//       );
//       String? token = await _firebaseMessaging.getToken();
//       Map<String, dynamic> data = {
//         "fcmToken": token,
//         "userId": this._user!.id,
//         "type": Platform.isAndroid ? "android" : "ios"
//       };
//       await this.http!.registerDevice(data);
//     } catch (err) {
//       print(err);
//     }
//   }

//   Future<void> createUserWithEmailPassword(
//     String email,
//     String password,
//     String userName,
//   ) async {
//     try {
//       final user =
//           await _firebase!.createUserWithEmailAndPassword(email, password);
//       var token = await user.getIdToken();
//       await this
//           .storageService!
//           .setData(StorageKeys.token.toString(), token.toString());
//       this._user = AppUser(
//         id: user.uid,
//         fullName: userName,
//         email: user.email,
//       );
//       // await user!.sendEmailVerification(); // ye yaha se hate ga
//       await this.http!.signUp({
//         "id": user.uid,
//         "fullName": userName,
//         "email": user.email,
//       });
//       await user!.sendEmailVerification(); // ye uncommitn ho ga
//       navigationService!.navigateTo(EmailVerificationScreenRoute);
//     } catch (err) {
//       utilService!.showToast(err.toString());
//     }
//   }

//   Future<void> changePassword(String oldPassword, String newPassword) async {
//     try {
//       final FirebaseAuth _auth = FirebaseAuth.instance;
//       final authResult = await _auth.signInWithEmailAndPassword(
//           email: this._user!.email!.trim(), password: oldPassword.trim());

//       final user = authResult.user;
//       await user!.updatePassword(newPassword);
//       navigationService!.navigateTo(ChangePasswordSuccessfullyScreenRoute);
//     } catch (err) {
//       utilService!.showToast(err.toString());
//     }
//   }

//   Future<void> logoutFirebaseUser() async {
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//     await _auth.signOut();
//     var sharedPreferences = await SharedPreferences.getInstance();
//     // stopStream();
//     try {
//       final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//       _firebaseMessaging.requestPermission(
//           //     const IosNotificationSettings(sound: true, badge: true, alert: true));
//           // _firebaseMessaging.onIosSettingsRegistered
//           //     .listen((IosNotificationSettings settings) {
//           //   print("Settings registered: $settings");
//           //
//           // }
//           );

//       _firebaseMessaging.setForegroundNotificationPresentationOptions(
//         sound: true,
//         badge: true,
//         alert: true,
//       );
//       String? token = await _firebaseMessaging.getToken();
//       var data = {
//         "UserId": this._user!.id,
//         "DeviceId": token,
//         "type": Platform.isAndroid ? "android" : "ios"
//       };
//       await this.http!.unRegisterDevice(data);
//       var rememberMe = await this.storageService!.getBoolData("rememberMe");
//       if (rememberMe ?? false) {
//         sharedPreferences.remove("token");
//         sharedPreferences.remove("route");
//       } else {
//         sharedPreferences.clear();
//       }
//       navigationService!.navigateTo(SelectAccountScreenRoute);
//     } catch (err) {
//       print(err);
//     }

//     navigationService!.navigateTo(SelectAccountScreenRoute);
//   }

//   Future<void> forgotPassword(String email) async {
//     try {
//       final FirebaseAuth _auth = FirebaseAuth.instance;
//       await _auth.sendPasswordResetEmail(email: email);
//       utilService!.showToast(
//           "An email has been sent please follow the instructions and recover your password.");
//       navigationService!.navigateTo(LoginScreenRoute);
//     } catch (err) {
//       utilService!.showToast(err.toString());
//     }
//   }

// // Facebook auth //

//   // Future<void> signinWithfacebook(BuildContext context) async {
//   //   try {
//   //     final FirebaseAuth _auth = FirebaseAuth.instance;

//   //     final LoginResult result = await FacebookAuth.instance.login(
//   //       permissions: [
//   //         'public_profile',
//   //         'email',
//   //       ],
//   //     ); // by default we request the email and the public profile
//   //     // if (result.status == LoginStatus.success) {
//   //     //   // you are logged
//   //     //   final AccessToken? accessToken = result.accessToken;
//   //     // }

//   //     this._accessToken = result.accessToken!.token;
//   //     await storageService!.setData("facebooktoken", this._accessToken);
//   //     AuthCredential credential =
//   //         FacebookAuthProvider.credential(result.accessToken!.token);
//   //     print(result);
//   //     var user = await _auth.signInWithCredential(credential);

//   //     // var profile = json.encode(user.additionalUserInfo.profile);
//   //     // var profileJSON = json.decode(profile);
//   //     //  var profileUrl = user.user!.photoURL! + "?width=300&height=300";
//   //     this._user = AppUser(
//   //       email: user.user!.email,
//   //       fullName: user.user!.displayName,
//   //       id: user.user!.uid,
//   //     );
//   //     this._user!.isEmailVerified = true;
//   //     var token = await user.user!.getIdToken(true);
//   //     this.token = token;
//   //     await this.storageService!.setData("token", this.token);
//   //     this.storageService!.setData(StorageKeys.user.toString(), this._user);
//   //     await this.getFCMToken();
//   //     await Provider.of<BusinessProvider>(context, listen: false)
//   //         .fetchAllCategory();
//   //     await Provider.of<LanguagesProvider>(context, listen: false)
//   //         .fetchAllLanguages();
//   //     if (SelectAccount.isInfluencers) {
//   //       await Provider.of<InfluencerProvider>(context, listen: false)
//   //           .setInfluencerUserData(user.user!.uid);
//   //     } else {
//   //       await Provider.of<BusinessProvider>(context, listen: false)
//   //           .setBusinessUserData(user.user!.uid);
//   //     }
//   //   } catch (err) {
//   //     this._user = null;
//   //     print(err);
//   //     utilService!.showToast(err.toString());
//   //   }
//   // }

// //SIGN IN KA Function
//   // Future<void> googleAuthProvider(BuildContext context) async {
//   //   try {
//   //     final FirebaseAuth _auth = FirebaseAuth.instance;
//   //     final GoogleSignIn _googleSignIn = GoogleSignIn(
//   //       scopes: ['email'],
//   //     );
//   //     if (await _googleSignIn.isSignedIn()) {
//   //       _googleSignIn.disconnect();
//   //     }
//   //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

//   //     final GoogleSignInAuthentication googleAuth =
//   //         await googleUser!.authentication;
//   //     this._googleId = googleAuth.idToken;
//   //     this._googleToken = googleAuth.accessToken;
//   //     await storageService!.setData("googleId", this._googleId);
//   //     await storageService!.setData("googleToken", this._googleToken);
//   //     final AuthCredential credential = GoogleAuthProvider.credential(
//   //       accessToken: googleAuth.accessToken,
//   //       idToken: googleAuth.idToken,
//   //     );

//   //     final user = await _auth.signInWithCredential(credential);

//   //     print("signed in " + user.user!.displayName!);
//   //     this._user = AppUser(
//   //       email: user.user!.email,
//   //       fullName: user.user!.displayName,
//   //       id: user.user!.uid,
//   //     );

//   //     this._user!.isEmailVerified = user.user!.emailVerified;
//   //     var token = await user.user!.getIdToken();
//   //     this.token = token;
//   //     await this
//   //         .storageService!
//   //         .setData(StorageKeys.token.toString(), this.token);
//   //     this.storageService!.setData(StorageKeys.user.toString(), this._user);
//   //     await this.getFCMToken();
//   //     await Provider.of<BusinessProvider>(context, listen: false)
//   //         .fetchAllCategory();
//   //     await Provider.of<LanguagesProvider>(context, listen: false)
//   //         .fetchAllLanguages();
//   //     if (SelectAccount.isInfluencers) {
//   //       await Provider.of<InfluencerProvider>(context, listen: false)
//   //           .setInfluencerUserData(user.user!.uid);
//   //     } else {
//   //       await Provider.of<BusinessProvider>(context, listen: false)
//   //           .setBusinessUserData(user.user!.uid);
//   //     }
//   //   } catch (err) {
//   //     this._user = null;
//   //     utilService!.showToast(err.toString());
//   //   }
//   // }

//   // Future<void> signInWithApple(BuildContext context) async {
//   //   try {
//   //     final FirebaseAuth _auth = FirebaseAuth.instance;
//   //     final rawNonce = generateNonce();
//   //     final nonce = sha256ofString(rawNonce);
//   //     final appleCredential = await SignInWithApple.getAppleIDCredential(
//   //       scopes: [
//   //         AppleIDAuthorizationScopes.email,https://i.diawi.com/xRUri5
//   //         AppleIDAuthorizationScopes.fullName,
//   //       ],
//   //       nonce: nonce,
//   //     );
//   //     final oauthCredential = OAuthProvider("apple.com").credential(
//   //       idToken: appleCredential.identityToken,
//   //       rawNonce: rawNonce,
//   //     );
//   //     final user = await _auth.signInWithCredential(oauthCredential);
//   //     print("signed in " + user.user!.displayName!);
//   //     this._user = AppUser(
//   //       email: user.user!.email,
//   //       fullName: user.user!.displayName,
//   //       id: user.user!.uid,
//   //     );
//   //     this._user!.isEmailVerified = user.user!.emailVerified;
//   //     var token = await user.user!.getIdToken();
//   //     this.token = token;
//   //     await this
//   //         .storageService!
//   //         .setData(StorageKeys.token.toString(), this.token);
//   //     this.storageService!.setData(StorageKeys.user.toString(), this._user);
//   //     await this.getFCMToken();
//   //     await Provider.of<BusinessProvider>(context, listen: false)
//   //         .fetchAllCategory();
//   //     await Provider.of<LanguagesProvider>(context, listen: false)
//   //         .fetchAllLanguages();
//   //     if (SelectAccount.isInfluencers) {
//   //       await Provider.of<InfluencerProvider>(context, listen: false)
//   //           .setInfluencerUserData(user.user!.uid);
//   //     } else {
//   //       await Provider.of<BusinessProvider>(context, listen: false)
//   //           .setBusinessUserData(user.user!.uid);
//   //     }
//   //   } catch (err) {
//   //     this._user = null;
//   //     utilService!.showToast(err.toString());
//   //   }
//   // }

// //for Apple sign in
//   /// Generates a cryptographically secure random nonce, to be included in a
//   /// credential request.
//   String generateNonce([int length = 32]) {
//     final charset =
//         '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
//     final random = Random.secure();
//     return List.generate(length, (_) => charset[random.nextInt(charset.length)])
//         .join();
//   }

// //for Apple sign in
//   /// Returns the sha256 hash of [input] in hex notation.
//   String sha256ofString(String input) {
//     final bytes = utf8.encode(input);
//     final digest = sha256.convert(bytes);
//     return digest.toString();
//   }
// }
