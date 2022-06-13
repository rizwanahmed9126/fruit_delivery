import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/constants/color_constants.dart';
import 'package:fruit_delivery_flutter/constants/select_account.dart';
import 'package:fruit_delivery_flutter/globals.dart';

import 'package:fruit_delivery_flutter/models/trip_routes_model.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/chat_provider.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/user_provider.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';

import 'package:fruit_delivery_flutter/screens/chache_image.dart';
import 'package:fruit_delivery_flutter/screens/chat_screen.dart';
import 'package:fruit_delivery_flutter/screens/driver_home_screen.dart';
import 'package:fruit_delivery_flutter/screens/notification_screen.dart';
import 'package:fruit_delivery_flutter/services/navigation_service.dart';
import 'package:fruit_delivery_flutter/services/storage_service.dart';
import 'package:fruit_delivery_flutter/utils/routes.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';
import 'package:fruit_delivery_flutter/widgets/enums.dart';
import 'package:fruit_delivery_flutter/widgets/trip_detail_stops_widget.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

// ignore: must_be_immutable
class TripDetailScreen extends StatefulWidget {
  var navigationService = locator<NavigationService>();

  @override
  _TripDetailScreenState createState() => _TripDetailScreenState();
}

enum timeLine {
  past,
  present,
  future,
}

class _TripDetailScreenState extends State<TripDetailScreen> {
  DateTime txdate = DateTime.now();
  StorageService? storageService = locator<StorageService>();
  final DateFormat startformatterMonth = DateFormat.yMMMd('en_US');
  var vendorData;
  //dynamic routeData = [];
  var member = {};
  bool isLoading = false;
  List<Placemark>? fromAddress;
  void initState() {
    // fetchDetail();
    // getAddress();
    // getAddress();
    super.initState();
  }

  getMember(Map<String, dynamic> chatMessage, BuildContext context) {
    //getMember detail from chatMessage gorup
    if (SelectAccount.selectAccount == SelectAccountEnum.User.toString()) {
      Map<String, dynamic> members = chatMessage['members'];
      members.forEach((key, value) {
        if (key != context.read<UserProvider>().userData.id) {
          member = value;
        }
      });
    } else if (SelectAccount.selectAccount ==
        SelectAccountEnum.Driver.toString()) {
      Map<String, dynamic> members = chatMessage['members'];
      members.forEach((key, value) {
        if (key != context.read<VendorProvider>().vendorData!.id) {
          member = value;
        }
      });
    } else {
      Map<String, dynamic> members = chatMessage['members'];
      members.forEach((key, value) {
        if (key != context.read<VendorProvider>().vendorData!.id) {
          member = value;
        }
      });
    }

    print(member);
  }

  // fetchDetail() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   await Provider.of<UserProvider>(context, listen: false)
  //       .fetchVendorsRoutebyId();

  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  var navigationService = locator<NavigationService>();
  int count = 0;
  // var _token;

  // getAddress() async {
  //   this._token = await storageService!
  //       .setData(StorageKeys.token.toString(), this._token);
  // }

