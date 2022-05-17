// ignore_for_file: unnecessary_this

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tactictrade/models/menu_home_categories.dart';

import '../share_preferences/preferences.dart';

class TradingConfigProvider with ChangeNotifier {
  // List
  bool isActiveShort = Preferences.brokerNewUseTradingShort;
  bool isActiveLong = Preferences.brokerNewUseTradingLong;
  bool showButton = true;

  shortValue(bool value) {
    this.isActiveShort = value;
    Preferences.brokerNewUseTradingShort = isActiveShort;
    notifyListeners();
  }

  shortRead() {
    final result = isActiveShort;
    return result;
  }

  reset() {
    Preferences.brokerNewUseTradingShort = false;
    Preferences.brokerNewUseTradingLong = false;
    isActiveShort = false;
    isActiveLong = false;
  }

  longValue(bool value) {
    this.isActiveLong = value;
    Preferences.brokerNewUseTradingLong = isActiveLong;
    notifyListeners();
  }

  longRead() {
    final result = isActiveLong;
    return result;
  }

  showButtom() {
    if (this.isActiveLong || this.isActiveShort) {
      this.showButton = true;
    } else {
      this.showButton = false;
    }

    return this.showButton;
  }
}
