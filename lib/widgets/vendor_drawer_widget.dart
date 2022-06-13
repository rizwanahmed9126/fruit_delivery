// import 'package:fruit_delivery_flutter/providers/auth_providers/user_provider.dart';
// import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
// import 'package:fruit_delivery_flutter/providers/products_provider.dart';
// import 'package:fruit_delivery_flutter/services/storage_service.dart';
// import 'package:provider/provider.dart';

// import '../utils/routes.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:fruit_delivery_flutter/utils/routes.dart';
// import '../services/navigation_service.dart';
// import '../utils/service_locator.dart';
// import 'package:fruit_delivery_flutter/constants/select_account.dart';

// class VendorDrawerWidget extends StatefulWidget {
//   @override
//   _VendorDrawerWidgetState createState() => _VendorDrawerWidgetState();
// }

// class _VendorDrawerWidgetState extends State<VendorDrawerWidget> {
//   var storageService = locator<StorageService>();
//   String userType = 'SelectAccountEnum.Driver';
//   @override
//   void initState() {
// // this.userType = z this.storageService.getData("selectAccount");
//     // TODO: implement initState
//     super.initState();
//   }

//   var navigationService = locator<NavigationService>();
//   bool isLoadingProgress = false;
//   var height;
//   var width;
//   bool _notificationSwitchValue = false;
//   @override
//   Widget build(BuildContext context) {
//     height = MediaQuery.of(context).size.height;
//     width = MediaQuery.of(context).size.width;
//     return Container(
//       width: MediaQuery.of(context).size.width / 1.2,
//       child: Stack(children: [
//         Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: <Widget>[
//               SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 height: height * 0.30,
//                 width: double.infinity,
//                 child: DrawerHeader(
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       scale: 12,
//                       image: AssetImage(
//                         "assets/images/Logo1.png",
//                       ),
//                     ),
//                   ),
//                   child: Column(
//                     children: [],
//                   ),
//                 ),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(
//                       left: 15,
//                       top: 10,
//                     ),
//                     child: Text(
//                       "SETTINGS",
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.black,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                       left: 17,
//                     ),
//                     child: Container(
//                       width: 30,
//                       height: 1,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 5,
//               ),

//               ListTile(
//                 dense: true,
//                 leading: Icon(
//                   Icons.notifications_none_outlined,
//                   size: 24,
//                   color: Color.fromRGBO(
//                     105,
//                     105,
//                     105,
//                     1,
//                   ),
//                 ),
//                 minLeadingWidth: 5,
//                 title: Text(
//                   'Notifications',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w700,
//                     fontSize: height * 0.023,
//                     color: Color.fromRGBO(105, 105, 105, 1),
//                   ),
//                 ),
//                 trailing: Transform.scale(
//                   scale: height * 0.001,
//                   child: CupertinoSwitch(
//                     trackColor:
//                         Colors.grey.shade400, // **INACTIVE STATE COLOR**
//                     activeColor: Theme.of(context)
//                         .backgroundColor, // **ACTIVE STATE COLOR**
//                     value: _notificationSwitchValue,

//                     onChanged: (bool value) {
//                       setState(() {
//                         _notificationSwitchValue = value;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 8, right: 8),
//                 child: Divider(
//                   color: Color.fromRGBO(222, 226, 234, 1),
//                   thickness: 1.5,
//                 ),
//               ),
//               ListTile(
//                 dense: true,
//                 horizontalTitleGap: height * 0.01,
//                 trailing: Icon(
//                   Icons.keyboard_arrow_right,
//                 ),
//                 title: Text('Home',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: height * 0.023,
//                       color: Color.fromRGBO(105, 105, 105, 1),
//                     )),
//                 onTap: () {
//                   navigationService.navigateTo(DriverHomeScreenRoute);

//                   FocusScope.of(context).unfocus();
//                 },
//               ),

//               Padding(
//                 padding: EdgeInsets.only(left: 8, right: 8),
//                 child: Divider(
//                   color: Color.fromRGBO(222, 226, 234, 1),
//                   thickness: 1.5,
//                 ),
//               ),

//               ListTile(
//                 dense: true,
//                 horizontalTitleGap: height * 0.01,
//                 trailing: Icon(
//                   Icons.keyboard_arrow_right,
//                 ),
//                 title: Text('Tracking',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: height * 0.023,
//                       color: Color.fromRGBO(105, 105, 105, 1),
//                     )),
//                 onTap: () {
//                   navigationService.navigateTo(MapSampleRoute);
//                 },
//               ),

//               Padding(
//                 padding: EdgeInsets.only(left: 8, right: 8),
//                 child: Divider(
//                   color: Color.fromRGBO(222, 226, 234, 1),
//                   thickness: 1.5,
//                 ),
//               ),
//               // if (SelectAccount.selectAccount ==
//               //     SelectAccountEnum.Driver.toString()||)
//               userType == 'SelectAccountEnum.Driver'
//                   ? ListTile(
//                       dense: true,
//                       horizontalTitleGap: height * 0.01,
//                       trailing: Icon(
//                         Icons.keyboard_arrow_right,
//                       ),
//                       title: Text('Add Fruits',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w700,
//                             fontSize: height * 0.023,
//                             color: Color.fromRGBO(105, 105, 105, 1),
//                           )),
//                       onTap: () async {
//                         setState(() {
//                           isLoadingProgress = true;
//                         });
//                         await Provider.of<ProductsProvider>(context,
//                                 listen: false)
//                             .fetchAllProducts();

//                         setState(() {
//                           isLoadingProgress = false;
//                         });
//                         navigationService.navigateTo(AddFruitScreenRoute);
//                       },
//                     )
//                   : Container(),

//               //start .............................................

//               //end................................................

