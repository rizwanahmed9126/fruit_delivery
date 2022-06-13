// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/widgets.dart';
import 'package:fruit_delivery_flutter/models/products_model.dart';
import 'package:fruit_delivery_flutter/models/routes_id_by_user_model.dart';
import 'package:fruit_delivery_flutter/models/trip_routes_model.dart';
import 'package:fruit_delivery_flutter/providers/products_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/providers/auth_providers/vendor_provider.dart';
import '/providers/g_data_provider.dart';
import '/services/http_service.dart';
import '/services/navigation_service.dart';
import '/services/util_service.dart';
import '/utils/routes.dart';
import '/utils/service_locator.dart';
import 'package:provider/provider.dart';

class RouteProvider with ChangeNotifier {
  UtilService? utilService = locator<UtilService>();
  HttpService? http = locator<HttpService>();
  List productData = [];
  List<dynamic> selectedProducts = [];
  List<dynamic> addedProducts = [];
  var navigationService = locator<NavigationService>();
  List<Map<String, dynamic>> product = [];
  List<Map<String, dynamic>> stop = [];
  List<Map<String, dynamic>> editedStops = [];
  RouteById? routeIdData;




  List<TripRouteModel> tripData = [];
  get getRouteData {
    return this.tripData;
  }

  // RouteById get getRouteDataById {
  //   return this.routeIdData!;
  // }
  LatLng? startLocationLt;


  createRouteFunc(String trucktext, BuildContext context) async {
    // List<Placemark>? countryStop;
    // if(Provider.of<GMapsProvider>(context, listen: false).stopData.length>0){
    //    countryStop = await placemarkFromCoordinates(
    //        Provider.of<GMapsProvider>(context, listen: false).stopData[0]["location"]["lat"],
    //       Provider.of<GMapsProvider>(context, listen: false).stopData[0]["location"]["long"]);
    // }

    List<Placemark> startLocation = await placemarkFromCoordinates(
      startLocationLt!.latitude,
      startLocationLt!.longitude,
    );

    product.clear();
    for (int i = 0;
        i < context.read<ProductsProvider>().selectedProducts.length;
        i++) {
      Map<String, dynamic> tempVar = {};

      var data = context.read<ProductsProvider>().selectedProducts;
      tempVar = {
        "id": data[i].id,
        "name": data[i].name,
        "unit": data[i].unit,
        "picture": data[i].picture,
        "createdOnDate": data[i].createdOnDate,
        "price": data[i].price,
        "backgroundColor": data[i].backgroundColor
      };

      product.add(tempVar);
      // print(tempVar);
    }

    for (int i = 0; i < Provider.of<GMapsProvider>(context, listen: false).stopData.length; i++) {
      Map<String, dynamic> stopVar = {};
      var data = Provider.of<GMapsProvider>(context, listen: false).stopData;
      List<Placemark> startLocation = await placemarkFromCoordinates(
          data[i]["location"]["lat"], data[i]["location"]["long"]);

      stopVar = {
        "timeOfReaching": data[i]["timeOfReaching"].toString(),
        "serialNo": data[i]["serialNo"].toString(),
        "id":data[i]["id"].toString(),
        "location": {
          "country": startLocation[0].country,
          "city": startLocation[0].locality,
          "address": data[i]["location"][
              "address"], //"${startLocation.first.street}, ${startLocation.first.subLocality}, ${startLocation.first.locality}",

          "lat": data[i]["location"]["lat"],
          "long": data[i]["location"]["long"]
        }
      };

      stop.add(stopVar);
      // print(tempVar);
    }
    // product = {
    //   "id": "cF5JzFHKyJbgwUwxs6tC",
    //   "name": "orange",
    //   "unit": "kg2",
    //   "picture":
    //       "https://firebasestorage.googleapis.com/v0/b/guanabanas-y-mas.appspot.com/o/fruits%2Forange.gif?alt=media&token=ab29e9c5-d001-4ce6-abca-501132aa8e57",
    //   "createdOnDate": 3432423434,
    //   "price": "5",
    //   "backgroundColor": "peach"
    // };
    // }
    Map<String, dynamic> data = {
      "products": product,
      "timeOfReaching": "12345",
      "timeDuration": "12345",
      "truckNumber": "$trucktext",
      "startLocation": {
        "lat": startLocationLt!.latitude,
        "long": startLocationLt!.longitude,
        "country": startLocation[0].country,
        "city": startLocation[0].locality,
        "address":
            "${startLocation.first.street}, ${startLocation.first.thoroughfare}, ${startLocation[0].subAdministrativeArea}"
      },
      "stops": stop,
      //  [
      //   {
      //     "timeOfReaching":
      //         "${Provider.of<GMapsProvider>(context, listen: false).stopData[0]["timeOfReaching"].toString()}",
      //     "serialNo":
      //         "${Provider.of<GMapsProvider>(context, listen: false).stopData[0]["serialNo"].toString()}",
      //     "location": {
      //       "country": countryStop[0].country,
      //       "city": countryStop[0].locality,
      //       "lat":
      //           // "f",

      //           Provider.of<GMapsProvider>(context, listen: false).stopData[0]
      //               ["location"]["lat"],
      //       "long":
      //           //  "df",

      //           Provider.of<GMapsProvider>(context, listen: false).stopData[0]
      //               ["location"]["long"]
      //     }
      //   }
      // ]
    };
    try {
      var response = await http!.postDriverRoutes(data);
      print(response.data);
      context.read<ProductsProvider>().selectedProducts.clear();

      await fetchAllRoute();

      context.read<ProductsProvider>().selectedProducts.clear();
      context.read<GMapsProvider>().stopData.clear();
      stop.clear();

      navigationService.navigateTo(ScheduleScreenRoute);

      this.selectedProducts = [];
      notifyListeners();
    } catch (err) {
      utilService!.showToast(err.toString());
    }
  }

