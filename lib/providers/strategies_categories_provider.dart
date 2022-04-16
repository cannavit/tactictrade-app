import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tactictrade/models/menu_home_categories.dart';

class CategoryStrategiesSelected with ChangeNotifier {
  // List

  List<Category> categories = [
    Category(null, 'All', null),
    Category(null, 'Favorite', null),
    Category(null, 'Me Strategies', null),
    Category(null, 'Winners', null),
    Category(null, 'Top Shorts', null),
    Category(null, 'Top Long', null),
    // Category(CupertinoIcons.person_3_fill, 'create strategy'),
  ];

  // Map<String, List<Article>> categoryArticles = {};
  CategoryStrategiesSelected() {
    //Todo call to backend

    // categories.forEach((item) {
    //   this.categoryA

    // });
  }
  // Default selected categorie

  String _selectedCategory = 'all Strategies';

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String value) {
    _selectedCategory = value;
    notifyListeners();
  }

  getArticulesByCategory(String category) async {
    //TODO call the API
  }
}
