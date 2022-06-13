// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/globals.dart';
import 'package:fruit_delivery_flutter/providers/g_data_provider.dart';
import 'package:fruit_delivery_flutter/providers/route_provider.dart';
import 'package:fruit_delivery_flutter/screens/route_detail_screen.dart';
import 'package:fruit_delivery_flutter/services/navigation_service.dart';
import 'package:fruit_delivery_flutter/utils/routes.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ScheduleWidget extends StatefulWidget {
  final String? from;
  final String? to;
  final String? startDate;
  final String? endDate;

  //final data;
  bool? active;
  ValueChanged<String>? action;
  String? tag;
  ScheduleWidget({
    this.from,
    this.to,
    this.startDate,
    this.endDate,
    //this.data,
    this.active,
    this.tag,
    this.action,
  });
  @override
  _ScheduleWidgetState createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
//   List<Placemark>? fromAddress;
// List<Placemark>? toAddress;
  var navigationService = locator<NavigationService>();

  // getAddress() async {
  //   fromAddress = await placemarkFromCoordinates(widget.from!.latitude, widget.from!.longitude);
  //   toAddress = await placemarkFromCoordinates(widget.to!.latitude, widget.to!.longitude);
  //
  //   setState(() {});
  // }

  // ignore: non_constant_identifier_names
  void HandleTap() async {
    setState(
      () {
        widget.action!(widget.tag!);
      },
    );


    showLoadingAnimation(context);
    await Provider.of<RouteProvider>(context, listen: false).fetchRoutebyId(widget.tag!);
    navigationService.closeScreen();
    navigationService.navigateTo(RouteDetailScreenRoute);
  }

  @override
  void initState() {
    //getAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: HandleTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: widget.active!
                  ? Color.fromRGBO(246, 250, 251, 1,)
                  : Colors.white,
              border: Border(
                left: BorderSide(
                  width: 5.0.w,
                  color: widget.active! ? Colors.green : Colors.white,
                ),
                bottom: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            margin: EdgeInsets.only(bottom: 0.h),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 15.h,
                    bottom: 15.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 25.w,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/Date.png',
                          scale: 1.3.h,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                             "${widget.startDate} - ${widget.endDate}",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: widget.active!
                                    ? Color.fromRGBO(
                                  44,
                                  44,
                                  44,
                                  1,
                                )
                                    : Color.fromRGBO(
                                  119,
                                  119,
                                  119,
                                  1,
                                ),
                                fontSize: 14.sp),
                          ),
                          // RichText(
                          //   text: TextSpan(
                          //     text: "Monday ",
                          //     style: TextStyle(
                          //         fontWeight: FontWeight.w800,
                          //         color: widget.active!
                          //             ? Color.fromRGBO(44, 44, 44, 1,) : Color.fromRGBO(119, 119, 119, 1,),
                          //         fontSize: 15.sp),
                          //     children: <TextSpan>[
                          //       TextSpan(
                          //         text: widget.startDate,
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.w800,
                          //             color: widget.active!
                          //                 ? Color.fromRGBO(
                          //                     44,
                          //                     44,
                          //                     44,
                          //                     1,
                          //                   )
                          //                 : Color.fromRGBO(
                          //                     119,
                          //                     119,
                          //                     119,
                          //                     1,
                          //                   ),
                          //             fontSize: 14.sp),
                          //       ),
                          //       TextSpan(
                          //         text: widget.endDate,
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.w800,
                          //             color: widget.active!
                          //                 ? Color.fromRGBO(
                          //                     44,
                          //                     44,
                          //                     44,
                          //                     1,
                          //                   )
                          //                 : Color.fromRGBO(
                          //                     119,
                          //                     119,
                          //                     119,
                          //                     1,
                          //                   ),
                          //             fontSize: 14.sp),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(height: 6.h),
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: 180.w,
                            ),
                            child: Text(
                              "From: ${widget.from}",
                              // fromAddress != null
                              //     ? "from:  ${fromAddress!.first.street} , ${fromAddress!.first.subLocality} ,${fromAddress!.first.locality} , ${fromAddress!.first.country}"
                              //     : "",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(
                                  143,
                                  143,
                                  143,
                                  1,
                                ),
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: 180.w,
                            ),
                            child: Text(
                              "To: ${widget.to}",
                              // toAddress != null
                              //     ? "to: ${toAddress!.first.street} ${toAddress!.first.subLocality} , ${toAddress!.first.locality} , ${toAddress!.first.country} "
                              //     : "",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(
                                  143,
                                  143,
                                  143,
                                  1,
                                ),
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 18.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // widget.active! ? Container() : Divider()
        ],
      ),
    );
  }
}
