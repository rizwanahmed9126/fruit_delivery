// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruit_delivery_flutter/constants/select_account.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/user_provider.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
import 'package:provider/provider.dart';

import '../services/navigation_service.dart';
import '../utils/routes.dart';
import '../utils/service_locator.dart';

class LogoutAlertDialog extends StatelessWidget {
  var navigationService = locator<NavigationService>();
  var storageService;
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        "Logout",
      ),
      content: Text(
        'Are you sure you want to logout?',
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
              navigationService.navigateTo(SelectAccountScreenRoute);
             
              SelectAccount.selectAccount == SelectAccountEnum.Driver.toString()
                  ? await Provider.of<VendorProvider>(context,listen: false).logoutFirebaseVendor(context)
                
                  : await Provider.of<UserProvider>(context,listen: false).logoutFirebaseUser(context);

              
              
              

            },
            child: Text('Yes')),
      ],
    );
  }
}
