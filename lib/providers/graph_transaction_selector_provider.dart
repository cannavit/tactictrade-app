import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../share_preferences/preferences.dart';

class GraphTransactionSelectProvider with ChangeNotifier {
  // List

  int selector = 1;
  IconData iconSelected =  CupertinoIcons.graph_circle;
  // Map<String, List<Article>> categoryArticles = {};

  write() {
    
    this.selector = selector + 1;

    print('SELECTOR: ');
    print(selector);
    if (selector > 2) {
      selector = 0;
    }

    if (selector == 0) {
         iconSelected = CupertinoIcons.graph_circle;
    } else if (selector == 1) {
      iconSelected = CupertinoIcons.graph_circle_fill;
    } else {
     iconSelected = CupertinoIcons.graph_square;
    }


    notifyListeners();
  }

  read() {
    return this.selector;
  }
}
