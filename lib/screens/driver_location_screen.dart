import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';

import '../models/favourate_model.dart';
import '../services/navigation_service.dart';
import '../services/storage_service.dart';
import '../utils/routes.dart';
import '../utils/service_locator.dart';
import '../widgets/column_scroll_view.dart';
import '../widgets/location_radio_widget.dart';

class DriverLocationScreen extends StatefulWidget {
  DriverLocationScreen({Key? key}) : super(key: key);

  @override
  _DriverLocationScreenState createState() => _DriverLocationScreenState();
}

class _DriverLocationScreenState extends State<DriverLocationScreen> {
  List<FavourateList> locationItem = [
    FavourateList(
        id: "1",
        title: "688 Cherry Hill Drive Gulfport,",
        subtitle: "MS 39503"),
    FavourateList(
        id: "2",
        title: "688 Cherry Hill Drive Gulfport,",
        subtitle: "MS 39503"),
    FavourateList(
        id: "3",
        title: "688 Cherry Hill Drive Gulfport,",
        subtitle: "MS 39503"),
    FavourateList(
        id: "4",
        title: "688 Cherry Hill Drive Gulfport,",
        subtitle: "MS 39503"),
    FavourateList(
        id: "5",
        title: "688 Cherry Hill Drive Gulfport,",
        subtitle: "MS 39503"),
    FavourateList(
        id: "6",
        title: "688 Cherry Hill Drive Gulfport,",
        subtitle: "MS 39503"),
    FavourateList(
        id: "7",
        title: "688 Cherry Hill Drive Gulfport,",
        subtitle: "MS 39503"),
    FavourateList(
        id: "8",
        title: "688 Cherry Hill Drive Gulfport,",
        subtitle: "MS 39503"),
    FavourateList(
        id: "9",
        title: "688 Cherry Hill Drive Gulfport,",
        subtitle: "MS 39503"),
  ];
  List<FavourateList> get getFavlist {
    return this.locationItem;
  }

  String tagId = ' ';
  String tagid = ' ';
  void active(
    dynamic val,
  ) {
    setState(() {
      tagId = val;
    });
  }

  void actived(
    dynamic val,
  ) {
    setState(() {
      tagid = val;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  var navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> locationRadio = [
      {
        "id": "1",
        "title": AppLocalizations.of(context).translate('UseCurrentLocation'),
      },
      {
        "id": "2",
        "title":
            AppLocalizations.of(context).translate('SeacrhLocationfromMap'),
      },
    ];
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,

        actions: [
          InkWell(
            onTap: () async {
              var storageService = locator<StorageService>();
              await storageService.setData("route", "/driver-location-screen");
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
                // _selectedIndex != 3
                //     ? 'assets/images/Menubutton.png'
                // :
                "assets/images/ArrowBack.png",
                scale: 2.5,
                // color: Colors.white,
              ),
              onPressed: () async {
                var storageService, data;
                storageService = locator<StorageService>();
                data = await storageService.getData("route");
                navigationService.navigateTo(data);
              }),
        ), // leading: Text('abc'),

        centerTitle: true,
        title:
            // _selectedIndex != 3
            // ?
            Image.asset(
          'assets/images/logoleaf.png',
          scale: 14,
          // color: Colors.white,
        ),
        // : Text(
        //     'My Profile',
        //     style: TextStyle(
        //       color: Colors.white,
        //       fontSize: 22.sp,
        //       fontWeight: FontWeight.w700,
        //     ),
        //   ),
        bottomOpacity: 0.0,
        // backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,

        automaticallyImplyLeading: false,
      ),
      body: ColumnScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.h, right: 16.h),
                  width: 400.h,
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 20),
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      hintText:
                          AppLocalizations.of(context).translate('Search'),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                      filled: true,
                      fillColor: Color.fromRGBO(235, 244, 250, 1),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.h)),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.h)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 25),
                  child: Container(
                    height: 100.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.h),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: ListView.builder(
                        padding: EdgeInsets.only(
                          bottom: 10.h,
                          top: 8.h,
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: locationRadio.length,
                        itemBuilder: (ctx, i) {
                          return LocationRadiowidget(
                            data: locationRadio[i],
                            action: active,
                            tag: locationRadio[i]['id'],
                            active:
                                tagId == locationRadio[i]['id'] ? true : false,
                          );
                        }),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        navigationService.navigateTo(CreateRouteScreenRoute);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        textStyle: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.03,
                            fontWeight: FontWeight.w600),
                        fixedSize: Size(
                          MediaQuery.of(context).size.width * 0.90,
                          MediaQuery.of(context).size.height * 0.070,
                        ),
                        primary: Theme.of(context).accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          side: BorderSide(
                            width: 1,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 5.w,
                          right: 10.w,
                        ),
                        child: Text(
                          AppLocalizations.of(context).translate('CreateRoute'),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 18.0.h,
                  ),
                  child: Text(
                    AppLocalizations.of(context).translate('NearbyLocations'),
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14.sp,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            Center(
                child: Container(
                    margin: EdgeInsets.only(top: 60),
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Image.asset("assets/images/no_location_yet.png")))
            // ListView.builder(
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   padding: EdgeInsets.only(),
            //   itemCount: locationItem.length,
            //   itemBuilder: (ctx, i) {
            //     return DriverLocationWidget(
            //       data: locationItem[i],
            //     );
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
