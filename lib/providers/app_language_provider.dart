import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale? _appLocale = Locale('en');
  String id = "";

  get appCurrentLocale {
    return _appLocale!.languageCode.toString();
  }

  Locale get appLocal => _appLocale ?? Locale("en");
  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = Locale('en');
      return Null;
    }
    if (prefs.containsKey('selectedLan')) {
      if (prefs.getString('selectedLan') == '') {
        return Null;
      } else {
        id = prefs.getString('selectedLan')!;
      }
    } else {
      return Null;
    }
    _appLocale = Locale(prefs.getString('language_code')!);
    return Null;
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == Locale("ar")) {
      _appLocale = Locale("ar");
      await prefs.setString('language_code', 'ar');
      await prefs.setString('countryCode', '');
    } else if (type == Locale("es")) {
      _appLocale = Locale("es");
      await prefs.setString('language_code', 'es');
      await prefs.setString('countryCode', '');
    } else if (type == Locale("vi")) {
      _appLocale = Locale("vi");
      await prefs.setString('language_code', 'vi');
      await prefs.setString('countryCode', '');
    } else if (type == Locale("km")) {
      _appLocale = Locale("km");
      await prefs.setString('language_code', 'km');
      await prefs.setString('countryCode', '');
    } else if (type == Locale("pt")) {
      _appLocale = Locale("pt");
      await prefs.setString('language_code', 'pt');
      await prefs.setString('countryCode', '');
    } else if (type == Locale("hi")) {
      _appLocale = Locale("hi");
      await prefs.setString('language_code', 'hi');
      await prefs.setString('countryCode', '');
    } else {
      _appLocale = Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    await prefs.setString('selectedLan', id);

    notifyListeners();
  }
}
