import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruit_delivery_flutter/models/vendor.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
import 'package:fruit_delivery_flutter/services/storage_service.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';
import 'package:fruit_delivery_flutter/widgets/enums.dart';
import 'package:provider/provider.dart';

class HttpService {
  Dio _dio = Dio(); //builtin
  StorageService? storage = locator<StorageService>();
  final baseUrl = "https://guanabanas-y-mas.firebaseapp.com/guanabana/api/v1/";
  final baseVendorUrl =
      "https://guanabanas-y-mas.firebaseapp.com/guanabana/vendor/api/v1/";
  Future<Dio> getApiClient() async {
    try {
      var token = await storage!.getData(StorageKeys.token.toString());
      print(token);
      _dio.interceptors.clear();
      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, interceptorHandler) {
            // Do something before request is sent
            options.headers["Authorization"] = "Bearer " + token.toString();
            return interceptorHandler.next(options);
            // ignore: non_constant_identifier_names
          },
          onResponse: (response, interceptorHandler) {
            // Do something with response data
            return interceptorHandler.next(response); // continue
            // ignore: non_constant_identifier_names
          },
          onError: (error, interceptorHandler) async {
            // Do something with response error
            if (error.response?.statusCode == 403 ||
                error.response?.statusCode == 401) {
              _dio.interceptors.requestLock.lock();
              _dio.interceptors.responseLock.lock();
              // ignore: unused_local_variable
              RequestOptions options = error.response!.requestOptions;
              // ignore: unused_local_variable
              Options? opt;
              var user = FirebaseAuth.instance.currentUser!;
              token = await user.getIdToken(true);
              await storage!.setData(StorageKeys.token.toString(), token);
              options.headers["Authorization"] = "Bearer " + token.toString();

              _dio.interceptors.requestLock.unlock();
              _dio.interceptors.responseLock.unlock();
              //  return _dio.request(options.path, options: opt);
            } else {
              return interceptorHandler.next(error);
            }
          },
        ),
      );
      //  _dio.options.baseUrl = baseUrl;
    } catch (err) {
      print(err);
    }

    return _dio;
  }

  userRegisterDevice(Map<String, dynamic> data) async {
    var http = await getApiClient();
    var response = await http.post(baseUrl + 'user/device', data: data);
    return response;
  }

  unRegisterDevice(Map<String, dynamic> data) async {
    var http = await getApiClient();
    var response = await http.delete(baseUrl + "user/device", data: data);
    return response;
  }

  signUp(Map<String, dynamic> data) async {
    var http = await getApiClient();

    var response = await http.post(baseUrl + "user/signup", data: data);
    print(response);
    return response;
  }

  // test141() async {
  //   var http = await getApiClient();
  //   var response = await http.post(baseUrl + 'user/signin');
  //   return response;
  // }
  getAllLanguages() async {
    try {
      var http = await getApiClient();
      var response = await http.get(baseUrl + "language");
      return response;
    } catch (er) {
      // print(er.toString());
    }
  }

  getUserById(String? userId) async {
    try {
      var http = await getApiClient();
      var response = await http.get(
        baseUrl + "user/detail/$userId",
      );
      return response;
    } catch (er) {
      // print(er.toString());
    }
  }

  editUserProfileInformation(Map<String, dynamic> data) async {
    var http = await getApiClient();
    var response = await http.put(baseUrl + "user", data: data);
    print(data);
    return response;
  }

  addUserCurrentLocation(Map<String, dynamic> data) async {
    var http = await getApiClient();
    var response = await http.put(baseUrl + "location", data: data);
    print(data);
    return response;
  }

