import 'dart:io';

import 'package:fruit_delivery_flutter/local/app_localization.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/user_provider.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
import 'package:fruit_delivery_flutter/providers/g_data_provider.dart';
import 'package:fruit_delivery_flutter/providers/products_provider.dart';
import 'package:fruit_delivery_flutter/screens/letschat_screen.dart';
import 'package:fruit_delivery_flutter/services/storage_service.dart';
import 'package:provider/provider.dart';

import '../utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fruit_delivery_flutter/utils/routes.dart';
import '../services/navigation_service.dart';
import '../utils/service_locator.dart';
import 'package:fruit_delivery_flutter/constants/select_account.dart';

class MainDrawerWidget extends StatefulWidget {
  @override
  _MainDrawerWidgetState createState() => _MainDrawerWidgetState();
}

class _MainDrawerWidgetState extends State<MainDrawerWidget> {
  var storageService = locator<StorageService>();
  String userType = '';
  @override
  void initState() {
    tes();

    super.initState();
  }

  tes() async {
    bool value=await storageService.getData("notificationIsActive")?? true;
    Provider.of<GMapsProvider>(context,listen: false).setNotificationToggle(value);
   // _notificationSwitchValue = await storageService.getData("notificationIsActive") ?? true;
    this.userType = await this.storageService.getData("selectAccount");
  }