  updateRouteFunc(
      String trucktext, String routeId, BuildContext context) async {
    var temp = Provider.of<GMapsProvider>(context, listen: false).getStops;
    print(temp);
    List<Placemark> stopAddresses = [];
    for (int index = 0; index < temp.length; index++) {
      stopAddresses.addAll(await placemarkFromCoordinates(
          temp[index]["location"]["lat"], temp[index]["location"]["long"]));
    }
    List<Placemark> startLocation = await placemarkFromCoordinates(
      startLocationLt!.latitude,
      startLocationLt!.longitude,
    );

    product.clear();
    for (int i = 0;
        i < context.read<ProductsProvider>().selectedProducts.length;
        i++) {
      Map<String, dynamic> tempVar = {};

      var data = context.read<ProductsProvider>().selectedProducts;
      tempVar = {
        "id": data[i].id,
        "name": data[i].name,
        "unit": data[i].unit,
        "picture": data[i].picture,
        "createdOnDate": data[i].createdOnDate,
        "price": data[i].price,
        "backgroundColor": data[i].backgroundColor
      };

      product.add(tempVar);
      // print(tempVar);

    }

    for (int i = 0;
        i < Provider.of<GMapsProvider>(context, listen: false).stopData.length;
        i++) {
      print(Provider.of<GMapsProvider>(context, listen: false).stopData.length);
      Map<String, dynamic> stopVar = {};
      var data = Provider.of<GMapsProvider>(context, listen: false).stopData;
      stopVar = {
        "timeOfReaching": data[i]["timeOfReaching"].toString(),
        "serialNo": data[i]["serialNo"].toString(),
        "id":data[i]["id"],
        "location": {
          "country": stopAddresses[i].country,
          "city": stopAddresses[i].locality,
          "address": data[i]["location"][
              "address"], //"${startLocation.first.street}, ${startLocation.first.subLocality}, ${startLocation[0].locality}",
          "lat": data[i]["location"]["lat"],
          "long": data[i]["location"]["long"]
        }
      };

      editedStops.add(stopVar);

      // print(tempVar);
    }
    print('${editedStops.length}');
    Map<String, dynamic> data = {
      "products": product,
      "timeOfReaching": "12345",
      "timeDuration": "12345",
      "truckNumber": "$trucktext",
      "startLocation": {
        "lat": startLocationLt!.latitude,
        "long": startLocationLt!.longitude,
        "country": startLocation[0].country,
        "city": startLocation[0].locality,
        "address":
            "${startLocation.first.street}, ${startLocation.first.thoroughfare}, ${startLocation[0].subAdministrativeArea}"
      },
      "stops": editedStops,
    };

    print(data);
    print(stop);
    print(stop.length);

    try {
      var response = await http!.updateDriverRoutes(data, routeId);
      print(response.data);

      //await fetchRoutebyId(routeIdData!.id!);

      await fetchAllRoute();

      context.read<ProductsProvider>().selectedProducts.clear();
      context.read<GMapsProvider>().stopData.clear();
      editedStops.clear();
      navigationService.navigateTo(ScheduleScreenRoute);

      this.selectedProducts = [];
      notifyListeners();
    } catch (err) {
      utilService!.showToast(err.toString());
    }
  }

  Future<void> fetchRoutebyId(String id) async {
    try {
      var response = await http!.getRoutebyId(id);

      if (response.statusCode == 200) {
        var body = response.data["data"];
        routeIdData = null;
        print(routeIdData);

        routeIdData = RouteById.fromJson(body);
        print(routeIdData!.turckNumber);

        print(routeIdData!.createdOnDate);
        print(routeIdData!.stops!.length);

        // id = response.data["data"]["id"];
        //   print(body);
        //   List<Products> tripProducts = [];
        //   for (int i = 0; i < body['products'].length; i++) {
        //     Products? tempObj;
        //     tempObj = Products(
        //       id: body['products'][i]['id'],
        //       name: body['products'][i]['name'],
        //       createdOnDate: int.parse(
        //           (body['products'][i]['createdOnDate'] ?? '0').toString()),
        //       picture: body['products'][i]['picture'],
        //       price: body['products'][i]['price'],
        //       unit: body['products'][i]['unit'],
        //       backgroundColor: body['products'][i]['backgroundColor'],
        //     );
        //
        //     tripProducts.add(tempObj);
        //     //selectedProducts.add(tempObj);
        //   }
        //
        //   // for (var abc in body) {
        //   // routeIdData = RouteById.fromJson(body);
        //
        //   // }
        //   routeIdData = RouteById(
        //     id: body['id'],
        //     createdOnDate: body['createdOnDate'],
        //     isActive: body['isActive'],
        //     startLocation: body['startLocation'],
        //     stops: (body['stops'] as List<dynamic>?)
        //         ?.map((e) => e as Map<String, dynamic>)
        //         .toList(),
        //     products: tripProducts,
        //     timeDuration: body['timeDuration'],
        //     timeOfReaching: body['timeOfReaching'],
        //     turckNumber: body['truckNumber'],
        //     vendorId: body['vendorId'],
        //   );
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> fetchAllRoute() async {
    try {
      var response = await http!.getRoute();
      tripData.clear();

      if (response.statusCode == 200) {
        var body = response.data["data"]["list"]; //["data"]["list"];
        print('this is the body--${body}');
        for (var abc in body) {
          tripData.add(TripRouteModel.fromJson(abc));
          // tripData.add(TripRouteModel(fromAddress: ))
          print("lengthcbv${tripData.length}");
        }
        tripData.sort((a, b) => b.createdOnDate!.compareTo(a.createdOnDate!));
      }

      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
  }


}
