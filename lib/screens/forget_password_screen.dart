import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';
import 'package:fruit_delivery_flutter/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../providers/auth_providers/vendor_provider.dart';
import '../services/navigation_service.dart';
import '../services/util_service.dart';
import '../utils/service_locator.dart';
import '../widgets/column_scroll_view.dart';

class ForgetPasswordScreen extends StatefulWidget {
  final selectAccount;
  ForgetPasswordScreen({this.selectAccount});

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var navigationService = locator<NavigationService>();
  UtilService? _util = locator<UtilService>();

  // FirebaseService? _firebaseService = locator<FirebaseService>();
  TextEditingController emailController = TextEditingController();

  var isLoadingProgress = false;
  bool valuefirst = false;
  bool valuesecond = true;

  // ignore: unused_field
  bool _showPassword = true;
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back),
                color: Colors.black,
              ),
            ),
            body: ColumnScrollView(
              child: Column(
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 30.w, right: 30.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(top: 80.h),
                                child: Image(
                                  image: AssetImage('assets/images/Logo1.png'),
                                  height: 100.h,
                                  fit: BoxFit.fill,
                                )),
                            SizedBox(
                              height: 50.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Text(
                                  AppLocalizations.of(context)
                                      .translate('ForgotPassword'),
                                  // "Forgot Password",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.sp)),
                            ),
                            SizedBox(height: 20.h),
                            Container(
                              // padding: EdgeInsets.only(right: 50.w, left: 50.w),
                              child: TextField(
                                controller: emailController,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14.sp),
                                decoration: new InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(242, 243, 245, 1),
                                        width: 1.0),
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(30.0),
                                    ),
                                  ),
                                  enabledBorder: new OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(242, 243, 245, 1),
                                        width: 1.0),
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(30.0),
                                    ),
                                  ),
                                  focusedBorder: new OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(242, 243, 245, 1),
                                        width: 1.0),
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(30.0),
                                    ),
                                  ),
                                  filled: true,
                                  hintStyle: new TextStyle(
                                      color: Colors.grey, fontSize: 12.sp),
                                  hintText: AppLocalizations.of(context)
                                      .translate('EmailAddress'),
                                  //"Email Address",
                                  fillColor: Color.fromRGBO(242, 243, 245, 1),
                                  contentPadding: EdgeInsets.all(15.0),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Container(
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (emailController.text == "") {
                                    _util!.showToast("Email cannot be empty");
                                  } else if (!emailController.text
                                      .contains("@")) {
                                    _util!.showToast(
                                        "Email format is incorrect.");
                                  } else {
                                    setState(() {
                                      isLoadingProgress = true;
                                    });
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    await Provider.of<VendorProvider>(context,
                                            listen: false)
                                        .forgotPassword(
                                      emailController.text,
                                      widget.selectAccount.toString(),
                                      context,
                                    );
                                    setState(() {
                                      isLoadingProgress = false;
                                    });
                                   
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  textStyle: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                      fontWeight: FontWeight.w600),
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width,
                                      MediaQuery.of(context).size.height *
                                          0.060),
                                  primary: Theme.of(context).accentColor,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(50.0),
                                      side: BorderSide(
                                          width: 1,
                                          color:
                                              Theme.of(context).accentColor)),
                                ),
                                child: Container(
                                    padding:
                                        EdgeInsets.only(left: 5.w, right: 10.w),
                                    child: new Text(
                                      AppLocalizations.of(context)
                                          .translate('RecoverPassword'),
                                      // "Recover Password",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                              ),
                            ),
                            SizedBox(height: 30.h),
                            Text(
                                AppLocalizations.of(context)
                                    .translate('Instruction'),
                                // "An email will be sent to your \nemail address with further instruction",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16.sp)),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // child2
                ],
              ),
            )),
        if (isLoadingProgress)
          Positioned.fill(
              child: Align(
            alignment: Alignment.center,
            child: Platform.isIOS
                ? CupertinoActivityIndicator()
                : CircularProgressIndicator(),
          )),
      ],
    );
  }
}
