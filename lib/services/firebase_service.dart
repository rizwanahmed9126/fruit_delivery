import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:fruit_delivery_flutter/services/storage_service.dart';
import 'package:fruit_delivery_flutter/services/util_service.dart';
import 'package:fruit_delivery_flutter/utils/routes.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';



import 'navigation_service.dart';

class FirebaseService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  UtilService? _util = locator<UtilService>();
  NavigationService? _navigation = locator<NavigationService>();
  StorageService? _storage = locator<StorageService>();

  Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      _util!.showToast(
          "An email has been sent please follow the instructions and recover your password.");
      _navigation!.navigateTo(LoginScreenRoute);
    } catch (err) {
      _util!.showToast(err.toString());
    }
  }

  Future<void> logoutFirebaseUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
  
    await _auth.signOut();
    await _storage!.clearData();
  }

  signinWithEmailAndPassword(String email, String password) async {
    final authResult = await _auth.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim());
    return authResult.user;
  }

  sendEmailVerification() async {
    final user = _auth.currentUser!;
    user.sendEmailVerification();
    _util!.showToast("A Verification email has been sent");
  }

  resendEmailVerification() async {
    final user = _auth.currentUser!;
    await user.sendEmailVerification();
    _util!.showToast(
        "A Verification Link Resend to your email kindly check your inbox");
  }

  createUserWithEmailAndPassword(String email, String password) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
        email: email.trim(), password: password.trim());
    return authResult.user;
  }

  uploadPicture(File file, String fileName, String id) async {
    try {
      firebase_storage.Reference storageReference;
      storageReference =
          firebase_storage.FirebaseStorage.instance.ref().child("files/$id");
      final firebase_storage.UploadTask uploadTask =
          storageReference.putFile(file);
      final firebase_storage.TaskSnapshot downloadUrl =
          (await uploadTask.whenComplete(() => null));
      final String url = (await downloadUrl.ref.getDownloadURL());
      return url;
    } catch (err) {
      // print(err);
    }
  }

  getFCMToken() async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.requestPermission();
    //     const IosNotificationSettings(sound: true, badge: true, alert: true));
    // _firebaseMessaging.onIosSettingsRegistered
    //     .listen((IosNotificationSettings settings) {
    //   // print("Settings registered: $settings");
    // });
    String? token = await _firebaseMessaging.getToken();
    return token;
  }

  // sendMessage(String? chatId, Message item) async {
  //   try {
  //     Map<String, dynamic> data = {
  //       "id": item.id,
  //       "createdOnDate": item.createdOnDate,
  //       "messageMediaUrl": item.messageMediaUrl,
  //       "messageText": item.messageText,
  //       "senderId": item.senderId,
  //       "messageMediaType": item.messageMediaType
  //     };
  //     // ignore: deprecated_member_use
  //     await FirebaseFirestore.instance
  //         .collection("chats")
  //         .doc(chatId)
  //         .collection("conversation")
  //         .doc(item.id)
  //         .set(data, SetOptions(merge: true));
  //     await FirebaseFirestore.instance.collection("chats").doc(chatId).set({
  //       "lastMessage": item.messageText,
  //       "modifiedOn": DateTime.now().millisecondsSinceEpoch
  //     }, SetOptions(merge: true));
  //   } catch (err) {
  //     // print(err);
  //   }
  // }
}
