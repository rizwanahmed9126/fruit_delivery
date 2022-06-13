import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/constants/color_constants.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';
import 'package:fruit_delivery_flutter/models/favourate_model.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/user_provider.dart';
import 'package:fruit_delivery_flutter/providers/g_data_provider.dart';
import 'package:fruit_delivery_flutter/services/storage_service.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';
import 'package:fruit_delivery_flutter/widgets/column_scroll_view.dart';
import 'package:fruit_delivery_flutter/widgets/location_radio_widget.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  StorageService? storageService = locator<StorageService>();
  var _controller = TextEditingController();
  var uuid = new Uuid();
  var userData;
  String? _sessionToken;
  List<dynamic> _placeList = [];
  //
  //
  //  Position? currentPosition=_placeList[index]["description"];

  _onChanged(String abc) {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(abc);
  }

  void getSuggestion(String input) async {
    String aPiKey = "AIzaSyAzUY0SJ5MC1ug7UW3fRjVSby0wE4vDm7M";
    // String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$aPiKey&sessiontoken=$_sessionToken&region=pk';
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      setState(() {
        _placeList = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  List<Placemark>? fromAddress;
  getAddress() async {
    fromAddress = await placemarkFromCoordinates(
        Provider.of<GMapsProvider>(context, listen: false)
            .currentLocation!
            .latitude!,
        Provider.of<GMapsProvider>(context, listen: false)
            .currentLocation!
            .longitude!);
    setState(() {});
  }

  String tagId = '1';

  void active(
    dynamic val,
  ) {
    setState(() {
      tagId = val;
    });
  }

  @override
  void initState() {
    getAddress();
    getlocation();
    getAddress();
    setState(() {});
    super.initState();
  }

  getlocation() async {
    userData = Provider.of<UserProvider>(context, listen: false).userData;
    value = ["${userData.address}"];
    SharedPreferences pref = await SharedPreferences.getInstance();
    value = pref.getStringList("location")!;
  }

  int? len;
  double? lat;
  double? long;
  String? country;
  String? city;
  String? address;
  bool save = false;
  List<String> value = [];
  // List<Placemark>? fromAddress;

  // getAddress() async {
  //   fromAddress = await placemarkFromCoordinates(
  //       Provider.of<GMapsProvider>(context, listen: false)
  //           .currentLocation!
  //           .latitude!,
  //       Provider.of<GMapsProvider>(context, listen: false)
  //           .currentLocation!
  //           .longitude!);

  //   setState(() {});
  // }

//  List<Placemark>? fromAddress= await placemarkFromCoordinates(
//
//                       );
//                       startLocationController.text="${fromAddress[0].street}, ${fromAddress[0].thoroughfare}, ${fromAddress[0].subAdministrativeArea}";
//                       setState(() {});
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
    return Consumer<UserProvider>(builder: (context, i, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          height: 45.h,
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: BorderRadius.circular(10),
            // shape: BoxShape.circle,
          ),
          margin: EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          width: double.infinity,
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            hoverElevation: 0,
            highlightElevation: 0,
            onPressed: () async {
              if (value.length > 5) {
                value.removeAt(0);
              }
              save = true;
              i.editUsersLocation(
                value: value,
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            child: Text(
              // "jj",
              AppLocalizations.of(context).translate('Save'),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                      AppLocalizations.of(context).translate('LocationHeading'),
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                SizedBox(
                  height: 25.h,
                ),
                tagId == "2"
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 400.w,
                            height: 40.h,
                            child: TextFormField(
                              onChanged: (e) {
                                _onChanged(_controller.text);
                              },
                              controller: _controller,
                              cursorColor: baseColor,
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 20),
                                prefixIcon:
                                    Icon(Icons.search, color: Colors.grey),
                                hintText: AppLocalizations.of(context)
                                    .translate('Search'),
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 14.sp),
                                filled: true,
                                fillColor: Color.fromRGBO(235, 244, 250, 1),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.h)),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.h)),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          _placeList.isNotEmpty
                              ? Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2.5,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[300]!,
                                            spreadRadius: 3,
                                            blurRadius: 2)
                                      ]),
                                  child: ListView.builder(
                                    itemCount: _placeList.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              _controller.text =
                                                  _placeList[index]
                                                      ["description"];

                                              List<Location> locations =
                                                  await locationFromAddress(
                                                      _placeList[index]
                                                          ["description"]);

                                              value.add(_placeList[index]
                                                  ["description"]);

                                              setState(() {
                                                _placeList.clear();
                                                _controller.text = "";
                                              });

                                              //print('length--${Provider.of<GMapsProvider>(context,listen: false).routesData.length}');
                                            },
                                            child: ListTile(
                                              title: Text(_placeList[index]
                                                  ["description"]),
                                            ),
                                          ),
                                          Container(
                                            height: 1,
                                            color: Colors.grey[300],
                                          )
                                          //Divider(),
                                        ],
                                      );
                                    },
                                  ),
                                )
                              : Text(' ')
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 100.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.h),
                      border: Border.all(color: Colors.grey.shade300)),
                  child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 0, top: 6.h),
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
                SizedBox(
                  height: 25.h,
                ),
                Text(
                  AppLocalizations.of(context).translate('NearbyLocations'),
                  style:
                      TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
                ),
                SizedBox(
                  height: value == [""] ? 40.h : 10.h,
                ),
                tagId == "1"
                    ? Text(
                        fromAddress == null
                            ? ""
                            : "${fromAddress![0].street}, ${fromAddress![0].thoroughfare}, ${fromAddress![0].subAdministrativeArea}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      )
                    : value == [""]
                        ? Center(
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Image.asset(
                                    "assets/images/no_location_yet.png")))
                        : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: value.length,
                            itemBuilder: (BuildContext context, int i) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    value[i].toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  )
                                ],
                              );
                            },
                          ),
                SizedBox(
                  height: 50.h,
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
