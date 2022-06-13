import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/providers/g_data_provider.dart';
import 'package:fruit_delivery_flutter/screens/create_route_form_screen.dart';
import 'package:fruit_delivery_flutter/screens/driver_home_screen.dart';
import 'package:fruit_delivery_flutter/services/util_service.dart';
import 'package:fruit_delivery_flutter/widgets/route_detail_widget.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fruit_delivery_flutter/models/routes_id_by_user_model.dart';
import 'package:fruit_delivery_flutter/providers/route_provider.dart';
import 'package:fruit_delivery_flutter/services/navigation_service.dart';
import 'package:fruit_delivery_flutter/utils/routes.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';

class RouteDetailScreen extends StatefulWidget {
  RouteDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  _RouteDetailScreenState createState() => _RouteDetailScreenState();
}

class _RouteDetailScreenState extends State<RouteDetailScreen> {
  bool isLoading = false;
  bool? active = false;
  var vendorData;
  var navigationService = locator<NavigationService>();
  UtilService? utilService = locator<UtilService>();
  DateTime txdate = DateTime.now();
  //List<RouteById> routeIdData = [];

  // List<Placemark>? fromAddress;
  // List<Placemark>? toAddress;

  // getAddress(
  //     double fromLat, double fromLang, double toLat, double toLang) async {
  //   fromAddress = await placemarkFromCoordinates(fromLat, fromLang);
  //   toAddress = await placemarkFromCoordinates(toLat, toLang);
  //
  //   setState(() {});
  // }

  final DateFormat startformatterMonth = DateFormat('dd/MM/yyyy');
  // @override
  // void initState() {
  //   super.initState();
  // }

