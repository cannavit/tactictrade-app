import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tactictrade/models/menu_home_categories.dart';

class CategoryStrategiesSelected with ChangeNotifier {
  // List

  List<Category> categories = [
    Category(null, 'All', null, 'all'),
    Category(null, 'Favorite', null, 'favorite'),
    Category(null, 'Likes', null, 'likes'),

    Category(null, 'Me Strategies', null, 'me'),
    Category(null, 'Winners', null, 'winners'),
    Category(null, 'Top Shorts', null, 'top_short'),
    Category(null, 'Top Long', null, 'top_long'),
    // Category(CupertinoIcons.person_3_fill, 'create strategy'),
  ];

  // Map<String, List<Article>> categoryArticles = {};
  CategoryStrategiesSelected() {
    //Todo call to

    print("@Note-01 ---- 732559669 -----");
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
