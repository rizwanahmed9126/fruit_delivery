import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';
import 'package:fruit_delivery_flutter/models/routes_id_by_user_model.dart';
import 'package:fruit_delivery_flutter/providers/g_data_provider.dart';
import 'package:fruit_delivery_flutter/providers/route_provider.dart';
import 'package:fruit_delivery_flutter/services/util_service.dart';
import 'package:fruit_delivery_flutter/widgets/card_map.dart';
import 'package:fruit_delivery_flutter/widgets/custom_button.dart';
import 'package:fruit_delivery_flutter/widgets/will_pop.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../popups.dart/warning_dialogue.dart';
import '../services/storage_service.dart';
import '../widgets/main_drawer_widget.dart';
import '../services/navigation_service.dart';
import '../utils/routes.dart';
import '../utils/service_locator.dart';

class DriverHomeScreen extends StatefulWidget {
  @override
  _DriverHomeScreenState createState() => _DriverHomeScreenState();
}

GMapsProvider? abc;

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  var utilService = locator<UtilService>();
  var navigationService = locator<NavigationService>();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    abc = Provider.of<GMapsProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    abc!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return Scaffold(
        key: scaffoldKey,
        drawer: MainDrawerWidget(),
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 50.h,
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () {
             Provider.of<GMapsProvider>(context,listen: false).startTrip?utilService.showToast("Please complete trip first"): scaffoldKey.currentState!.openDrawer();
            },
            child: Image.asset(
              'assets/images/Menubutton.png',
              scale: 2.5.h,
            ),
            // Container(
            //   height: 40,
            //   width: 40,
            //   decoration: BoxDecoration(
            //       color: Color(0xFFebf4fa),
            //       borderRadius: BorderRadius.circular(8)),
            //   child: Center(
            //     child: Icon(
            //       Icons.align_horizontal_left,
            //       color: Color(0xFF8ea0ad),
            //     ),
            //   ),
            // ),
          ),
          title: Container(
            child: Text(
              AppLocalizations.of(context).translate('DrawerTracking'),
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  var storageService = locator<StorageService>();
                  await storageService.setData("route", "/driver-home-screen");
                  navigationService.navigateTo(NotificationScreenRoute);
                },
                child: Container(
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                      color: Color(0xFFebf4fa),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Icon(
                      Icons.notifications_none_outlined,
                      color: Color(0xFF8ea0ad),
                    ),
                  ),
                ),

                // Image.asset(
                //   'assets/images/notification.png',
                //   scale: 2.5,
                //   // color: Colors.white,
                // )
              ),
            ),
          ],
        ),
        body: WillPopScope(
          onWillPop: () async {
            showOnWillPop(context, () {
              navigationService.navigateTo(ScheduleScreenRoute);
              Provider.of<GMapsProvider>(context, listen: false).dispose();

              Provider.of<GMapsProvider>(context, listen: false).startTrip =
                  false;
              Provider.of<GMapsProvider>(context, listen: false).enableNext =
                  false;
              Provider.of<GMapsProvider>(context, listen: false).enableReach =
                  true;
              Provider.of<GMapsProvider>(context, listen: false).reaching = 0;
              Provider.of<GMapsProvider>(context, listen: false).complete = 1;
            });
            return false;
          },
          child: Consumer<GMapsProvider>(
            builder: (context, i, _) {
              return Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(i.routeDataByID!.startLocation!['lat'],
                          i.routeDataByID!.startLocation!['long']),
                      zoom: 15,
                    ),
                    myLocationButtonEnabled: true,
                    myLocationEnabled: false,
                    zoomControlsEnabled: false,
                    tiltGesturesEnabled: true,
                    compassEnabled: true,
                    scrollGesturesEnabled: true,
                    zoomGesturesEnabled: true,
                    buildingsEnabled: false,
                    onMapCreated: (GoogleMapController controller) async {
                      i.initializeMarkers();
                      i.mapController = controller;
                      i.getPolyline();
                      i.animateCamera();
                    },
                    mapType: MapType.normal,
                    markers: Set<Marker>.of(i.markers.values),
                    polylines: Set<Polyline>.of(i.polylines.values),
                  ),
                  // Positioned(
                  //   top: height * 0.05,
                  //   left: 15,
                  //   child: Container(
                  //     width: width,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(5),
                  //         color: Colors.white,
                  //         boxShadow: [
                  //           BoxShadow(
                  //               color: Colors.white,
                  //               offset: Offset(1.0, 12.0),
                  //               blurRadius: 20,
                  //               spreadRadius: 40),
                  //         ]),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(right: 30),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Row(
                  //             children: [
                  //               InkWell(
                  //                 onTap: () {
                  //                   scaffoldKey.currentState!.openDrawer();
                  //                 },
                  //                 child: Image.asset(
                  //                   'assets/images/Menubutton.png',
                  //                   scale: 2.5.h,
                  //                 ),
                  //                 // Container(
                  //                 //   height: 40,
                  //                 //   width: 40,
                  //                 //   decoration: BoxDecoration(
                  //                 //       color: Color(0xFFebf4fa),
                  //                 //       borderRadius: BorderRadius.circular(8)),
                  //                 //   child: Center(
                  //                 //     child: Icon(
                  //                 //       Icons.align_horizontal_left,
                  //                 //       color: Color(0xFF8ea0ad),
                  //                 //     ),
                  //                 //   ),
                  //                 // ),
                  //               ),
                  //               SizedBox(
                  //                 width: 10,
                  //               ),
                  //               Container(
                  //                 child: Text(
                  //                   AppLocalizations.of(context)
                  //                       .translate('DrawerTracking'),
                  //                   style: TextStyle(fontSize: 24),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),

                  //           //SizedBox(width: size.width*0.06,),
                  //           InkWell(
                  //             onTap: () async {
                  //               var storageService = locator<StorageService>();
                  //               await storageService.setData(
                  //                   "route", "/driver-home-screen");
                  //               navigationService
                  //                   .navigateTo(NotificationScreenRoute);
                  //             },
                  //             child: Container(
                  //               height: 38,
                  //               width: 38,
                  //               decoration: BoxDecoration(
                  //                   color: Color(0xFFebf4fa),
                  //                   borderRadius: BorderRadius.circular(10)),
                  //               child: Center(
                  //                 child: Icon(
                  //                   Icons.notifications_none_outlined,
                  //                   color: Color(0xFF8ea0ad),
                  //                 ),
                  //               ),
                  //             ),

                  //             // Image.asset(
                  //             //   'assets/images/notification.png',
                  //             //   scale: 2.5,
                  //             //   // color: Colors.white,
                  //             // )
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 100),
                  //   child: Container(
                  //     height: 100,
                  //     width: width,
                  //     //padding: EdgeInsets.only(left: 8.w, right: 8.w),
                  //     child: TextField(
                  //       onTap: () async {
                  //         showDialog(
                  //             context: context,
                  //             barrierDismissible: false,
                  //             builder: (_) {
                  //               return WarningScreen();
                  //             });
                  //       },
                  //       readOnly: true,
                  //       style: TextStyle(color: Colors.black, fontSize: 14.sp),
                  //       decoration: new InputDecoration(
                  //         border: OutlineInputBorder(
                  //           borderSide: const BorderSide(
                  //               color: Color.fromRGBO(242, 243, 245, 1), width: 1.0),
                  //           borderRadius: const BorderRadius.all(
                  //             const Radius.circular(30.0),
                  //           ),
                  //         ),
                  //         enabledBorder: new OutlineInputBorder(
                  //           borderSide: const BorderSide(
                  //               color: Color.fromRGBO(242, 243, 245, 1), width: 1.0),
                  //           borderRadius: const BorderRadius.all(
                  //             const Radius.circular(30.0),
                  //           ),
                  //         ),
                  //         focusedBorder: new OutlineInputBorder(
                  //           borderSide: const BorderSide(
                  //               color: Color.fromRGBO(242, 243, 245, 1), width: 1.0),
                  //           borderRadius: const BorderRadius.all(
                  //             const Radius.circular(30.0),
                  //           ),
                  //         ),
                  //         prefixIcon: Icon(Icons.search),
                  //         filled: true,
                  //         hintStyle:
                  //         new TextStyle(color: Colors.grey, fontSize: 12.sp),
                  //         hintText: "Search for a location",
                  //         fillColor: Color.fromRGBO(235, 244, 250, 1),
                  //         contentPadding: EdgeInsets.all(15.0),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  i.startTrip
                      ? Text('')
                      : Positioned(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: AvatarGlow(
                              startDelay: Duration(milliseconds: 500),
                              glowColor: Color.fromRGBO(53, 186, 138, 1),
                              endRadius: 155,
                              duration: Duration(milliseconds: 2000),
                              repeat: true,
                              showTwoGlows: true,
                              repeatPauseDuration: Duration(milliseconds: 300),
                              child: MaterialButton(
                                onPressed: () {
                                  i.callStartRoute(i.routeDataByID!.id!).then((value) {
                                    if (value == "true") {
                                      i.startTrip = true;

                                      //i.setStartTripValue(true);
                                      i.getLiveTracking();
                                    } else {
                                      utilService.showToast("Sorry! you can't start this trip");
                                    }
                                  });

                                  //navigationService.navigateTo(MapSampleRoute);
                                },
                                elevation: 20.0,
                                shape: CircleBorder(),
                                child: Container(
                                  width: 155,
                                  height: 155,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(53, 186, 138, 1),
                                      borderRadius:
                                          BorderRadius.circular(160.0)),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('Start'),
                                    // "Start",
                                    style: TextStyle(
                                        fontSize: 20.h,
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                  Visibility(
                    visible: i.startTrip,
                    child: Positioned(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            height: 260,
                            width: width,
                            child: MapCard(
                                // cancel: (){},
                                // next: (){},
                                // reached: (){
                                //   print('this is the next value${i.showNext}');
                                //   i.setStartTripValue(true);
                                //
                                // },
                                // enableShow: i.showNext
                                )),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }

  // Widget mapCard({String? runTimeDistance,bool? enableShow,Function? reached, Function? cancel,Function? next}){
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 15),
  //     child: Container(
  //       //height:MediaQuery.of(context).size.height / 2.6,
  //       width: MediaQuery.of(context).size.width*0.95,
  //
  //       decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(15),
  //           boxShadow: [
  //             BoxShadow(
  //                 color: Colors.grey[300]!,
  //                 blurRadius: 3,
  //                 spreadRadius: 2
  //             )
  //           ]
  //       ),
  //
  //       child: Padding(
  //         padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
  //         child: Column(
  //           // mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             ListTile(
  //               contentPadding: EdgeInsets.all(0),
  //               leading: ClipRRect(
  //                 borderRadius: BorderRadius.circular(12.h),
  //                 child: Image.network(
  //                   'https://cdn.arstechnica.net/wp-content/uploads/2021/04/GettyImages-1216654363-800x534.jpg',
  //                   height: 40.h,
  //                   width: 45.w,
  //                   fit: BoxFit.fill,
  //                 ),
  //               ),
  //               title: Text('Berry Allen'),
  //               subtitle: Text('Driver',
  //                   style: TextStyle(color: Colors.black45, fontSize: 12.sp)),
  //               trailing: InkWell(
  //                   onTap: () {
  //                     // navigationService.navigateTo(ChatScreenRoute);
  //                   },
  //                   child: GestureDetector(
  //                     onTap: () {
  //                       showDialog(
  //                           context: context,
  //                           barrierDismissible: false,
  //                           builder: (_) {
  //                             return WarningScreen();
  //                           });
  //                     },
  //                     // navigationService.navigateTo(TripDetailScreenRoute),
  //                     child: Container(
  //                       padding: EdgeInsets.all(8.h),
  //                       decoration: BoxDecoration(
  //                           color: Colors.lightGreen.shade50,
  //                           borderRadius: BorderRadius.circular(5)),
  //                       child: Text(
  //                         'Trip Details',
  //                         style: TextStyle(
  //                             color: Colors.green,
  //                             fontWeight: FontWeight.w600,
  //                             fontSize: 12.sp),
  //                       ),
  //
  //                     ),
  //                   )),
  //             ),
  //             Container(
  //               width: double.infinity,
  //               height: 1.h,
  //               color: Colors.grey.shade300,
  //             ),
  //
  //             Container(
  //               height: 100,
  //
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   //crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Container(
  //                       width: 20,
  //                       //color: Colors.red,
  //                       child: Padding(
  //                         padding: const EdgeInsets.only(top: 8.0),
  //                         child: Column(
  //                           children: [
  //                             Icon(Icons.circle,size: 12,color:Colors.green),
  //                             Container(
  //                               height: 40,
  //                               width: 1,
  //                               color: Colors.grey[200],
  //                             ),
  //                             Icon(Icons.circle_outlined,color: Colors.green,size: 12,)
  //
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     Column(
  //                       children: [
  //                         Column(
  //                           crossAxisAlignment:
  //                           CrossAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                               'START POINT,',
  //                               style: TextStyle(
  //                                   color: Colors.black26,
  //                                   fontSize: 10.sp),
  //                             ),
  //                             Text(
  //                               '15 Heritage Court South Portland..,',
  //                               style: TextStyle(
  //                                   fontWeight: FontWeight.bold,
  //                                   fontSize: 12.sp),
  //                             ),
  //                           ],
  //                         ),
  //                         SizedBox(height: 20,),
  //                         Column(
  //                           crossAxisAlignment:
  //                           CrossAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                               'START POINT,',
  //                               style: TextStyle(
  //                                   color: Colors.black26,
  //                                   fontSize: 10.sp),
  //                             ),
  //                             Text(
  //                               '15 Heritage Court South Portland..,',
  //                               style: TextStyle(
  //                                   fontWeight: FontWeight.bold,
  //                                   fontSize: 12.sp),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                     Container(
  //                       height: 50,
  //                       width: 1,
  //                       color: Colors.grey[200],
  //                     ),
  //                     Container(
  //                       height: 50,
  //                       child: Center(
  //                         child: Column(
  //                           // mainAxisAlignment: MainAxisAlignment.start,
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //
  //                           children: [
  //                             Text("Distance",
  //                                 style: TextStyle(
  //                                     color: Colors.black26, fontSize: 12.sp)
  //                             ),
  //
  //                             RichText(
  //                               text: TextSpan(
  //                                 text: '${runTimeDistance}',
  //                                 style: TextStyle(
  //                                     fontWeight: FontWeight.bold,
  //                                     fontSize: 24.sp,
  //                                     color: Colors.black54),
  //                                 children: <TextSpan>[
  //                                   TextSpan(
  //                                       text: ' km',
  //                                       style: TextStyle(
  //                                         // fontWeight: FontWeight.bold,
  //                                           fontSize: 18.sp)),
  //                                 ],
  //                               ),
  //                             )
  //                           ],
  //                         ),
  //                       ),
  //                     )
  //
  //
  //                   ],
  //                 ),
  //               ),
  //             ),
  //
  //             // Row(
  //             //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             //   children: [
  //             //     Expanded(
  //             //       child: ListView.builder(
  //             //           shrinkWrap: true,
  //             //           itemCount: routeDetailList.length,
  //             //           itemBuilder: (ctx, index) {
  //             //             return Padding(
  //             //               padding: EdgeInsets.only(left: 12.0.h),
  //             //               child: TimelineTile(
  //             //                 alignment: TimelineAlign.start,
  //             //                 endChild: Padding(
  //             //                   padding: EdgeInsets.only(bottom: 8.h),
  //             //                   child: Row(
  //             //                     children: [
  //             //                       Padding(
  //             //                         padding: EdgeInsets.only(left: 8.h),
  //             //                         child: Column(
  //             //                           crossAxisAlignment:
  //             //                               CrossAxisAlignment.start,
  //             //                           children: [
  //             //                             Text(
  //             //                               '${routeDetailList[index].mtitle},',
  //             //                               style: TextStyle(
  //             //                                   color: Colors.black26,
  //             //                                   fontSize: 10.sp),
  //             //                             ),
  //             //                             Text(
  //             //                               '${routeDetailList[index].title},',
  //             //                               style: TextStyle(
  //             //                                   fontWeight: FontWeight.bold,
  //             //                                   fontSize: 12.sp),
  //             //                             ),
  //             //                           ],
  //             //                         ),
  //             //                       ),
  //             //                     ],
  //             //                   ),
  //             //                 ),
  //             //                 beforeLineStyle: LineStyle(color: Colors.green, thickness: 2.0),
  //             //                 afterLineStyle: LineStyle(color: Colors.grey, thickness: 1.5),
  //             //                 isFirst: index == 0,
  //             //                 isLast: index == routeDetailList.length - 1,
  //             //                 indicatorStyle: IndicatorStyle(
  //             //                     indicatorXY: 0.5,
  //             //                     width: 8.w,
  //             //                     height: 8.w,
  //             //                     color: Colors.green),
  //             //               ),
  //             //             );
  //             //           }),
  //             //     ),
  //             //     Container(
  //             //       height: 100,
  //             //
  //             //       width: 1,
  //             //       color: Colors.grey[200],
  //             //     ),
  //             //     Column(
  //             //       mainAxisAlignment: MainAxisAlignment.center,
  //             //       crossAxisAlignment: CrossAxisAlignment.start,
  //             //       children: [
  //             //         Text("Distance",
  //             //             style: TextStyle(
  //             //                 color: Colors.black26, fontSize: 12.sp)
  //             //         ),
  //             //
  //             //         RichText(
  //             //           text: TextSpan(
  //             //             text: '00',
  //             //             style: TextStyle(
  //             //                 fontWeight: FontWeight.bold,
  //             //                 fontSize: 24.sp,
  //             //                 color: Colors.black54),
  //             //             children: <TextSpan>[
  //             //               TextSpan(
  //             //                   text: ' km',
  //             //                   style: TextStyle(
  //             //                     // fontWeight: FontWeight.bold,
  //             //                       fontSize: 18.sp)),
  //             //             ],
  //             //           ),
  //             //         )
  //             //       ],
  //             //     )
  //             // ]),
  //
  //
  //             SizedBox(
  //               height: 5.h,
  //             ),
  //
  //
  //
  //             Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 // crossAxisAlignment: Cros,
  //                 children: [
  //                   CustomButton(
  //                     onTap:
  //                         (){
  //                       print('this is the next value${i.showNext}');
  //                       i.setStartTripValue(true);
  //
  //                     },
  //
  //                     name: AppLocalizations.of(context).translate('Reached'),
  //                     color: Color.fromRGBO(6, 164, 2, 1),
  //                     txtColor: Colors.white,
  //                   ),
  //                   SizedBox(
  //                     width: 12.w,
  //                   ),
  //
  //                   CustomButton(
  //                     onTap: cancel!(),//(){},
  //                     name: AppLocalizations.of(context).translate('cancel'),
  //                     color: Color.fromRGBO(242, 243, 245, 1),
  //                     txtColor: Colors.grey.shade600,
  //                   ),
  //                   SizedBox(
  //                     width: 12.w,
  //                   ),
  //                    Visibility(
  //                      visible: enableShow!,
  //                      child: CustomButton(
  //                       onTap:next!(), //(){},
  //                       name: AppLocalizations.of(context).translate('nextstep'),
  //                       color: Color.fromRGBO(255, 122, 0, 1),
  //                       txtColor: Colors.white,
  //                   ),
  //                    )
  //
  //
  //                 ]),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

}
