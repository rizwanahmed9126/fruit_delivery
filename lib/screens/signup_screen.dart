// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/constants/select_account.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';
import 'package:fruit_delivery_flutter/providers/auth_provider.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/user_provider.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
import 'package:fruit_delivery_flutter/screens/email_verification_screen.dart';
import 'package:fruit_delivery_flutter/screens/login_screen.dart';
import 'package:fruit_delivery_flutter/services/util_service.dart';
import 'package:fruit_delivery_flutter/widgets/column_scroll_view.dart';
import 'package:provider/provider.dart';
import '../services/navigation_service.dart';
import '../utils/service_locator.dart';

class SignUpScreen extends StatefulWidget {
  final selectAccount;
  SignUpScreen({this.selectAccount});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var navigationService = locator<NavigationService>();
  var utilService = locator<UtilService>();
  bool valuefirst = false;
  bool valuesecond = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  bool _showPassword = true;
  bool _showPassword1 = true;
  bool isLoadingProgress = false;

  @override
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
            body: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: ColumnScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.arrow_back),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ]),
                          Container(
                            padding: EdgeInsets.only(left: 30.w, right: 30.w),
                            child: Column(
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(top: 80.h),
                                    child: Image(
                                      image: AssetImage(
                                        'assets/images/Logo1.png',
                                      ),
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
                                          .translate('Signup'),
                                      // "SIGN UP",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.sp)),
                                ),
                                SizedBox(height: 20.h),
                                Container(
                                  // padding: EdgeInsets.only(right: 50.w, left: 50.w),
                                  child: TextField(
                                    controller: nameController,
                                    maxLength: 30,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14.sp),
                                    decoration: new InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                242, 243, 245, 1),
                                            width: 1.0),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(30.0),
                                        ),
                                      ),
                                      enabledBorder: new OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                242, 243, 245, 1),
                                            width: 1.0),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(30.0),
                                        ),
                                      ),
                                      focusedBorder: new OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                242, 243, 245, 1),
                                            width: 1.0),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(30.0),
                                        ),
                                      ),
                                      filled: true,
                                      hintStyle: new TextStyle(
                                          color: Colors.grey, fontSize: 12.sp),
                                      hintText: AppLocalizations.of(context)
                                          .translate('FullName'),
                                      //"Full Name",
                                      fillColor:
                                          Color.fromRGBO(242, 243, 245, 1),
                                      contentPadding: EdgeInsets.all(15.0),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  // padding: EdgeInsets.only(right: 50, left: 50),
                                  child: TextFormField(
                                    controller: emailController,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    decoration: new InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                242, 243, 245, 1),
                                            width: 0.0),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(30.0),
                                        ),
                                      ),
                                      enabledBorder: new OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                242, 243, 245, 1),
                                            width: 1.0),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(30.0),
                                        ),
                                      ),
                                      focusedBorder: new OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                242, 243, 245, 1),
                                            width: 1.0),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(30.0),
                                        ),
                                      ),
                                      // fillColor: Colors.fromRGBO(193, 152, 106, 1),
                                      filled: true,
                                      hintStyle: new TextStyle(
                                          color: Colors.grey, fontSize: 12.sp),
                                      hintText: AppLocalizations.of(context)
                                          .translate('EmailAddress'),
                                      //"Email",
                                      fillColor:
                                          Color.fromRGBO(242, 243, 245, 1),
                                      contentPadding: EdgeInsets.all(15.h),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  // padding: EdgeInsets.only(right: 50, left: 50),
                                  child: TextFormField(
                                    controller: passwordController,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    obscureText: _showPassword,
                                    decoration: new InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                242, 243, 245, 1),
                                            width: 0.0),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(30.0),
                                        ),
                                      ),
                                      enabledBorder: new OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                242, 243, 245, 1),
                                            width: 1.0),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(30.0),
                                        ),
                                      ),
                                      focusedBorder: new OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                242, 243, 245, 1),
                                            width: 1.0),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(30.0),
                                        ),
                                      ),
                                      // fillColor: Colors.fromRGBO(193, 152, 106, 1),
                                      filled: true,
                                      hintStyle: new TextStyle(
                                          color: Colors.grey, fontSize: 12.sp),
                                      hintText: AppLocalizations.of(context)
                                          .translate('Password'),
                                      //  "Password",
                                      fillColor:
                                          Color.fromRGBO(242, 243, 245, 1),
                                      contentPadding: EdgeInsets.all(15.h),

                                      suffixIcon: !_showPassword
                                          ? IconButton(
                                              icon: Icon(Icons.visibility_off,
                                                  size: 15.h,
                                                  color: Colors.grey),
                                              onPressed: () {
                                                setState(() {
                                                  _showPassword = true;
                                                });
                                              },
                                            )
                                          : IconButton(
                                              icon: Icon(Icons.visibility,
                                                  size: 15.h,
                                                  color: Colors.grey),
                                              onPressed: () {
                                                setState(() {
                                                  _showPassword = false;
                                                });
                                              },
                                            ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  // padding: EdgeInsets.only(right: 50, left: 50),
                                  child: TextFormField(
                                    controller: confirmpasswordController,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    obscureText: _showPassword1,
                                    decoration: new InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                242, 243, 245, 1),
                                            width: 0.0),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(30.0),
                                        ),
                                      ),
                                      enabledBorder: new OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                242, 243, 245, 1),
                                            width: 1.0),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(30.0),
                                        ),
                                      ),
                                      focusedBorder: new OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                242, 243, 245, 1),
                                            width: 1.0),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(30.0),
                                        ),
                                      ),
                                      // fillColor: Colors.fromRGBO(193, 152, 106, 1),
                                      filled: true,
                                      hintStyle: new TextStyle(
                                          color: Colors.grey, fontSize: 12.sp),
                                      hintText: AppLocalizations.of(context)
                                          .translate('ConfirmPassword'),
                                      // "Confirm Password",
                                      fillColor:
                                          Color.fromRGBO(242, 243, 245, 1),
                                      contentPadding: EdgeInsets.all(15.h),

                                      suffixIcon: !_showPassword1
                                          ? IconButton(
                                              icon: Icon(Icons.visibility_off,
                                                  size: 15.h,
                                                  color: Colors.grey),
                                              onPressed: () {
                                                setState(() {
                                                  _showPassword1 = true;
                                                });
                                              },
                                            )
                                          : IconButton(
                                              icon: Icon(Icons.visibility,
                                                  size: 15.h,
                                                  color: Colors.grey),
                                              onPressed: () {
                                                setState(() {
                                                  _showPassword1 = false;
                                                });
                                              },
                                            ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Container(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        setState(() {
                                          isLoadingProgress = true;
                                        });
                                        if (nameController.text == "" ||
                                            emailController.text == "" ||
                                            passwordController.text == "" ||
                                            confirmpasswordController.text ==
                                                "") {
                                          utilService.showToast(
                                              "Please fill all fields");
                                        } else if (!emailController.text
                                                .contains('@') ||
                                            !emailController.text
                                                .contains('.com')) {
                                          utilService.showToast(
                                              "Please Enter a valid Email");
                                        } else if (passwordController
                                                .text.length <
                                            8) {
                                          utilService.showToast(
                                              ' Password must be of 8 characters');
                                          setState(() {
                                            isLoadingProgress = false;
                                          });
                                        } else if (passwordController.text !=
                                            confirmpasswordController.text) {
                                          utilService
                                              .showToast("Password not match");
                                        } else {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          SelectAccount.selectAccount ==
                                                  SelectAccountEnum.Driver
                                                      .toString()
                                              ? await Provider.of<
                                                          VendorProvider>(
                                                      context,
                                                      listen: false)
                                                  .createVendorWithEmailPassword(
                                                  context: context,
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text,
                                                  userName: nameController.text,
                                                  selectedAccount: widget
                                                      .selectAccount
                                                      .toString(),
                                                )
                                              : await Provider.of<UserProvider>(
                                                      context,
                                                      listen: false)
                                                  .createUserWithEmailPassword(
                                                  context: context,
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text,
                                                  userName: nameController.text,
                                                  selectedAccount: widget
                                                      .selectAccount
                                                      .toString(),
                                                );
                                          setState(() {
                                            isLoadingProgress = false;
                                          });
                                          print(
                                              "selected account ${widget.selectAccount.toString()}");
                                        }

                                        setState(() {
                                          isLoadingProgress = false;
                                        });
                                      } catch (e) {
                                        setState(() {
                                          isLoadingProgress = false;
                                        });
                                        utilService.showToast(
                                            "Please check your internet connection");
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      textStyle: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
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
                                              color: Theme.of(context)
                                                  .accentColor)),
                                    ),
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            left: 5.w, right: 10.w),
                                        child: new Text(
                                          AppLocalizations.of(context)
                                              .translate('Signup'),
                                          //"Sign Up",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // child2
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)
                                .translate('DontHaveAnAccount'),
                            // "Already have an account?",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            height: 40.h,
                            width: 50.w,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoginScreen(
                                          selectAccount:
                                              widget.selectAccount.toString(),
                                        )));
                                // navigationService.navigateTo(LoginScreenRoute);
                              },
                              child: Text(
                                  AppLocalizations.of(context)
                                      .translate('Login'),
                                  //'Login',
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ))),
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
