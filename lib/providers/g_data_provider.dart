import 'dart:async';
import 'dart:io';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_delivery_flutter/models/routes_id_by_user_model.dart';
import 'package:fruit_delivery_flutter/services/http_service.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:haversine_distance/haversine_distance.dart';
import 'package:location/location.dart';

class GMapsProvider with ChangeNotifier {
  String aPiKey = "AIzaSyAzUY0SJ5MC1ug7UW3fRjVSby0wE4vDm7M";
  HttpService? http = locator<HttpService>();

  List stopData = [];
  List<routeModel> routesData = [];
  Location? location = new Location();
  bool? drawerNotificationToggle = true;

  setNotificationToggle(bool value) {
    drawerNotificationToggle = value;
    notifyListeners();
  }

  // LocationData? vendorCurrentLocation;
  // LocationData? userCurrentLocation;
  //
  // getVendorCurrentLocation() async {
  //   vendorCurrentLocation = await location!.getLocation();
  // }
  //
  // getUserCurrentLocation() async {
  //   userCurrentLocation = await location!.getLocation();
  //
  // }

  bool startTrip = false;

  bool enableNext = false;
  bool enableReach = true;

  // bool disableNext=true;
  // bool disableReach=false;

  // setStartTripValue(bool value){
  //   enableNext=value;
  //   notifyListeners();
  // }
  double runTimeDistance = 0.0;

  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String? Address1;
  String? Address2;

  LatLng? firstPoint;

  LatLng? initialPoint;
  LatLng? nextPoint;
  LocationData? currentLocation;
  late GoogleMapController mapController;
  StreamSubscription<LocationData>? locationSubscription;

  RouteById? routeDataByID;

  BitmapDescriptor? startPoint;
  BitmapDescriptor? pinLocationIcon;
  BitmapDescriptor? pointReachingIcon;
  BitmapDescriptor? pointCompleteIcon;
  BitmapDescriptor? currentPositionMarker;

  LatLng? fromLocationLatLng;
  LatLng? toLocationLatLng;

  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;

  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  get routeData {
    return this.routesData;
  }

  get getStops {
    return this.stopData;
  }

  Future<dynamic> callStartRoute(String id) async {
    try {
      var response = await http!.startRoute(id);

      if (response.statusCode == 200) {
        return "${response.data['isSuccess']}";
      } else {
        return "fail";
      }
    } catch (error) {
      print(error.toString());
      return "fail";
    }
  }

  Future<dynamic> callReachRoute(String routeID, String reachID) async {
    try {
      var response = await http!.reachRoute(routeID, reachID);

      if (response.statusCode == 200) {
        return "${response.data['isSuccess']}";
      } else {
        return "fail";
      }
    } catch (error) {
      print(error.toString());
      return "fail";
    }
  }

  Future<dynamic> callNextStopRoute(String routeID, String reachID) async {
    try {
      var response = await http!.nextStopRoute(routeID, reachID);

      if (response.statusCode == 200) {
        return "${response.data['isSuccess']}";
      } else {
        return "fail";
      }
    } catch (error) {
      print(error.toString());
      return "fail";
    }
  }

  Future<dynamic> notificationOnOFff(bool value) async {
    try {
      var response = await http!.notificationOnOff(value);

      if (response.statusCode == 200) {
        return "${response.data['isSuccess']}";
      } else {
        return "fail";
      }
    } catch (error) {
      print(error.toString());
      return "fail";
    }
  }

  @override
  void dispose() {
    mapController.dispose();
    locationSubscription!.cancel();
    markers.clear();
    startTrip = false;
    reaching = 0;
    complete = 1;
  }

  saveRouteDataByID(RouteById value) {
    routeDataByID = value;
    notifyListeners();
  }

  calculateDistance(LatLng start, LatLng end) {
    runTimeDistance = Geolocator.distanceBetween(
            start.latitude, start.longitude, end.latitude, end.longitude) /
        1000;
    runTimeDistance = double.parse(runTimeDistance.toStringAsFixed(2));
    notifyListeners();
  }

  saveRouteData(routeModel value) {
    routesData.add(value);
  }

  addStopData(var data, var index) {
    var flag = true;
    this.stopData.forEach((element) {
      if (int.parse(element['serialNo']) == index) {
        flag = false;
      }
    });
    if (flag) {
      this.stopData.add(data);
    } else {
      this.stopData[index]['location'] = data['location'];
    }
  }

