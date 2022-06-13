import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/user_provider.dart';
import 'package:fruit_delivery_flutter/services/navigation_service.dart';
import 'package:fruit_delivery_flutter/services/storage_service.dart';
import 'package:fruit_delivery_flutter/utils/routes.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';
import 'package:provider/provider.dart';
import '../widgets/trip_item_widget.dart';

class TripScreen extends StatefulWidget {
  TripScreen({Key? key}) : super(key: key);

  @override
  _TripScreenState createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  var navigationService = locator<NavigationService>();
  bool isloadingprogress = false;
  String tagId = ' ';
  void active(
    dynamic val,
  ) {
    setState(() {
      tagId = val;
    });
  }

  Future<void> _removeLoading() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _loading = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 280,
                ),
                child: Text(
                  "There is not any active vendor in your region yet.",
                  overflow: TextOverflow.visible,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      );
    });
  }

  @override
  void initState() {
    _removeLoading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: AppBar(
            backgroundColor: Colors.white,
            actions: [
              InkWell(
                onTap: () async {
                  var storageService = locator<StorageService>();
                  await storageService.setData("route", "/trip-screen");
                  navigationService.navigateTo(NotificationScreenRoute);
                },
                child: Image.asset(
                  'assets/images/notification.png',
                  scale: 2.5,
                  // color: Colors.white,
                ),
              ),
            ],

            leading: Builder(
              builder: (context) => IconButton(
                icon: Image.asset(
                  'assets/images/ArrowBack.png',
                  scale: 2.5,
                  // color: Colors.white,
                ),
                onPressed: () => navigationService.closeScreen(),
              ),
            ), // leading: Text('abc'),

            centerTitle: true,

            title: Image.asset(
              'assets/images/logoleaf.png',
              scale: 14,
              // color: Colors.white,
            ),
            bottomOpacity: 0.0,
            // backgroundColor: Theme.of(context).backgroundColor,
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
        ),
        body: provider.vendersData.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Text(
                      "Check driver's scheduled trip \n& buy fruits in your area",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // InkWell(
                  //   onTap: () async {
                  //     setState(() {
                  //       isloadingprogress = true;
                  //     });
                  //     await Provider.of<UserProvider>(context, listen: false)
                  //         .fetchVendorsRoutebyId(provider.vendersData[0].id!);

                  //     setState(() {
                  //       isloadingprogress = false;
                  //     });
                  //   },
                  //   child: Container(
                  //     height: 28.h,
                  //     width: 80.h,
                  //     color: Colors.red,
                  //     // child: ElevatedButton(
                  //     // style: ButtonStyle(
                  //     //     elevation: MaterialStateProperty.resolveWith(
                  //     //         (states) => 0),
                  //     //     shadowColor: MaterialStateProperty.resolveWith(
                  //     //         (states) => Colors.grey.shade400),
                  //     //     backgroundColor: MaterialStateColor.resolveWith(
                  //     //         (states) => Colors.white),
                  //     //     shape: MaterialStateProperty.resolveWith((states) =>
                  //     //         RoundedRectangleBorder(
                  //     //             borderRadius: BorderRadius.circular(50),
                  //     //             side: BorderSide(
                  //     //                 color: Colors.grey.shade600,
                  //     //                 width: 1)))),

                  //     child: Text(
                  //       "Trip Detail",
                  //       style: TextStyle(
                  //           fontSize: 9.sp, color: Colors.grey.shade600),
                  //     ),
                  //   ),
                  // ),
                  // ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: provider.vendersData.length,
                        itemBuilder: (ctx, i) {
                          return TripItemWidget(
                            data: provider.vendersData[i],
                            action: active,
                            tag: provider.vendersData[i].id,
                            active: tagId == provider.vendersData[i].id
                                ? true
                                : false,
                          );
                        }),
                  )
                ],
              )
            : _loading,
      );
    });
  }

  Widget _loading = Center(child: CircularProgressIndicator());
}
