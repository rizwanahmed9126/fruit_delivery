import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:fruit_delivery_flutter/models/getallvender_model.dart';
import 'package:fruit_delivery_flutter/services/util_service.dart';
import 'package:geocoding/geocoding.dart' as loc;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'package:fruit_delivery_flutter/constants/color_constants.dart';
import 'package:fruit_delivery_flutter/globals.dart';
import 'package:fruit_delivery_flutter/local/app_localization.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
import 'package:fruit_delivery_flutter/providers/g_data_provider.dart';
import 'package:fruit_delivery_flutter/providers/products_provider.dart';
import 'package:fruit_delivery_flutter/providers/route_provider.dart';
import 'package:fruit_delivery_flutter/services/navigation_service.dart';
import 'package:fruit_delivery_flutter/utils/routes.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';
import 'package:fruit_delivery_flutter/widgets/add_stop_widget.dart';
import 'package:fruit_delivery_flutter/widgets/column_scroll_view.dart';
import 'package:fruit_delivery_flutter/widgets/location_txt_field.dart';
import 'package:fruit_delivery_flutter/widgets/my_item_create_route_widget.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:google_geocoding/google_geocoding.dart';

class CreateRouteFormScreen extends StatefulWidget {
  String? routeId;
  //String? startLocation;
  CreateRouteFormScreen({
    Key? key,
    this.routeId,
    //this.startLocation,
  }) : super(key: key);
  @override
  _CreateRouteFormScreenState createState() => _CreateRouteFormScreenState();
}

GMapsProvider? abc;

