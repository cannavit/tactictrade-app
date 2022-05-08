import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tactictrade/models/menu_home_categories.dart';

class CategoryTimerSelected with ChangeNotifier {
  // List

  List<Category> categories = [
    Category(null, 'hour', null, '1h'),
    Category(null, 'day', null, '1d'),
    Category(null, 'week', null, '1w'),
    Category(null, 'month', null, '1m'),
    Category(null, 'year', null, '1y'),
    Category(null, '5 Years', null, '5y'),
    // Category(CupertinoIcons.person_3_fill, 'create strategy'),
  ];

  // Map<String, List<Article>> categoryArticles = {};
  CategoryTimerSelected() {
    //Todo call to
  }
  // Default selected categorie

  String _selectedCategory = 'all Strategies';

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String value) {
    _selectedCategory = value;
    notifyListeners();
  }

  getArticulesByCategory(String category) async {}
}
