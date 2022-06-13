import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';
import 'package:fruit_delivery_flutter/popups.dart/exit_alert_dialog.dart';
import 'package:fruit_delivery_flutter/providers/g_data_provider.dart';
import 'package:fruit_delivery_flutter/providers/products_provider.dart';
import 'package:fruit_delivery_flutter/providers/route_provider.dart';
import 'package:fruit_delivery_flutter/screens/create_route_form_screen.dart';
import 'package:fruit_delivery_flutter/services/navigation_service.dart';
import 'package:fruit_delivery_flutter/services/storage_service.dart';
import 'package:fruit_delivery_flutter/utils/routes.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';
import 'package:fruit_delivery_flutter/widgets/main_drawer_widget.dart';
import 'package:fruit_delivery_flutter/widgets/schedule_widget.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  var navigationService = locator<NavigationService>();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  String tagId = '';
  void active(String val) {
    setState(() {
      tagId = val;
    });
  }

  Future<void> _removeLoading() async {
    await Future.delayed(Duration(seconds: 5));
    setState(() {
      _loading = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                child: Text(
                  "There is not route yet.",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              width: 270.h,
              child: Text(
                "Tap here to create a new route.",
                textAlign: TextAlign.center,
                style: TextStyle(height: 1.3.h, fontSize: 14.sp),
              ),
            ),
            SizedBox(
              height: 35.h,
            ),
            GestureDetector(
              onTap: () {
                navigationService.navigateTo(CreateRouteFormScreenRoute);
              },
              child: CircleAvatar(
                radius: 57.h,
                backgroundColor: Color.fromRGBO(154, 219, 195, 1),
                child: CircleAvatar(
                  radius: 50.h,
                  backgroundColor: Color.fromRGBO(53, 186, 139, 1),
                  child: Icon(
                    Icons.add,
                    size: 50.h,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => ExitAlertDialog(),
    ).then((value) => value as bool);
  }
  var storageService = locator<StorageService>();

  @override
  void initState() {
    _removeLoading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: AppBar(
            backgroundColor: Colors.white,
            actions: [
              InkWell(
                onTap: () async {
                  var storageService = locator<StorageService>();
                  await storageService.setData("route", "/schedule-screen");
                  navigationService.navigateTo(NotificationScreenRoute);
                },
                child: Image.asset(
                  'assets/images/notification.png',
                  scale: 2.5,
                  // color: Colors.white,
                ),
              ),
            ],

            leading: InkWell(
              onTap: () async{
                // bool value=await storageService.getData("notificationIsActive")?? true;
                // Provider.of<GMapsProvider>(context,listen: false).setNotificationToggle(value);
                scaffoldKey.currentState?.openDrawer();
              },
              child: Image.asset(
                'assets/images/Menubutton.png',
                scale: 2.5.h,
              ),
            ), // leading: Text('abc'),

            centerTitle: false,

            title: Text(
              // AppLocalizations.of(context).translate('Schedule'),
              "Trips List",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Color.fromRGBO(
                  126,
                  133,
                  140,
                  1,
                ),
              ),
              // bottomOpacity: 0.0,
              // // backgroundColor: Theme.of(context).backgroundColor,
              // elevation: 0,
              // automaticallyImplyLeading: false,
            ),
          ),
        ),
        drawer: MainDrawerWidget(),
        body: Consumer<RouteProvider>(
          builder: (context, i, _) {
            return i.tripData.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.only(
                      // top: 0.h,
                      bottom: 10.h,
                      left: 5.w,
                      right: 10.w,
                    ),
                    child: Container(
                      child: Column(
                        children: [
                          // Row(
                          //   children: [
                          //     SizedBox(
                          //       width: 18.h,
                          //     ),
                          //     Text(
                          //       "Select Date",
                          //       style: TextStyle(
                          //         fontSize: (20.sp),
                          //         color: Color.fromRGBO(
                          //           88,
                          //           88,
                          //           88,
                          //           1,
                          //         ),
                          //         fontWeight: FontWeight.w600,
                          //       ),
                          //     ),
                          //     IconButton(
                          //       onPressed: () {},
                          //       icon: Icon(
                          //         Icons.keyboard_arrow_down,
                          //         size: 28.h,
                          //         color: Colors.grey.shade600,
                          //       ),
                          //     ),
                          //   ],
                          // ),

                          // SizedBox(height: 15.h),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.only(
                                top: 0.h,
                                bottom: 0.h,
                                right: 5.w,
                                left: 5.w,
                              ),
                              itemCount: i.tripData.length,
                              itemBuilder: (ctx, index) {
                                int a = i.tripData[index].stops!.length - 1;

                                print("trip len: ${i.tripData.length}");
                                return ScheduleWidget(
                                  // data: schedulelist[i],

                                  startDate: i.tripData[index].stops!.isNotEmpty
                                      ? i.tripData[index].stops![0]
                                          .timeOfReaching
                                      : "",
                                  endDate: i.tripData[index].stops!.isNotEmpty
                                      ? i.tripData[index].stops![a]
                                          .timeOfReaching
                                      : "",
                                  from: i.tripData[index].startLocation!
                                      .address, //LatLng(i.tripData[index].startLocation!.lat, i.tripData[index].startLocation!.long),
                                  to: i.tripData[index].stops!.isNotEmpty
                                      ? i.tripData[index].stops![a].location!
                                          .address
                                      //LatLng(i.tripData[index].stops![a].location!.lat.toDouble(), i.tripData[index].stops![a].location!.long.toDouble())
                                      : i.tripData[index].startLocation!
                                          .address, //LatLng(i.tripData[index].startLocation!.lat, i.tripData[index].startLocation!.long),

                                  tag: i.tripData[index]
                                      .id, //schedulelist[i]["id"],
                                  action: active,
                                  active: tagId == i.tripData[index].id
                                      //schedulelist[i]["id"]
                                      ? true
                                      : false,
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: Platform.isIOS
                                ? EdgeInsets.only(bottom: 20.0)
                                : EdgeInsets.all(0),
                            child: Container(
                              width: 310.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10.h,
                                ),
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(
                                      255,
                                      149,
                                      1,
                                      1,
                                    ),
                                    Color.fromRGBO(
                                      254,
                                      108,
                                      0,
                                      1,
                                    ),
                                  ],
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Provider.of<GMapsProvider>(context,
                                          listen: false)
                                      .stopData
                                      .clear();
                                  //print("map create length-${Provider.of<GMapsProvider>(context,listen: false).stopData.length}");

                                  navigationService
                                      .navigateTo(CreateRouteFormScreenRoute);
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (ctx) => CreateRouteFormScreen()));
                                },
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('CreateRoute'),
                                  // "Create Route",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : _loading;
          },
        ),
      ),
    );
  }

  Widget _loading = Center(child: CircularProgressIndicator());
}