class _CreateRouteFormScreenState extends State<CreateRouteFormScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoadingProgress = false;
  var navigationService = locator<NavigationService>();
  TextEditingController startLocationController = TextEditingController();
  TextEditingController truckNoController = TextEditingController();
  final GlobalKey widgetKey = GlobalKey();
  late ValueChanged<List> onItemClicked;
  bool ignoringPointer = false;
  //List<String> length1 = ["sa0"];
  int length1 = 1;
  // var vendorData;

  void addField() {
    setState(() {
      length1 = length1 + 1;
      //length1.add("sa$a");
    });
  }

  void removeField() {
    setState(() {
      length1 = length1 - 1;
      //length1.removeAt(a);
    });
  }

  void active(var data) {
    // if (data)
    //   setState(() {
    //     vendorData =
    //         Provider.of<VendorProvider>(context, listen: false).vendorData;
    //   });
    Navigator.of(context).pop();
  }

  getFilledData(BuildContext context) async {
    Provider.of<ProductsProvider>(context, listen: false).selectedProducts =
        context.read<RouteProvider>().routeIdData!.products!;

    if (context.read<RouteProvider>().routeIdData!.stops!.length == 0) {
      length1 = 1;
    } else {
      length1 = context.read<RouteProvider>().routeIdData!.stops!.length;
    }

    truckNoController.text =
        context.read<RouteProvider>().routeIdData!.turckNumber!;
    // List<Placemark>? fromAddress = await placemarkFromCoordinates(context.read<RouteProvider>().routeIdData!.startLocation["address"]
    //     Provider.of<GMapsProvider>(context, listen: false)
    //         .currentLocation!
    //         .latitude!,
    //     Provider.of<GMapsProvider>(context, listen: false)
    //         .currentLocation!
    //         .longitude!);

    startLocationController.text =
        "${context.read<RouteProvider>().routeIdData!.startLocation!["address"]}";
    //"${fromAddress[0].street}, ${fromAddress[0].thoroughfare}, ${fromAddress[0].subAdministrativeArea}";

    setState(() {});
  }

  var uuid = new Uuid();
  String? _sessionToken;
  List<dynamic> _placeList = [];
  //
  //
  //  Position? currentPosition=_placeList[index]["description"];
  String? country;

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

  @override
  void initState() {
    abc = Provider.of<GMapsProvider>(context, listen: false);

    super.initState();
    if (widget.routeId != null) {
      getFilledData(context);
    }
  }

  int a = 1;
  bool show = true;
  var utilService = locator<UtilService>();

  @override
  void dispose() {
    abc!.stopData.clear();

    super.dispose();
  }
  var googleGeocoding =
      GoogleGeocoding("AIzaSyAzUY0SJ5MC1ug7UW3fRjVSby0wE4vDm7M");

  

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);
    return Consumer<ProductsProvider>(builder: (context, pp, _) {
      return WillPopScope(
        onWillPop: () async {
          context.read<ProductsProvider>().selectedProducts = [];
          context.read<ProductsProvider>().selectedProducts.clear();
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: false,
            elevation: 0.0,
            leadingWidth: 50.w,
            leading: Padding(
              padding: EdgeInsets.only(left: 5..w, top: 8.h),
              child: IconButton(
                padding: EdgeInsets.all(4.w),
                icon: Image.asset('assets/images/ArrowBack.png'),
                iconSize: 12.sp,
                onPressed: () {
                  // navigationService.navigateTo(CreateRouteScreenRoute);
                  context.read<ProductsProvider>().selectedProducts = [];
                  context.read<ProductsProvider>().selectedProducts.clear();

                  navigationService.closeScreen();
                },
              ),
            ),

            title: Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Text(
                widget.routeId == null
                    ? AppLocalizations.of(context).translate('CreateRoute')
                    : 'Edit Route',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
            // actions: [
            //   Padding(
            //     padding: EdgeInsets.only(right:18.0.w, top: 8.h),
            //     child: Container(
            //       decoration: BoxDecoration(color: buttonColor,borderRadius: BorderRadius.circular(12.r),
            //       ),
            //       child: Padding(
            //         padding: const EdgeInsets.all(12.0),
            //         child: Image.asset('assets/images/Notifications.png'),
            //       ),
            //       height: 35.w,
            //       width: 45.w,
            //     ),
            //   ),
            // ]
          ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          // floatingActionButton: pp.selectedProducts.length != 0
          //     ? Container(
          //         height: 45.h,
          //         decoration: BoxDecoration(
          //           color: baseColor,
          //           borderRadius: BorderRadius.circular(10),
          //           // shape: BoxShape.circle,
          //         ),
          //         margin: EdgeInsets.only(
          //           left: 15,
          //           right: 15,
          //         ),
          //         width: double.infinity,
          //         child: FloatingActionButton(
          //           backgroundColor: Colors.transparent,
          //           elevation: 0.0,
          //           onPressed: () async {
          //             if (truckNoController.text.isEmpty) {
          //               utilService.showToast("Truck Number can't be Empty");
          //             } else {
          //               if (startLocationController.text.isEmpty) {
          //                 Provider.of<RouteProvider>(context, listen: false)
          //                         .startLocationLt =
          //                     LatLng(
          //                         Provider.of<GMapsProvider>(context,
          //                                 listen: false)
          //                             .currentLocation!
          //                             .latitude!,
          //                         Provider.of<GMapsProvider>(context,
          //                                 listen: false)
          //                             .currentLocation!
          //                             .longitude!);
          //               } else {
          //                 List<Location> locations = await locationFromAddress(
          //                     startLocationController.text);

          //                 Provider.of<RouteProvider>(context, listen: false)
          //                         .startLocationLt =
          //                     LatLng(
          //                         locations[0].latitude, locations[0].longitude);
          //               }

          //               setState(() {
          //                 isLoadingProgress = true;
          //               });
          //               if (widget.routeId == null) {
          //                 await Provider.of<RouteProvider>(context, listen: false)
          //                     .createRouteFunc(
          //                   truckNoController.text,
          //                   context,
          //                 );
          //               } else {
          //                 await Provider.of<RouteProvider>(context, listen: false)
          //                     .updateRouteFunc(truckNoController.text,
          //                         widget.routeId!, context);
          //               }

          //               setState(() {
          //                 isLoadingProgress = false;
          //               });
          //             }
          //           },
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(
          //               20,
          //             ),
          //           ),
          //           child: Text(
          //             AppLocalizations.of(context).translate('Submit'),
          //             style: TextStyle(
          //               color: Colors.white,
          //               fontWeight: FontWeight.w700,
          //             ),
          //           ),
          //         ),
          //       )
          //     : Container(),
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(15.r),
                child: ColumnScrollView(
                    child: Column(children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        takeAddressTxtField(
                            // hint: "Start Location",
                            // controller: startLocationController,
                            // //editedStartLocation: widget.startLocation ?? '',
                            // suffixActive: true,
                            ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TimeLineTextField(
                                
                           
                                controller: truckNoController,
                                isFirst: false,
                                isLast: false,
                                hintText: 'Truck Number',
                                timelineAlignment: TimelineAlign.start,
                                suffixOnpress: () {},
                                isSuffixIcon: false,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            // Padding(
                            //   padding: EdgeInsets.only(bottom: 15.0.h),
                            //   child: GestureDetector(
                            //       onTap: () {},
                            //       child: Icon(
                            //         Icons.close,
                            //         color: Colors.black54,
                            //         size: 18.sp,
                            //       )),
                            // )
                          ],
                        ),
                        Stack(
                          children: [
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: length1,
                              itemBuilder: (BuildContext context, int index) {
                                // if(context.read<RouteProvider>().routeIdData!=null){
                                //   if (context.read<RouteProvider>().routeIdData!.stops != null) {
                                //     for (int j = 0; j < context.read<RouteProvider>().routeIdData!.stops!.length; j++) {
                                //       Provider.of<GMapsProvider>(context, listen: false).addStopData({
                                //         'serialNo': index.toString(),
                                //         'location': {
                                //           'lat': context.read<RouteProvider>().routeIdData!.stops![j]['location']['lat'],
                                //           'long': context.read<RouteProvider>().routeIdData!.stops![j]['location']['long'],
                                //           'address':context.read<RouteProvider>().routeIdData!.stops![j]["location"]["address"],
                                //
                                //         },
                                //       }, index);
                                //     }
                                //   }
                                // }
                                return Row(
                                  children: [
                                    AddStopWidget(
                                      // key: UniqueKey(),
                                      index: index,
                                      filledAddress: widget.routeId != null && length1 == context.read<RouteProvider>().routeIdData!.stops!.length
                                          ? context.read<RouteProvider>().routeIdData!.stops![index]['location']['address']
                                          : "",
                                      time: widget.routeId != null &&
                                              length1 ==
                                                  context
                                                      .read<RouteProvider>()
                                                      .routeIdData!
                                                      .stops!
                                                      .length
                                          ? context
                                              .read<RouteProvider>()
                                              .routeIdData!
                                              .stops![index]['timeOfReaching']
                                          : "",
                                    ),
                                    // Container(
                                    //   width: 30.w,
                                    //   child: Visibility(
                                    //     visible: length1.length == 1 ? false : true,
                                    //     child: IconButton(
                                    //         onPressed: () {
                                    //           Provider.of<GMapsProvider>(context, listen: false).removeStop(index);
                                    //           show=false;
                                    //           //removeField(index);
                                    //         },
                                    //         icon: Icon(
                                    //           Icons.close,
                                    //           color: Colors.black54,
                                    //           size: 18.sp,
                                    //         )
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                );
                              },
                            ),

                            Positioned.fill(
                              bottom: 15.h,
                              right: 0.w,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: InkWell(
                                  onTap: () {
                                    addField();
                                    //a=a+1;
                                  },
                                  child: Container(
                                      width: 20.w,
                                      padding: EdgeInsets.all(4.w),
                                      child: Icon(Icons.add)),
                                ),
                              ),
                            )
                            // : Container()
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  if (pp.selectedProducts.length != 0)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("My Items"),
                        GestureDetector(
                          onTap: () async {
                            showLoadingAnimation(context);

                            await Provider.of<ProductsProvider>(context,
                                    listen: false)
                                .fetchAllProducts(count: 100, page: 1);

                            navigationService.closeScreen();
                            navigationService.navigateTo(AddFruitScreenRoute);
                          },
                          child: Container(
                              padding: EdgeInsets.fromLTRB(
                                8,
                                4,
                                8,
                                4,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.green.shade50,
                              ),
                              child: Icon(Icons.add)),
                        )
                      ],
                    ),
                  SizedBox(
                    height: pp.selectedProducts.length == 0 ? 20 : 0,
                  ),

                  SizedBox(
                    height: pp.selectedProducts.length == 0 ? 20 : 0,
                  ),
                  pp.selectedProducts.length == 0
                      ? GestureDetector(
                          onTap: () async {
                            setState(() {
                              isLoadingProgress = true;
                            });
                            await Provider.of<ProductsProvider>(context,
                                    listen: false)
                                .fetchAllProducts(count: 100, page: 1);

                            setState(() {
                              isLoadingProgress = false;
                            });
                            // showDialog(
                            //     context: context,
                            //     barrierDismissible: false,
                            //     builder: (_) {
                            //       return WarningScreen();
                            //     });
                            navigationService.navigateTo(AddFruitScreenRoute);
                          },
                          child: Container(
                            alignment: Alignment.bottomRight,
                            height: 95.h,
                            child: Image.asset(
                              'assets/images/add-fruits.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            ListView.builder(
                                itemCount: pp.selectedProducts.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (ctx, i) {
                                  return pp.selectedProducts.length == 0
                                      ? Center(
                                          child: Text(
                                            "No data found",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10),
                                          ),
                                        )
                                      : MyItemsList(
                                          data: pp.selectedProducts[i],
                                          active: active,
                                        );
                                }),
                            SizedBox(
                              height: 20.h,
                            )
                          ],
                        ),

                  // Consumer<VendorProvider>(
                  //     builder: (context, provider, child) {
                  //     return ListView.builder(
                  //         itemCount: provider.vendorData.length,
                  //         shrinkWrap: true,
                  //         physics: NeverScrollableScrollPhysics(),
                  //         itemBuilder: (ctx, i) {
                  //           return MyItemsList(
                  //             data: provider.vendorData.products[i],
                  //             active: active,
                  //           );
                  //         });
                  //   }),
                  SizedBox(height: 10.h),
                  // pp.selectedProducts.length != 0
                  //     ? GestureDetector(
                  //         onTap: () {
                  //           // showDialog(
                  //           //     context: context,
                  //           //     barrierDismissible: false,
                  //           //     builder: (_) {
                  //           //       return WarningScreen();
                  //           //     });
                  //           navigationService.navigateTo(DriverHomeScreenRoute);
                  //           //navigationService.navigateTo(RouteDetailScreenRoute);
                  //         },
                  //         child: Container(
                  //           alignment: Alignment.center,
                  //           decoration: BoxDecoration(
                  //               color: baseColor,
                  //               borderRadius: BorderRadius.circular(8.0.r)),
                  //           height: 45.w,
                  //           width: double.infinity,
                  //           child: Text(
                  //               AppLocalizations.of(context).translate('Submit'),
                  //               style: TextStyle(
                  //                   color: Colors.white,
                  //                   fontWeight: FontWeight.w700)),
                  //         ),
                  //       )
                  //     : Container()
                ])),
              ),
              isLoadingProgress == true
                  ? Positioned.fill(
                      child: Align(
                      alignment: Alignment.center,
                      child: Platform.isIOS
                          ? CupertinoActivityIndicator()
                          : CircularProgressIndicator(),
                    ))
                  : Container(),
              pp.selectedProducts.length != 0
                  ? Positioned.fill(
                      bottom: 10.h,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: AbsorbPointer(
                          absorbing: ignoringPointer,
                          child: Container(
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
                              onPressed: () async {
                                if (truckNoController.text.isEmpty) {
                                  utilService
                                      .showToast("Truck Number can't be Empty");
                                } else {
                                  if (startLocationController.text.isEmpty) {
                                    Provider.of<RouteProvider>(context,
                                                listen: false)
                                            .startLocationLt =
                                        LatLng(
                                            Provider.of<GMapsProvider>(context,
                                                    listen: false)
                                                .currentLocation!
                                                .latitude!,
                                            Provider.of<GMapsProvider>(context,
                                                    listen: false)
                                                .currentLocation!
                                                .longitude!);
                                  } else {
                                    //List<Location> locations =await locationFromAddress(startLocationController.text);

                                    List<Component> abc = [];

                                    var risult = await googleGeocoding.geocoding
                                        .get(startLocationController.text, abc);

                                    Provider.of<RouteProvider>(context,
                                            listen: false)
                                        .startLocationLt = LatLng(
                                      risult!.results!.first.geometry!.location!
                                          .lat!,
                                      risult.results!.first.geometry!.location!
                                          .lng!,
                                    );
                                  }

                                  setState(() {
                                    isLoadingProgress = true;
                                    ignoringPointer = true;
                                  });
                                  if (widget.routeId == null) {
                                    await Provider.of<RouteProvider>(context,
                                            listen: false)
                                        .createRouteFunc(
                                      truckNoController.text,
                                      context,
                                    );
                                  } else {
                                    await Provider.of<RouteProvider>(context,
                                            listen: false)
                                        .updateRouteFunc(truckNoController.text,
                                            widget.routeId!, context);
                                  }

                                  setState(() {
                                    isLoadingProgress = false;
                                    ignoringPointer = false;
                                  });
                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                              ),
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('Submit'),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      );
    });
  }

  Widget takeAddressTxtField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 40.h,
          child: TextFormField(
              // readOnly: true,
              onTap: () {
                // _onChanged();
              },
              onChanged: (e) {
                _onChanged(startLocationController.text);
              },
              controller: startLocationController,
              cursorColor: baseColor,
              cursorHeight: 20,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 12.0.w),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0.r),
                    borderSide: BorderSide(
                      color: baseColor,
                      width: 1.4,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0.r),
                    borderSide: BorderSide(
                      color: smokeColor,
                      width: 1.4,
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0.r),
                      ),
                      borderSide: BorderSide(color: smokeColor)),
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: new TextStyle(
                      color: Color(0xffb5bcc6),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500),
                  hintText: "Start Location",
                  suffixIcon: InkWell(
                    onTap: () async {
                      // LatLng current=LatLng();
                      List<loc.Placemark>? fromAddress =
                          await loc.placemarkFromCoordinates(
                              Provider.of<GMapsProvider>(context, listen: false)
                                  .currentLocation!
                                  .latitude!,
                              Provider.of<GMapsProvider>(context, listen: false)
                                  .currentLocation!
                                  .longitude!);
                      startLocationController.text =
                          "${fromAddress[0].street}, ${fromAddress[0].thoroughfare}, ${fromAddress[0].subAdministrativeArea}";
                      setState(() {});
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Image.asset('assets/images/Current-Location.png',
                            height: 25.w, width: 25.w)),
                  ))),
        ),
        _placeList.isNotEmpty
            ? Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 1),
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
                            startLocationController.text =
                                _placeList[index]["description"];
                            // List<loc.Location> locations = await loc.locationFromAddress(
                            //  _placeList[index]["description"]);
                            List<Component> abc = [];

                            var risult = await googleGeocoding.geocoding
                                .get(startLocationController.text, abc);

                            Provider.of<GMapsProvider>(context, listen: false)
                                .saveRouteData(routeModel(
                              lng: risult!
                                  .results!.first.geometry!.location!.lat!,
                              lat: risult
                                  .results!.first.geometry!.location!.lng!,
                            ));

                            setState(() {
                              _placeList.clear();
                            });

                            //print('length--${Provider.of<GMapsProvider>(context,listen: false).routesData.length}');
                          },
                          child: ListTile(
                            title: Text(_placeList[index]["description"]),
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
    );
  }
}

