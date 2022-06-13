// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:uuid/uuid.dart';
//
// import 'package:fruit_delivery_flutter/constants/color_constants.dart';
// import 'package:fruit_delivery_flutter/providers/g_data_provider.dart';
//
// // ignore: must_be_immutable
// class TakeAddressTxtField extends StatefulWidget {
//   String? hint;
//   bool? suffixActive;
//   TextEditingController controller;
//
//
//
//   TakeAddressTxtField({
//     Key? key,
//     this.hint,
//     this.suffixActive,
//     required this.controller
//
//
//   }) : super(key: key);
//
//   @override
//   _TakeAddressTxtFieldState createState() => _TakeAddressTxtFieldState();
// }
//
// class _TakeAddressTxtFieldState extends State<TakeAddressTxtField> {
//   //var _controller = TextEditingController();
//   var uuid = new Uuid();
//   String? _sessionToken;
//   List<dynamic> _placeList = [];
//   //
//   //
//   //  Position? currentPosition=_placeList[index]["description"];
//   String? country;
//
//   _onChanged(String abc) {
//     if (_sessionToken == null) {
//       setState(() {
//         _sessionToken = uuid.v4();
//       });
//     }
//     getSuggestion(abc);
//   }
//
//   @override
//   void initState() {
//     // if (widget.editedStartLocation!.isNotEmpty) {
//     //   _controller.text = widget.editedStartLocation!;
//     // }
//
//     super.initState();
//   }
//
//   void getSuggestion(String input) async {
//     String aPiKey = "AIzaSyAzUY0SJ5MC1ug7UW3fRjVSby0wE4vDm7M";
//     // String type = '(regions)';
//     String baseURL =
//         'https://maps.googleapis.com/maps/api/place/autocomplete/json';
//     String request =
//         '$baseURL?input=$input&key=$aPiKey&sessiontoken=$_sessionToken&region=pk';
//     var response = await http.get(Uri.parse(request));
//     if (response.statusCode == 200) {
//       setState(() {
//         _placeList = json.decode(response.body)['predictions'];
//       });
//     } else {
//       throw Exception('Failed to load predictions');
//     }
//   }
//
//   // _getCurrentLocation() {
//   //   Geolocator.getCurrentPosition(
//   //           desiredAccuracy: LocationAccuracy.best,
//   //           forceAndroidLocationManager: true)
//   //       .then((Position position) {
//   //     setState(() {
//   //      country = position;
//   //       _getAddressFromLatLng();
//   //     });
//   //   }).catchError((e) {
//   //     print(e);
//   //   });
//   // }
//
//   // _getAddressFromLatLng() async {
//   //   try {
//   //     List<Placemark> placemarks = await placemarkFromCoordinates(
//   //         currentPosition!.latitude, currentPosition!.longitude);
//
//   //     Placemark place = placemarks[0];
//
//   //     setState(() {
//   //       country =
//   //           "${place.country}";
//   //     });
//   //   } catch (e) {
//   //     print(e);
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Container(
//           height: 40.h,
//           child: TextFormField(
//               // readOnly: true,
//               onTap: () {
//                 // _onChanged();
//               },
//               onChanged: (e) {
//                 _onChanged(widget.controller.text);
//               },
//               controller: widget.controller,
//               cursorColor: baseColor,
//               cursorHeight: 20,
//               decoration: InputDecoration(
//                   contentPadding: EdgeInsets.only(left: 12.0.w),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0.r),
//                     borderSide: BorderSide(
//                       color: baseColor,
//                       width: 1.4,
//                     ),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0.r),
//                     borderSide: BorderSide(
//                       color: smokeColor,
//                       width: 1.4,
//                     ),
//                   ),
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(8.0.r),
//                       ),
//                       borderSide: BorderSide(color: smokeColor)),
//                   filled: true,
//                   fillColor: Colors.white,
//                   hintStyle: new TextStyle(
//                       color: Color(0xffb5bcc6),
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.w500),
//                   hintText: widget.hint,
//                   suffixIcon: widget.suffixActive == true
//                       ? InkWell(
//                     onTap: ()async{
//                      // LatLng current=LatLng();
//                       List<Placemark>? fromAddress= await placemarkFromCoordinates(
//                           Provider.of<GMapsProvider>(context,listen: false).currentLocation!.latitude!, Provider.of<GMapsProvider>(context,listen: false).currentLocation!.longitude!
//                       );
//                       widget.controller.text="${fromAddress[0].street}, ${fromAddress[0].thoroughfare}, ${fromAddress[0].subAdministrativeArea}";
//                       setState(() {});
//
//
//                     },
//                         child: Padding(
//                             padding: const EdgeInsets.all(6),
//                             child: Image.asset(
//                                 'assets/images/Current-Location.png',
//                                 height: 25.w,
//                                 width: 25.w)),
//                       )
//                       : null
//                   // timeController.text =
//                   // '${_time.format(context)}',
//
//                   )),
//         ),
//         _placeList.isNotEmpty
//             ? Container(
//                 height: MediaQuery.of(context).size.height / 2.5,
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: Colors.grey, width: 1),
//                     borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(8),
//                         bottomRight: Radius.circular(8)),
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.grey[300]!,
//                           spreadRadius: 3,
//                           blurRadius: 2)
//                     ]),
//                 child: ListView.builder(
//                   itemCount: _placeList.length,
//                   itemBuilder: (context, index) {
//                     return Column(
//                       children: [
//                         InkWell(
//                           onTap: () async {
//                             widget.controller.text = _placeList[index]["description"];
//                             List<Location> locations = await locationFromAddress(_placeList[index]["description"]);
//                             Provider.of<GMapsProvider>(context, listen: false).saveRouteData(routeModel(
//                               lng: locations[0].longitude,
//                               lat: locations[0].latitude,
//                             ));
//
//                             setState(() {
//                               _placeList.clear();
//                             });
//
//                             //print('length--${Provider.of<GMapsProvider>(context,listen: false).routesData.length}');
//                           },
//                           child: ListTile(
//                             title: Text(_placeList[index]["description"]),
//                           ),
//                         ),
//                         Container(
//                           height: 1,
//                           color: Colors.grey[300],
//                         )
//                         //Divider(),
//                       ],
//                     );
//                   },
//                 ),
//               )
//             : Text(' ')
//       ],
//     );
//   }
// }
