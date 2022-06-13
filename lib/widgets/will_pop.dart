import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruit_delivery_flutter/services/navigation_service.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';
Future<Widget> showOnWillPop(context,VoidCallback onTap) async {
  var navigationService = locator<NavigationService>();
  return await showDialog(
    context: context,
    builder: (context) => new AlertDialog(
      title:  Text("End Trip",
          style:  TextStyle(color: Colors.black, fontSize: 20.0)),
      content:
       Text("Do you Really Want to End this Trip"),
      actions: <Widget>[
        // ignore: deprecated_member_use
         FlatButton(
          onPressed: onTap,

          child: new Text("Yes",
              style: new TextStyle(fontSize: 18.0)),
        ),
        // ignore: deprecated_member_use
         FlatButton(
          onPressed: () => navigationService.closeScreen(),
          // this line dismisses the dialog
          child:  Text(
              "Cancel",
              style:  TextStyle(fontSize: 18.0)),
        )
      ],
    ),
  ) ;
}