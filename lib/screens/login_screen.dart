import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/constants/select_account.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/user_provider.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
import 'package:fruit_delivery_flutter/providers/route_provider.dart';
import 'package:fruit_delivery_flutter/screens/forget_password_screen.dart';
import 'package:fruit_delivery_flutter/screens/signup_screen.dart';
import 'package:fruit_delivery_flutter/popups.dart/warning_dialogue.dart';
import 'package:fruit_delivery_flutter/services/storage_service.dart';
import 'package:fruit_delivery_flutter/services/util_service.dart';
import 'package:fruit_delivery_flutter/popups.dart/exit_alert_dialog.dart';
import 'package:fruit_delivery_flutter/utils/authentication.dart';
import 'package:provider/provider.dart';
import '../services/navigation_service.dart';
import '../utils/routes.dart';
import '../utils/service_locator.dart';
import '../widgets/ios_button_widget.dart';
import '../widgets/column_scroll_view.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginScreen extends StatefulWidget {
  final selectAccount;
  LoginScreen({this.selectAccount});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var utilService = locator<UtilService>();
  var navigationService = locator<NavigationService>();
  var storageService = locator<StorageService>();
  bool valueTick = false;
  // bool valuesecond = true;
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool _showPassword = true;
  bool isLoadingProgress = false;

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => ExitAlertDialog(),
    ).then((value) => value as bool);
  }

  loadData() async {
    var data =
        await Provider.of<UserProvider>(context, listen: false).getIsRemember();
    if (data) {
      var email = await this.storageService.getData("userEmail");
      var password = await this.storageService.getData("password");
      passwordController.text = password;
      emailController.text = email;
    }
  }

  @override
  void initState() {
    super.initState();

    loadData();

    // analyticService.setCurrentScreen('LoginScreen');
  }

  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Stack(
        children: [
          Scaffold(
              body: ColumnScrollView(
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
                          onPressed: () => navigationService
                              .navigateTo(SelectAccountScreenRoute),
                        ),
                        Container(
                          width: 80.h,
                          // width:
                          //     SelectAccount.isInfluencers ? 90.h : 80.h,
                          padding: EdgeInsets.all(5.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                topLeft: Radius.circular(5)),
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).accentColor,
                                Theme.of(context).accentColor,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              widget.selectAccount.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10.h,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top: 25.h),
                              child: Image(
                                image: AssetImage('assets/images/Logo1.png'),
                                height: 100.h,
                                fit: BoxFit.fill,
                              )),
                          SizedBox(
                            height: 40.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                                AppLocalizations.of(context).translate('Login'),
                                // "LOGIN",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp)),
                          ),
                          SizedBox(height: 20.h),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: emailController,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14.sp),
                                  decoration: new InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(242, 243, 245, 1),
                                          width: 1.0),
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(30.0),
                                      ),
                                    ),
                                    enabledBorder: new OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(242, 243, 245, 1),
                                          width: 1.0),
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(30.0),
                                      ),
                                    ),
                                    focusedBorder: new OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(242, 243, 245, 1),
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
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 30.w,
                                      child: Checkbox(
                                        side: BorderSide(color: Colors.grey),
                                        value: this.valueTick,
                                        activeColor:
                                            Theme.of(context).accentColor,
                                        onChanged: (bool? valuesecond) async {
                                          setState(() {
                                            this.valueTick = valuesecond!;
                                          });
                                          await Provider.of<UserProvider>(
                                                  context,
                                                  listen: false)
                                              .setIsRemeber(this.valueTick);
                                        },
                                      ),
                                    ),
                                    Text(
                                        AppLocalizations.of(context)
                                            .translate('Remember'),
                                        // "Remember",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp)),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ForgetPasswordScreen(
                                            selectAccount:
                                                widget.selectAccount.toString(),
                                          )));
                                  // navigationService
                                  //     .navigateTo(ForgetPasswordScreenRoute);
                                },
                                child: Text(
                                    AppLocalizations.of(context)
                                            .translate('ForgotPassword') +
                                        "?",
                                    //'Forgot Password?',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  setState(() {
                                    isLoadingProgress = true;
                                  });

                                  if (emailController.text == '' ||
                                      passwordController.text == '') {
                                    utilService
                                        .showToast('Please fill all fields');
                                    setState(() {
                                      isLoadingProgress = false;
                                    });
                                    return;
                                  } else if (passwordController.text.length <
                                      8) {
                                    utilService.showToast(
                                        'Password must be at least 8 characters');
                                  } else if (!emailController.text
                                          .contains("@") ||
                                      !emailController.text.contains(".com")) {
                                    utilService.showToast(
                                        "The email address is badly formatted");
                                    setState(() {
                                      isLoadingProgress = false;
                                    });
                                    return;
                                  } else {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());

                                    SelectAccount.selectAccount == SelectAccountEnum.Driver.toString()
                                        ? await Provider.of<VendorProvider>(context, listen: false,).signinVendorWithEmailAndPassword(emailController.text, passwordController.text, context)
                                        : await Provider.of<UserProvider>(context, listen: false,).signinUserWithEmailAndPassword(emailController.text, passwordController.text, context);

                                    setState(() {
                                      isLoadingProgress = false;
                                    });
                                  }
                                } catch (e) {
                                  setState(() {
                                    isLoadingProgress = false;
                                  });
                                  utilService.showToast(
                                      "Please check your internet connection");
                                }

                                // if (SelectAccount.selectAccount ==
                                //     SelectAccountEnum.Driver.toString()) {
                                //   navigationService
                                //       .navigateTo(DriverHomeScreenRoute);
                                // } else {
                                //   navigationService
                                //       .navigateTo(MainDashboardScreenRoute);
                                // }
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
                                    MediaQuery.of(context).size.height * 0.060),
                                primary: Theme.of(context).accentColor,
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(50.0),
                                    side: BorderSide(
                                        width: 1,
                                        color: Theme.of(context).accentColor)),
                              ),
                              child: Container(
                                  padding:
                                      EdgeInsets.only(left: 5.w, right: 10.w),
                                  child: new Text(
                                    AppLocalizations.of(context)
                                        .translate('Login'),
                                    // "Login",
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
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 30.w,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Colors.black38,
                                width: 1.w,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('OrLogInWth'),
                            //  'or Login with',
                            style: TextStyle(
                                color: Colors.black38, fontSize: 12.sp),
                          ),
                        ),
                        Container(
                          width: 30.w,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Colors.black38,
                                width: 1.w,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Platform.isIOS
                        ? IosButtons(
                      facebook: ()async{
                        setState(() {
                          isLoadingProgress = true;
                        });
                        SelectAccount.selectAccount == SelectAccountEnum.Driver.toString()
                            ? await Provider.of<VendorProvider>(context,listen: false).vendorSignInWithFacebook(context: context).then((value){
                          setState(() {
                            isLoadingProgress = false;
                          });
                        })
                            : await Provider.of<UserProvider>(context,listen: false).userSigninWithFacebook(context).then((value){
                        setState(() {
                        isLoadingProgress = false;
                        });
                        });
                      },
                      google: ()async{
                        setState(() {
                          isLoadingProgress = true;
                        });
                        SelectAccount.selectAccount == SelectAccountEnum.Driver.toString()
                            ? await Provider.of<VendorProvider>(context,listen: false).vendorSignInWithGoogle(context: context).then((value){
                          setState(() {
                            isLoadingProgress = false;
                          });
                        })
                            : await Provider.of<UserProvider>(context,listen: false).userSigninWithGoogle(context).then((value){
                        setState(() {
                        isLoadingProgress = false;
                        });
                        });
                      },
                      apple: ()async{
                        setState(() {
                          isLoadingProgress = true;
                        });
                        SelectAccount.selectAccount == SelectAccountEnum.Driver.toString()
                            ? await Provider.of<VendorProvider>(context,listen: false).vendorSignInWithApple(context).then((value){
                          setState(() {
                            isLoadingProgress = false;
                          });
                        })
                            : await Provider.of<UserProvider>(context,listen: false).userSignInWithApple(context).then((value){
                        setState(() {
                        isLoadingProgress = false;
                        });
                        });


                      },
                    )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                                Container(
                                  child: ElevatedButton(
                                    onPressed: () async{

                                     // Provider.of<VendorProvider>(context,listen: false).vendorSignInWithFacebook(context: context);

                                      setState(() {
                                        isLoadingProgress = true;
                                      });
                                      SelectAccount.selectAccount == SelectAccountEnum.Driver.toString()
                                          ? await Provider.of<VendorProvider>(context,listen: false).vendorSignInWithFacebook(context: context).then((value){
                                        setState(() {
                                          isLoadingProgress = false;
                                        });
                                      })
                                          : await Provider.of<UserProvider>(context,listen: false).userSigninWithFacebook(context).then((value){
                                        setState(() {
                                          isLoadingProgress = false;
                                        });
                                      });





                                      // final LoginResult result = await FacebookAuth.instance.login();
                                      // // Once signed in, return the UserCredential
                                      // final OAuthCredential facebookCredential = FacebookAuthProvider.credential(result.accessToken!.token);
                                      // final userCredential = await FirebaseAuth.instance.signInWithCredential(facebookCredential).then((value)async{
                                      //   var token = await value.user!.getIdToken();
                                      //   print('$token');
                                      //   print('${value.user!.displayName}');
                                      //   print('${value.user!.photoURL}');
                                      //
                                      //   print('${value.user!.email}');
                                      // });




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
                                          MediaQuery.of(context).size.width *
                                              0.38,
                                          MediaQuery.of(context).size.height *
                                              0.060),
                                      primary: Color.fromRGBO(242, 243, 245, 1),
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(50.0),
                                          side: BorderSide(
                                              width: 1,
                                              color: Color.fromRGBO(
                                                  242, 243, 245, 1))),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Image.asset(
                                            'assets/images/Login-Facebook.png',
                                            height: 20,
                                          ),
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: 5.w, right: 10.w),
                                            child: new Text(
                                              "Facebook",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: ElevatedButton(
                                    onPressed: ()async {





                                      setState(() {
                                        isLoadingProgress = true;
                                      });
                                      SelectAccount.selectAccount == SelectAccountEnum.Driver.toString()
                                          ? await Provider.of<VendorProvider>(context,listen: false).vendorSignInWithGoogle(context: context).then((value){
                                        setState(() {
                                          isLoadingProgress = false;
                                        });
                                      })
                                          : await Provider.of<UserProvider>(context,listen: false).userSigninWithGoogle(context).then((value){
                                        setState(() {
                                          isLoadingProgress = false;
                                        });
                                      });







                                      //     .then((value)async{
                                      //   if (value != null) {
                                      //     print('this is user data${value.email}');
                                      //     print('this is user data${value.photoURL}');
                                      //     print('this is user data${value.phoneNumber}');
                                      //     print('this is user data${value.displayName}');
                                      //     print('this is user data${value.getIdToken()}');
                                      //
                                      //     if (value.photoURL != "") {
                                      //       await Provider.of<RouteProvider>(context, listen: false).fetchAllRoute().then((value) {
                                      //         if (Provider.of<RouteProvider>(context, listen: false).tripData.isNotEmpty) {
                                      //           navigationService.navigateTo(ScheduleScreenRoute);
                                      //         } else {
                                      //           navigationService.navigateTo(CreateRouteScreenRoute);
                                      //         }
                                      //       });
                                      //       //navigationService!.navigateTo(CreateRouteScreenRoute);
                                      //       //return;
                                      //     } else {
                                      //       navigationService.navigateTo(CreateVendorProfileScreenRoute);
                                      //       //return;
                                      //     }
                                      //
                                      //     // Navigator.of(context).pushReplacement(
                                      //     //   MaterialPageRoute(
                                      //     //     builder: (context) => UserInfoScreen(
                                      //     //       user: user,
                                      //     //     ),
                                      //     //   ),
                                      //     // );
                                      //   }
                                      //
                                      //
                                      // });






                                      // showDialog(
                                      //     context: context,
                                      //     barrierDismissible: false,
                                      //     builder: (_) {
                                      //       return WarningScreen();
                                      //     });
                                      // navigationService.navigateTo(MeasureHeightScreenRoute);
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
                                          MediaQuery.of(context).size.width *
                                              0.38,
                                          MediaQuery.of(context).size.height *
                                              0.060),
                                      primary: Color.fromRGBO(242, 243, 245, 1),
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(50.0),
                                          side: BorderSide(
                                              width: 1,
                                              color: Color.fromRGBO(
                                                  242, 243, 245, 1))),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Image.asset(
                                            'assets/images/Login-Google.png',
                                            height: 20,
                                          ),
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: 5.w, right: 10.w),
                                            child: new Text(
                                              "Google",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                  ],
                ),
                // child2
                Padding(
                  padding: EdgeInsets.only(bottom: 14.0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)
                                .translate('AlreadyHaveAnAccount') +
                            "?",
                        // "Dont have an account?",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        height: 40.h,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(
                                  selectAccount:
                                      widget.selectAccount.toString(),
                                ),
                              ),
                            );
                            // navigationService.navigateTo(SignUpScreenRoute);
                          },
                          child: Text(
                              AppLocalizations.of(context).translate('Signup'),
                              // 'Sign Up',
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp)),
                        ),
                      ),
                    ],
                  ),
                )
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
      ),
    );
  }

  // Future<UserCredential> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //
  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //
  //   // Once signed in, return the UserCredential
  //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }
}
