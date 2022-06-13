// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';
import 'package:fruit_delivery_flutter/screens/schedule_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/auth_providers/user_provider.dart';
import '../screens/chache_image.dart';
import '../services/util_service.dart';
import '../utils/routes.dart';
import '../services/navigation_service.dart';
import '../utils/service_locator.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var utilService = locator<UtilService>();
  bool isLoadingProgress = false;
  var imageUrl = '';
  // var utilService = locator<UtilService>();
  var user;
  final GlobalKey<FormState> _formKey = GlobalKey();
  var navigationService = locator<NavigationService>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var school;
  // ignore: unused_field
  bool _showPassword = true;
  @override
  void dispose() {
    super.dispose();
  }

  void locationOfPainCallback(String lop) {
    setState(() => school = lop);
  }

  String tagId = ' ';
  void active(
    dynamic val,
  ) {
    setState(() {
      tagId = val;
    });
  }

  @override
  void initState() {
    user = Provider.of<UserProvider>(context, listen: false).userData;
    if (user != null) {
      nameController.text = user.fullName;
      emailController.text = user.email;
      phoneController.text = user.phoneNumber;
      addressController.text = user.address ?? "";

      imageUrl = user.profilePicture;
    }
    super.initState();
  }

  bool validateEmail(String value) {
    Pattern? pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    return (!regex.hasMatch(value)) ? false : true;
  }

  // String? validateMobile(String value) {
  //   String pattern = r'^(?:[+0][1-9])?[0-9]{9,13}$';
  //   RegExp regExp = new RegExp(pattern);
  //   if (!regExp.hasMatch(value)) {
  //     return 'Enter correct number';
  //   } else
  //     return null;
  // }
  bool validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      utilService.showToast("Please enter valid phone number");
      return false;
    }
    return true;
  }

  final picker = ImagePicker();
  File? _image;

  getImageFromGallery() async {
    var imageFile = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    setState(() {
      _image = File(imageFile!.path);
    });
  }

  getImageFromCamera() async {
    var imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    setState(() {
      _image = File(imageFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    print(height);
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                // gradient: LinearGradient(
                //     begin: Alignment.topLeft,
                //     end: Alignment.bottomRight,
                //     colors: [
                //       Color.fromRGBO(53, 187, 72, 1),
                //       Color.fromRGBO(53, 187, 72, 1)
                //     ]),
              ),
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 30, bottom: 10, left: 2),
                      child: Row(
                        children: [
                          IconButton(
                              iconSize: 20.h,
                              icon: Icon(Icons.arrow_back),
                              color: Colors.white,
                              onPressed: () {
                                //navigationService.navigateTo(ScheduleScreenRoute);
                                //navigationService.navigateTo(UserProfileTabScreenRoute);
                                navigationService.closeScreen();
                              }),
                          SizedBox(
                            width: 10,
                          ),
                          Center(
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('EditProfile'),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.h,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    _image != null
                        ? Stack(
                            children: [
                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.file(
                                      File(_image!.path),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 80, left: 80),
                                  child: GestureDetector(
                                    onTap: () async {
                                      _settingModalBottomSheet(
                                        context,
                                      );
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: AssetImage(
                                          "assets/images/Camera.png"),
                                      radius: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : imageUrl != '' && imageUrl != null
                            ? Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 55.h,
                                    backgroundColor: Colors.white,
                                    child: CacheImage(
                                      imageUrl:
                                          imageUrl != '' && imageUrl != null
                                              ? imageUrl
                                              : user.profilePicture,
                                      height: 100.h,
                                      width: 100.h,
                                      radius: 100.h,
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          _settingModalBottomSheet(
                                            context,
                                          );
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          child: Image.asset(
                                            'assets/images/Camera.png',
                                          ),
                                          radius: 18.h,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 50.h,
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.white,
                                    child: user.profilePicture != null &&
                                            user.profilePicture != ''
                                        ? CacheImage(
                                            imageUrl: imageUrl != '' &&
                                                    imageUrl != null
                                                ? imageUrl
                                                : user.profilePicture,
                                            height: 100.h,
                                            width: 100.h,
                                            radius: 100.h,
                                          )
                                        : Image.asset(
                                            'assets/images/place_holder.png'),
                                  ),
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      // FractionalOffset(0, 0)
                                      child: GestureDetector(
                                        onTap: () {
                                          _settingModalBottomSheet(
                                            context,
                                          );
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          child: Image.asset(
                                            'assets/images/Camera.png',
                                          ),
                                          radius: 18.h,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                    SizedBox(
                      height: 60.h,
                    ),
                  ],
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    // height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        child: Form(
                            key: _formKey,
                            // autovalidate: _autoValidate,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: 500.h,
                                          child: TextFormField(
                                            controller: nameController,
                                            maxLength: 15,
                                            readOnly: false,
                                            autocorrect: true,
                                            decoration: InputDecoration(
                                                prefixIcon: Image.asset(
                                                  "assets/images/user.png",
                                                  scale: 3,
                                                ),
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 10),
                                                hintText:
                                                    AppLocalizations.of(context)
                                                        .translate('FullName'),
                                                hintStyle: TextStyle(
                                                    color: Colors.grey.shade300,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                labelText:
                                                    AppLocalizations.of(context)
                                                        .translate('FullName'),
                                                labelStyle: TextStyle(
                                                    fontSize: 14.h,
                                                    height: 1,
                                                    color: Theme.of(context)
                                                        .accentColor),
                                                filled: true,
                                                fillColor: Colors.white,
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                ))),
                                          ),
                                        ),

                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Container(
                                          width: 500.h,
                                          child: TextFormField(
                                            controller: emailController,

                                            // autovalidateMode: AutovalidateMode
                                            //     .onUserInteraction,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            // validator: (input) {
                                            //   bool emailValid = RegExp(
                                            //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            //       .hasMatch(input ?? "");
                                            //   if (emailValid == true) {
                                            //     return null;
                                            //   } else {
                                            //     return "Email id should be valid";
                                            //   }
                                            // },
                                            readOnly: true,
                                            autocorrect: true,
                                            decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.email_outlined,
                                                  color: Colors.greenAccent,
                                                  size: 22,
                                                ),
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                isDense: true,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 10.0),
                                                labelText: AppLocalizations.of(
                                                        context)
                                                    .translate('EmailAddress'),
                                                labelStyle: TextStyle(
                                                    color: Theme.of(context)
                                                        .accentColor),
                                                hintText: AppLocalizations.of(
                                                        context)
                                                    .translate('EmailAddress'),
                                                hintStyle: TextStyle(
                                                    color: Colors.grey.shade300,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                filled: true,
                                                fillColor: Colors.white,
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                ))),
                                          ),
                                        ),

                                        SizedBox(
                                          height: 10.h,
                                        ),

                                        Container(
                                          width: 500.h,
                                          child: TextFormField(
                                            keyboardType: TextInputType.phone,
                                            controller: phoneController,
                                            readOnly: false,
                                            autocorrect: true,
                                            decoration: InputDecoration(
                                                prefixIcon: Image.asset(
                                                  "assets/images/phone.png",
                                                  scale: 3,
                                                ),
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                isDense: true,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 10),
                                                labelText: AppLocalizations.of(
                                                        context)
                                                    .translate('PhoneNumber'),
                                                labelStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                ),
                                                hintText: AppLocalizations.of(
                                                        context)
                                                    .translate('PhoneNumber'),
                                                hintStyle: TextStyle(
                                                    color: Colors.grey.shade300,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                filled: true,
                                                fillColor: Colors.white,
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                ))),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          width: 500.h,
                                          child: TextFormField(
                                            onTap: () {
                                              // showDialog(
                                              //     context: context,
                                              //     builder: (_) =>
                                              //         SelectedShcoolPopupWidget());
                                            },
                                            controller: addressController,
                                            readOnly: false,
                                            autocorrect: true,
                                            decoration: InputDecoration(
                                                prefixIcon: Image.asset(
                                                  "assets/images/calender.png",
                                                  scale: 3,
                                                ),
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 10),
                                                hintText:
                                                    AppLocalizations.of(context)
                                                        .translate('Address'),
                                                hintStyle: TextStyle(
                                                    color: Colors.grey.shade300,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                labelText:
                                                    AppLocalizations.of(context)
                                                        .translate('Address'),
                                                labelStyle: TextStyle(
                                                    fontSize: 14.h,
                                                    height: 1,
                                                    color: Theme.of(context)
                                                        .accentColor),
                                                filled: true,
                                                fillColor: Colors.white,
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                ))),
                                          ),
                                        ),

                                        // ignore: deprecated_member_use
                                      ]),
                                  if (height > 700)
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                  SizedBox(
                                    height: 45.h,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              setState(() {
                                                isLoadingProgress = true;
                                              });

                                              // if (imageUrl == '' ||
                                              //     imageUrl == null) {
                                              //   utilService.showToast(
                                              //       "Please upload profile picture");
                                              //   setState(() {
                                              //     isLoadingProgress = false;
                                              //   });
                                              // }
                                              if (nameController.text == "") {
                                                utilService.showToast(
                                                    "Please enter name");
                                                setState(() {
                                                  isLoadingProgress = false;
                                                });
                                                return;
                                              } else if (emailController.text ==
                                                  "") {
                                                utilService.showToast(
                                                    "Please enter email");
                                                setState(() {
                                                  isLoadingProgress = false;
                                                });
                                                return;
                                              } else if (!emailController.text
                                                      .contains(".com") ||
                                                  !emailController.text
                                                      .contains("@")) {
                                                utilService.showToast(
                                                    "Please enter a valid email");
                                                setState(() {
                                                  isLoadingProgress = false;
                                                });
                                                return;
                                              } else if (phoneController.text ==
                                                  "") {
                                                utilService.showToast(
                                                    "Please  enter phone number");
                                                setState(() {
                                                  isLoadingProgress = false;
                                                });
                                                return;
                                              } else if (addressController.text =="") {
                                                utilService.showToast("Please enter address");
                                                setState(() {
                                                  isLoadingProgress = false;
                                                });
                                                return;
                                              } else if (!validateMobile(phoneController.text)) {
                                                setState(() {
                                                  isLoadingProgress = false;
                                                });
                                              } else {
                                                setState(() {
                                                  isLoadingProgress = true;
                                                });
                                                if (_image != null) {
                                                  utilService.browseImage(user.id, _image).then((String value) async {{
                                                      imageUrl = value;
                                                      isLoadingProgress = false;
                                                      await Provider.of<UserProvider>(context, listen: false)
                                                          .createUserProfile(
                                                        imageUrl: imageUrl,
                                                        name: nameController.text,
                                                        email: emailController.text,
                                                        phoneNumber: phoneController.text,
                                                        address: addressController.text,

                                                        // context: context
                                                      );
                                                      setState(() {
                                                        isLoadingProgress = false;
                                                      });
                                                      navigationService.closeScreen();
                                                      navigationService.navigateTo(UserProfileTabScreenRoute);
                                                    }
                                                  });
                                                }
                                                if (_image == null) {
                                                  //isLoadingProgress = false;
                                                  await Provider.of<
                                                              UserProvider>(
                                                          context,
                                                          listen: false)
                                                      .createUserProfile(
                                                    imageUrl: imageUrl,
                                                    name: nameController.text,
                                                    email: emailController.text,
                                                    phoneNumber:
                                                        phoneController.text,
                                                    address:
                                                        addressController.text,

                                                    // context: context
                                                  );
                                                  setState(() {
                                                    isLoadingProgress = false;
                                                  });
                                                  navigationService.navigateTo(UserProfileTabScreenRoute);
                                                  //navigationService.closeScreen();
                                                }

                                                // await Provider.of<UserProvider>(
                                                //         context,
                                                //         listen: false)
                                                //     .createUserProfile(
                                                //   imageUrl: imageUrl,
                                                //   name: nameController.text,
                                                //   email: emailController.text,
                                                //   phoneNumber:
                                                //       phoneController.text,
                                                //   address:
                                                //       addressController.text,
                                                //
                                                //   // context: context
                                                // );
                                                // setState(() {
                                                //   isLoadingProgress = false;
                                                // });
                                                // navigationService.navigateTo(MyProfileScreenRoute);
                                                //navigationService.closeScreen();
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              textStyle: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.03,
                                                  fontWeight: FontWeight.w600),
                                              fixedSize: Size(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.85,
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.065),
                                              primary:
                                                  Theme.of(context).accentColor,
                                              shape: new RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          5.0),
                                                  side: BorderSide(
                                                      width: 1,
                                                      color: Theme.of(context)
                                                          .accentColor)),
                                            ),
                                            child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 5.w, right: 10.w),
                                                child: new Text(
                                                  "Save",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                    shadows: [
                                                      Shadow(
                                                        blurRadius: 10.0,
                                                        color: Colors
                                                            .grey.shade600,
                                                        offset:
                                                            Offset(4.0, 4.0),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ]),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (isLoadingProgress)
              Center(
                child: Platform.isIOS
                    ? CupertinoActivityIndicator()
                    : CircularProgressIndicator(),
              )
          ],
        ));
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 200,
            child: new Wrap(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Upload Profile Picture",
                      //'Upload Profile Picture',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Divider(),
                new ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: LinearGradient(
                            begin: (Alignment.bottomCenter),
                            end: (Alignment.bottomLeft),
                            colors: [
                              Colors.purple,
                              Colors.purpleAccent,
                            ])),
                    child: new Icon(
                      Icons.camera,
                      color: Colors.white,
                    ),
                  ),
                  title: new Text("Take Photo",
                      // 'Take Photo',
                      style: Theme.of(context).textTheme.subtitle2),
                  onTap: () {
                    // setState(() {
                    //   isLoadingProgress = true;
                    getImageFromCamera();
                    // utilService.captureImage(vendor.id).then((String value) => setState(() {
                    //           imageUrl = value;
                    //           isLoadingProgress = false;
                    //         }));
                    // });
                    // isLoadingProgress = false;
                    Navigator.of(context).pop();
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: new ListTile(
                    leading: Container(
                      margin: EdgeInsets.only(top: 3),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(
                              begin: (Alignment.bottomCenter),
                              end: (Alignment.bottomLeft),
                              colors: [
                                Colors.pink,
                                Colors.pinkAccent,
                              ])),
                      child: new Icon(
                        Icons.image,
                        color: Colors.white,
                      ),
                    ),
                    title: new Text("Browse",
                        // 'Browse',
                        style: Theme.of(context).textTheme.subtitle2),
                    onTap: () {
                      // setState(() {
                      //   isLoadingProgress = true;
                      getImageFromGallery();
                      // utilService.browseImage(vendor.id,).then((String value) => setState(() {
                      //           imageUrl = value;
                      //           isLoadingProgress = false;
                      //         }));
                      // });
                      // isLoadingProgress = false;
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