  // fetchRouteById() async {
  //   if (routeIdData.isEmpty) {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     await Provider.of<RouteProvider>(context, listen: false)
  //         .fetchRoutebyId("11CevNqe0TieBECftd62");
  //     routeIdData =
  //         Provider.of<RouteProvider>(context, listen: false).getRouteDataById;
  //     setState(() {
  //       isLoading = false;
  //     });
  //   } else {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              icon: Image.asset(
                'assets/images/ArrowBack.png',
                scale: 2.5,
                // color: Colors.white,
              ),
              onPressed: () {
                // navigationService.navigateTo(CreateRouteFormScreenRoute);
                navigationService.closeScreen();
              },
            ),
          ),
          title: Text(
            // AppLocalizations.of(context).translate('Routedetail'),
            'Route Detail',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 18.sp),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.grey.shade500,
                size: 19.h,
              ),
              onPressed: () {
                print(
                    '${context.read<RouteProvider>().routeIdData!.stops!.length}');
                Provider.of<GMapsProvider>(context, listen: false)
                    .stopData
                    .clear();

                if (context.read<RouteProvider>().routeIdData != null) {
                  if (context.read<RouteProvider>().routeIdData!.stops !=
                      null) {
                    for (int j = 0;
                        j <
                            context
                                .read<RouteProvider>()
                                .routeIdData!
                                .stops!
                                .length;
                        j++) {
                      Provider.of<GMapsProvider>(context, listen: false).addStopData({
                        'serialNo': j.toString(),
                        'id':context.read<RouteProvider>().routeIdData!.stops![j]["id"],
                        'location': {
                          'lat': context.read<RouteProvider>().routeIdData!.stops![j]['location']['lat'],
                          'long': context.read<RouteProvider>().routeIdData!.stops![j]['location']['long'],
                          'address': context.read<RouteProvider>().routeIdData!.stops![j]["location"]["address"],
                        },
                      }, j);
                    }
                  }
                }

                // for(int i=0;i<context.read<RouteProvider>().routeIdData!.stops!.length;i++){
                //   Provider.of<GMapsProvider>(context, listen: false).addStopData({
                //     'serialNo': context.read<RouteProvider>().routeIdData!.stops![i]["serialNo"],
                //     'location': {
                //       'lat': context.read<RouteProvider>().routeIdData!.stops![i]["location"]["lat"],
                //       'long': context.read<RouteProvider>().routeIdData!.stops![i]["location"]["long"],
                //       'address':context.read<RouteProvider>().routeIdData!.stops![i]["location"]["address"],
                //     },
                //   }, i);
                // }
                print(
                    'stop length--${Provider.of<GMapsProvider>(context, listen: false).stopData.length}');

                //Provider.of<GMapsProvider>(context,listen: false).stopData;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext ctx) => CreateRouteFormScreen(
                      routeId: context.read<RouteProvider>().routeIdData!.id,
                      //startLocation: context.read<RouteProvider>().routeIdData!.startLocation!['address'],
                    ),
                  ),
                );
              },
            ),
          ],
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        resizeToAvoidBottomInset: true,
        body: Consumer<RouteProvider>(
          builder: (context, i, _) {
            //if (i.routeIdData!.stops!.length != 0) {}
            return i.routeIdData != null
                ? Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height.h,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 25.h,
                              ),
                              i.routeIdData!.stops!.length != 0
                                  ? Expanded(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: i.routeIdData!.stops!.length,
                                        itemBuilder: (ctx, index) {
                                          return
                                              // i.routeIdData!.stops!.length != 0
                                              //   ?
                                              /*
                                        // Padding(
                                        //     padding:
                                        //         EdgeInsets.only(left: 12.0.h),
                                        //     child: TimelineTile(
                                        //       alignment: TimelineAlign.start,
                                        //       endChild: Padding(
                                        //         padding: EdgeInsets.only(
                                        //             left: 10.0.w,
                                        //             bottom: 16.0.h,
                                        //             right: 16),
                                        //         child: Column(
                                        //           mainAxisAlignment:
                                        //               MainAxisAlignment.start,
                                        //           children: [
                                        //             Row(
                                        //               children: [
                                        //                 Text(
                                        //                   "Stop ${index + 1}",

                                        //                   // i.routeIdData[index].stops.
                                        //                   style: TextStyle(
                                        //                       fontSize: 10.0.sp,
                                        //                       fontWeight:
                                        //                           FontWeight
                                        //                               .w700),
                                        //                 ),
                                        //               ],
                                        //             ),
                                        //             SizedBox(height: 3.h),
                                        //             Card(
                                        //               shape:
                                        //                   RoundedRectangleBorder(
                                        //                 side: BorderSide(
                                        //                     color: Colors
                                        //                         .grey.shade300,
                                        //                     width: .8),
                                        //                 borderRadius:
                                        //                     BorderRadius.circular(
                                        //                         12.r),
                                        //               ),
                                        //               child: ClipRRect(
                                        //                 borderRadius:
                                        //                     BorderRadius.circular(
                                        //                         12.r),
                                        //                 child: Container(
                                        //                   decoration:
                                        //                       BoxDecoration(
                                        //                     border: Border(
                                        //                       left: BorderSide(
                                        //                         color: Colors.grey
                                        //                             .shade300,
                                        //                         width: 5.0.w,
                                        //                       ),
                                        //                     ),
                                        //                   ),
                                        //                   child: Padding(
                                        //                     padding:
                                        //                         const EdgeInsets
                                        //                             .all(12.0),
                                        //                     child: Row(
                                        //                       crossAxisAlignment:
                                        //                           CrossAxisAlignment
                                        //                               .start,
                                        //                       children: [
                                        //                         Padding(
                                        //                           padding:
                                        //                               const EdgeInsets
                                        //                                       .all(
                                        //                                   8.0),
                                        //                           child: Column(
                                        //                             crossAxisAlignment:
                                        //                                 CrossAxisAlignment
                                        //                                     .start,
                                        //                             children: [
                                        //                               Text(
                                        //                                 "Date",
                                        //                                 style: TextStyle(
                                        //                                     fontSize: 9
                                        //                                         .sp,
                                        //                                     color: Colors
                                        //                                         .grey
                                        //                                         .shade600),
                                        //                               ),
                                        //                               Text(
                                        //                                 // "123",
                                        //                                 "${startformatterMonth.format(DateTime.fromMillisecondsSinceEpoch(
                                        //                                   (i.routeIdData!
                                        //                                       .createdOnDate!),
                                        //                                 ))}",

                                        //                                 // // "${DateTime.fromMillisecondsSinceEpoch(
                                        //                                 // //   (i.routeData[index]
                                        //                                 // //       .createdOnDate!),
                                        //                                 // // )}",
                                        //                                 style:
                                        //                                     TextStyle(
                                        //                                   fontSize:
                                        //                                       11.sp,
                                        //                                   fontWeight:
                                        //                                       FontWeight.w500,
                                        //                                 ),
                                        //                               ),
                                        //                               SizedBox(
                                        //                                 height:
                                        //                                     10.h,
                                        //                               ),
                                        //                               Text(
                                        //                                 "Active",
                                        //                                 style:
                                        //                                     TextStyle(
                                        //                                   fontSize:
                                        //                                       9.sp,
                                        //                                   color: Colors
                                        //                                       .grey
                                        //                                       .shade600,
                                        //                                 ),
                                        //                               ),
                                        //                               Text(
                                        //                                 i.routeIdData!
                                        //                                     .timeOfReaching!,
                                        //                                 style:
                                        //                                     TextStyle(
                                        //                                   fontSize:
                                        //                                       11.sp,
                                        //                                   fontWeight:
                                        //                                       FontWeight.w600,
                                        //                                 ),
                                        //                               )
                                        //                             ],
                                        //                           ),
                                        //                         ),
                                        //                         SizedBox(
                                        //                           height: 25.h,
                                        //                         ),
                                        //                         Container(
                                        //                           margin:
                                        //                               EdgeInsets
                                        //                                   .only(
                                        //                             top: 10,
                                        //                           ),
                                        //                           height: 45.h,
                                        //                           child: Column(
                                        //                             children: [
                                        //                               Container(
                                        //                                 height:
                                        //                                     5.h,
                                        //                                 width:
                                        //                                     5.h,
                                        //                                 decoration:
                                        //                                     BoxDecoration(
                                        //                                   borderRadius:
                                        //                                       BorderRadius.circular(
                                        //                                     50,
                                        //                                   ),
                                        //                                   border:
                                        //                                       Border.all(
                                        //                                     width:
                                        //                                         1.h,
                                        //                                     color:
                                        //                                         Colors.green,
                                        //                                   ),
                                        //                                 ),
                                        //                               ),
                                        //                               Container(
                                        //                                 height:
                                        //                                     35.h,
                                        //                                 child:
                                        //                                     VerticalDivider(),
                                        //                               ),
                                        //                               Container(
                                        //                                 height:
                                        //                                     5.h,
                                        //                                 width:
                                        //                                     5.h,
                                        //                                 decoration:
                                        //                                     BoxDecoration(
                                        //                                   color: Colors
                                        //                                       .green,
                                        //                                   borderRadius:
                                        //                                       BorderRadius.circular(
                                        //                                     50,
                                        //                                   ),
                                        //                                 ),
                                        //                               ),
                                        //                             ],
                                        //                           ),
                                        //                         ),
                                        //                         Column(
                                        //                           mainAxisAlignment:
                                        //                               MainAxisAlignment
                                        //                                   .start,
                                        //                           crossAxisAlignment:
                                        //                               CrossAxisAlignment
                                        //                                   .start,
                                        //                           children: [
                                        //                             SizedBox(
                                        //                               height: 5.h,
                                        //                             ),
                                        //                             Text(
                                        //                               "hjh",
                                        //                               // "${i.routeIdData[index].startLocation![0]["locality"]}"
                                        //                               //     .toString(),
                                        //                               //  +
                                        //                               // "${i.routeIdData[index].startLocation![i]["country"]} ",
                                        //                               style:
                                        //                                   TextStyle(
                                        //                                 fontSize:
                                        //                                     11.sp,
                                        //                                 fontWeight:
                                        //                                     FontWeight
                                        //                                         .w500,
                                        //                               ),
                                        //                             ),
                                        //                             Text(
                                        //                               // "111",
                                        //                               i.routeIdData!
                                        //                                   .turckNumber!,
                                        //                               style:
                                        //                                   TextStyle(
                                        //                                 fontSize:
                                        //                                     9.sp,
                                        //                                 color: Colors
                                        //                                     .grey
                                        //                                     .shade600,
                                        //                               ),
                                        //                             ),
                                        //                             SizedBox(
                                        //                               height: 9.h,
                                        //                             ),
                                        //                             Text(
                                        //                               i
                                        //                                   .routeIdData!
                                        //                                   .stops![
                                        //                                       index]
                                        //                                       [
                                        //                                       'location']
                                        //                                       [
                                        //                                       'lat']
                                        //                                   .toString(),
                                        //                               style:
                                        //                                   TextStyle(
                                        //                                 fontSize:
                                        //                                     11.sp,
                                        //                                 fontWeight:
                                        //                                     FontWeight
                                        //                                         .w500,
                                        //                               ),
                                        //                             ),
                                        //                             Text(
                                        //                               // "111",
                                        //                               i.routeIdData!
                                        //                                   .turckNumber!,
                                        //                               style:
                                        //                                   TextStyle(
                                        //                                 fontSize:
                                        //                                     9.sp,
                                        //                                 color: Colors
                                        //                                     .grey
                                        //                                     .shade600,
                                        //                               ),
                                        //                             ),
                                        //                           ],
                                        //                         )
                                        //                       ],
                                        //                     ),
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //             ),
                                        //           ],
                                        //         ),
                                        //       ),
                                        //       beforeLineStyle: LineStyle(
                                        //           color: Colors.green,
                                        //           thickness: 2.0),
                                        //       afterLineStyle: LineStyle(
                                        //           color: active!
                                        //               ? Colors.green
                                        //               : Colors.grey,
                                        //           thickness: 1.5),
                                        //       isFirst: index == 0,
                                        //       isLast:
                                        //           index == i.tripData.length - 1,
                                        //       indicatorStyle: IndicatorStyle(
                                        //         indicatorXY: 0.0,
                                        //         width: 8.w,
                                        //         height: 8.w,
                                        //         color: active!
                                        //             ? Colors.green
                                        //             : Colors.grey,
                                        //       ),
                                        //     ),
                                        //   )
*/
                                              RouteDetailWidget(
                                            start: index == 0
                                                ? i.routeIdData!
                                                    .startLocation!['address']
                                                : i.routeIdData!
                                                        .stops![index - 1]
                                                    ['location']['address'],
                                            end: i.routeIdData!.stops![index]
                                                ['location']['address'],
                                            truckNumber:
                                                i.routeIdData!.turckNumber!,
                                            arriveTime:
                                                i.routeIdData!.stops![index]
                                                    ["timeOfReaching"],
                                            createdOnDate: i.routeIdData!
                                                .stops![index]["createdOnDate"],
                                            index: index,
                                            //routeIdData: i.routeIdData!,
                                            active: active!,
                                          );
                                          // : Text(
                                          //     "No Route Generate",
                                          //     style: TextStyle(
                                          //         color: Colors.black,
                                          //         fontSize: 20.sp),
                                          //   );
                                        },
                                      ),
                                    )
                                  : Text(
                                      "No Route Generate",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20.sp),
                                    ),
                              Padding(
                                padding: Platform.isIOS
                                    ? EdgeInsets.only(bottom: 8.0)
                                    : EdgeInsets.all(0),
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 8.0.h),
                                  width: 320.w,
                                  height: 45.h,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        shape:
                                            MaterialStateProperty.resolveWith(
                                                (states) =>
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10))),
                                        backgroundColor:
                                            MaterialStateColor.resolveWith(
                                                (states) => Color.fromRGBO(
                                                    53, 186, 139, 1))),
                                    onPressed: () {
                                      print('length of${i.routeIdData!.stops!.length}');
                                      if(i.routeIdData!.stops!.length>0){
                                        Provider.of<GMapsProvider>(context, listen: false).saveRouteDataByID(i.routeIdData!);
                                        Provider.of<GMapsProvider>(context, listen: false).setValueForAnimateCamera();
                                        Provider.of<GMapsProvider>(context, listen: false).initializeMarkers();
                                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>DriverHomeScreen(routes:i.routeIdData! ,)));
                                        navigationService.navigateTo(DriverHomeScreenRoute);
                                      }
                                      else{
                                        utilService!.showToast("You Can't start this route");
                                      }


                                    },
                                    child: Text(
                                      // AppLocalizations.of(context)
                                      //     .translate('Getroute'),
                                      "Start Route",
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (isLoading)
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          ),
                        )
                    ],
                  )
                : Container();
          },
        ));
  }
}
