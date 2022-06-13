// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'package:fruit_delivery_flutter/models/routes_id_by_user_model.dart';

class RouteDetailWidget extends StatefulWidget {
  int index;
  String start;
  String end;
  String truckNumber;
  int createdOnDate;
  String arriveTime;
  //RouteById routeIdData;
  bool active;

  RouteDetailWidget({
    Key? key,
    required this.index,
    //required this.routeIdData,
    required this.active,
    required this.start,
    required this.end,
    required this.arriveTime,
    required this.createdOnDate,
    required this.truckNumber
  }) : super(key: key);

  @override
  _RouteDetailWidgetState createState() => _RouteDetailWidgetState();
}

class _RouteDetailWidgetState extends State<RouteDetailWidget> {
  final DateFormat startformatterMonth = DateFormat('dd/MM/yyyy');
  // List<Placemark>? fromAddress;
  // List<Placemark>? toAddress;
  //
  // getAddress() async {
  //   if (widget.index == 0) {
  //     fromAddress = await placemarkFromCoordinates(widget.routeIdData.startLocation!['lat'], widget.routeIdData.startLocation!['long']);
  //     toAddress = await placemarkFromCoordinates(
  //         widget.routeIdData.stops![widget.index]['location']['lat'],
  //         widget.routeIdData.stops![widget.index]['location']['long']);
  //   } else {
  //     fromAddress = await placemarkFromCoordinates(
  //         widget.routeIdData.stops![widget.index - 1]['location']['lat'],
  //         widget.routeIdData.stops![widget.index - 1]['location']['long']);
  //     toAddress = await placemarkFromCoordinates(
  //         widget.routeIdData.stops![widget.index]['location']['lat'],
  //         widget.routeIdData.stops![widget.index]['location']['long']);
  //   }
  //   // fromAddress = await placemarkFromCoordinates(
  //   //     widget.stopsData['location']['lat'], widget.stopsData['location']['long']);
  //   // toAddress = await placemarkFromCoordinates(
  //   //     widget.to!.latitude, widget.to!.longitude);
  //
  //   setState(() {});
  // }

  @override
  void initState() {
   // getAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0.h),
      child: TimelineTile(
        alignment: TimelineAlign.start,
        endChild: Padding(
          padding: EdgeInsets.only(left: 10.0.w, bottom: 16.0.h, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Stop ${widget.index + 1}",

                    // i.routeIdData[index].stops.
                    style: TextStyle(
                        fontSize: 10.0.sp, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey.shade300, width: .8),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: Colors.grey.shade300,
                          width: 5.0.w,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date",
                                  style: TextStyle(
                                      fontSize: 9.sp,
                                      color: Colors.grey.shade600),
                                ),
                                Text(
                                  // "123",
                                  "${startformatterMonth.format(DateTime.fromMillisecondsSinceEpoch((widget.createdOnDate),
                                  ))}",

                                  // // "${DateTime.fromMillisecondsSinceEpoch(
                                  // //   (i.routeData[index]
                                  // //       .createdOnDate!),
                                  // // )}",
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Active",
                                  style: TextStyle(
                                    fontSize: 9.sp,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Text(
                                  widget.arriveTime,
                                  //widget.routeIdData.stops![widget.index]['timeOfReaching'],
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 10,
                            ),
                            height: 45.h,
                            child: Column(
                              children: [
                                Container(
                                  height: 5.h,
                                  width: 5.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      50,
                                    ),
                                    border: Border.all(
                                      width: 1.h,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 35.h,
                                  child: VerticalDivider(),
                                ),
                                Container(
                                  height: 5.h,
                                  width: 5.h,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(
                                      50,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5.h,
                              ),
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth: 180.w,
                                ),
                                child: Text(
                                  widget.start,
                                  // fromAddress != null
                                  //     ? " ${fromAddress!.first.street} , ${fromAddress!.first.subLocality} ,${fromAddress!.first.locality} , ${fromAddress!.first.country}"
                                  //     : "",
                                  // "${i.routeIdData[index].startLocation![0]["locality"]}"
                                  //     .toString(),
                                  //  +
                                  // "${i.routeIdData[index].startLocation![i]["country"]} ",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Text(
                                widget.truckNumber,
                                // "111",
                                //widget.routeIdData.turckNumber!,
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              SizedBox(
                                height: 9.h,
                              ),
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth: 180.w,
                                ),
                                child: Text(
                                  widget.end,
                                  // toAddress != null
                                  //     ? " ${toAddress!.first.street}  ${toAddress!.first.subLocality} , ${toAddress!.first.locality} , ${toAddress!.first.country}"
                                  //     : "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Text(
                                widget.truckNumber,
                                // "111",
                                //widget.routeIdData.turckNumber!,
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        beforeLineStyle: LineStyle(color: Colors.green, thickness: 2.0),
        afterLineStyle: LineStyle(
            color: widget.active ? Colors.green : Colors.grey, thickness: 1.5),
        isFirst: widget.index == 0,
        // isLast: widget.index == i.tripData.length - 1,
        indicatorStyle: IndicatorStyle(
          indicatorXY: 0.0,
          width: 8.w,
          height: 8.w,
          color: widget.active ? Colors.green : Colors.grey,
        ),
      ),
    );
  }
}
