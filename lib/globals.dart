import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// bool inChat = false;

Future<void> showLoadingAnimation(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (context) {
      return Center(
          child: Platform.isIOS
              ? CupertinoActivityIndicator()
              : CircularProgressIndicator());
    },
  );
}

Future<void> showAlertTextBox(BuildContext context, String text) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: Colors.green,
        content: Container(
          child: Text(
            text,
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
    },
  );
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoActivityIndicator()
        : CircularProgressIndicator();
  }
}