  @override
  Widget build(BuildContext context) {
    //routeData = Provider.of<UserProvider>(context, listen: false).vendersData;
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          leadingWidth: 60.w,
          leading: Padding(
            padding: EdgeInsets.only(left: 18.0.w, top: 3.h),
            child: GestureDetector(
                onTap: () {
                  // navigationService.navigateTo(TripScreenRoute);
                  navigationService.closeScreen();
                },
                child: Image.asset(
                  'assets/images/ArrowBack.png',
                  width: 35.h,
                  height: 35.h,
                )),
          ),
          title: Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: GestureDetector(
                onTap: () {},
                child: Image.asset(
                  'assets/images/logoleaf.png',
                  scale: 14,
                )),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(top: 3.0.h, right: 12.w),
              child:
                  // Stack(
                  // children: [
                  GestureDetector(
                      onTap: () {
                        navigationService.navigateTo(NotificationScreenRoute);
                      },
                      child: Image.asset(
                        'assets/images/notification.png',
                        width: 35.h,
                        height: 35.h,
                      )),
              // Positioned(
              //     right: 0.0,
              //     child: Container(
              //       height: 15.h,
              //       width: 15.h,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(6),
              //           color: Color(0xfff89f6f)),
              //       child: Center(
              //           child: Text(
              //         '9+',
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 12.0.sp,
              //             fontWeight: FontWeight.w700),
              //       )),
              //     )),
              // ],
              // ),
            ),
          ],
        ),
        body: Consumer<UserProvider>(
          builder: (context, index, _) {
            return isLoading == false
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 15.0.h,
                          right: 18.0.w,
                          left: 18.0.w,
                          bottom: 15.0.h,
                        ),
                        child: Text(
                          'Trip Detail Page',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                        child: Row(
                          children: [
                            // ClipRRect(
                            //   borderRadius: BorderRadius.circular(12),
                            //   child: Image.asset(
                            //     'assets/images/Person.png',
                            //     height: 55.h,
                            //     width: 55.w,
                            //   ),
                            // ),
                            // if (vendorData != null)
                            //   vendorData.profilePicture == null ||
                            //           vendorData.profilePicture == ""
                            //       ? ClipRRect(
                            //           child: Image.asset(
                            //             "assets/images/place_holder.png",
                            //             height: 55.h,
                            //             width: 55.w,
                            //           ),
                            //         )
                            //       :
                            ClipRRect(
                              child: CacheImage(
                                imageUrl:
                                    "https://firebasestorage.googleapis.com/v0/b/guanabanas-y-mas.appspot.com/o/profileimages%2F${index.routeIdData[0].id}?alt=media&token=b94cc404-b405-46c8-9e99-fb80d37371c0",

                                // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSv35iRbziWD4nZ9LCeEmadoORUPnmL4dpOnQ&usqp=CAU",
                                height: 55.h,
                                width: 55.w,
                                radius: 10.h,
                              ),
                            ),
                            SizedBox(
                              width: 15.0.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  // "Driver Name",
                                  index.routeIdData[0].fullName.toString()
                                  // vendorData.fullName,
                                  ,
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'Driver',
                                  style: TextStyle(
                                    color: iconColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () async {
                                // var storageService =
                                //     locator<StorageService>();
                                // await storageService.setData(
                                //     "route", "/trip_detail_screen");

                                // navigationService.navigateTo(ChatScreenRoute);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 7,
                                        spreadRadius: 0,
                                        offset: Offset(0, 5),
                                      )
                                    ]),
                                child: GestureDetector(
                                  onTap: () async {
                                    showLoadingAnimation(context);
                                    // inChat = true;
                                    await context
                                        .read<ChatProvider>()
                                        .createChatRoom(
                                          senderUser: context
                                              .read<UserProvider>()
                                              .userData
                                              .id,
                                          receiverUser: index.routeIdData[0]
                                              .id, //dummy driver id || will be changed later.
                                          recieverName:
                                              index.routeIdData[0].fullName,

                                          context: context,
                                        );
                                    print(
                                        "driver id: ${index.routeIdData[0].id}");
                                    context.read<ChatProvider>().receverId =
                                        index.routeIdData[0].id!;
                                    context.read<ChatProvider>().senderId =
                                        context
                                            .read<UserProvider>()
                                            .userData
                                            .id!;
                                    await context
                                        .read<ChatProvider>()
                                        .getChatRoomId()
                                        .then((value) => print(
                                            "chat room id: ${context.read<ChatProvider>().chatRoomId}"));
                                    await context
                                        .read<ChatProvider>()
                                        .createChatRoom(
                                          senderUser: context
                                              .read<UserProvider>()
                                              .userData
                                              .id,
                                          receiverUser: index.routeIdData[0]
                                              .id, //dummy driver id || will be changed later.
                                          recieverName:
                                              index.routeIdData[0].fullName,
                                          

                                          context: context,
                                        );
                                    print(
                                        "driver id: ${index.routeIdData[0].id}");
                                    context.read<ChatProvider>().receverId =
                                        index.routeIdData[0].id!;
                                    context.read<ChatProvider>().senderId =
                                        context
                                            .read<UserProvider>()
                                            .userData
                                            .id!;
                                    await context
                                        .read<ChatProvider>()
                                        .getChatRoomId();
                                    navigationService.closeScreen();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext ctx) =>
                                            ChatScreen(
                                          memberProfile:
                                              'https://firebasestorage.googleapis.com/v0/b/guanabanas-y-mas.appspot.com/o/profileimages%2F${index.routeIdData[0].id}?alt=media&token=b94cc404-b405-46c8-9e99-fb80d37371c0',
                                          memberName: index
                                              .routeIdData[0].fullName
                                              .toString(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Chip(
                                      avatar: Image.asset(
                                        'assets/images/chatIcon.png',
                                        height: 14.h,
                                        width: 14.h,
                                      ),
                                      label: Text(
                                        'Chat',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      labelPadding: EdgeInsets.only(right: 6.w),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 7.5.w, vertical: 2.h),
                                      backgroundColor: baseColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 18.0.h, right: 18.0.h, top: 12.0.h),
                        child: Divider(
                          height: 10,
                        ),
                      ),
                      Expanded(
                          child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18.0.w, vertical: 8.0.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Available Fruits Item",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                // GestureDetector(
                                //     onTap: () {
                                //       navigationService
                                //           .navigateTo(SearchProductScreenRoute);
                                //     },
                                //     child: Container(
                                //         padding: EdgeInsets.symmetric(
                                //             horizontal: 12.w, vertical: 5.h),
                                //         decoration: BoxDecoration(
                                //             borderRadius:
                                //                 BorderRadius.circular(20.r),
                                //             border: Border.all(
                                //                 width: 1.5.h, color: iconColor)),
                                //         child: Text('View All',
                                //             style: TextStyle(
                                //                 color: iconColor,
                                //                 fontWeight: FontWeight.w600,
                                //                 fontSize: 12.sp)))
                                //                 )
                              ],
                            ),
                          ),
                          Container(
                            height: 210.h,
                            width: 160.w,
                            child: ListView.builder(
                                padding: EdgeInsets.only(
                                    left: 18.w, top: 10.h, bottom: 14.h),
                                shrinkWrap: true,
                                itemCount: index.routeIdData[0]
                                    .activeRoute!["products"].length,
                                // 4,
                                //  routeData[0].products.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, i) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      // color: Color.fromRGBO(254, 245, 236, 1),
                                      color: index.routeIdData[0]
                                                      .activeRoute!["products"]
                                                  [i]["backgroundColor"] ==
                                              "orange"
                                          ? Color.fromRGBO(254, 245, 236, 1)
                                          : index.routeIdData[0].activeRoute!["products"]
                                                      [i]["backgroundColor"] ==
                                                  " yellow"
                                              ? Color.fromRGBO(254, 248, 216, 1)
                                              : index.routeIdData[0].activeRoute!["products"][i]
                                                          ["backgroundColor"] ==
                                                      "green"
                                                  ? Color.fromRGBO(
                                                      238, 245, 227, 1)
                                                  : index.routeIdData[0].activeRoute!["products"]
                                                                  [i]
                                                              ["backgroundColor"] ==
                                                          "red"
                                                      ? Color.fromRGBO(248, 232, 232, 1)
                                                      : index.routeIdData[0].activeRoute!["products"][i]["backgroundColor"] == "peach"
                                                          ? Color.fromRGBO(254, 241, 230, 1)
                                                          : index.routeIdData[0].activeRoute!["products"][i]["backgroundColor"] == "darkgreen"
                                                              ? Color.fromRGBO(235, 241, 232, 1)
                                                              : Color.fromRGBO(254, 241, 230, 1),
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                    ),
                                    height: 190.h,
                                    width: 145.w,
                                    margin: EdgeInsets.only(right: 12.w),
                                    padding: EdgeInsets.all(15.w),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Center(
                                              child: Image.network(index
                                                      .routeIdData[0]
                                                      .activeRoute!["products"]
                                                  [i]["picture"]),
                                            ),
                                          ),
                                          SizedBox(height: 18.h),
                                          Text(
                                            index.routeIdData[0]
                                                    .activeRoute!["products"][i]
                                                ["name"],
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          Text(
                                            index.routeIdData[0]
                                                    .activeRoute!["products"][i]
                                                ["unit"],
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          Text(
                                            "\$ " +
                                                index.routeIdData[0]
                                                        .activeRoute![
                                                    "products"][i]["price"],

                                            // "\$ " + routeData[0].products![i].price!,

                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ]),
                                  );
                                }),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18.0.sp, vertical: 18.0.sp),
                            child: Text(
                              "Trip Route Plan",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.0.sp),
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: index.routeIdData[0]
                                    .activeRoute!["stops"].length,
                                // routeData.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, i) {
                                  // for (int j = 0;
                                  //     j <
                                  //         index.routeIdData[0]
                                  //             .activeRoute!["stops"].length;
                                  //     j++) {
                                  //   if (i > j) {
                                  //     if (index.routeIdData[0]
                                  //                 .activeRoute!["stops"][j + 1]
                                  //             ["isActive"] ==
                                  //         true) {
                                  //       if (j > 0) {
                                  //         index.routeIdData[0]
                                  //                 .activeRoute!["stops"][j - 1]
                                  //             ["isActive"] = true;
                                  //       } else {
                                  //         index.routeIdData[0]
                                  //                 .activeRoute!["stops"][j]
                                  //             ["isActive"] = true;
                                  //       }
                                  //     }
                                  //   }
                                  // }
                                  return TripDetailStopsWidget(
                                      data: index.routeIdData[0], i: i);
                                }),
                          )
                        ],
                      )),
                    ],
                  )
                : Center(
                    child: Platform.isIOS
                        ? CupertinoActivityIndicator()
                        : CircularProgressIndicator(),
                  );
          },
        ));
  }
}