  var navigationService = locator<NavigationService>();
  bool isLoadingProgress = false;
  var height;
  var width;
  //bool? _notificationSwitchValue;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      child: Stack(children: [
        Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                height: height * 0.30,
                width: double.infinity,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      scale: 12,
                      image: AssetImage(
                        "assets/images/Logo1.png",
                      ),
                    ),
                  ),
                  child: Column(
                    children: [],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 15,
                      top: 10,
                    ),
                    child: Text(
                      AppLocalizations.of(context).translate('DrawerSetting'),
                      style: TextStyle(
                        fontSize: height * 0.02,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 17,
                    ),
                    child: Container(
                      width: 30,
                      height: 1,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              if (SelectAccount.selectAccount !=
                  SelectAccountEnum.Guest.toString())
                ListTile(
                  dense: true,
                  leading: Icon(
                    Icons.notifications_none_outlined,
                    size: 24,
                    color: Color.fromRGBO(
                      105,
                      105,
                      105,
                      1,
                    ),
                  ),
                  minLeadingWidth: 5,
                  title: Text(
                    AppLocalizations.of(context)
                        .translate('DrawerNotification'),
                    // 'Notifications',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: height * 0.02,
                      color: Color.fromRGBO(105, 105, 105, 1),
                    ),
                  ),
                  trailing: Transform.scale(
                    scale: height * 0.001,
                    child: Consumer<GMapsProvider>(
                      builder: (context,i,_){
                        return CupertinoSwitch(
                          trackColor:
                          Colors.grey.shade400, // **INACTIVE STATE COLOR**
                          activeColor: Theme.of(context).backgroundColor, // **ACTIVE STATE COLOR**
                          value: i.drawerNotificationToggle!, //_notificationSwitchValue != null ? _notificationSwitchValue! : true,

                          onChanged: (bool value) {
                            setState(() {
                              i.setNotificationToggle(value);
                              storageService.setBoolData("notificationIsActive", value);
                              //_notificationSwitchValue = value;
                              print(value);
                              Provider.of<GMapsProvider>(context, listen: false).notificationOnOFff(value);
                            });
                          },
                        );
                      },
                    )
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Divider(
                  color: Color.fromRGBO(222, 226, 234, 1),
                  thickness: 1.5,
                ),
              ),
              ListTile(
                dense: true,
                horizontalTitleGap: height * 0.01,
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                ),
                title:
                    Text(AppLocalizations.of(context).translate('DrawerHome'),
                        // Home',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: height * 0.02,
                          color: Color.fromRGBO(105, 105, 105, 1),
                        )),
                onTap: () {
                  SelectAccount.selectAccount ==
                          SelectAccountEnum.Driver.toString()
                      ? navigationService.navigateTo(DriverHomeScreenRoute)
                      : navigationService.navigateTo(MainDashboardScreenRoute);
                  FocusScope.of(context).unfocus();
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Divider(
                  color: Color.fromRGBO(222, 226, 234, 1),
                  thickness: 1.5,
                ),
              ),
              if (SelectAccount.selectAccount ==
                  SelectAccountEnum.Driver.toString())
                ListTile(
                  dense: true,
                  horizontalTitleGap: height * 0.01,
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                  ),
                  title:
                      Text(AppLocalizations.of(context).translate('MyProfile'),
                          // 'My Profile',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: height * 0.02,
                            color: Color.fromRGBO(105, 105, 105, 1),
                          )),
                  onTap: () {
                    navigationService.navigateTo(VendorProfileScreenRoute);
                  },
                ),
              if (SelectAccount.selectAccount ==
                  SelectAccountEnum.Driver.toString())
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Divider(
                    color: Color.fromRGBO(222, 226, 234, 1),
                    thickness: 1.5,
                  ),
                ),
              if (SelectAccount.selectAccount ==
                  SelectAccountEnum.Driver.toString())
                ListTile(
                  dense: true,
                  horizontalTitleGap: height * 0.01,
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                  ),
                  title:
                      //Text(AppLocalizations.of(context).translate('MyProfile'),
                      Text('Chat',
                          // 'My Profile',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: height * 0.02,
                            color: Color.fromRGBO(105, 105, 105, 1),
                          )),
                  onTap: () {
                    navigationService.navigateTo(DriverLetsChatScreenRoute);
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (BuildContext ctx) => LetsChatScreen(),
                    // ));
                  },
                ),

              if (SelectAccount.selectAccount ==
                  SelectAccountEnum.Driver.toString())
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Divider(
                    color: Color.fromRGBO(222, 226, 234, 1),
                    thickness: 1.5,
                  ),
                ),
              // if (SelectAccount.selectAccount ==
              //     SelectAccountEnum.Driver.toString())
              //   ListTile(
              //     dense: true,
              //     horizontalTitleGap: height * 0.01,
              //     trailing: Icon(
              //       Icons.keyboard_arrow_right,
              //     ),
              //     title: Text(
              //         AppLocalizations.of(context).translate('DrawerTracking'),
              //         // 'Tracking',
              //         style: TextStyle(
              //           fontWeight: FontWeight.w700,
              //           fontWeight: FontWeight.w700,
              //           fontSize: height * 0.02,
              //           color: Color.fromRGBO(105, 105, 105, 1),
              //         )),
              //     onTap: () {
              //       navigationService.navigateTo(DriverHomeScreenRoute);
              //     },
              //   ),
              // if (SelectAccount.selectAccount ==
              //     SelectAccountEnum.Driver.toString())
              //   Padding(
              //     padding: EdgeInsets.only(left: 8, right: 8),
              //     child: Divider(
              //       color: Color.fromRGBO(222, 226, 234, 1),
              //       thickness: 1.5,
              //     ),
              //   ),
              // if (SelectAccount.selectAccount ==
              //     SelectAccountEnum.Driver.toString()||)
              // this.userType == 'SelectAccountEnum.Driver' ||
              //         SelectAccount.selectAccount ==
              //             SelectAccountEnum.Driver.toString()
              //     // ||
              //     //         SelectAccount.selectAccount !=
              //     //             SelectAccountEnum.Guest.toString()
              //     ? ListTile(
              //         dense: true,
              //         horizontalTitleGap: height * 0.01,
              //         trailing: Icon(
              //           Icons.keyboard_arrow_right,
              //         ),
              //         title: Text(
              //             AppLocalizations.of(context)
              //                 .translate('DrawerAddFruits'),
              //             // 'Add Fruits',
              //             style: TextStyle(
              //               fontWeight: FontWeight.w700,
              //               fontSize: height * 0.02,
              //               color: Color.fromRGBO(105, 105, 105, 1),
              //             )),
              //         onTap: () async {
              //           setState(() {
              //             isLoadingProgress = true;
              //           });
              //           await Provider.of<ProductsProvider>(context,
              //                   listen: false)
              //               .fetchAllProducts(count: 10, page: 1);

              //           setState(() {
              //             isLoadingProgress = false;
              //           });
              //           navigationService.navigateTo(AddFruitScreenRoute);
              //         },
              //       )
              //     : Container(),

              //start .............................................

              // //end................................................
              // if (SelectAccount.selectAccount ==
              //     SelectAccountEnum.Driver.toString())
              //   Padding(
              //     padding: EdgeInsets.only(left: 8, right: 8),
              //     child: Divider(
              //       color: Color.fromRGBO(222, 226, 234, 1),
              //       thickness: 1.5,
              //     ),
              //   ),
              // if (SelectAccount.selectAccount ==
              //     SelectAccountEnum.Driver.toString())
              //   ListTile(
              //     dense: true,
              //     horizontalTitleGap: height * 0.01,
              //     trailing: Icon(
              //       Icons.keyboard_arrow_right,
              //     ),
              //     title: Text(
              //         AppLocalizations.of(context).translate('DrawerMyFruits'),
              //         // 'My Fruits',
              //         style: TextStyle(
              //           fontWeight: FontWeight.w700,
              //           fontSize: height * 0.02,
              //           color: Color.fromRGBO(105, 105, 105, 1),
              //         )),
              //     onTap: () {
              //       navigationService.navigateTo(MyFruitsScreenRoute);
              //     },
              //   ),
              // if (SelectAccount.selectAccount ==
              //     SelectAccountEnum.Driver.toString())
              //   Padding(
              //     padding: EdgeInsets.only(left: 8, right: 8),
              //     child: Divider(
              //       color: Color.fromRGBO(222, 226, 234, 1),
              //       thickness: 1.5,
              //     ),
              //   ),
              if (SelectAccount.selectAccount ==
                  SelectAccountEnum.Driver.toString())
                ListTile(
                  dense: true,
                  horizontalTitleGap: height * 0.01,
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                  ),
                  title: Text(
                      AppLocalizations.of(context).translate('CreateRoute'),
                      // 'Create Route',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: height * 0.02,
                        color: Color.fromRGBO(105, 105, 105, 1),
                      )),
                  onTap: () {
                    navigationService.navigateTo(ScheduleScreenRoute);
                  },
                ),
              if (SelectAccount.selectAccount ==
                  SelectAccountEnum.Driver.toString())
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Divider(
                    color: Color.fromRGBO(222, 226, 234, 1),
                    thickness: 1.5,
                  ),
                ),
              if (SelectAccount.selectAccount !=
                  SelectAccountEnum.Guest.toString())
                ListTile(
                  dense: true,
                  horizontalTitleGap: height * 0.01,
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                  ),
                  title: Text(
                      AppLocalizations.of(context)
                          .translate('DrawerChangePassword'),
                      // 'Change Password',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: height * 0.02,
                        color: Color.fromRGBO(105, 105, 105, 1),
                      )),
                  onTap: () {
                    navigationService.navigateTo(ResetPasswordScreenRoute);
                  },
                ),
              if (SelectAccount.selectAccount !=
                  SelectAccountEnum.Guest.toString())
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Divider(
                    color: Color.fromRGBO(222, 226, 234, 1),
                    thickness: 1.5,
                  ),
                ),
              ListTile(
                dense: true,
                horizontalTitleGap: height * 0.01,
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                ),
                title: Text(
                    // 'Change Language',
                    AppLocalizations.of(context)
                        .translate('DrawerChangeLanguage'),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: height * 0.02,
                      color: Color.fromRGBO(105, 105, 105, 1),
                    )),
                onTap: () {
                  navigationService.navigateTo(LanguagesScreenRoute);
                  // showDialog(
                  //     context: context,
                  //     barrierDismissible: false,
                  //     builder: (_) {
                  //       return WarningScreen();
                  //     });
                  FocusScope.of(context).unfocus();
                },
              ),

              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Divider(
                  color: Color.fromRGBO(222, 226, 234, 1),
                  thickness: 1.5,
                ),
              ),
              // SizedBox(
              //   height: 65,
              // ),

              ListTile(
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                ),
                dense: true,
                horizontalTitleGap: height * 0.01,
                leading: Icon(
                  Icons.facebook,
                ),
                title: Text(
                    // 'Find us on Facebook',
                    AppLocalizations.of(context)
                        .translate('DrawerFindUsOnFacebook'),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: height * 0.02,
                      color: Color.fromRGBO(105, 105, 105, 1),
                    )),
                onTap: () {
                  navigationService.navigateTo(FacebookWidgetRoute);
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Divider(
                  color: Color.fromRGBO(222, 226, 234, 1),
                  thickness: 1.5,
                ),
              ),
              Container(
                // color: Colors.amber,
                height: SelectAccount.selectAccount !=
                        SelectAccountEnum.Guest.toString()
                    ? SelectAccount.selectAccount ==
                            SelectAccountEnum.Driver.toString()
                        ? MediaQuery.of(context).size.height * 0.2
                        : MediaQuery.of(context).size.height * 0.2
                    : MediaQuery.of(context).size.height * 0.35,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListTile(
                      onTap: () {},
                    ),
                    SelectAccount.selectAccount ==
                            SelectAccountEnum.Guest.toString()
                        ? Container()
                        : InkWell(
                            onTap: () async {
                              setState(() {
                                isLoadingProgress = true;
                              });
                              SelectAccount.selectAccount ==
                                      SelectAccountEnum.Guest.toString()
                                  ? Navigator.of(context)
                                      .pushNamedAndRemoveUntil(
                                          SelectAccountScreenRoute,
                                          (route) => false)
                                  : SelectAccount.selectAccount ==
                                          SelectAccountEnum.Driver.toString()
                                      ? await Provider.of<VendorProvider>(
                                              context,
                                              listen: false)
                                          .logoutFirebaseVendor(context)
                                      : await Provider.of<UserProvider>(context,
                                              listen: false)
                                          .logoutFirebaseUser(context);
                              setState(() {
                                isLoadingProgress = false;
                              });
                              // navigationService.navigateTo(SelectAccountScreenRoute);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 20,
                                    bottom: 5,
                                  ),
                                  width: MediaQuery.of(context).size.width / 8,
                                  decoration: BoxDecoration(
                                    // color: Colors.green,
                                    border: Border(
                                      top: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.logout,
                                      color: Theme.of(context).accentColor,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate('logout'),
                                      // 'Logout',
                                      style: TextStyle(
                                        fontSize: height * 0.02,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          )
                  ],
                ),
              ),

              // Padding(
              //   padding: EdgeInsets.only(left: 8, right: 8),
              //   child: Divider(
              //     color: Color.fromRGBO(222, 226, 234, 1),
              //     thickness: 1.5,
              //   ),
              // ),
              // Container(
              //   // color: Colors.amber,
              //   height: SelectAccount.selectAccount !=
              //           SelectAccountEnum.Guest.toString()
              //       ? SelectAccount.selectAccount ==
              //               SelectAccountEnum.Driver.toString()
              //           ? MediaQuery.of(context).size.height * 0.2
              //           : MediaQuery.of(context).size.height * 0.28
              //       : MediaQuery.of(context).size.height * 0.428,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       ListTile(
              //         onTap: () {},
              //       ),
              //       InkWell(
              //         onTap: () async {
              //           setState(() {
              //             isLoadingProgress = true;
              //           });
              //           SelectAccount.selectAccount ==
              //                   SelectAccountEnum.Guest.toString()
              //               ? navigationService
              //                   .navigateTo(SelectAccountScreenRoute)
              //               : SelectAccount.selectAccount ==
              //                       SelectAccountEnum.Driver.toString()
              //                   ? await Provider.of<VendorProvider>(context,
              //                           listen: false)
              //                       .logoutFirebaseVendor(context)
              //                   : await Provider.of<UserProvider>(context,
              //                           listen: false)
              //                       .logoutFirebaseUser(context);
              //           setState(() {
              //             isLoadingProgress = false;
              //           });
              //           // navigationService.navigateTo(SelectAccountScreenRoute);
              //         },
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Container(
              //               margin: EdgeInsets.only(
              //                 left: 20,
              //                 bottom: 5,
              //               ),
              //               width: MediaQuery.of(context).size.width / 8,
              //               decoration: BoxDecoration(
              //                 // color: Colors.green,
              //                 border: Border(
              //                   top: BorderSide(
              //                     color: Colors.black,
              //                     width: 1,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             Row(
              //               children: [
              //                 SizedBox(
              //                   width: 10,
              //                 ),
              //                 Icon(
              //                   Icons.logout,
              //                   color: Theme.of(context).accentColor,
              //                   size: 16,
              //                 ),
              //                 SizedBox(
              //                   width: 5,
              //                 ),
              //                 Text(
              //                   'Logout',
              //                   style: TextStyle(
              //                     fontSize: 18,
              //                     color: Colors.black,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             SizedBox(
              //               height: 10,
              //             )
              //           ],
              //         ),
              //       )
              //     ],
              //   ),
              // )
            ],
          ),
        ),
        if (isLoadingProgress)
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Platform.isIOS
                  ? CupertinoActivityIndicator()
                  : CircularProgressIndicator(),
            ),
          ),
      ]),
    );
  }
}
