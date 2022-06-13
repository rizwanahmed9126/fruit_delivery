import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/navigation_service.dart';
import '../utils/service_locator.dart';
import '../utils/routes.dart';

class LoginAlert extends StatefulWidget {
  LoginAlert();
  @override
  _LoginAlertState createState() => _LoginAlertState();
}

class _LoginAlertState extends State<LoginAlert> {
  var navigationService = locator<NavigationService>();
  var height;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return AlertDialog(
      contentPadding: EdgeInsets.only(top: 20, bottom: 15),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: SingleChildScrollView(
        child: Container(
          // color: Colors.red,
          padding: EdgeInsets.only(right: 0.5, left: 0.5),
          height: height * 0.5,
          width: MediaQuery.of(context).size.height * 0.5,
          // color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Center(
              //   child: Container(
              //       height: ScreenUtil().setHeight(200),
              //       child: Image.asset("assets/images/Loud.png")),
              // ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              Container(
                child: Text(
                  'Alert!',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: height * 0.05),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(15),
              ),
              Container(
                width: ScreenUtil().setWidth(40),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.black,
                      width: ScreenUtil().setWidth(2),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(50),
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  "Kindly Login for further process",
                  style: TextStyle(fontSize: height * 0.03),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(50),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    navigationService.navigateTo(SelectAccountScreenRoute);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    textStyle: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.03,
                        fontWeight: FontWeight.w600),
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.55,
                        MediaQuery.of(context).size.height * 0.060),
                    primary: Theme.of(context).backgroundColor,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(50.0),
                        side: BorderSide(
                            width: 1,
                            color: Theme.of(context).backgroundColor)),
                  ),
                  child: Container(
                      padding: EdgeInsets.only(left: 5, right: 10),
                      child: new Text(
                        "Done",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: height * 0.02,
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                ),
              ),

              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