  addtime(var data, var index) {
    var flag = true;
    this.stopData.forEach((element) {
      if (int.parse(element['serialNo']) == index) {
        flag = false;
      }
    });
    if (flag) {
      this.stopData[index]['timeOfReaching'] = data;
    } else {
      this.stopData[index]['timeOfReaching'] = data;
    }
  }

  removeStop(var index) {
    print(this.stopData.length);
    this
        .stopData
        .removeWhere((element) => element['serialNo'] == index.toString());
    print(this.stopData.length);
    // this.stopData.removeAt(index);
    // print(this.stopData.length);
  }

  getMarkers(String id, LatLng position, BitmapDescriptor? icon,
      String stopNmbr, String time) async {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
        markerId: markerId,
        icon: icon!,
        position: position,
        infoWindow: InfoWindow(title: "$stopNmbr", snippet: "$time")

        //rotation: currentLocation!.heading!,
        );
    markers[markerId] = marker;
    notifyListeners();
  }

  startMarker(String id, LatLng position, BitmapDescriptor? icon) async {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
      markerId: markerId,
      icon: icon!,
      position: position,
      rotation: currentLocation!.heading!,
    );
    markers[markerId] = marker;
  }

  getCurrentLocation() async {
    _serviceEnabled = await location!.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location!.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }

    _permissionGranted = await location!.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location!.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    currentLocation = await location!.getLocation();
  }

  setValueForAnimateCamera() {
    fromLocationLatLng = LatLng(routeDataByID!.startLocation!['lat'],
        routeDataByID!.startLocation!['long']);
    toLocationLatLng = LatLng(
        routeDataByID!.stops![routeDataByID!.stops!.length - 1]['location']
            ['lat'],
        routeDataByID!.stops![routeDataByID!.stops!.length - 1]['location']
            ['long']);
    notifyListeners();
  }

  // initializeMarkers() async {
  //   pinLocationIcon = await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration(size: Size(20, 20)),
  //       Platform.isIOS
  //           ? 'assets/images/points2-Ios.png'
  //           : 'assets/images/points2.png');
  //   startPoint = await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration(size: Size(20, 20)), 'assets/images/startPoint.png');
  //   currentPositionMarker = await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration(size: Size(20, 20)), 'assets/images/live_arrow.png');
  //   pointReachingIcon = await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration(size: Size(20, 20)),
  //       Platform.isIOS
  //           ? 'assets/images/pointReachingIcon-Ios.png'
  //           : 'assets/images/pointReachingIcon.png');
  //   pointCompleteIcon = await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration(size: Size(20, 20)),
  //       'assets/images/pointCompleteIcon.png');

  //   //pointReachingIcon.png
  //   notifyListeners();
  // }

  initializeMarkers() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(20, 20)),
        // Platform.isIOS
        // ?
        'assets/images/points2-Ios.png'
        // : 'assets/images/points2.png'
        );
    startPoint = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(15, 15)), 'assets/images/startPoint.png');
    currentPositionMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(15, 15)), 'assets/images/live_arrow.png');
    pointReachingIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(15, 15)),
        // Platform.isIOS
        // ?
        'assets/images/pointReachingIcon-Ios.png'
        // : 'assets/images/pointReachingIcon.png'
        );
    pointCompleteIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(15, 15)),
        'assets/images/pointCompleteIcon.png');
    //pointReachingIcon.png
    notifyListeners();
  }

  int reaching = 0;
  int complete = 1;
  reachingInc() {
    //if(reaching<=routeDataByID!.stops!.length){
    reaching = reaching + 1;
    // }
    // else{
    //   print('route completed');
    // }
    notifyListeners();
  }

  completeInc() {
    if (complete < routeDataByID!.stops!.length) {
      complete = complete + 1;
    }
    notifyListeners();
  }

  updateDistanceEndPoint(LatLng value, LatLng value1) {
    firstPoint = value;
    nextPoint = value1;
    calculateDistance(
      value,
      value1,
    );
    notifyListeners();
  }

  updateAddress(String value, String value1) {
    Address1 = value;
    Address2 = value1;
    notifyListeners();
  }

  getLiveTracking() {
    Address1 = routeDataByID!.startLocation!['address'];
    Address2 = routeDataByID!.stops![0]['location']['address'];
    firstPoint = LatLng(routeDataByID!.startLocation!['lat'],
        routeDataByID!.startLocation!['long']);
    initialPoint = LatLng(routeDataByID!.startLocation!['lat'],
        routeDataByID!.startLocation!['long']);
    nextPoint = LatLng(routeDataByID!.stops![0]['location']['lat'],
        routeDataByID!.stops![0]['location']['long']);
    calculateDistance(
      initialPoint!,
      nextPoint!,
    );

    getMarkers(
        "a$reaching",
        LatLng(routeDataByID!.stops![reaching]['location']['lat'],
            routeDataByID!.stops![reaching]['location']['long']),
        pointReachingIcon,
        "${reaching + 1} Stop",
        "${routeDataByID!.stops![reaching]['timeOfReaching']}");
    //reachingInc();

    //getMarkers("a0", LatLng(routeDataByID!.stops![0]['location']['lat'], routeDataByID!.stops![0]['location']['long']),pointReachingIcon);

    locationSubscription =
        location!.onLocationChanged.listen((LocationData cLoc) {
      print('current');

      initialPoint = LatLng(cLoc.latitude!, cLoc.longitude!);

      calculateDistance(
        initialPoint!,
        nextPoint!,
      );

      currentLocation = cLoc;

      startMarker(
          "live",
          LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
          currentPositionMarker);

      // CameraPosition cPosition = CameraPosition(zoom: 15, target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),);
      // mapController.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    });
    notifyListeners();
  }

  getPolyline() async {
    polylineCoordinates.clear();

    PolylineResult? result;
    getMarkers(
        "a",
        LatLng(routeDataByID!.startLocation!['lat'],
            routeDataByID!.startLocation!['long']),
        startPoint,
        "Start",
        "Start Point");
    getMarkers(
        "a0",
        LatLng(routeDataByID!.stops![0]['location']['lat'],
            routeDataByID!.stops![0]['location']['long']),
        pinLocationIcon,
        "1 Stop",
        "${routeDataByID!.stops![0]["timeOfReaching"]}");
    result = await polylinePoints.getRouteBetweenCoordinates(
      aPiKey,
      PointLatLng(routeDataByID!.startLocation!['lat'],
          routeDataByID!.startLocation!['long']),
      PointLatLng(routeDataByID!.stops![0]['location']['lat'],
          routeDataByID!.stops![0]['location']['long']),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    for (int j = 1; j < routeDataByID!.stops!.length; j++) {
      print('length${routeDataByID!.stops!.length}');
      getMarkers(
          "a$j",
          LatLng(routeDataByID!.stops![j]['location']['lat'],
              routeDataByID!.stops![j]['location']['long']),
          pinLocationIcon,
          "${j + 1} Stop",
          "${routeDataByID!.stops![j]["timeOfReaching"]}");
      result = await polylinePoints.getRouteBetweenCoordinates(
        aPiKey,
        PointLatLng(routeDataByID!.stops![j - 1]['location']['lat'],
            routeDataByID!.stops![j - 1]['location']['long']),
        PointLatLng(routeDataByID!.stops![j]['location']['lat'],
            routeDataByID!.stops![j]['location']['long']),
        travelMode: TravelMode.driving,
        // wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]
      );
      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }
    }
    _addPolyLine();
    notifyListeners();
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Color(0xFFacacac),
        width: 5,
        points: polylineCoordinates);
    polylines[id] = polyline;
    notifyListeners();
  }

  animateCamera() {
    mapController.animateCamera(
      CameraUpdate.newLatLngBounds(
          LatLngBounds(
              southwest: LatLng(
                  fromLocationLatLng!.latitude <= toLocationLatLng!.latitude
                      ? fromLocationLatLng!.latitude
                      : toLocationLatLng!.latitude,
                  fromLocationLatLng!.longitude <= toLocationLatLng!.longitude
                      ? fromLocationLatLng!.longitude
                      : toLocationLatLng!.longitude),
              northeast: LatLng(
                  fromLocationLatLng!.latitude <= toLocationLatLng!.latitude
                      ? toLocationLatLng!.latitude
                      : fromLocationLatLng!.latitude,
                  fromLocationLatLng!.longitude <= toLocationLatLng!.longitude
                      ? toLocationLatLng!.longitude
                      : fromLocationLatLng!.longitude)),
          100),
    );
    notifyListeners();
  }
}

class routeModel {
  String? time;
  double? lng;
  double? lat;
  String? country;

  routeModel({this.lng, this.time, this.country, this.lat});
}
