import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';
import 'package:fruit_delivery_flutter/models/route_detail_model.dart';
import 'package:fruit_delivery_flutter/popups.dart/warning_dialogue.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/user_provider.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
import 'package:fruit_delivery_flutter/providers/g_data_provider.dart';
import 'package:fruit_delivery_flutter/screens/schedule_screen.dart';
import 'package:fruit_delivery_flutter/services/navigation_service.dart';
import 'package:fruit_delivery_flutter/services/util_service.dart';
import 'package:fruit_delivery_flutter/utils/routes.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';
import 'package:fruit_delivery_flutter/widgets/custom_button.dart';
import 'package:fruit_delivery_flutter/widgets/will_pop.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MapCard extends StatefulWidget {
  //final VoidCallback reached;
  // final VoidCallback cancel;
  // final VoidCallback next;

  const MapCard({
    Key? key,
    //required this.reached,
    //required this.cancel,required this.next,
  }) : super(key: key);

  @override
  _MapCardState createState() => _MapCardState();
}

class _MapCardState extends State<MapCard> {
  // List<RouteDetailList> routeDetailList = [
  //   RouteDetailList(
  //     id: "1",
  //     title: "15 Heritage Court South Portland..",
  //     mtitle: " START POINT",
  //     status: true,
  //   ),
  //   RouteDetailList(
  //     id: "2",
  //     title: "9365 Ashley Street York,PA 1740..",
  //     mtitle: " END POINT",
  //     status: false,
  //   ),
  // ];
  var navigationService = locator<NavigationService>();
  UtilService? utilService = locator<UtilService>();
  // var vendor;
  // @override
  // void initState() {
  //   vendor=Provider.of<VendorProvider>(context,listen: false).vendorData;
  //   // TODO: implement initState
  //   super.initState();
  // }
  //bool enableNext=false;
  @override
  Widget build(BuildContext context) {
    return Consumer<GMapsProvider>(
      builder: (context, i, _) {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 15),
          child: Container(
            //height:MediaQuery.of(context).size.height / 2.6,
            width: MediaQuery.of(context).size.width * 0.95,

            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[300]!, blurRadius: 3, spreadRadius: 2)
                ]),

            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<VendorProvider>(
                    builder: (context, i, _) {
                      return ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: ClipRRect(
                            borderRadius: BorderRadius.circular(12.h),
                            child: CachedNetworkImage(
                              imageUrl: i.vendorData!.profilePicture!,
                              placeholder: (context, url) => Image.asset(
                                'assets/images/placeholder1.png',
                              ),
                              errorWidget: (context, url, error) => Center(
                                child: Image.asset(
                                  'assets/images/not_found1.png',
                                ),
                              ),
                              fit: BoxFit.cover,
                              height: 40.h,
                              width: 45.w,
                            )
                            // Image.network(
                            //   '${i.vendorData!.profilePicture}',
                            //   height: 40.h,
                            //   width: 45.w,
                            //   fit: BoxFit.fill,
                            // ),
                            ),
                        title: Text('${i.vendorData!.fullName}'),
                        subtitle: Text('Driver',
                            style: TextStyle(
                                color: Colors.black45, fontSize: 12.sp)),
                        trailing: InkWell(
                            onTap: () {
                              // navigationService.navigateTo(ChatScreenRoute);
                            },
                            child: GestureDetector(
                              onTap: () {
                                //navigationService.navigateTo(TripDetailScreenRoute);
                                // showDialog(
                                //     context: context,
                                //     barrierDismissible: false,
                                //     builder: (_) {
                                //       return WarningScreen();
                                //     });
                              },
                              // navigationService.navigateTo(TripDetailScreenRoute),
                              child: Container(
                                padding: EdgeInsets.all(8.h),
                                decoration: BoxDecoration(
                                    color: Colors.lightGreen.shade50,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  'Trip Details',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp),
                                ),
                              ),
                            )),
                      );
                    },
                  ),

                  Container(
                    width: double.infinity,
                    height: 1.h,
                    color: Colors.grey.shade300,
                  ),

                  Container(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 20,
                            //color: Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                children: [
                                  Icon(Icons.circle,
                                      size: 12, color: Colors.green),
                                  Container(
                                    height: 40,
                                    width: 1,
                                    color: Colors.grey[200],
                                  ),
                                  Icon(
                                    Icons.circle_outlined,
                                    color: Colors.green,
                                    size: 12,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'START POINT,',
                                    style: TextStyle(
                                        color: Colors.black26, fontSize: 10.sp),
                                  ),
                                  Container(
                                    height: 17.h,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    //color: Colors.red,
                                    child: Text(
                                      '${i.Address1}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'END POINT,',
                                    style: TextStyle(
                                        color: Colors.black26, fontSize: 10.sp),
                                  ),
                                  Container(
                                    height: 17.h,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    // color: Colors.red,
                                    child: Text(
                                      '${i.Address2}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            height: 50,
                            width: 1,
                            color: Colors.grey[200],
                          ),
                          Container(
                            height: 50,
                            child: Center(
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text("Distance",
                                      style: TextStyle(
                                          color: Colors.black26,
                                          fontSize: 12.sp)),
                                  RichText(
                                    text: TextSpan(
                                      text: '${i.runTimeDistance}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24.sp,
                                          color: Colors.black54),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: ' km',
                                            style: TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 18.sp)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Expanded(
                  //       child: ListView.builder(
                  //           shrinkWrap: true,
                  //           itemCount: routeDetailList.length,
                  //           itemBuilder: (ctx, index) {
                  //             return Padding(
                  //               padding: EdgeInsets.only(left: 12.0.h),
                  //               child: TimelineTile(
                  //                 alignment: TimelineAlign.start,
                  //                 endChild: Padding(
                  //                   padding: EdgeInsets.only(bottom: 8.h),
                  //                   child: Row(
                  //                     children: [
                  //                       Padding(
                  //                         padding: EdgeInsets.only(left: 8.h),
                  //                         child: Column(
                  //                           crossAxisAlignment:
                  //                               CrossAxisAlignment.start,
                  //                           children: [
                  //                             Text(
                  //                               '${routeDetailList[index].mtitle},',
                  //                               style: TextStyle(
                  //                                   color: Colors.black26,
                  //                                   fontSize: 10.sp),
                  //                             ),
                  //                             Text(
                  //                               '${routeDetailList[index].title},',
                  //                               style: TextStyle(
                  //                                   fontWeight: FontWeight.bold,
                  //                                   fontSize: 12.sp),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 beforeLineStyle: LineStyle(color: Colors.green, thickness: 2.0),
                  //                 afterLineStyle: LineStyle(color: Colors.grey, thickness: 1.5),
                  //                 isFirst: index == 0,
                  //                 isLast: index == routeDetailList.length - 1,
                  //                 indicatorStyle: IndicatorStyle(
                  //                     indicatorXY: 0.5,
                  //                     width: 8.w,
                  //                     height: 8.w,
                  //                     color: Colors.green),
                  //               ),
                  //             );
                  //           }),
                  //     ),
                  //     Container(
                  //       height: 100,
                  //
                  //       width: 1,
                  //       color: Colors.grey[200],
                  //     ),
                  //     Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text("Distance",
                  //             style: TextStyle(
                  //                 color: Colors.black26, fontSize: 12.sp)
                  //         ),
                  //
                  //         RichText(
                  //           text: TextSpan(
                  //             text: '00',
                  //             style: TextStyle(
                  //                 fontWeight: FontWeight.bold,
                  //                 fontSize: 24.sp,
                  //                 color: Colors.black54),
                  //             children: <TextSpan>[
                  //               TextSpan(
                  //                   text: ' km',
                  //                   style: TextStyle(
                  //                     // fontWeight: FontWeight.bold,
                  //                       fontSize: 18.sp)),
                  //             ],
                  //           ),
                  //         )
                  //       ],
                  //     )
                  // ]),

                  SizedBox(
                    height: 5.h,
                  ),

                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: Cros,
                      children: [
                        CustomButton(
                          onTap: i.enableReach
                              ? () {
                                  if (i.reaching <
                                      i.routeDataByID!.stops!.length) {
                                    i
                                        .callReachRoute(
                                            i.routeDataByID!.id!,
                                            i.routeDataByID!.stops![i.reaching]
                                                ["id"])
                                        .then((value) {
                                      if (value == "true") {
                                        i.getMarkers(
                                            "a${i.reaching}",
                                            LatLng(
                                                i.routeDataByID!
                                                        .stops![i.reaching]
                                                    ['location']['lat'],
                                                i.routeDataByID!
                                                        .stops![i.reaching]
                                                    ['location']['long']),
                                            i.pointCompleteIcon,
                                            "${i.reaching + 1} Stop",
                                            "Completed");
                                        i.enableNext = true;
                                        i.enableReach = false;
                                      } else {
                                        utilService!
                                            .showToast("Sorry BE error");
                                      }
                                    });
                                  } else {
                                    utilService!.showToast("Route Completed");
                                  }
                                }
                              : () {
                                  print('empty reached');
                                },
                          name:
                              AppLocalizations.of(context).translate('Reached'),
                          color: i.enableReach
                              ? Color.fromRGBO(6, 164, 2, 1)
                              : Colors.grey,
                          txtColor: Colors.white,
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        CustomButton(
                          onTap: i.enableNext
                              ? () {
                                  if (i.reaching <
                                      i.routeDataByID!.stops!.length - 1) {
                                    i
                                        .callNextStopRoute(
                                            i.routeDataByID!.id!,
                                            i.routeDataByID!.stops![i.reaching]
                                                ["id"])
                                        .then((value) {
                                      if (value == "true") {
                                        i.reachingInc();
                                        i.getMarkers(
                                            "a${i.reaching}",
                                            LatLng(
                                                i.routeDataByID!
                                                        .stops![i.reaching]
                                                    ['location']['lat'],
                                                i.routeDataByID!
                                                        .stops![i.reaching]
                                                    ['location']['long']),
                                            i.pointReachingIcon,
                                            "${i.reaching + 1} Stop",
                                            "${i.routeDataByID!.stops![i.reaching]["timeOfReaching"]}");

                                        i.updateDistanceEndPoint(
                                          LatLng(
                                              i.routeDataByID!
                                                      .stops![i.reaching - 1]
                                                  ['location']['lat'],
                                              i.routeDataByID!
                                                      .stops![i.reaching - 1]
                                                  ['location']['long']),
                                          LatLng(
                                              i.routeDataByID!
                                                      .stops![i.reaching]
                                                  ['location']['lat'],
                                              i.routeDataByID!
                                                      .stops![i.reaching]
                                                  ['location']['long']),
                                        );
                                        i.updateAddress(
                                          i.routeDataByID!
                                                  .stops![i.reaching - 1]
                                              ['location']['address'],
                                          i.routeDataByID!.stops![i.reaching]
                                              ['location']['address'],
                                        );

                                        i.enableNext = false;
                                        i.enableReach = true;
                                      } else {
                                        utilService!
                                            .showToast("Sorry BE error");
                                      }
                                    });
                                  } else {
                                    utilService!.showToast("Route Completed");
                                  }
                                }
                              : () {
                                  utilService!.showToast(
                                      "You have to complete the previous stop first!");
                                },
                          name: AppLocalizations.of(context)
                              .translate('nextstep'),
                          color: i.enableNext
                              ? Color.fromRGBO(255, 122, 0, 1)
                              : Colors.grey,
                          txtColor: Colors.white,
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        CustomButton(
                          onTap: () {
                            showOnWillPop(context, () {
                              navigationService.navigateTo(ScheduleScreenRoute);
                              i.dispose();
                              i.startTrip = false;
                              i.enableNext = false;
                              i.enableReach = true;
                              i.reaching = 0;
                              i.complete = 1;
                            });

                            //navigationService.closeScreen();
                          },
                          name:
                              AppLocalizations.of(context).translate('cancel'),
                          color: Color.fromRGBO(242, 243, 245, 1),
                          txtColor: Colors.grey.shade600,
                        ),
                      ]),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
