import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tactictrade/models/menu_home_categories.dart';

import '../share_preferences/preferences.dart';

class TradingConfigProvider with ChangeNotifier {
  // List
  bool isActiveShort = Preferences.brokerNewUseTradingShort;
  bool isActiveLong = Preferences.brokerNewUseTradingLong;
  bool showButton = true;
  // Map<String, List<Article>> categoryArticles = {};

  


  short_value(bool value) {
    this.isActiveShort = value;
    Preferences.brokerNewUseTradingShort = this.isActiveShort;
    notifyListeners();
  }

  short_read() {
    final result = this.isActiveShort;
    return result;
  }

  long_value(bool value) {
    this.isActiveLong = value;
    Preferences.brokerNewUseTradingLong = this.isActiveLong;
    notifyListeners();
  }

  long_read() {
    final result = this.isActiveLong;
    return result;
  }

  show_buttom() {
    if (this.isActiveLong || this.isActiveShort) {
      this.showButton = true;
    } else {
      this.showButton = false;
    }

    return this.showButton;
  }
}
