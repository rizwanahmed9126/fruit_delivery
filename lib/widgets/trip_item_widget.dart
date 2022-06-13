import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/globals.dart';
import 'package:fruit_delivery_flutter/models/getallvender_model.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/chat_provider.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/user_provider.dart';
import 'package:fruit_delivery_flutter/screens/chache_image.dart';
import 'package:fruit_delivery_flutter/screens/chat_screen.dart';
import 'package:fruit_delivery_flutter/utils/routes.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import '../services/navigation_service.dart';
import '../utils/service_locator.dart';

// ignore: must_be_immutable
class TripItemWidget extends StatefulWidget {
  GetVendor? data;
  bool? active = true;
  String? tag;
  ValueChanged<dynamic>? action;
  TripItemWidget({
    this.action,
    this.active,
    this.data,
    this.tag,
  });

  @override
  _TripItemWidgetState createState() => _TripItemWidgetState();
}

class _TripItemWidgetState extends State<TripItemWidget> {
  // bool isloadingprogress = false;
  var navigationService = locator<NavigationService>();
  String? locationtxt;
  void handletap() {
    widget.action!(widget.tag);
  }

  List<Placemark>? fromAddress;

  getAddress() async {
    fromAddress = await placemarkFromCoordinates(
        widget.data!.activeRoute!.stops![0].location!.lat!,
        widget.data!.activeRoute!.stops![0].location!.long!);
    setState(() {});
  }

  @override
  void initState() {
    getAddress();
    // TODO: implement initState
    super.initState();
  }

  bool active = false;
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
        Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 10.0, top: 4.0),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                      width: 1,
                      color: active
                          ? Colors.green
                          : Color.fromRGBO(246, 142, 86, 1))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(10),
                        //   child: Image(
                        //     image: AssetImage("assets/images/dummy3.jpg"
                        //         // widget.data.activeRoute!.products![0].picture!,
                        //         ),
                        //     fit: BoxFit.fill,
                        //     height: 32.h,
                        //     width: 32.h,
                        //   ),
                        // ),
                        CacheImage(
                          radius: 10,
                          imageUrl: widget.data!.profilePicture!,
                          height: 32.h,
                          width: 32.h,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.data!.fullName.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.sp),
                            ),
                            Text("Driver",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10.sp,
                                    height: 1.7,
                                    color: Colors.grey.shade500)),
                          ],
                        ),
                        Spacer(),
                        // Column(
                        //   children: [
                        //     GestureDetector(
                        //      onTap: () async {
                        //          setState(() {
                        //           isloadingprogress = true;
                        //         });
                        //         await Provider.of<UserProvider>(context,
                        //                 listen: false)
                        //             .fetchActiveVendor();

                        //         setState(() {
                        //           isloadingprogress = false;
                        //         });
                        //         navigationService
                        //             .navigateTo(TripDetailScreenRoute);
                        //       },
                        //       child: Text(
                        //         "ff",
                        //         // widget.data['subdetail'],
                        //         style: TextStyle(
                        //             fontSize: 10.sp,
                        //             fontWeight: FontWeight.bold,
                        //             color: Color.fromRGBO(53, 186, 138, 1)),
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       height: 6,
                        //     ),
                        //     // Container(
                        //     //     height: 15,
                        //     //     width: 50,
                        //     //     decoration: BoxDecoration(
                        //     //         color: widget.active!
                        //     //             ? Color.fromRGBO(246, 142, 86, 1)
                        //     //             : Colors.white,
                        //     //         borderRadius: BorderRadius.circular(50)),
                        //     //     child: Center(
                        //     //       child: Text(
                        //     //         "Near you",
                        //     //         style: TextStyle(
                        //     //             fontSize: 8.sp,
                        //     //             color: widget.active!
                        //     //                 ? Colors.white
                        //     //                 : Colors.white),
                        //     //       ),
                        //     //     ))
                        //   ],
                        // )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: 12,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          fromAddress != null
                              ? "${fromAddress![0].street}, ${fromAddress![0].thoroughfare}, ${fromAddress![0].subAdministrativeArea}"
                              : "",
                          style: TextStyle(fontSize: 10.sp),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 12,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          DateFormat.yMMMd().format(
                              DateTime.fromMillisecondsSinceEpoch(widget.data!
                                  .activeRoute!.stops![0].createdOnDate!)),
                          style: TextStyle(fontSize: 10.sp),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.watch_later_outlined,
                          size: 12,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          widget.data!.activeRoute!.stops![0].timeOfReaching!
                              .toString()
                              .toString(),
                          style: TextStyle(fontSize: 10.sp),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 28.h,
                          width: 80.h,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.resolveWith(
                                    (states) => 0),
                                shadowColor: MaterialStateProperty.resolveWith(
                                    (states) => Colors.grey.shade400),
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.white),
                                shape: MaterialStateProperty.resolveWith(
                                    (states) => RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        side: BorderSide(
                                            color: Colors.grey.shade600,
                                            width: 1)))),
                            onPressed: () async {
                              showLoadingAnimation(context);
                              await Provider.of<UserProvider>(context,
                                      listen: false)
                                  .fetchVendorsRoutebyId(
                                widget.data!.id!,
                              );

                              navigationService.closeScreen();
                              navigationService
                                  .navigateTo(TripDetailScreenRoute);
                            },
                            child: Text(
                              "Trip Detail",
                              style: TextStyle(
                                  fontSize: 9.sp, color: Colors.grey.shade600),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          height: 28.h,
                          //width: 80.w,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.resolveWith(
                                      (states) => 0),
                                  shadowColor: MaterialStateProperty.resolveWith(
                                      (states) => Colors.grey.shade400),
                                  backgroundColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.white),
                                  shape: MaterialStateProperty.resolveWith(
                                      (states) => RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side: BorderSide(
                                              color: Colors.grey.shade600,
                                              width: 1)))),
                              onPressed: () async {
                                showLoadingAnimation(context);
                                // inChat = true;
                                await context
                                    .read<ChatProvider>()
                                    .createChatRoom(
                                      senderUser: context
                                          .read<UserProvider>()
                                          .userData
                                          .id,
                                      receiverUser: widget.data!
                                          .id, //dummy driver id || will be changed later.
                                      recieverName: widget.data!.fullName,
                                      context: context,
                                    );
                                context.read<ChatProvider>().receverId =
                                    widget.data!.id!;
                                context.read<ChatProvider>().senderId =
                                    context.read<UserProvider>().userData.id!;
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
                                      receiverUser: widget.data!
                                          .id, //dummy driver id || will be changed later.
                                      recieverName: widget.data!.fullName,
                                      context: context,
                                    );
                                context.read<ChatProvider>().receverId =
                                    widget.data!.id!;
                                context.read<ChatProvider>().senderId =
                                    context.read<UserProvider>().userData.id!;
                                await context
                                    .read<ChatProvider>()
                                    .getChatRoomId();
                                navigationService.closeScreen();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext ctx) => ChatScreen(
                                        memberProfile:
                                            widget.data!.profilePicture,
                                        memberName: widget.data!.fullName),
                                  ),
                                );
                              },
                              child:
                                  Text("Send Message", style: TextStyle(fontSize: 9.sp, color: Colors.grey.shade600))),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        // isloadingprogress
        //     ? Positioned.fill(
        //         child: Align(
        //             alignment: Alignment.center,
        //             child: Platform.isIOS
        //                 ? CupertinoActivityIndicator()
        //                 : CircularProgressIndicator()))
        //     : Container()
      ],
    );
  }
}
