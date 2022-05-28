import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tactictrade/models/menu_home_categories.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

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

class TimeFilterSelected with ChangeNotifier {
  // List

  List<Category> categories = [
    Category(null, '30 min', null, '30min'),
    Category(null, '1 Day', null, '1d'),
    Category(null, '2 Days', null, '2d'),
    Category(null, '1 week', null, '1w'),
    Category(null, '2 weeks', null, '2w'),
    Category(null, '1 Month', null, '1m'),
    Category(null, '2 Months', null, '2m'),
    Category(null, '6 Months', null, '6m'),
    Category(null, '1 Year', null, '1y'),
    Category(null, '2 Years', null, '2y'),
  ];

  dynamicCategoryCarousel(String strategyCandleGraphCarouselListType) {
    
    if (strategyCandleGraphCarouselListType == '1d') {
      categories = [
        Category(null, '1 week', null, '7'),
        Category(null, '2 weeks', null, '14'),
        Category(null, '1 Month', null, '32'),
        Category(null, '2 Months', null, '64'),
        Category(null, '6 Months', null, '186'),
        Category(null, '1 Year', null, '364'),
        Category(null, '2 Years', null, '728'),
      ];
    } else if (strategyCandleGraphCarouselListType == '30m') {
      categories = [
        Category(null, '30 Min', null, '1'),
        Category(null, '1 Days', null, '5'),
        Category(null, '1 Weeks', null, '7'),
        Category(null, '2 Weeks', null, '14'),
        Category(null, '3 Weeks', null, '21'),
        Category(null, '1 Months', null, '30'),
        Category(null, '2 Months', null, '60'),
        Category(null, '3 Months', null, '90'),
        Category(null, '6 Months', null, '180'),
      ];
    } else {
      categories = [
        Category(null, '30 min', null, '1'),
        Category(null, '1 Day', null, '5'),
        Category(null, '2 Days', null, '7'),
        Category(null, '1 week', null, '10'),
        Category(null, '2 weeks', null, '14'),
        Category(null, '1 Month', null, '30'),
        Category(null, '2 Months', null, '60'),
        Category(null, '6 Months', null, '180'),
        Category(null, '1 Year', null, '364'),
        Category(null, '2 Years', null, '780'),
      ];
    }

    return categories;
  }

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
