import 'package:flutter/material.dart';
import 'package:fruit_delivery_flutter/models/languages.dart';
import 'package:fruit_delivery_flutter/services/http_service.dart';
import 'package:fruit_delivery_flutter/services/navigation_service.dart';
import 'package:fruit_delivery_flutter/services/storage_service.dart';
import 'package:fruit_delivery_flutter/services/util_service.dart';
import 'package:fruit_delivery_flutter/utils/service_locator.dart';

class LanguagesProvider with ChangeNotifier {
  NavigationService? navigationService = locator<NavigationService>();
  UtilService? utilService = locator<UtilService>();
  StorageService? storageService = locator<StorageService>();
  HttpService? http = locator<HttpService>();

  List _loadedData = [];
  List _loadedDataApi = [];

  setLanguages(var service) {
    // set locally
    this._loadedData.add(service);
    print(this._loadedData);
  }

  List get getLanguagesApi {
    return this._loadedDataApi.toSet().toList();
  }

  List get getLanguages {
    // get locally
    return this._loadedData.toSet().toList();
  }

  removeLanguages(var service) {
    // remove locally
    this._loadedData.remove(service);
    print(this._loadedData);
  }

  Future<void> fetchAllLanguages() async {
    try {
      var response = await this.http!.getAllLanguages();

      if (response == null) {
        return;
      }
      var data = response.data['data'];
      this._loadedDataApi = [];
      for (int i = 0; i < data.length; i++) {
        this._loadedDataApi.add(LanguagesModel.fromJson(data[i]));
      }
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
