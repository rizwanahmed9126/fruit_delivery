import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

import 'package:fruit_delivery_flutter/models/routehistory_model.dart';
import 'package:fruit_delivery_flutter/providers/auth_providers/vendor_provider.dart';
import 'package:fruit_delivery_flutter/screens/driver_home_screen.dart';
import 'package:fruit_delivery_flutter/services/http_service.dart';
import 'package:fruit_delivery_flutter/services/navigation_service.dart';
import 'package:fruit_delivery_flutter/utils/routes.dart';

import '../models/products_model.dart';
import '../services/util_service.dart';
import '../utils/service_locator.dart';

class ProductsProvider with ChangeNotifier {
  UtilService? utilService = locator<UtilService>();
  HttpService? http = locator<HttpService>();
  List<Products> productData = [];
  List<Products> selectedProducts = [];
  List<Products> tempSelectedProducts = [];
  List<dynamic> addedProducts = [];
  List<RouteHistory> routeData = [];

  List<isActiveModel> isActive = [];
  setIdActiveValue(isActiveModel value) {
    isActive.add(value);
    notifyListeners();
  }

  changeValue(int a, isActiveModel value) {
    isActive[a] = value;
    notifyListeners();
  }

  var navigationService = locator<NavigationService>();

  List<String> length1 = [
    "Add spot",
  ];
  addField(int a) {
    length1.add("Add spot$a");
    notifyListeners();
  }

  removeField(int a) {
    print(length1.length);
    length1.length--;
    //length1.removeWhere((element) => element==length1[a]);
    //print(length1.length);
    notifyListeners();
  }

  get fruit {
    return this.addedProducts;
  }
//////////////////////////////////////
  // setPrice(var price) {
  //   this.price.add(price);
  // }

  // removePrice(var price) {
  //   this.price.remove(price);
  setTempSelectedProducts(
      {
      // var data
      String? id,
      String? name,
      String? price,
      int? createdOnDate,
      String? unit,
      String? picture,
      String? backgroundColor,
      String? description,
      required BuildContext context}) {
    Products? newProduct;
    bool isNew = true;

    for (int i = 0; i < tempSelectedProducts.length; i++) {
      if (this.tempSelectedProducts[i].id == id) {
        this.tempSelectedProducts[i].price = price;
        isNew = false;
      }
    }
    if (isNew) {
      newProduct = Products(
        id: id,
        description: description,
        backgroundColor: backgroundColor,
        createdOnDate: createdOnDate,
        name: name,
        picture: picture,
        price: price,
        unit: unit,
      );
      // selectedProducts.add(newProduct);
      tempSelectedProducts.add(newProduct);
      // if (selectedProducts.length > 0) {
      //   for (var i = 0; i < this.tempSelectedProducts.length; i++) {
      //     for (var j = 0; j < this.productData.length; j++) {
      //       if (productData[j].id == tempSelectedProducts[i].id) {
      //         productData.removeAt(j);
      //       }
      //     }
      //   }
      // }
      // newProduct = null;
    }
    // Provider.of<VendorProvider>(context, listen: false)
    //     .setVendorProducts(selectedProducts);
    notifyListeners();
  }

  setSelectedProducts(
      {
      // var data
      String? id,
      String? name,
      String? price,
      int? createdOnDate,
      String? unit,
      String? picture,
      String? backgroundColor,
      String? description,
      required BuildContext context}) {
    Products? newProduct;
    bool isNew = true;

    for (int i = 0; i < tempSelectedProducts.length; i++) {
      if (this.tempSelectedProducts[i].id == id) {
        this.tempSelectedProducts[i].price = price;
        isNew = false;
      }
    }
    if (isNew) {
      newProduct = Products(
        id: id,
        description: description,
        backgroundColor: backgroundColor,
        createdOnDate: createdOnDate,
        name: name,
        picture: picture,
        price: price,
        unit: unit,
      );
      selectedProducts.add(newProduct);
      tempSelectedProducts.add(newProduct);
      if (selectedProducts.length > 0) {
        for (var i = 0; i < this.tempSelectedProducts.length; i++) {
          for (var j = 0; j < this.productData.length; j++) {
            if (productData[j].id == tempSelectedProducts[i].id) {
              productData.removeAt(j);
            }
          }
        }
      }
      newProduct = null;
    }
    Provider.of<VendorProvider>(context, listen: false)
        .setVendorProducts(selectedProducts);
    notifyListeners();
  }

  removeTempSelectedProducts({
    String? id,
    BuildContext? context,
  }) {
    // productData.add(selectedProducts.firstWhere((element) => element.id == id));
    // selectedProducts.removeWhere((item) => item.id == id);
    tempSelectedProducts.removeWhere((item) => item.id == id);

    // print(this.selectedProducts);
    notifyListeners();
  }

  removeSelectedProducts({
    String? id,
    BuildContext? context,
  }) {
    selectedProducts.removeWhere((item) => item.id == id);
    //tempSelectedProducts.removeWhere((item) => item.id == id);

    // print(this.selectedProducts);
    notifyListeners();
  }

  setAlreadyAddedProducts(var data) {
    this.addedProducts = data;
  }

