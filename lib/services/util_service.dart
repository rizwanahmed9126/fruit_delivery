import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UtilService {
  // FirebaseService firebaseService = locator<FirebaseService>();
  File? image;
  var fileName = "";
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[300],
        textColor: Colors.black,
        fontSize: 16.0);
  }

  Future pickImage(String? userId, String imageUrl) async {
    String imageName = getRandomString(15);
    firebase_storage.Reference storageReference;
    try {
      // final image = await ImagePicker()
      //     .pickImage(source: ImageSource.gallery, maxWidth: 600);
      // if (image == null) return;

      final imageTemporary = File(imageUrl);
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(imageUrl);
      final savedImage = await imageTemporary.copy('${appDir.path}/$fileName');
      storageReference = firebase_storage.FirebaseStorage.instance
          .ref()
          .child("fruits/$imageName");
      final firebase_storage.UploadTask uploadTask =
          storageReference.putFile(savedImage);
      final firebase_storage.TaskSnapshot downloadUrl =
          (await uploadTask.whenComplete(() => null));
      final String url = (await downloadUrl.ref.getDownloadURL());
      return url;
    } on PlatformException catch (e) {}
  }

  Future<String> browseImage(String userId, var imageFile) async {
    firebase_storage.Reference storageReference;
    // ignore: deprecated_member_use
    // final picker = ImagePicker();
    File _image;
    // var imageFile = await picker.getImage(
    //   source: ImageSource.gallery,
    //   maxWidth: 600,
    // );

    if (imageFile == null) {
      return '';
    }
    _image = File(imageFile.path);
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _image.copy('${appDir.path}/$fileName');
    storageReference = firebase_storage.FirebaseStorage.instance
        .ref()
        .child("profileimages/$userId");
    final firebase_storage.UploadTask uploadTask =
        storageReference.putFile(savedImage);
    final firebase_storage.TaskSnapshot downloadUrl =
        (await uploadTask.whenComplete(() => null));
    final String url = (await downloadUrl.ref.getDownloadURL());
    return url;
  }

  Future<String> captureImage(String userId) async {
    firebase_storage.Reference storageReference;
    // ignore: deprecated_member_use
    final picker = ImagePicker();
    File _image;
    var imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageFile == null) {
      return '';
    }
    _image = File(imageFile.path);
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _image.copy('${appDir.path}/$fileName');
    storageReference = firebase_storage.FirebaseStorage.instance
        .ref()
        .child("profileimages/$userId");
    final firebase_storage.UploadTask uploadTask =
        storageReference.putFile(savedImage);
    final firebase_storage.TaskSnapshot downloadUrl =
        (await uploadTask.whenComplete(() => null));
    final String url = (await downloadUrl.ref.getDownloadURL());
    return url;
  }

  Future<String> browseImageForChat() async {
    final picker = ImagePicker();

    var imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    if (imageFile == null) {
      return '';
    }
    return imageFile.path;
  }

  Future<String> sendImageForChat(String mediaPath) async {
    String imageName = getRandomString(15);
    firebase_storage.Reference storageReference;
    File _image;
    _image = File(mediaPath);

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(mediaPath);
    final savedImage = await _image.copy('${appDir.path}/$fileName');

    storageReference = firebase_storage.FirebaseStorage.instance
        .ref()
        .child("chats/$imageName");
    final firebase_storage.UploadTask uploadTask =
        storageReference.putFile(savedImage);
    final firebase_storage.TaskSnapshot downloadUrl =
        (await uploadTask.whenComplete(() => null));
    final String url = (await downloadUrl.ref.getDownloadURL());
    return url;
  }
}
