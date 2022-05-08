import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tactictrade/models/menu_home_categories.dart';

import '../share_preferences/preferences.dart';

class SelectBrokerTradingConfig with ChangeNotifier {
  // List

  int brokerSelected = 0;
  int brokerId = 1;
  // Map<String, List<Article>> categoryArticles = {};

  write(int value, int brokerId) {
    this.brokerSelected = value;
    this.brokerId = brokerId;

    Preferences.brokerSelectedPreferences = brokerId;

    notifyListeners();
  }

  read() {
    final result = this.brokerSelected;
    return result;
  }

  readId() {
    return this.brokerId;
  }
}
