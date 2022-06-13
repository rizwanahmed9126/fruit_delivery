import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExitAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        "Exit App!",
      ),
      content: Text(
        'Are you sure you want to exit this app?',
      ),
      actions: <Widget>[
        CupertinoDialogAction(
            textStyle: TextStyle(color: Colors.grey[600]),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'No',
            )),
        CupertinoDialogAction(
            textStyle: TextStyle(color: Colors.blue[700]),
            isDefaultAction: true,
            onPressed: () async {
              exit(0);
            },
            child: Text('Yes')),
      ],
    );
  }
}