/* 
// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fruit_delivery_flutter/constants/color_constants.dart';
// import 'package:fruit_delivery_flutter/constants/select_account.dart';
// import 'package:fruit_delivery_flutter/globals.dart';

// import 'package:fruit_delivery_flutter/models/trip_routes_model.dart';
// import 'package:fruit_delivery_flutter/providers/auth_providers/chat_provider.dart';
// import 'package:fruit_delivery_flutter/providers/auth_providers/user_provider.dart';
// import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';

// import 'package:fruit_delivery_flutter/screens/chache_image.dart';
// import 'package:fruit_delivery_flutter/screens/chat_screen.dart';
// import 'package:fruit_delivery_flutter/screens/driver_home_screen.dart';
// import 'package:fruit_delivery_flutter/services/navigation_service.dart';
// import 'package:fruit_delivery_flutter/services/storage_service.dart';
// import 'package:fruit_delivery_flutter/utils/routes.dart';
// import 'package:fruit_delivery_flutter/utils/service_locator.dart';
// import 'package:fruit_delivery_flutter/widgets/enums.dart';
// import 'package:fruit_delivery_flutter/widgets/trip_detail_stops_widget.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:timeline_tile/timeline_tile.dart';

// // ignore: must_be_immutable
// class TripDetailScreen extends StatefulWidget {
//   var navigationService = locator<NavigationService>();

//   @override
//   _TripDetailScreenState createState() => _TripDetailScreenState();
// }

// enum timeLine {
//   past,
//   present,
//   future,
// }

// class _TripDetailScreenState extends State<TripDetailScreen> {
//   DateTime txdate = DateTime.now();
//   StorageService? storageService = locator<StorageService>();
//   final DateFormat startformatterMonth = DateFormat.yMMMd('en_US');
//   var vendorData;
//   //dynamic routeData = [];
//   var member = {};
//   bool isLoading = false;
//   List<Placemark>? fromAddress;
//   void initState() {
//     // fetchDetail();

//     // getAddress();
//     super.initState();
//   }

//   getMember(Map<String, dynamic> chatMessage, BuildContext context) {
//     //getMember detail from chatMessage gorup
//     if (SelectAccount.selectAccount == SelectAccountEnum.User.toString()) {
//       Map<String, dynamic> members = chatMessage['members'];
//       members.forEach((key, value) {
//         if (key != context.read<UserProvider>().userData.id) {
//           member = value;
//         }
//       });
//     } else if (SelectAccount.selectAccount ==
//         SelectAccountEnum.Driver.toString()) {
//       Map<String, dynamic> members = chatMessage['members'];
//       members.forEach((key, value) {
//         if (key != context.read<VendorProvider>().vendorData!.id) {
//           member = value;
//         }
//       });
//     } else {
//       Map<String, dynamic> members = chatMessage['members'];
//       members.forEach((key, value) {
//         if (key != context.read<UserProvider>().userData.id) {
//           member = value;
//         }
//       });
//     }

//     print(member);
//   }

//   // fetchDetail() async {
//   //   setState(() {
//   //     isLoading = true;
//   //   });
//   //   await Provider.of<UserProvider>(context, listen: false)
//   //       .fetchVendorsRoutebyId();

//   //   setState(() {
//   //     isLoading = false;
//   //   });
//   // }

//   var navigationService = locator<NavigationService>();
//   int count = 0;
//   var _token;

//   getAddress() async {
//     this._token = await storageService!
//         .setData(StorageKeys.token.toString(), this._token);
//   }

//   @override
//   Widget build(BuildContext context) {
//     //routeData = Provider.of<UserProvider>(context, listen: false).vendersData;
//     ScreenUtil.init(
//         BoxConstraints(
//             maxWidth: MediaQuery.of(context).size.width,
//             maxHeight: MediaQuery.of(context).size.height),
//         designSize: Size(360, 690),
//         orientation: Orientation.portrait);

//     return SafeArea(
//       child: Scaffold(
//           backgroundColor: Colors.white,
//           appBar: AppBar(
//             backgroundColor: Colors.transparent,
//             elevation: 0.0,
//             centerTitle: true,
//             leadingWidth: 60.w,
//             leading: Padding(
//               padding: EdgeInsets.only(left: 18.0.w, top: 3.h),
//               child: GestureDetector(
//                   onTap: () {
//                     navigationService.navigateTo(TripScreenRoute);
//                   },
//                   child: Image.asset(
//                     'assets/images/ArrowBack.png',
//                     width: 35.h,
//                     height: 35.h,
//                   )),
//             ),
//             title: Padding(
//               padding: EdgeInsets.only(top: 4.h),
//               child: GestureDetector(
//                   onTap: () {},
//                   child: Image.asset(
//                     'assets/images/logoleaf.png',
//                     scale: 14,
//                   )),
//             ),
//             actions: [
//               Padding(
//                 padding: EdgeInsets.only(top: 4.0.h, right: 18.w),
//                 child: Stack(
//                   children: [
//                     GestureDetector(
//                         onTap: () {},
//                         child: Padding(
//                           padding: EdgeInsets.only(top: 4.0.h, right: 4.0.h),
//                           child: Image.asset(
//                             'assets/images/notification.png',
//                             width: 35.h,
//                             height: 35.h,
//                           ),
//                         )),
//                     Positioned(
//                         right: 0.0,
//                         child: Container(
//                           height: 15.h,
//                           width: 15.h,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(6),
//                               color: Color(0xfff89f6f)),
//                           child: Center(
//                               child: Text(
//                             '9+',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12.0.sp,
//                                 fontWeight: FontWeight.w700),
//                           )),
//                         )),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           body: Consumer<UserProvider>(
//             builder: (context, index, _) {
//               return isLoading == false
//                   ? Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(
//                             top: 15.0.h,
//                             right: 18.0.w,
//                             left: 18.0.w,
//                             bottom: 15.0.h,
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 18.0.w),
//                           child: Row(
//                             children: [
//                               // ClipRRect(
//                               //   borderRadius: BorderRadius.circular(12),
//                               //   child: Image.asset(
//                               //     'assets/images/Person.png',
//                               //     height: 55.h,
//                               //     width: 55.w,
//                               //   ),
//                               // ),
//                               // if (vendorData != null)
//                               //   vendorData.profilePicture == null ||
//                               //           vendorData.profilePicture == ""
//                               //       ? ClipRRect(
//                               //           child: Image.asset(
//                               //             "assets/images/place_holder.png",
//                               //             height: 55.h,
//                               //             width: 55.w,
//                               //           ),
//                               //         )
//                               //       :
//                               ClipRRect(
//                                 child: CacheImage(
//                                   imageUrl:
//                                       "https://firebasestorage.googleapis.com/v0/b/guanabanas-y-mas.appspot.com/o/profileimages%/${index.routeIdData[0].id}?alt=media&token=b94cc404-b405-46c8-9e99-fb80d37371c0",
//                                   height: 55.h,
//                                   width: 55.w,
//                                   radius: 10.h,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 15.0.w,
//                               ),

//                               Padding(
//                                 padding:
//                                     EdgeInsets.symmetric(horizontal: 18.0.w),
//                                 child: Row(
//                                   children: [
//                                     // ClipRRect(
//                                     //   borderRadius: BorderRadius.circular(12),
//                                     //   child: Image.asset(
//                                     //     'assets/images/Person.png',
//                                     //     height: 55.h,
//                                     //     width: 55.w,
//                                     //   ),
//                                     // ),
//                                     // if (vendorData != null)
//                                     //   vendorData.profilePicture == null ||
//                                     //           vendorData.profilePicture == ""
//                                     //       ? ClipRRect(
//                                     //           child: Image.asset(
//                                     //             "assets/images/place_holder.png",
//                                     //             height: 55.h,
//                                     //             width: 55.w,
//                                     //           ),
//                                     //         )
//                                     //       :
//                                     ClipRRect(
//                                       child: CacheImage(
//                                         imageUrl:
//                                             "https://firebasestorage.googleapis.com/v0/b/guanabanas-y-mas.appspot.com/o/profileimages%/${index.routeIdData[0].id}?alt=media&token=$_token",
//                                         // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSv35iRbziWD4nZ9LCeEmadoORUPnmL4dpOnQ&usqp=CAU",
//                                         height: 55.h,
//                                         width: 55.w,
//                                         radius: 10.h,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 15.0.w,
//                                     ),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           // "Driver Name",
//                                           index.routeIdData[0].fullName
//                                               .toString()
//                                           // vendorData.fullName,
//                                           ,
//                                           style: TextStyle(
//                                             fontSize: 17.sp,
//                                             fontWeight: FontWeight.w700,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Spacer(),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(100),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: Colors.grey.shade300,
//                                               blurRadius: 7,
//                                               spreadRadius: 0,
//                                               offset: Offset(0, 5),
//                                             )
//                                           ]),
//                                       child: GestureDetector(
//                                         onTap: () async {
//                                           showLoadingAnimation(context);
//                                           await context
//                                               .read<ChatProvider>()
//                                               .createChatRoom(
//                                                 senderUser: context
//                                                     .read<UserProvider>()
//                                                     .userData
//                                                     .id,
//                                                 receiverUser: index
//                                                     .routeIdData[0]
//                                                     .id, //dummy driver id || will be changed later.
//                                                 context: context,
//                                               );
//                                           context
//                                                   .read<ChatProvider>()
//                                                   .receverId =
//                                               index.routeIdData[0].id!;
//                                           context
//                                                   .read<ChatProvider>()
//                                                   .senderId =
//                                               context
//                                                   .read<UserProvider>()
//                                                   .userData
//                                                   .id!;
//                                           await context
//                                               .read<ChatProvider>()
//                                               .getChatRoomId()
//                                               .then((value) => print(
//                                                   "chat room id: ${context.read<ChatProvider>().chatRoomId}"));

//                                           navigationService.closeScreen();
//                                           Navigator.of(context).push(
//                                             MaterialPageRoute(
//                                               builder: (BuildContext ctx) =>
//                                                   ChatScreen(
//                                                 memberProfile:
//                                                     "https://firebasestorage.googleapis.com/v0/b/guanabanas-y-mas.appspot.com/o/profileimages%/${index.routeIdData[0].id}?alt=media&token=b94cc404-b405-46c8-9e99-fb80d37371c0",
//                                                 memberName: index
//                                                     .routeIdData[0].fullName!,
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                         child: Chip(
//                                             avatar: Image.asset(
//                                               'assets/images/chatIcon.png',
//                                               height: 14.h,
//                                               width: 14.h,
//                                             ),
//                                             label: Text(
//                                               'Chat',
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.w600),
//                                             ),
//                                             labelPadding:
//                                                 EdgeInsets.only(right: 6.w),
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: 7.5.w,
//                                                 vertical: 2.h),
//                                             backgroundColor: baseColor),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     left: 18.0.h, right: 18.0.h, top: 12.0.h),
//                                 child: Divider(
//                                   height: 10,
//                                 ),
//                               ),
//                               Expanded(
//                                   child: ListView(
//                                 padding: EdgeInsets.zero,
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 18.0.w, vertical: 8.0.h),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           "Available Fruits Item",
//                                           style: TextStyle(
//                                             fontSize: 18.sp,
//                                             fontWeight: FontWeight.w600,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                         // GestureDetector(
//                                         //     onTap: () {
//                                         //       navigationService
//                                         //           .navigateTo(SearchProductScreenRoute);
//                                         //     },
//                                         //     child: Container(
//                                         //         padding: EdgeInsets.symmetric(
//                                         //             horizontal: 12.w, vertical: 5.h),
//                                         //         decoration: BoxDecoration(
//                                         //             borderRadius:
//                                         //                 BorderRadius.circular(20.r),
//                                         //             border: Border.all(
//                                         //                 width: 1.5.h, color: iconColor)),
//                                         //         child: Text('View All',
//                                         //             style: TextStyle(
//                                         //                 color: iconColor,
//                                         //                 fontWeight: FontWeight.w600,
//                                         //                 fontSize: 12.sp)))
//                                         //                 )
//                                       ],
//                                     ),
//                                   ),
//                                   Container(
//                                     height: 210.h,
//                                     width: 160.w,
//                                     child: ListView.builder(
//                                         padding: EdgeInsets.only(
//                                             left: 18.w,
//                                             top: 10.h,
//                                             bottom: 14.h),
//                                         shrinkWrap: true,
//                                         itemCount: index.routeIdData[0]
//                                             .activeRoute!["products"].length,
//                                         // 4,
//                                         //  routeData[0].products.length,
//                                         scrollDirection: Axis.horizontal,
//                                         itemBuilder: (context, i) {
//                                           return Container(
//                                             decoration: BoxDecoration(
//                                               // color: Color.fromRGBO(254, 245, 236, 1),
//                                               color: index.routeIdData[0]
//                                                               .activeRoute!["products"][i]
//                                                           ["backgroundColor"] ==
//                                                       "orange"
//                                                   ? Color.fromRGBO(
//                                                       254, 245, 236, 1)
//                                                   : index.routeIdData[0].activeRoute!["products"]
//                                                                   [i][
//                                                               "backgroundColor"] ==
//                                                           " yellow"
//                                                       ? Color.fromRGBO(
//                                                           254, 248, 216, 1)
//                                                       : index.routeIdData[0].activeRoute!["products"][i]
//                                                                   ["backgroundColor"] ==
//                                                               "green"
//                                                           ? Color.fromRGBO(238, 245, 227, 1)
//                                                           : index.routeIdData[0].activeRoute!["products"][i]["backgroundColor"] == "red"
//                                                               ? Color.fromRGBO(248, 232, 232, 1)
//                                                               : index.routeIdData[0].activeRoute!["products"][i]["backgroundColor"] == "peach"
//                                                                   ? Color.fromRGBO(254, 241, 230, 1)
//                                                                   : index.routeIdData[0].activeRoute!["products"][i]["backgroundColor"] == "darkgreen"
//                                                                       ? Color.fromRGBO(235, 241, 232, 1)
//                                                                       : Color.fromRGBO(254, 241, 230, 1),
//                                               borderRadius:
//                                                   BorderRadius.circular(
//                                                 10,
//                                               ),
//                                             ),
//                                             height: 190.h,
//                                             width: 145.w,
//                                             margin:
//                                                 EdgeInsets.only(right: 12.w),
//                                             padding: EdgeInsets.all(15.w),
//                                             child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Expanded(
//                                                     child: Center(
//                                                       child: Image.network(index
//                                                                   .routeIdData[0]
//                                                                   .activeRoute![
//                                                               "products"][i]
//                                                           ["picture"]),
//                                                     ),
//                                                   ),
//                                                   SizedBox(height: 18.h),
//                                                   Text(
//                                                     index.routeIdData[0]
//                                                             .activeRoute![
//                                                         "products"][i]["name"],
//                                                     style: TextStyle(
//                                                       fontSize: 18.sp,
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                       color: Colors.black,
//                                                     ),
//                                                   ),
//                                                   SizedBox(height: 8.h),
//                                                   Text(
//                                                     index.routeIdData[0]
//                                                             .activeRoute![
//                                                         "products"][i]["unit"],
//                                                     style: TextStyle(
//                                                       fontSize: 11.sp,
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                       color: Colors.grey,
//                                                     ),
//                                                   ),
//                                                   SizedBox(height: 8.h),
//                                                   Text(
//                                                     "\$ " +
//                                                         index.routeIdData[0]
//                                                                     .activeRoute![
//                                                                 "products"][i]
//                                                             ["price"],

//                                                     // "\$ " + routeData[0].products![i].price!,

//                                                     style: TextStyle(
//                                                       fontSize: 12.sp,
//                                                       fontWeight:
//                                                           FontWeight.w700,
//                                                       color: Colors.black,
//                                                     ),
//                                                   ),
//                                                 ]),
//                                           );
//                                         }),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 18.0.sp, vertical: 18.0.sp),
//                                     child: Text(
//                                       "Trip Route Plan",
//                                       style: TextStyle(
//                                         fontSize: 18.sp,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 18.0.sp),
//                                     child: ListView.builder(
//                                         padding: EdgeInsets.zero,
//                                         itemCount: index.routeIdData[0]
//                                             .activeRoute!["stops"].length,
//                                         // routeData.length,
//                                         shrinkWrap: true,
//                                         physics: NeverScrollableScrollPhysics(),
//                                         itemBuilder: (context, i) {
//                                           // for (int j = 0;
//                                           //     j <
//                                           //         index.routeIdData[0]
//                                           //             .activeRoute!["stops"].length;
//                                           //     j++) {
//                                           //   if (i > j) {
//                                           //     if (index.routeIdData[0]
//                                           //                 .activeRoute!["stops"][j + 1]
//                                           //             ["isActive"] ==
//                                           //         true) {
//                                           //       if (j > 0) {
//                                           //         index.routeIdData[0]
//                                           //                 .activeRoute!["stops"][j - 1]
//                                           //             ["isActive"] = true;
//                                           //       } else {
//                                           //         index.routeIdData[0]
//                                           //                 .activeRoute!["stops"][j]
//                                           //             ["isActive"] = true;
//                                           //       }
//                                           //     }
//                                           //   }
//                                           // }
//                                           return TripDetailStopsWidget(
//                                               data: index.routeIdData[0], i: i);
//                                         }),
//                                   )
//                                 ],
//                               )),
//                             ],
//                           ),
//                         ),
//                       ],
//                     )
//                   : Center(
//                       child: Platform.isIOS
//                           ? CupertinoActivityIndicator()
//                           : CircularProgressIndicator(),
//                     );
//             },
//           )),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/constants/color_constants.dart';
import 'package:fruit_delivery_flutter/constants/select_account.dart';
import 'package:fruit_delivery_flutter/globals.dart';

import 'package:fruit_delivery_flutter/models/trip_routes_model.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/chat_provider.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/user_provider.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';

import 'package:fruit_delivery_flutter/screens/chache_image.dart';
import 'package:fruit_delivery_flutter/screens/chat_screen.dart';
import 'package:fruit_delivery_flutter/screens/driver_home_screen.dart';
import 'package:fruit_delivery_flutter/services/navigation_service.dart';
import 'package:fruit_delivery_flutter/services/storage_service.dart';
import 'package:fruit_delivery_flutter/utils/routes.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';
import 'package:fruit_delivery_flutter/widgets/enums.dart';
import 'package:fruit_delivery_flutter/widgets/trip_detail_stops_widget.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

// ignore: must_be_immutable
class TripDetailScreen extends StatefulWidget {
  var navigationService = locator<NavigationService>();

  @override
  _TripDetailScreenState createState() => _TripDetailScreenState();
}

enum timeLine {
  past,
  present,
  future,
}

class _TripDetailScreenState extends State<TripDetailScreen> {
  DateTime txdate = DateTime.now();
  StorageService? storageService = locator<StorageService>();
  final DateFormat startformatterMonth = DateFormat.yMMMd('en_US');
  var vendorData;
  //dynamic routeData = [];
  var member = {};
  bool isLoading = false;
  List<Placemark>? fromAddress;
  void initState() {
    // fetchDetail();

    // getAddress();
    super.initState();
  }

  getMember(Map<String, dynamic> chatMessage, BuildContext context) {
    //getMember detail from chatMessage gorup
    if (SelectAccount.selectAccount == SelectAccountEnum.User.toString()) {
      Map<String, dynamic> members = chatMessage['members'];
      members.forEach((key, value) {
        if (key != context.read<UserProvider>().userData.id) {
          member = value;
        }
      });
    } else if (SelectAccount.selectAccount ==
        SelectAccountEnum.Driver.toString()) {
      Map<String, dynamic> members = chatMessage['members'];
      members.forEach((key, value) {
        if (key != context.read<VendorProvider>().vendorData!.id) {
          member = value;
        }
      });
    } else {
      Map<String, dynamic> members = chatMessage['members'];
      members.forEach((key, value) {
        if (key != context.read<VendorProvider>().vendorData!.id) {
          member = value;
        }
      });
    }

    print(member);
  }

  // fetchDetail() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   await Provider.of<UserProvider>(context, listen: false)
  //       .fetchVendorsRoutebyId();

  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  var navigationService = locator<NavigationService>();
  int count = 0;
  var _token;

  getAddress() async {
    this._token = await storageService!
        .setData(StorageKeys.token.toString(), this._token);
  }

  @override
  Widget build(BuildContext context) {
    //routeData = Provider.of<UserProvider>(context, listen: false).vendersData;
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            leadingWidth: 60.w,
            leading: Padding(
              padding: EdgeInsets.only(left: 18.0.w, top: 3.h),
              child: GestureDetector(
                  onTap: () {
                    navigationService.navigateTo(TripScreenRoute);
                  },
                  child: Image.asset(
                    'assets/images/ArrowBack.png',
                    width: 35.h,
                    height: 35.h,
                  )),
            ),
            title: Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    'assets/images/logoleaf.png',
                    scale: 14,
                  )),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(top: 4.0.h, right: 18.w),
                child: Stack(
                  children: [
                    GestureDetector(
                        onTap: () {
                          navigationService.navigateTo(NotificationScreenRoute);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 4.0.h, right: 4.0.h),
                          child: Image.asset(
                            'assets/images/notification.png',
                            width: 35.h,
                            height: 35.h,
                          ),
                        )),
                    Positioned(
                        right: 0.0,
                        child: Container(
                          height: 15.h,
                          width: 15.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color(0xfff89f6f)),
                          child: Center(
                              child: Text(
                            '9+',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0.sp,
                                fontWeight: FontWeight.w700),
                          )),
                        )),
                  ],
                ),
              ),
            ],
          ),
          body: Consumer<UserProvider>(
            builder: (context, index, _) {
              return isLoading == false
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 15.0.h,
                            right: 18.0.w,
                            left: 18.0.w,
                            bottom: 15.0.h,
                          ),
                          child: Text(
                            'Trip Detail Page',
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                          child: Row(
                            children: [
                              // ClipRRect(
                              //   borderRadius: BorderRadius.circular(12),
                              //   child: Image.asset(
                              //     'assets/images/Person.png',
                              //     height: 55.h,
                              //     width: 55.w,
                              //   ),
                              // ),
                              // if (vendorData != null)
                              //   vendorData.profilePicture == null ||
                              //           vendorData.profilePicture == ""
                              //       ? ClipRRect(
                              //           child: Image.asset(
                              //             "assets/images/place_holder.png",
                              //             height: 55.h,
                              //             width: 55.w,
                              //           ),
                              //         )
                              //       :
                              ClipRRect(
                                child: CacheImage(
                                  imageUrl:
                                      "https://firebasestorage.googleapis.com/v0/b/guanabanas-y-mas.appspot.com/o/profileimages%/${index.routeIdData[0].id}?alt=media&token=$_token",
                                  // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSv35iRbziWD4nZ9LCeEmadoORUPnmL4dpOnQ&usqp=CAU",
                                  height: 55.h,
                                  width: 55.w,
                                  radius: 10.h,
                                ),
                              ),
                              SizedBox(
                                width: 15.0.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    // "Driver Name",
                                    index.routeIdData[0].fullName.toString()
                                    // vendorData.fullName,
                                    ,
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    'Driver',
                                    style: TextStyle(
                                      color: iconColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () async {
                                  var storageService =
                                      locator<StorageService>();
                                  await storageService.setData(
                                      "route", "/trip_detail_screen");

                                  navigationService.navigateTo(ChatScreenRoute);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300,
                                          blurRadius: 7,
                                          spreadRadius: 0,
                                          offset: Offset(0, 5),
                                        )
                                      ]),
                                  child: GestureDetector(
                                    onTap: () async {
                                      showLoadingAnimation(context);
                                      await context
                                          .read<ChatProvider>()
                                          .createChatRoom(
                                            senderUser: context
                                                .read<UserProvider>()
                                                .userData
                                                .id,
                                            receiverUser: index.routeIdData[0]
                                                .id, //dummy driver id || will be changed later.
                                            context: context,
                                          );
                                      print(
                                          "driver id: ${index.routeIdData[0].id}");
                                      context.read<ChatProvider>().receverId =
                                          index.routeIdData[0].id!;
                                      context.read<ChatProvider>().senderId =
                                          context
                                              .read<UserProvider>()
                                              .userData
                                              .id!;
                                      await context
                                          .read<ChatProvider>()
                                          .getChatRoomId()
                                          .then((value) => print(
                                              "chat room id: ${context.read<ChatProvider>().chatRoomId}"));

                                      navigationService.closeScreen();
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext ctx) =>
                                              ChatScreen(
                                            memberProfile:
                                                'https://firebasestorage.googleapis.com/v0/b/guanabanas-y-mas.appspot.com/o/profileimages%2FRRb03eVr7eYFn6S7lBNaSeeavmt1?alt=media&token=3df3676a-5894-4859-96c2-af30562a0831',
                                            memberName: index
                                                .routeIdData[0].fullName
                                                .toString(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Chip(
                                        avatar: Image.asset(
                                          'assets/images/chatIcon.png',
                                          height: 14.h,
                                          width: 14.h,
                                        ),
                                        label: Text(
                                          'Chat',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        labelPadding:
                                            EdgeInsets.only(right: 6.w),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 7.5.w, vertical: 2.h),
                                        backgroundColor: baseColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 18.0.h, right: 18.0.h, top: 12.0.h),
                          child: Divider(
                            height: 10,
                          ),
                        ),
                        Expanded(
                            child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18.0.w, vertical: 8.0.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Available Fruits Item",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // GestureDetector(
                                  //     onTap: () {
                                  //       navigationService
                                  //           .navigateTo(SearchProductScreenRoute);
                                  //     },
                                  //     child: Container(
                                  //         padding: EdgeInsets.symmetric(
                                  //             horizontal: 12.w, vertical: 5.h),
                                  //         decoration: BoxDecoration(
                                  //             borderRadius:
                                  //                 BorderRadius.circular(20.r),
                                  //             border: Border.all(
                                  //                 width: 1.5.h, color: iconColor)),
                                  //         child: Text('View All',
                                  //             style: TextStyle(
                                  //                 color: iconColor,
                                  //                 fontWeight: FontWeight.w600,
                                  //                 fontSize: 12.sp)))
                                  //                 )
                                ],
                              ),
                            ),
                            Container(
                              height: 210.h,
                              width: 160.w,
                              child: ListView.builder(
                                  padding: EdgeInsets.only(
                                      left: 18.w, top: 10.h, bottom: 14.h),
                                  shrinkWrap: true,
                                  itemCount: index.routeIdData[0]
                                      .activeRoute!["products"].length,
                                  // 4,
                                  //  routeData[0].products.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, i) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        // color: Color.fromRGBO(254, 245, 236, 1),
                                        color: index.routeIdData[0]
                                                        .activeRoute!["products"]
                                                    [i]["backgroundColor"] ==
                                                "orange"
                                            ? Color.fromRGBO(254, 245, 236, 1)
                                            : index.routeIdData[0].activeRoute![
                                                            "products"][i]
                                                        ["backgroundColor"] ==
                                                    " yellow"
                                                ? Color.fromRGBO(
                                                    254, 248, 216, 1)
                                                : index.routeIdData[0]
                                                                .activeRoute!["products"][i]
                                                            ["backgroundColor"] ==
                                                        "green"
                                                    ? Color.fromRGBO(238, 245, 227, 1)
                                                    : index.routeIdData[0].activeRoute!["products"][i]["backgroundColor"] == "red"
                                                        ? Color.fromRGBO(248, 232, 232, 1)
                                                        : index.routeIdData[0].activeRoute!["products"][i]["backgroundColor"] == "peach"
                                                            ? Color.fromRGBO(254, 241, 230, 1)
                                                            : index.routeIdData[0].activeRoute!["products"][i]["backgroundColor"] == "darkgreen"
                                                                ? Color.fromRGBO(235, 241, 232, 1)
                                                                : Color.fromRGBO(254, 241, 230, 1),
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                      ),
                                      height: 190.h,
                                      width: 145.w,
                                      margin: EdgeInsets.only(right: 12.w),
                                      padding: EdgeInsets.all(15.w),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Center(
                                                child: Image.network(index
                                                        .routeIdData[0]
                                                        .activeRoute![
                                                    "products"][i]["picture"]),
                                              ),
                                            ),
                                            SizedBox(height: 18.h),
                                            Text(
                                              index.routeIdData[0]
                                                      .activeRoute!["products"]
                                                  [i]["name"],
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(height: 8.h),
                                            Text(
                                              index.routeIdData[0]
                                                      .activeRoute!["products"]
                                                  [i]["unit"],
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            SizedBox(height: 8.h),
                                            Text(
                                              "\$ " +
                                                  index.routeIdData[0]
                                                          .activeRoute![
                                                      "products"][i]["price"],

                                              // "\$ " + routeData[0].products![i].price!,

                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ]),
                                    );
                                  }),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18.0.sp, vertical: 18.0.sp),
                              child: Text(
                                "Trip Route Plan",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 18.0.sp),
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: index.routeIdData[0]
                                      .activeRoute!["stops"].length,
                                  // routeData.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, i) {
                                    // for (int j = 0;
                                    //     j <
                                    //         index.routeIdData[0]
                                    //             .activeRoute!["stops"].length;
                                    //     j++) {
                                    //   if (i > j) {
                                    //     if (index.routeIdData[0]
                                    //                 .activeRoute!["stops"][j + 1]
                                    //             ["isActive"] ==
                                    //         true) {
                                    //       if (j > 0) {
                                    //         index.routeIdData[0]
                                    //                 .activeRoute!["stops"][j - 1]
                                    //             ["isActive"] = true;
                                    //       } else {
                                    //         index.routeIdData[0]
                                    //                 .activeRoute!["stops"][j]
                                    //             ["isActive"] = true;
                                    //       }
                                    //     }
                                    //   }
                                    // }
                                    return TripDetailStopsWidget(
                                        data: index.routeIdData[0], i: i);
                                  }),
                            )
                          ],
                        )),
                      ],
                    )
                  : Center(
                      child: Platform.isIOS
                          ? CupertinoActivityIndicator()
                          : CircularProgressIndicator(),
                    );
            },
          )),
    );
  }
}
*/