//////vendor////
  vendorSignUp(Map<String, dynamic> data) async {
    var http = await getApiClient();

    var response = await http.post(baseUrl + "vendor/signup", data: data);
    print(response);
    return response;
  }

  vendorRegisterDevice(Map<String, dynamic> data) async {
    var http = await getApiClient();
    var response = await http.post(baseUrl + 'vendor/device', data: data);
    print(response);
    return response;
  }

  vendorUnRegisterDevice(Map<String, dynamic> data) async {
    var http = await getApiClient();
    var response = await http.delete(baseUrl + "vendor/device", data: data);
    print(response);
    return response;
  }

  getVendorById(String? userId) async {
    try {
      var http = await getApiClient();
      var response = await http.get(
        baseUrl + "vendor/detail/$userId",
      );
      return response;
    } catch (er) {
      // print(er.toString());
    }
  }

  editVendorProfileInformation(Map<String, dynamic> data) async {
    var http = await getApiClient();
    var response = await http.put(baseUrl + "vendor", data: data);
    print(data);
    return response;
  }

  addVendorCurrentLocation(Map<String, dynamic> data) async {
    var http = await getApiClient();
    var response = await http.put(baseUrl + "location", data: data);
    print(data);
    return response;
  }

  ///////////////////////////////
  getAllProducts({int? count, int? page}) async {
    try {
      var http = await getApiClient();
      var response = await http.get(baseUrl + "product", queryParameters: {
        "page": page,
        "count": count,
      });
      return response;
    } catch (er) {
      print(er.toString());
    }
  }

  // postDriverRoutes() async {
  //   try {
  //     var http = await getApiClient();
  //     var response = await http.post(baseUrl + "/route", data: data);
  //     return response;
  //   } catch (err) {
  //     print(err.toString());
  //   }
  // }
  getAllRoutes({int? count, int? page}) async {
    try {
      var http = await getApiClient();
      var response = await http.get(baseVendorUrl + "route", queryParameters: {
        "page": page,
        "count": count,
      });
      return response;
    } catch (err) {
      print(err.toString());
    }
  }

  getActiveVendor({int? count, int? page}) async {
    try {
      var http = await getApiClient();
      var response =
          await http.get(baseUrl + "vendor/active", queryParameters: {
        "page": page,
        "count": count,
      });
      return response;
    } catch (err) {
      print(err.toString());
    }
  }

  postAllProducts(var data) async {
    try {
      var http = await getApiClient();
      var response = await http.post(baseUrl + "vendor/product", data: data);
      return response;
    } catch (err) {
      print(err.toString());
    }
  }

  addFruitVendor(var data) async {
    try {
      var http = await getApiClient();
      var response = await http.post(baseVendorUrl + "product", data: data);
      return response;
    } catch (err) {
      print(err.toString());
    }
  }

  postDriverRoutes(var data) async {
    try {
      var http = await getApiClient();
      var response = await http.post(baseVendorUrl + "route", data: data);
      return response;
    } catch (err) {
      print(err.toString());
    }
  }

  getAllVendors() async {
    try {
      var http = await getApiClient();
      var response = await http.get(
        baseVendorUrl + "vendor",
      );
      return response;
    } catch (err) {
      print(err.toString());
    }
  }

  updateDriverRoutes(var data, String id) async {
    try {
      var http = await getApiClient();
      var response = await http.put(baseVendorUrl + "route/$id", data: data);
      return response;
    } catch (err) {
      print(err.toString());
    }
  }

  getRoutebyId(String id) async {
    try {
      var http = await getApiClient();
      var response = await http.get(baseVendorUrl + "/route/$id");

      print(response);
      return response;
    } catch (er) {
      print(er.toString());
    }
  }

  getTripDetailRoute(String id) async {
    try {
      var http = await getApiClient();
      var response = await http.get("$baseUrl/vendor/detail/$id");

      print(response);
      return response;
    } catch (er) {
      print(er.toString());
    }
  }

  getRoute() async {
    try {
      var http = await getApiClient();
      var response = await http.get(
          "https://guanabanas-y-mas.firebaseapp.com/guanabana/vendor/api/v1/route");

      print(response);
      return response;
    } catch (er) {
      print(er.toString());
    }
  }

  editUserLocation(var data) async {
    var http = await getApiClient();
    var response = await http.put(baseUrl + "location", data: data);
    print(data);
    return response;
  }

  startRoute(String id) async {
    try {
      var http = await getApiClient();
      var response = await http.put(
          "https://guanabanas-y-mas.firebaseapp.com/guanabana/vendor/api/v1/route/start/$id");

      print(response);
      return response;
    } catch (er) {
      print(er.toString());
    }
  }

  notificationOnOff(bool value) async {
    try {
      var http = await getApiClient();
      var response = await http.put(
          "https://guanabanas-y-mas.firebaseapp.com/guanabana/api/v1/setting/locationNotification/$value");

      print(response);
      return response;
    } catch (er) {
      print(er.toString());
    }
  }

  reachRoute(String routeID, String reachID) async {
    try {
      var http = await getApiClient();
      var response = await http.put(
          "https://guanabanas-y-mas.firebaseapp.com/guanabana/vendor/api/v1/route/$routeID/reached/$reachID");

      print(response);
      return response;
    } catch (er) {
      print(er.toString());
    }
  }

  nextStopRoute(String routeID, String reachID) async {
    try {
      var http = await getApiClient();
      var response = await http.put(
          "https://guanabanas-y-mas.firebaseapp.com/guanabana/vendor/api/v1/route/$routeID/nextStop/$reachID");

      print(response);
      return response;
    } catch (er) {
      print(er.toString());
    }
  }
}