//               Padding(
//                 padding: EdgeInsets.only(left: 8, right: 8),
//                 child: Divider(
//                   color: Color.fromRGBO(222, 226, 234, 1),
//                   thickness: 1.5,
//                 ),
//               ),

//               ListTile(
//                 dense: true,
//                 horizontalTitleGap: height * 0.01,
//                 trailing: Icon(
//                   Icons.keyboard_arrow_right,
//                 ),
//                 title: Text('My Fruits',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: height * 0.023,
//                       color: Color.fromRGBO(105, 105, 105, 1),
//                     )),
//                 onTap: () {
//                   navigationService.navigateTo(MyFruitsScreenRoute);
//                 },
//               ),

//               Padding(
//                 padding: EdgeInsets.only(left: 8, right: 8),
//                 child: Divider(
//                   color: Color.fromRGBO(222, 226, 234, 1),
//                   thickness: 1.5,
//                 ),
//               ),

//               ListTile(
//                 dense: true,
//                 horizontalTitleGap: height * 0.01,
//                 trailing: Icon(
//                   Icons.keyboard_arrow_right,
//                 ),
//                 title: Text('Create Route',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: height * 0.023,
//                       color: Color.fromRGBO(105, 105, 105, 1),
//                     )),
//                 onTap: () {
//                   navigationService.navigateTo(CreateRouteFormScreenRoute);
//                 },
//               ),

//               Padding(
//                 padding: EdgeInsets.only(left: 8, right: 8),
//                 child: Divider(
//                   color: Color.fromRGBO(222, 226, 234, 1),
//                   thickness: 1.5,
//                 ),
//               ),

//               ListTile(
//                 dense: true,
//                 horizontalTitleGap: height * 0.01,
//                 trailing: Icon(
//                   Icons.keyboard_arrow_right,
//                 ),
//                 title: Text('Change Password',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: height * 0.023,
//                       color: Color.fromRGBO(105, 105, 105, 1),
//                     )),
//                 onTap: () {
//                   navigationService.navigateTo(ResetPasswordScreenRoute);
//                 },
//               ),

//               Padding(
//                 padding: EdgeInsets.only(left: 8, right: 8),
//                 child: Divider(
//                   color: Color.fromRGBO(222, 226, 234, 1),
//                   thickness: 1.5,
//                 ),
//               ),
//               ListTile(
//                 dense: true,
//                 horizontalTitleGap: height * 0.01,
//                 trailing: Icon(
//                   Icons.keyboard_arrow_right,
//                 ),
//                 title: Text('Change Language',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: height * 0.023,
//                       color: Color.fromRGBO(105, 105, 105, 1),
//                     )),
//                 onTap: () {
//                   navigationService.navigateTo(LanguagesScreenRoute);
//                   FocusScope.of(context).unfocus();
//                 },
//               ),

//               Padding(
//                 padding: EdgeInsets.only(left: 8, right: 8),
//                 child: Divider(
//                   color: Color.fromRGBO(222, 226, 234, 1),
//                   thickness: 1.5,
//                 ),
//               ),
//               // SizedBox(
//               //   height: 65,
//               // ),

//               ListTile(
//                 trailing: Icon(
//                   Icons.keyboard_arrow_right,
//                 ),
//                 dense: true,
//                 horizontalTitleGap: height * 0.01,
//                 leading: Icon(
//                   Icons.facebook,
//                 ),
//                 title: Text('Find us on Facebook',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: height * 0.023,
//                       color: Color.fromRGBO(105, 105, 105, 1),
//                     )),
//                 onTap: () {
//                   navigationService.navigateTo(FacebookWidgetRoute);
//                 },
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 8, right: 8),
//                 child: Divider(
//                   color: Color.fromRGBO(222, 226, 234, 1),
//                   thickness: 1.5,
//                 ),
//               ),
//               Container(
//                 // color: Colors.amber,
//                 height: SelectAccount.selectAccount !=
//                         SelectAccountEnum.Guest.toString()
//                     ? SelectAccount.selectAccount ==
//                             SelectAccountEnum.Driver.toString()
//                         ? MediaQuery.of(context).size.height * 0.2
//                         : MediaQuery.of(context).size.height * 0.28
//                     : MediaQuery.of(context).size.height * 0.428,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     ListTile(
//                       onTap: () {},
//                     ),
//                     InkWell(
//                       onTap: () async {
//                         setState(() {
//                           isLoadingProgress = true;
//                         });
//                         SelectAccount.selectAccount ==
//                                 SelectAccountEnum.Guest.toString()
//                             ? navigationService
//                                 .navigateTo(SelectAccountScreenRoute)
//                             : await Provider.of<VendorProvider>(context,
//                                     listen: false)
//                                 .logoutFirebaseVendor(context);

//                         setState(() {
//                           isLoadingProgress = false;
//                         });
//                         // navigationService.navigateTo(SelectAccountScreenRoute);
//                       },
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(
//                               left: 20,
//                               bottom: 5,
//                             ),
//                             width: MediaQuery.of(context).size.width / 8,
//                             decoration: BoxDecoration(
//                               // color: Colors.green,
//                               border: Border(
//                                 top: BorderSide(
//                                   color: Colors.black,
//                                   width: 1,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Icon(
//                                 Icons.logout,
//                                 color: Theme.of(context).accentColor,
//                                 size: 16,
//                               ),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Text(
//                                 'Logout',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10,
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//         if (isLoadingProgress)
//           Positioned.fill(
//             child: Align(
//               alignment: Alignment.center,
//               child:  Platform.isIOS?
          // CupertinoActivityIndicator():
          //  CircularProgressIndicator(),,
//             ),
//           ),
//       ]),
//     );
//   }
// }
