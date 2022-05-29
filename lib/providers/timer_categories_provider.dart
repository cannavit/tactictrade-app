import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tactictrade/models/menu_home_categories.dart';


//TODO delete it
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

  String period = '1w';
  String interval = '1h';

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

  dynamicCategoryCarousel(String period) {
                     // true

    
    if (period.contains('mo')) {
      categories = [
        Category(null, '1day', null, '7d'),
        Category(null, '5day', null, '1h'),
        Category(null, '1week', null, '10'),
        Category(null, '2weeks', null, '14'),
        Category(null, '3weeks', null, '21'),
        Category(null, '1months', null, '30'),
        Category(null, '2months', null, '60'),
        Category(null, '3months', null, '90'),
      ];
    } else if (period.contains('h')) {
      categories = [
        Category(null, '1d', null, '1'),
        Category(null, '5d', null, '3'),
        Category(null, '1w', null, '10'),
        Category(null, '2w', null, '14'),
        Category(null, '3w', null, '21'),
        Category(null, '1m', null, '30'),
        Category(null, '2m', null, '60'),
        Category(null, '3m', null, '90'),
      ];
    } else {
      categories = [
        Category(null, '1min', null, '1'),
        Category(null, '1d', null, '5'),
        Category(null, '2d', null, '7'),
        Category(null, '1w', null, '10'),
        Category(null, '2w', null, '14'),
        Category(null, '1m', null, '30'),
        Category(null, '2m', null, '60'),
        Category(null, '6m', null, '180'),
        Category(null, '1y', null, '364'),
        Category(null, '2y', null, '780'),
      ];
    }

    return categories;
  }

  // Map<String, List<Article>> categoryArticles = {};
  // CategoryTimerSelected() {
  //   //Todo call to
  // }
  // Default selected categorie

  String _selectedCategory = 'all Strategies';

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String value) {
    _selectedCategory = value;
    notifyListeners();
  }

  getArticulesByCategory(String category) async {}
}