// ignore: must_be_immutable

// ignore: must_be_immutable
class TimeLineTextField extends StatelessWidget {
  String? hintText;

  Color? indicatorColor;
  bool isFirst;
  bool isLast;
  bool isSuffixIcon;
  IconData? suffixIcon;
  TextEditingController? controller;
  TimelineAlign timelineAlignment;
  VoidCallback suffixOnpress;

  

  TimeLineTextField(
      {this.controller,
     
      required this.isLast,
      required this.isFirst,
      this.indicatorColor,
      required this.timelineAlignment,
      this.hintText,
      required this.isSuffixIcon,
      required this.suffixOnpress,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isLast: isLast,
      isFirst: isFirst,
      lineXY: 0.0,
      beforeLineStyle: LineStyle(color: iconColor, thickness: 1.5),
      afterLineStyle: LineStyle(color: iconColor, thickness: 1.5),
      indicatorStyle: IndicatorStyle(
        indicatorXY: 0.5,
        width: 5.w,
        height: 5.w,
        color: baseColor,
      ),
      alignment: timelineAlignment,
      endChild: Padding(
        padding: EdgeInsets.only(left: 8.0.w, bottom: 12.0.w),
        child: Container(
          height: 40.h,
          child: TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(8),
              ],
              controller: controller,
              cursorColor: baseColor,
              cursorHeight: 20,
             
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 12.0.w),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0.r),
                  borderSide: BorderSide(
                    color: baseColor,
                    width: 1.4,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0.r),
                  borderSide: BorderSide(
                    color: smokeColor,
                    width: 1.4,
                  ),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0.r),
                    ),
                    borderSide: BorderSide(color: smokeColor)),
                filled: true,
                fillColor: Colors.white,
                hintStyle: new TextStyle(
                    color: Color(0xffb5bcc6),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500),
                hintText: hintText,
                suffixIcon: isSuffixIcon == true
                    ? Padding(
                        padding: const EdgeInsets.all(6),
                        child: GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                                'assets/images/Current-Location.png',
                                height: 25.w,
                                width: 25.w)))
                    : null,
              )),
        ),
      ),
    );
  }
}
