import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruit_delivery_flutter/models/vendor.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
import 'package:fruit_delivery_flutter/services/http_service.dart';
import 'package:fruit_delivery_flutter/services/storage_service.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';
import 'package:fruit_delivery_flutter/widgets/enums.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
//import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Authentication{
  HttpService? http = locator<HttpService>();
  StorageService? storageService = locator<StorageService>();


  static Future<FirebaseApp> _initilize()async{
    FirebaseApp firebaseApp=await Firebase.initializeApp();

    return firebaseApp;
}


   Future<User?> signInWithGoogle({required BuildContext context}) async {
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
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);


        user = userCredential.user;
        var token = await user!.getIdToken();
        await this.storageService!.setData(StorageKeys.token.toString(), token.toString());
        // Provider.of<VendorProvider>(context,listen: false). = VendorUser(
        //   id: user.uid,
        //   fullName: user.displayName,
        //   email: user.email,
        // );
        // await user!.sendEmailVerification(); // ye yaha se hate ga
        await this.http!.vendorSignUp({
          "id": user.uid,
          "fullName": user.displayName,
          "email": user.email,
        });

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

    return user;
  }
}


// class GoogleSignInButton extends StatefulWidget {
//   @override
//   _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
// }
//
// class _GoogleSignInButtonState extends State<GoogleSignInButton> {
//   bool _isSigningIn = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: _isSigningIn
//           ? CircularProgressIndicator(
//         valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//       )
//           : OutlinedButton(
//         style: ButtonStyle(
//           backgroundColor: MaterialStateProperty.all(Colors.white),
//           shape: MaterialStateProperty.all(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(40),
//             ),
//           ),
//         ),
//         onPressed: () async {
//           setState(() {
//             _isSigningIn = true;
//           });
//
//           User? user =
//           await Authentication.signInWithGoogle(context: context);
//
//           setState(() {
//             _isSigningIn = false;
//           });
//
//           if (user != null) {
//             print('this is user data${user.email}');
//             // Navigator.of(context).pushReplacement(
//             //   MaterialPageRoute(
//             //     builder: (context) => UserInfoScreen(
//             //       user: user,
//             //     ),
//             //   ),
//             // );
//           }
//         },
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Image(
//                 image: AssetImage("assets/google_logo.png"),
//                 height: 35.0,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: Text(
//                   'Sign in with Google',
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.black54,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



// class MyHome extends StatefulWidget {
//   final FacebookLogin plugin;
//
//   const MyHome({Key? key, required this.plugin}) : super(key: key);
//
//   @override
//   _MyHomeState createState() => _MyHomeState();
// }
//
// class _MyHomeState extends State<MyHome> {
//   String? _sdkVersion;
//   FacebookAccessToken? _token;
//   FacebookUserProfile? _profile;
//   String? _email;
//   String? _imageUrl;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _getSdkVersion();
//     _updateLoginInfo();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isLogin = _token != null && _profile != null;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login via Facebook example'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8.0),
//         child: Center(
//           child: Column(
//             children: <Widget>[
//               if (_sdkVersion != null) Text('SDK v$_sdkVersion'),
//               if (isLogin)
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 10),
//                   child: _buildUserInfo(context, _profile!, _token!, _email),
//                 ),
//               isLogin
//                   ? OutlinedButton(
//                 child: const Text('Log Out'),
//                 onPressed: _onPressedLogOutButton,
//               )
//                   : OutlinedButton(
//                 child: const Text('Log In'),
//                 onPressed: _onPressedLogInButton,
//               ),
//               if (!isLogin && Platform.isAndroid)
//                 OutlinedButton(
//                   child: const Text('Express Log In'),
//                   onPressed: () => _onPressedExpressLogInButton(context),
//                 )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildUserInfo(BuildContext context, FacebookUserProfile profile,
//       FacebookAccessToken accessToken, String? email) {
//     final avatarUrl = _imageUrl;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (avatarUrl != null)
//           Center(
//             child: Image.network(avatarUrl),
//           ),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             const Text('User: '),
//             Text(
//               '${profile.firstName} ${profile.lastName}',
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//         const Text('AccessToken: '),
//         Text(
//           accessToken.token,
//           softWrap: true,
//         ),
//         if (email != null) Text('Email: $email'),
//       ],
//     );
//   }
//
//   Future<void> _onPressedLogInButton() async {
//     await widget.plugin.logIn(permissions: [
//       FacebookPermission.publicProfile,
//       FacebookPermission.email,
//     ]);
//     await _updateLoginInfo();
//   }
//
//   Future<void> _onPressedExpressLogInButton(BuildContext context) async {
//     final res = await widget.plugin.expressLogin();
//     if (res.status == FacebookLoginStatus.success) {
//       await _updateLoginInfo();
//     } else {
//       await showDialog<Object>(
//         context: context,
//         builder: (context) => const AlertDialog(
//           content: Text("Can't make express log in. Try regular log in."),
//         ),
//       );
//     }
//   }
//
//   Future<void> _onPressedLogOutButton() async {
//     await widget.plugin.logOut();
//     await _updateLoginInfo();
//   }
//
//   Future<void> _getSdkVersion() async {
//     final sdkVesion = await widget.plugin.sdkVersion;
//     setState(() {
//       _sdkVersion = sdkVesion;
//     });
//   }
//
//   Future<void> _updateLoginInfo() async {
//     final plugin = widget.plugin;
//     final token = await plugin.accessToken;
//     FacebookUserProfile? profile;
//     String? email;
//     String? imageUrl;
//
//     if (token != null) {
//       profile = await plugin.getUserProfile();
//       if (token.permissions.contains(FacebookPermission.email.name)) {
//         email = await plugin.getUserEmail();
//       }
//       imageUrl = await plugin.getProfileImageUrl(width: 100);
//     }
//
//     setState(() {
//       _token = token;
//       _profile = profile;
//       _email = email;
//       _imageUrl = imageUrl;
//     });
//   }
// }




