import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/constants/color_constants.dart';
import '/models/trip_detail_route_user.dart';
import '/screens/chache_image.dart';
import '/services/storage_service.dart';
import '/utils/service_locator.dart';
import '/widgets/google_webview.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TripDetailStopsWidget extends StatefulWidget {
  TripDetailRouteUser? data;
  int? i;
  TripDetailStopsWidget({Key? key, this.data, this.i}) : super(key: key);

  @override
  _TripDetailStopsWidgetState createState() => _TripDetailStopsWidgetState();
}

class _TripDetailStopsWidgetState extends State<TripDetailStopsWidget> {
  StorageService? storageService = locator<StorageService>();
  GoogleView googleUtils = GoogleView();
  bool isLoadingProgress = false;

  List<Placemark>? fromAddress;

  getAddress() async {
    fromAddress = await placemarkFromCoordinates(
        widget.data!.activeRoute!["stops"][widget.i]["location"]["lat"]
            .toDouble(),
        widget.data!.activeRoute!["stops"][widget.i]["location"]["long"]
            .toDouble());

    setState(() {});
  }

  @override
  void initState() {
    getAddress();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "activeout: ${widget.data!.activeRoute!["stops"][widget.i]["isActive"]}");
    int stop = widget.i! + 1;
    return Stack(
      children: [
        TimelineTile(
          alignment: TimelineAlign.start,
          endChild: Padding(
            padding: EdgeInsets.only(left: 8.0.w, bottom: 16.0.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      // "01",
                      "Stop " + stop.toString(),

                      style: TextStyle(
                          fontSize: 13.0.sp, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: widget.data!.activeRoute!["stops"][widget.i]
                                  ["isActive"] ==
                              true
                          ? baseColor
                          : smokeColor,
                      width: .8,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: widget.data!.activeRoute!["stops"][widget.i]
                                            ["status"] ==
                                        "completed" ||
                                    widget.data!.activeRoute!["stops"][widget.i]
                                            ["status"] ==
                                        "ongoing"
                                ? baseColor
                                : smokeColor,
                            width: 5.0.sp,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0.h),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 6.0.h),
                              child: Row(
                                children: [
                                  // if (vendorData != null)
                                  Center(
                                    child:
                                        //  vendorData
                                        //                 .profilePicture ==
                                        //             null ||
                                        //         vendorData
                                        //                 .profilePicture ==
                                        //             ""
                                        // ? CircleAvatar(
                                        //     radius: 18.sp,
                                        //     child: Image.asset(
                                        //         "assets/images/place_holder.png"))
                                        // :
                                        CircleAvatar(
                                      backgroundColor: smokeColor,
                                      radius: 21.sp,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 18.sp,
                                        child: CacheImage(
                                          imageUrl:
                                              "https://firebasestorage.googleapis.com/v0/b/guanabanas-y-mas.appspot.com/o/profileimages%2F${widget.data!.id}?alt=media&token=b94cc404-b405-46c8-9e99-fb80d37371c0",
                                          // $_token",
                                          height: 100.h,
                                          width: 100.h,
                                          radius: 100.h,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // CircleAvatar(
                                  //   backgroundColor: smokeColor,
                                  //   radius: 21.sp,
                                  //   child: CircleAvatar(
                                  //     radius: 18.0.sp,
                                  //     backgroundImage:
                                  //         NetworkImage(
                                  //             timelineList[i]
                                  //                 .personAvatar),
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Driver'.toUpperCase(),
                                          style: TextStyle(
                                            color: baseColor,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          // "vendor Name",
                                          widget.data!.fullName!,
                                          // vendorData.fullName,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      if (widget.data!.activeRoute!["stops"]
                                              [widget.i]["isActive"] ==
                                          true)
                                        InkWell(
                                          onTap: () async {
                                            googleUtils.openMap(
                                                widget
                                                    .data!
                                                    .activeRoute!["stops"]
                                                        [widget.i]["location"]
                                                        ["lat"]
                                                    .toDouble(),
                                                widget
                                                    .data!
                                                    .activeRoute!["stops"]
                                                        [widget.i]["location"]
                                                        ["long"]
                                                    .toDouble()
                                                // 24.85934849672671,
                                                // 67.00965411640001
                                                );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xfffac6aa),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        7.0.r)),
                                            padding: EdgeInsets.all(2.5.w),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xfff68e56),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0.r)),
                                              padding: EdgeInsets.all(4.0.w),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        color: Colors.white),
                                                    height: 4.h,
                                                    width: 4.h,
                                                  ),
                                                  SizedBox(
                                                    width: 4.w,
                                                  ),
                                                  Text(
                                                    'Get Directions',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 9.sp),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      Icon(
                                        Icons.more_vert,
                                        size: 18.sp,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 2.0.sp,
                              thickness: 0.8,
                            ),
                            SizedBox(height: 8.0.h),

                            //.........location Row .................................
                            Row(children: [
                              widget.data!.activeRoute!["stops"][widget.i]
                                          ["isActive"] ==
                                      true
                                  ? Icon(Icons.location_pin,
                                      size: 15.sp, color: Colors.black54)
                                  : Icon(Icons.location_on_outlined,
                                      size: 15.sp, color: Colors.black54),
                              SizedBox(width: 5.0.w),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.44,
                                child: Text(
                                  // widget.data.activeRoute!["stops"][widget.i]
                                  fromAddress != null
                                      ? "${fromAddress![0].street}, ${fromAddress![0].thoroughfare}, ${fromAddress![0].subAdministrativeArea}"
                                      : "xxxxxxxxxxxx",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                            ]),
                            SizedBox(height: 4.0.h),
                            //....time and date row.....................
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.watch_later_outlined,
                                        size: 15.sp,
                                        color: Colors.grey.shade600),
                                    SizedBox(width: 5.0.w),
                                    Text(
                                      widget.data!.activeRoute!["stops"]
                                          [widget.i]["timeOfReaching"],
                                      // "hello",timeOfReaching
                                      // routeData[1].timeOfReaching,
                                      style: TextStyle(
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54),
                                    )
                                  ],
                                ),
                                SizedBox(width: 5.0.w),
                                Container(
                                  width: 1.5,
                                  height: 8.h,
                                  color: Colors.black54,
                                ),
                                SizedBox(width: 5.0.w),
                                Text(
                                  // "hello",
                                  DateFormat.yMMMd().format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          widget.data!.activeRoute!["stops"]
                                              [widget.i]["createdOnDate"])),

                                  style: TextStyle(
                                      fontSize: 9.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          afterLineStyle: LineStyle(
            color:
                widget.data!.activeRoute!["stops"][widget.i]["isActive"] == true
                    ? baseColor
                    : iconColor,
            thickness: 1.5,
          ),
          isFirst: true,
          //  i == 0,
          isLast: false,
          // i == provider.routeIdData[0].stops.length - 1,
          indicatorStyle: IndicatorStyle(
            indicatorXY: 0.0,
            width: 8.w,
            height: 8.w,
            color:
                widget.data!.activeRoute!["stops"][widget.i]["isActive"] == true
                    ? baseColor
                    : iconColor,
          ),
        ),
        Positioned.fill(
            child: Align(
          child: isLoadingProgress == true
              ? Platform.isIOS
                  ? CupertinoActivityIndicator()
                  : CircularProgressIndicator()
              : Container(),
        ))
      ],
    );
  }
}