  get getSelectedProducts {
    return List.from(this.selectedProducts)..addAll(this.addedProducts);
  }

////////////////////////////////
  List<Products> get getAllProducts {
    return this.productData;
  }

  List<RouteHistory> get gatAllroutes {
    return this.routeData;
  }

  Future<void> postProducts(BuildContext context) async {
    try {
      var data = List.from(this.selectedProducts)..addAll(this.addedProducts);
      var response = await http!.postAllProducts(data);
      print(response.data);
      await Provider.of<VendorProvider>(context, listen: false)
          .setVendorProducts(response.data['data']['products']);
      setAlreadyAddedProducts(response.data['data']['products']);

      navigationService.navigateTo(MyFruitsScreenRoute);

      this.selectedProducts = [];
    } catch (err) {
      utilService!.showToast(err.toString());
    }
    notifyListeners();
  }

  Future<void> postTripProduct(BuildContext context) async {
    try {
      var data = List.from(this.selectedProducts)..addAll(this.addedProducts);
      var response = await http!.postAllProducts(data);
      print(response.data);
      await Provider.of<VendorProvider>(context, listen: false)
          .setVendorProducts(response.data['data']['products']);
      setAlreadyAddedProducts(response.data['data']['products']);

      // navigationService.navigateTo(CreateRouteScreenMyItemsRoute);

      this.selectedProducts = [];
    } catch (err) {
      utilService!.showToast(err.toString());
    }
  }

  List<dynamic> productitemPost = [];

  Future<void> editProduct(Products data, BuildContext context) async {
    try {
      var sendingData = {
        'name': data.name,
        'description': data.description,
        'unit': data.unit,
        'price': data.price,
        'picture': data.picture,
        'backgroundColor': data.backgroundColor,
      };
      var response = await http!.addFruitVendor(sendingData);
      print(response.data);
      // await Provider.of<VendorProvider>(context, listen: false)
      //     .setVendorProducts(response.data['data']['products']);
      // setAlreadyAddedProducts(response.data['data']['products']);
      // navigationService.navigateTo(MyFruitsScreenRoute);
      // this.selectedProducts = [];
    } catch (err) {
      utilService!.showToast(err.toString());
    }
  }

  Future<void> deleteProducts(var data, BuildContext context) async {
    try {
      var response = await http!.postAllProducts(data);
      print(response.data);
      await Provider.of<VendorProvider>(context, listen: false)
          .setVendorProducts(response.data['data']['products']);
      setAlreadyAddedProducts(response.data['data']['products']);

      this.selectedProducts = [];
    } catch (err) {
      utilService!.showToast(err.toString());
    }
  }

  Future<void> fetchAllProducts({
    int? count,
    int? page,
  }) async {
    try {
      var response = await this.http!.getAllProducts(count: count, page: page);
      if (response == null) {
        return;
      }
      var data = response.data["data"]["list"];
      print(data);
      this.productData = [];
      isActive = [];
      for (var i = 0; i < data.length; i++) {
        print(i);
        print(response.data['data']['list'][i]['backgroundColor']);
        this.productData.add(Products.fromJson(data[i]));

        setIdActiveValue(isActiveModel(value: "", isActive: false));
      }
      if (selectedProducts.length > 0) {
        for (var i = 0; i < this.selectedProducts.length; i++) {
          for (var j = 0; j < this.productData.length; j++) {
            if (productData[j].id == selectedProducts[i].id) {
              productData.removeAt(j);
              isActive.removeAt(j);
            }
          }
        }
      }

      // for (var i = 0; i < this.addedProducts.length; i++) {
      //   for (var j = 0; j < this.productData.length; j++) {
      //     if (productData[j].id == addedProducts[i]['id']) {
      //       productData.removeAt(j);
      //     }
      //   }
      // }

      print(productData.length);
      notifyListeners();
    } catch (error) {
      utilService!.showToast(error.toString());
    }
  }

  // Future<void> fetchAllRoutes({
  //   int? count,
  //   int? page,
  // }) async {
  //   try {
  //     var response = await this.http!.getAllRoutes(count: count, page: page);
  //     if (response == null) {
  //       return;
  //     }

  //     this.routeData = [];

  //     var data = response.data["data"]["list"];

  //     for (var i = 0; i < data.length; i++) {

  //        for(int j=0;j<data[i]['stops'].length;j++)
  //     {

  //     }
  //        dynamic lat=data[i]['startLocation']["lat"];
  //        dynamic long=data[i]['startLocation']["long"];
  //        placemarks = await placemarkFromCoordinates(lat, long);

  //       this.routeData.add(RouteHistory(
  //             id: data[i]['id'],
  //             startLocation:placemarks.toString(),
  //             createdOnDate: data[i]['createdOnDate'],
  //             stops: data[i]['stops'],
  //           ));
  //     }

  //     print(this.routeData.length);

  //     notifyListeners();
  //   } catch (error) {
  //     utilService!.showToast(error.toString());
  //   }
  // }
}

class isActiveModel {
  String value;
  bool isActive;
  isActiveModel({
    required this.value,
    required this.isActive,
  });
}
