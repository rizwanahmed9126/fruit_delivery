// // ignore_for_file: unused_element
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fruit_delivery_flutter/local/app_localization.dart';
// import 'package:fruit_delivery_flutter/services/storage_service.dart';
// import '../widgets/main_drawer_widget.dart';
// import '../services/navigation_service.dart';
// import '../utils/routes.dart';
// import '../utils/service_locator.dart';
// import '../widgets/card_map.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
//
// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   late GoogleMapController mapController;
//   double _originLatitude = 6.5212402, _originLongitude = 3.3679965;
//   double _destLatitude = 6.5212401, _destLongitude = 3.3679964;
//   // double _originLatitude = 24.860966, _originLongitude = 66.990501;
//   // double _destLatitude = 26.46423, _destLongitude = 66.06358;
//   Map<MarkerId, Marker> markers = {};
//   Map<PolylineId, Polyline> polylines = {};
//   List<LatLng> polylineCoordinates = [];
//   PolylinePoints polylinePoints = PolylinePoints();
//   // String googleAPiKey = "AIzaSyB4tnldf4HMr4M9eQwkYy9OZirIeojuLzA";
//
//   @override
//   void initState() {
//     super.initState();
//
//     /// origin marker
//     _addMarker(LatLng(_originLatitude, _originLongitude), "origin",
//         BitmapDescriptor.defaultMarker);
//
//     /// destination marker
//     _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
//         BitmapDescriptor.defaultMarkerWithHue(90));
//     // _getPolyline();
//   }
//
//   var navigationService = locator<NavigationService>();
//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.init(
//         BoxConstraints(
//             maxWidth: MediaQuery.of(context).size.width,
//             maxHeight: MediaQuery.of(context).size.height),
//         designSize: Size(360, 690),
//         orientation: Orientation.portrait);
//     return Scaffold(
//         drawer: MainDrawerWidget(),
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(65),
//           child: AppBar(
//             backgroundColor: Colors.white,
//             actions: [
//               InkWell(
//                 onTap: () async {
//                   var storageService = locator<StorageService>();
//                   await storageService.setData("route", "/map-sample-screen");
//                   navigationService.navigateTo(NotificationScreenRoute);
//                 },
//                 child: Image.asset(
//                   'assets/images/notification.png',
//                   scale: 2.5,
//                   // color: Colors.white,
//                 ),
//               ),
//             ],
//
//             leading: Builder(
//               builder: (context) => IconButton(
//                   icon: Image.asset(
//                     'assets/images/Menubutton.png',
//                     scale: 2.5,
//                     // color: Colors.white,
//                   ),
//                   onPressed: () {
//                     Scaffold.of(context).openDrawer();
//                   }),
//             ), // leading: Text('abc'),
//
//             // centerTitle: true,
//
//             title: Text(
//               AppLocalizations.of(context).translate('DrawerTracking'),
//               // "Tracking",
//               style: TextStyle(color: Colors.black),
//             ),
//             bottomOpacity: 0.0,
//             // backgroundColor: Theme.of(context).backgroundColor,
//             elevation: 0,
//             automaticallyImplyLeading: false,
//           ),
//         ),
//         body: Stack(
//           children: [
//             GoogleMap(
//               initialCameraPosition: CameraPosition(
//                   target: LatLng(_originLatitude, _originLongitude), zoom: 15),
//               myLocationEnabled: true,
//               tiltGesturesEnabled: true,
//               compassEnabled: true,
//               scrollGesturesEnabled: true,
//               zoomGesturesEnabled: true,
//               onMapCreated: _onMapCreated,
//               markers: Set<Marker>.of(markers.values),
//               polylines: Set<Polyline>.of(polylines.values),
//             ),
//             Positioned(
//               child: Align(
//                 alignment: Alignment.topCenter,
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Container(
//                       padding: EdgeInsets.only(left: 8.w, right: 8.w),
//                       child: TextField(
//                         onTap: () async {
//                           var storageService = locator<StorageService>();
//                           await storageService.setData(
//                               "route", "/map-sample-screen");
//
//                           navigationService
//                               .navigateTo(DriverLocationScreenRoute);
//                         },
//                         readOnly: true,
//                         style: TextStyle(color: Colors.black, fontSize: 14.sp),
//                         decoration: new InputDecoration(
//                           border: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Color.fromRGBO(242, 243, 245, 1),
//                                 width: 1.0),
//                             borderRadius: const BorderRadius.all(
//                               const Radius.circular(30.0),
//                             ),
//                           ),
//                           enabledBorder: new OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Color.fromRGBO(242, 243, 245, 1),
//                                 width: 1.0),
//                             borderRadius: const BorderRadius.all(
//                               const Radius.circular(30.0),
//                             ),
//                           ),
//                           focusedBorder: new OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Color.fromRGBO(242, 243, 245, 1),
//                                 width: 1.0),
//                             borderRadius: const BorderRadius.all(
//                               const Radius.circular(30.0),
//                             ),
//                           ),
//                           prefixIcon: Icon(Icons.search),
//                           filled: true,
//                           hintStyle: new TextStyle(
//                               color: Colors.grey, fontSize: 12.sp),
//                           hintText: AppLocalizations.of(context)
//                               .translate('Searchforalocation'),
//                           fillColor: Color.fromRGBO(235, 244, 250, 1),
//                           contentPadding: EdgeInsets.all(15.0),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//               child: Align(
//                 alignment: Alignment.bottomCenter,
//                 child: MapCard(),
//               ),
//             ),
//           ],
//         ));
//   }
//
//   void _onMapCreated(GoogleMapController controller) async {
//     mapController = controller;
//   }
//
//   _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
//     MarkerId markerId = MarkerId(id);
//     Marker marker =
//         Marker(markerId: markerId, icon: descriptor, position: position);
//     markers[markerId] = marker;
//   }
//
//   _addPolyLine() {
//     PolylineId id = PolylineId("poly");
//     Polyline polyline = Polyline(
//         polylineId: id, color: Colors.red, points: polylineCoordinates);
//     polylines[id] = polyline;
//     setState(() {});
//   }
//
//   // _getPolyline() async {
//   //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//   //       // googleAPiKey,
//   //       PointLatLng(_originLatitude, _originLongitude),
//   //       PointLatLng(_destLatitude, _destLongitude),
//   //       travelMode: TravelMode.driving,
//   //       wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]);
//   //   if (result.points.isNotEmpty) {
//   //     result.points.forEach((PointLatLng point) {
//   //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//   //     });
//   //   }
//   //   _addPolyLine();
//   // }
// }
