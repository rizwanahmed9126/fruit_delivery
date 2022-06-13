// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fruit_delivery_flutter/local/app_localization.dart';
// import 'package:fruit_delivery_flutter/models/my_fruits_model.dart';
// import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
// import 'package:fruit_delivery_flutter/services/navigation_service.dart';
// import 'package:fruit_delivery_flutter/utils/routes.dart';
// import 'package:fruit_delivery_flutter/utils/service_locator.dart';
// import 'package:fruit_delivery_flutter/widgets/my_fruits_item.dart';
// import 'package:provider/provider.dart';

// class MyFruitsScreen extends StatefulWidget {
//   MyFruitsScreen({Key? key}) : super(key: key);

//   @override
//   _MyFruitsScreenState createState() => _MyFruitsScreenState();
// }

// class _MyFruitsScreenState extends State<MyFruitsScreen> {
//   var vendorData;
//   var navigationService = locator<NavigationService>();

//   void active(var data) {
//     if (data)
//       setState(() {
//         vendorData =
//             Provider.of<VendorProvider>(context, listen: false).vendorData;
//       });
//     Navigator.of(context).pop();
//   }

//   @override
//   void initState() {
//     vendorData = Provider.of<VendorProvider>(context, listen: false).vendorData;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.init(
//         BoxConstraints(
//             maxWidth: MediaQuery.of(context).size.width,
//             maxHeight: MediaQuery.of(context).size.height),
//         designSize: Size(360, 690),
//         orientation: Orientation.portrait);
//     return WillPopScope(
//       onWillPop: () async {
//         navigationService.navigateTo(DriverHomeScreenRoute);
//         return false;
//       },
//       child: Scaffold(
//         // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//         // floatingActionButton: Container(
//         //   height: 45.h,
//         //   decoration: BoxDecoration(
//         //     color: Theme.of(context).accentColor,
//         //     borderRadius: BorderRadius.circular(10),
//         //     // shape: BoxShape.circle,
//         //   ),
//         //   margin: EdgeInsets.only(
//         //     left: 15,
//         //     right: 15,
//         //   ),
//         //   width: double.infinity,
//         //   child: FloatingActionButton(
//         //     // splashColor: Colors.transparent,
//         //     backgroundColor: Colors.transparent,
//         //     elevation: 0.0,
//         //     onPressed: () async {},
//         //     shape:
//         //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         //     child: Text(
//         //       "Submit ",
//         //       textAlign: TextAlign.center,
//         //       style: TextStyle(
//         //         fontSize: 14,
//         //         fontWeight: FontWeight.w600,
//         //         color: Colors.white,
//         //       ),
//         //     ),
//         //   ),
//         // ),
//         backgroundColor: Colors.white,
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(65),
//           child: AppBar(
//             backgroundColor: Colors.white,
//             leading: Padding(
//               padding: EdgeInsets.all(8.0.h),
//               child: GestureDetector(
//                 onTap: () {
//                   navigationService.navigateTo(DriverHomeScreenRoute);
//                 },
//                 child: Image.asset(
//                   'assets/images/ArrowBack.png',
//                   fit: BoxFit.fill,
//                   width: 10.h,
//                   height: 10.h,
//                 ),
//               ),
//             ),

//             centerTitle: true,

//             title: Image.asset(
//               'assets/images/logoleaf.png',
//               scale: 14,
//               // color: Colors.white,
//             ),
//             bottomOpacity: 0.0,
//             // backgroundColor: Theme.of(context).backgroundColor,
//             elevation: 0,
//             automaticallyImplyLeading: false,
//             // actions: [
//             //   Padding(
//             //     padding: EdgeInsets.only(left: 18.0.w, top: 3.h),
//             //     child: IconButton(
//             //       onPressed: () {
//             //         showDialog(
//             //             context: context,
//             //             builder: (BuildContext context) {
//             //               return MyFruitListPopup();
//             //             });
//             //       },
//             //       icon: Image.asset(
//             //         'assets/images/add_icon.png',
//             //         // width: 40.h,
//             //         // height: 40.h,
//             //       ),
//             //       iconSize: 35.h,
//             //     ),
//             //   )
//             // ],
//           ),
//         ),
//         body: Container(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                   height: 32,
//                   child: Text(
//                     AppLocalizations.of(context).translate('DrawerMyFruits'),
//                     // "   My Fruits",
//                     style:
//                         TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
//                   )),
//               Expanded(
//                   child: vendorData.products == null
//                       ? Center(
//                           child: Container(
//                             // height: MediaQuery.of(context).size.height * 0.02,
//                             width: MediaQuery.of(context).size.height * 0.4,
//                             child: Image.asset(
//                               "assets/images/Fruit-Basket.png",
//                               // fit: BoxFit.fill,
//                             ),
//                           ),
//                         )
//                       : Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Consumer<VendorProvider>(
//                               builder: (context, provider, child) {
//                             return ListView.builder(
//                                 itemCount:
//                                     provider.vendorData!.products!.length,
//                                 itemBuilder: (ctx, i) {
//                                   return MyFruitsItem(
//                                     data: provider.vendorData!.products![i],
//                                     active: active,
//                                   );
//                                 });
//                           }),
//                         )),
//               SizedBox(
//                 height: 50.h,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
