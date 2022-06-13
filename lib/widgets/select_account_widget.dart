// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:fruit_delivery_flutter/constants/select_account.dart';
import 'package:fruit_delivery_flutter/screens/login_screen.dart';
import 'package:fruit_delivery_flutter/services/storage_service.dart';
import 'package:fruit_delivery_flutter/utils/routes.dart';
import '../services/navigation_service.dart';
import '../utils/service_locator.dart';

// ignore: must_be_immutable
class SelectAccountWidget extends StatefulWidget {
  var navigationService = locator<NavigationService>();
  final data;
  final active;
  ValueChanged<dynamic> action; //callback value change
  String tag;
  SelectAccountWidget({
    required this.action,
    required this.tag,
    this.data,
    this.active,
  });

  @override
  _SelectAccountWidgetState createState() => _SelectAccountWidgetState();
}

class _SelectAccountWidgetState extends State<SelectAccountWidget> {
  var navigationService = locator<NavigationService>();
  var storageService = locator<StorageService>();
  void handleTap() async {
    setState(() {
      widget.action(widget.tag);

      if (widget.tag == '1') {
        SelectAccount.selectAccount = SelectAccountEnum.User.toString();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LoginScreen(
                  selectAccount: widget.data['label'],
                )));
        widget.action(widget.data['id']);
        storageService.setData("selectAccount", SelectAccountEnum.User.toString());
      }
      // if (widget.tag == '2') {
      //   SelectAccount.selectAccount = SelectAccountEnum.Guest.toString();
      //   navigationService.navigateTo(MainDashboardScreenRoute);
      //   widget.action(widget.data['id']);
      //   storageService.setData(
      //       "selectAccount", SelectAccountEnum.Guest.toString());
      // }
      if (widget.tag == '2') {
        SelectAccount.selectAccount = SelectAccountEnum.Driver.toString();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LoginScreen(
                  selectAccount: widget.data['label'],
                )));

        widget.action(widget.tag);
        storageService.setData(
            "selectAccount", SelectAccountEnum.Driver.toString());
      }
      // else {
      //   navigationService.navigateTo(MainDashboardScreenRoute);
      //   widget.action(widget.data['id']);
      // }
    });
    // await storageService.setData("selectAccount", SelectAccount.selectAccount);
    // navigationService.navigateTo(CreateRouteScreenRoute);
    // widget.action(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          width: 1,
          color: widget.active ? Colors.white : Colors.grey,
        ),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              widget.active ? Theme.of(context).accentColor : Colors.white,
              widget.active ? Theme.of(context).accentColor : Colors.white,
            ]),
      ),
      // ignore: deprecated_member_use
      child: FlatButton(
        onPressed: () {
          handleTap();
          // navigationService.navigateTo(LoginScreenRoute);
        },
        child: Text(
          widget.data['label'],
          style: TextStyle(
            color: widget.active ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }
}
