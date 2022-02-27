import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tactictrade/models/menu_home_categories.dart';

class CategoryStrategiesSelected with ChangeNotifier {
  // List

  List<Category> categories = [
    Category(null, 'all Strategies', null),
    Category(null, 'me Strategies', null),
    Category(null, 'Publics strategies', null),
    Category(CupertinoIcons.add_circled, 'create strategy', 'create_strategy'),
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
