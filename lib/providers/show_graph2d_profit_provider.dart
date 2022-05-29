import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../share_preferences/preferences.dart';

class ShowGraph2dProfitProvider with ChangeNotifier {
  // List

  bool showProfitGraph = true;
  // Map<String, List<Article>> categoryArticles = {};

  value(bool showProfitGraph) {
    this.showProfitGraph = showProfitGraph;
    Preferences.showProfitGraph = showProfitGraph;
    notifyListeners();
  }

  read() {
    return showProfitGraph;
  }
}
