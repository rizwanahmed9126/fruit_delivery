import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  getData(String key) async {
    var storage = await SharedPreferences.getInstance();
    var data = storage.get(key);
    if (data != null) {
      return json.decode(data.toString());
    }
    return data;
  }

  setData(String key, dynamic data) async {
    var storage = await SharedPreferences.getInstance();
    var encodedData = json.encode(data);
    await storage.setString(key, encodedData);
  }

  clearData() async {
    var storage = await SharedPreferences.getInstance();
    for (String key in storage.getKeys()) {
      if (key != "language_code" && key != "countryCode") {
        storage.remove(key);
      }
    }
    // await storage.clear();
  }

  haveData(String key) async {
    var storage = await SharedPreferences.getInstance();
    var v = storage.containsKey(key);
    return v;
  }

  setBoolData(String key, bool data) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setBool(key, data);
  }

  haveBoolData(String key) async {
    var storage = await SharedPreferences.getInstance();
    var v = storage.containsKey(key);
    return v;
  }

  getBoolData(String key) async {
    var storage = await SharedPreferences.getInstance();
    var data = storage.get(key);

    return data;
  }

  removeData(String key) async {
    var storage = await SharedPreferences.getInstance();
    var v = storage.remove(key);
    return v;
  }
}
