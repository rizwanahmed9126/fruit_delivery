import 'package:fruit_delivery_flutter/providers/auth_providers/user_provider.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
import 'package:fruit_delivery_flutter/screens/chache_image.dart';
import 'package:fruit_delivery_flutter/utils/routes.dart';
import 'package:provider/provider.dart';

import '../services/navigation_service.dart';
import '../services/util_service.dart';
import '../utils/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VendorProfileScreen extends StatefulWidget {
  VendorProfileScreen({Key? key}) : super(key: key);

  @override
  _VendorProfileScreenState createState() => _VendorProfileScreenState();
}

class _VendorProfileScreenState extends State<VendorProfileScreen> {
  bool isLoadingProgress = false;
  var imageUrl = '';
  var utilService = locator<UtilService>();
  // var data;
  var vendorData;
  final GlobalKey<FormState> _formKey = GlobalKey();
  var navigationService = locator<NavigationService>();
  TextEditingController nameController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var school;
  // ignore: unused_field
  bool _showPassword = true;
  @override
  void dispose() {
    // navigationService.closeScreen();
    super.dispose();
  }

  void locationOfPainCallback(String lop) {
    setState(() => school = lop);
  }

  @override
  void initState() {
    vendorData = Provider.of<VendorProvider>(context, listen: false).vendorData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(
          360,
          800,
        ),
        orientation: Orientation.portrait);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        bottomOpacity: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        actions: [
          GestureDetector(
            onTap: () =>
                navigationService.navigateTo(VendorEditProfileScreenRoute),
            child: Image.asset(
              "assets/images/edit.png",
              scale: 2.5,
              // color: Colors.white,
            ),
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            navigationService.closeScreen();
            //navigationService.navigateTo(DriverHomeScreenRoute);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Theme.of(context).backgroundColor,
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                children: [
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //     top: 60.h,
                  //     bottom: 10.h,
                  //   ),
                  //   child: Padding(
                  //     padding: EdgeInsets.only(left: 14.w, right: 15.w),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         GestureDetector(
                  //           onTap: () {},
                  //           child: Image(
                  //             width: 22.w,
                  //             height: 22.h,
                  //             image: AssetImage(
                  //               "assets/images/menu-icon.png",
                  //             ),
                  //           ),
                  //         ),
                  //         Center(
                  //           child: Text(
                  //             'My Profile',
                  //             style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 18.sp,
                  //               fontWeight: FontWeight.w700,
                  //             ),
                  //           ),
                  //         ),
                  //         GestureDetector(
                  //           onTap: () => navigationService
                  //               .navigateTo(EditProfileScreenRoute),
                  //           child: Image(
                  //             width: 22.w,
                  //             height: 22.h,
                  //             image: AssetImage(
                  //               "assets/images/edit.png",
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Stack(
                    children: [
                      if (vendorData != null)
                        Center(
                          child: vendorData.profilePicture == null ||
                                  vendorData.profilePicture == ""
                              ? CircleAvatar(
                                  radius: 55.h,
                                  child: Image.asset(
                                      "assets/images/place_holder.png"))
                              : CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 55.h,
                                  child: CacheImage(
                                    imageUrl: vendorData.profilePicture,
                                    height: 100.h,
                                    width: 100.h,
                                    radius: 100.h,
                                  ),
                                ),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),

                  Text(
                    vendorData != null ? vendorData.fullName : "",
                    style: TextStyle(
                      color: Color.fromRGBO(
                        253,
                        255,
                        254,
                        1,
                      ),
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 22.h,
                        color: Color.fromRGBO(
                          239,
                          248,
                          247,
                          1,
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Text(
                        vendorData != null
                            ? vendorData.address
                            : "Boston, MA 02101",
                        style: TextStyle(
                          color: Color.fromRGBO(
                            239,
                            248,
                            247,
                            1,
                          ),
                          fontSize: 14.sp,
                          height: 1.5.h,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                  padding: EdgeInsets.only(
                    left: 15.w,
                    top: 15.h,
                    right: 15.w,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.h),
                      topRight: Radius.circular(20.h),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(4.h),
                    child: Container(
                      child: Form(
                        key: _formKey,
                        // autovalidate: _autoValidate,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 500.h,
                                child: TextFormField(
                                  controller: nameController,
                                  readOnly: true,
                                  autocorrect: true,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0.w,
                                      horizontal: 10.h,
                                    ),
                                    prefixIcon: Row(
                                      children: [
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Image(
                                          width: 22.w,
                                          height: 22.h,
                                          image: AssetImage(
                                            "assets/images/user.png",
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Text(
                                          "Full Name",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Color.fromRGBO(
                                              116,
                                              131,
                                              146,
                                              1,
                                            ),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                    suffixIcon: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          vendorData != null
                                              ? vendorData.fullName
                                              : "",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp,
                                            color: Color.fromRGBO(
                                              181,
                                              188,
                                              196,
                                              1,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.h,
                                        )
                                      ],
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 15.h,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: emailController,
                                        readOnly: true,
                                        autocorrect: true,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 15.0.w,
                                            horizontal: 10.h,
                                          ),
                                          prefixIcon: Row(
                                            children: [
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Image(
                                                width: 22.w,
                                                height: 22.h,
                                                image: AssetImage(
                                                  "assets/images/email.png",
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15.w,
                                              ),
                                              Text(
                                                'Email Address',
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                    116,
                                                    131,
                                                    146,
                                                    1,
                                                  ),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20.w,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  vendorData != null
                                                      ? vendorData.email ??""
                                                      : "",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.sp,
                                                    color: Color.fromRGBO(
                                                      181,
                                                      188,
                                                      196,
                                                      1,
                                                    ),
                                                  ),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                          // suffixIcon: Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.end,
                                          //   children: [
                                          //     Text(
                                          //       'angelina_test@gmail.com',
                                          //       overflow: TextOverflow.ellipsis,
                                          //       style: TextStyle(
                                          //         fontWeight: FontWeight.w600,
                                          //         fontSize: 16.sp,
                                          //         color: Color.fromRGBO(
                                          //           181,
                                          //           188,
                                          //           196,
                                          //           1,
                                          //         ),
                                          //       ),
                                          //     ),
                                          //     SizedBox(
                                          //       width: 5.h,
                                          //     )
                                          //   ],
                                          // ),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Expanded(
                              //   child: Row(
                              //     children: [
                              //       Expanded(
                              //         child: Container(
                              //           // width: 500.h,
                              //           child: TextFormField(
                              //             controller: nameController,
                              //             readOnly: true,
                              //             autocorrect: true,
                              //             decoration: InputDecoration(
                              //               border: InputBorder.none,
                              //               focusedBorder: InputBorder.none,
                              //               enabledBorder: InputBorder.none,
                              //               errorBorder: InputBorder.none,
                              //               disabledBorder: InputBorder.none,
                              //               floatingLabelBehavior:
                              //                   FloatingLabelBehavior.always,
                              //               isDense: true,
                              //               contentPadding:
                              //                   EdgeInsets.symmetric(
                              //                 vertical: 15.0.w,
                              //                 horizontal: 10.h,
                              //               ),
                              //               prefixIcon: Row(
                              //                 children: [
                              //                   SizedBox(
                              //                     width: 5.w,
                              //                   ),
                              //                   Image(
                              //                     width: 22.w,
                              //                     height: 22.h,
                              //                     image: AssetImage(
                              //                       "assets/images/email.png",
                              //                     ),
                              //                   ),
                              //                   SizedBox(
                              //                     width: 15.w,
                              //                   ),
                              //                   Text(
                              //                     'Email Address',
                              //                     style: TextStyle(
                              //                       color: Color.fromRGBO(
                              //                         116,
                              //                         131,
                              //                         146,
                              //                         1,
                              //                       ),
                              //                       fontWeight: FontWeight.w600,
                              //                       fontSize: 16.sp,
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //               // suffixIcon: Row(
                              //               //   mainAxisAlignment:
                              //               //       MainAxisAlignment.end,
                              //               //   children: [
                              //               //     Text(
                              //               //       'angelina_test@gmail.com',
                              //               //       overflow: TextOverflow.ellipsis,
                              //               //       style: TextStyle(
                              //               //         fontWeight: FontWeight.w600,
                              //               //         fontSize: 16.sp,
                              //               //         color: Color.fromRGBO(
                              //               //           181,
                              //               //           188,
                              //               //           196,
                              //               //           1,
                              //               //         ),
                              //               //       ),
                              //               //     ),
                              //               //     SizedBox(
                              //               //       width: 5.h,
                              //               //     )
                              //               //   ],
                              //               // ),
                              //               filled: true,
                              //               fillColor: Colors.white,
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //       Expanded(
                              //         child: Text(
                              //           'angelina_test@gmail.com',
                              //           overflow: TextOverflow.ellipsis,
                              //           style: TextStyle(
                              //             fontWeight: FontWeight.w600,
                              //             fontSize: 16.sp,
                              //             color: Color.fromRGBO(
                              //               181,
                              //               188,
                              //               196,
                              //               1,
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // Container(
                              //   // width: 500.h,
                              //   child: TextFormField(
                              //     controller: nameController,
                              //     readOnly: true,
                              //     autocorrect: true,
                              //     decoration: InputDecoration(
                              //       border: InputBorder.none,
                              //       focusedBorder: InputBorder.none,
                              //       enabledBorder: InputBorder.none,
                              //       errorBorder: InputBorder.none,
                              //       disabledBorder: InputBorder.none,
                              //       floatingLabelBehavior:
                              //           FloatingLabelBehavior.always,
                              //       isDense: true,
                              //       contentPadding: EdgeInsets.symmetric(
                              //         vertical: 15.0.w,
                              //         horizontal: 10.h,
                              //       ),
                              //       prefixIcon: Row(
                              //         children: [
                              //           SizedBox(
                              //             width: 5.w,
                              //           ),
                              //           Image(
                              //             width: 22.w,
                              //             height: 22.h,
                              //             image: AssetImage(
                              //               "assets/images/email.png",
                              //             ),
                              //           ),
                              //           SizedBox(
                              //             width: 15.w,
                              //           ),
                              //           Text(
                              //             'Email Address',
                              //             style: TextStyle(
                              //               color: Color.fromRGBO(
                              //                 116,
                              //                 131,
                              //                 146,
                              //                 1,
                              //               ),
                              //               fontWeight: FontWeight.w600,
                              //               fontSize: 16.sp,
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //       suffixIcon: Row(
                              //         mainAxisAlignment: MainAxisAlignment.end,
                              //         children: [
                              //           Text(
                              //             'angelina_test@gmail.com',
                              //             overflow: TextOverflow.ellipsis,
                              //             style: TextStyle(
                              //               fontWeight: FontWeight.w600,
                              //               fontSize: 16.sp,
                              //               color: Color.fromRGBO(
                              //                 181,
                              //                 188,
                              //                 196,
                              //                 1,
                              //               ),
                              //             ),
                              //           ),
                              //           SizedBox(
                              //             width: 5.h,
                              //           )
                              //         ],
                              //       ),
                              //       filled: true,
                              //       fillColor: Colors.white,
                              //     ),
                              //   ),
                              // ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Container(
                                width: 500.h,
                                child: TextFormField(
                                  // controller: nameController,
                                  readOnly: true,
                                  autocorrect: true,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.w,
                                      horizontal: 10.h,
                                    ),
                                    prefixIcon: Row(
                                      children: [
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Image(
                                          width: 22.w,
                                          height: 22.h,
                                          image: AssetImage(
                                            "assets/images/phone.png",
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Text(
                                          "Phone Number",
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                              116,
                                              131,
                                              146,
                                              1,
                                            ),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                    suffixIcon: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          vendorData != null
                                              ? vendorData.phoneNumber
                                              : "",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp,
                                            color: Color.fromRGBO(
                                              181,
                                              188,
                                              196,
                                              1,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                      ],
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Container(
                                width: 500.h,
                                child: TextFormField(
                                  controller: nameController,
                                  readOnly: true,
                                  autocorrect: true,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0.w,
                                      horizontal: 10.h,
                                    ),
                                    prefixIcon: Row(
                                      children: [
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Icon(
                                          Icons.location_on_outlined,
                                          size: 22.h,
                                          color:
                                              Theme.of(context).backgroundColor,
                                        ),
                                        // Image(
                                        //   width: 22.w,
                                        //   height: 22.h,
                                        //   image: AssetImage(
                                        //     "assets/images/calender.png",
                                        //   ),
                                        // ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Text(
                                          "Address",
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                              116,
                                              131,
                                              146,
                                              1,
                                            ),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                    suffixIcon: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Text(
                                            vendorData != null
                                                ? vendorData.address
                                                : "",
                                            // maxLines: 2,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp,
                                              color: Color.fromRGBO(
                                                181,
                                                188,
                                                196,
                                                1,
                                              ),
                                            ),
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                        // Text(
                                        //   vendorData != null
                                        //       ? vendorData.address
                                        //       : "",
                                        //   style: TextStyle(
                                        //     fontWeight: FontWeight.w600,
                                        //     fontSize: 16.sp,
                                        //     color: Color.fromRGBO(
                                        //       181,
                                        //       188,
                                        //       196,
                                        //       1,
                                        //     ),
                                        //   ),
                                        // ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                      ],
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                              // ignore: deprecated_member_use
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
