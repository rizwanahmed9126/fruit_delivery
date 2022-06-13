import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/constants/select_account.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';
import 'package:fruit_delivery_flutter/providers/auth_provider.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/user_provider.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
import 'package:fruit_delivery_flutter/services/util_service.dart';
import 'package:provider/provider.dart';
import '../widgets/column_scroll_view.dart';
import '../services/navigation_service.dart';
import '../utils/service_locator.dart';

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  var navigationService = locator<NavigationService>();
  UtilService? _util = locator<UtilService>();
  bool valuefirst = false;
  bool valuesecond = true;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _confirmShowPassword = true;
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              // navigationService.navigateTo(LoginScreenRoute);
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
          ),
        ),
        body: Stack(
          children: [
            Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: ColumnScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 30.w, right: 30.w),
                            child: Column(
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(top: 50.h),
                                    child: Image(
                                      image:
                                          AssetImage('assets/images/Logo1.png'),
                                      height: 150.h,
                                    )),
                                SizedBox(
                                  height: 40.h,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate('ResetPassword'),
                                      // "Reset Password",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.sp)),
                                ),
                                SizedBox(height: 20.h),
                                Container(
                                  // padding: EdgeInsets.only(right: 50, left: 50),
                                  child: TextFormField(
                                    controller: oldPasswordController,
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
                                          .translate('OldPassword'),
                                      //  "Old Password",
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
                                    controller: newPasswordController,
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
                                          .translate('NewPassword'),
                                      // "New Password",
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
                                SizedBox(height: 10.h),
                                Container(
                                  // padding: EdgeInsets.only(right: 50, left: 50),
                                  child: TextFormField(
                                    controller: confirmPasswordController,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    obscureText: _confirmShowPassword,
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
                                      // "New Password",
                                      fillColor:
                                          Color.fromRGBO(242, 243, 245, 1),
                                      contentPadding: EdgeInsets.all(15.h),

                                      suffixIcon: !_confirmShowPassword
                                          ? IconButton(
                                              icon: Icon(Icons.visibility_off,
                                                  size: 15.h,
                                                  color: Colors.grey),
                                              onPressed: () {
                                                setState(() {
                                                  _confirmShowPassword = true;
                                                });
                                              },
                                            )
                                          : IconButton(
                                              icon: Icon(Icons.visibility,
                                                  size: 15.h,
                                                  color: Colors.grey),
                                              onPressed: () {
                                                setState(() {
                                                  _confirmShowPassword = false;
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
                                      setState(() {
                                        isLoadingProgress = true;
                                      });
                                      if (oldPasswordController.text == "") {
                                        _util!.showToast(
                                            "Please enter old password");
                                        setState(() {
                                          isLoadingProgress = false;
                                        });
                                      } else if (newPasswordController
                                              .text.length <
                                          8) {
                                        _util!.showToast(
                                            "password must be at least 8 characters");
                                        setState(() {
                                          isLoadingProgress = false;
                                        });
                                      } else if (newPasswordController.text ==
                                          "") {
                                        _util!.showToast(
                                            "Please enter new password");
                                        setState(() {
                                          isLoadingProgress = false;
                                        });
                                      } else if (confirmPasswordController
                                              .text ==
                                          "") {
                                        _util!.showToast(
                                            "Please enter new password");
                                        setState(() {
                                          isLoadingProgress = false;
                                        });
                                      } else if (newPasswordController.text !=
                                          confirmPasswordController.text) {
                                        _util!.showToast(
                                            "Password and Confirm Password must be same");
                                        setState(() {
                                          isLoadingProgress = false;
                                        });
                                      } else if (newPasswordController.text ==
                                          oldPasswordController.text) {
                                        _util!.showToast(
                                            "Old Password and New Password can't be same");
                                        setState(() {
                                          isLoadingProgress = false;
                                        });
                                      } else {
                                        SelectAccount.selectAccount ==
                                                SelectAccountEnum.Driver
                                                    .toString()
                                            ? await Provider.of<VendorProvider>(
                                                    context,
                                                    listen: false)
                                                .changePassword(
                                                    context: context,
                                                    oldPassword:
                                                        oldPasswordController
                                                            .text,
                                                    newPassword:
                                                        newPasswordController
                                                            .text)
                                            : await Provider.of<UserProvider>(
                                                    context,
                                                    listen: false)
                                                .changePassword(
                                                    context: context,
                                                    oldPassword:
                                                        oldPasswordController
                                                            .text,
                                                    newPassword:
                                                        newPasswordController
                                                            .text);
                                        setState(() {
                                          isLoadingProgress = false;
                                        });
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
                                              .translate('ResetPassword'),
                                          // "Reset Password",
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
                    ],
                  ),
                )),
            if (isLoadingProgress)
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                      // color: HexColor("#3BE6AF"),
                      ),
                ),
              ),
          ],
        ));
  }
}
