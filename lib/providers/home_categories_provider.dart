import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tactictrade/models/menu_home_categories.dart';

class CategorySelected with ChangeNotifier {
  // List

  List<Category> categories = [
    Category(CupertinoIcons.graph_circle_fill, 'dashboard', null),
    Category(CupertinoIcons.square_favorites_alt_fill, 'strategies', null),
    Category(CupertinoIcons.person_3_fill, 'mantainers', null),
    Category(CupertinoIcons.playpause_fill, 'follows', null),
    Category(CupertinoIcons.text_badge_checkmark, 'tutorials', null),
  ];

  CategorySelected() {
    //Todo call to backend

    // categories.forEach((item) {
    //   this.categoryA

    // });
  }

  String _selectedCategory = 'dashboard';

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String value) {
    _selectedCategory = value;
    notifyListeners();
  }

  getArticulesByCategory(String category) async {
    //TODO call the API
  }
}
