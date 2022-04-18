import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tactictrade/models/menu_home_categories.dart';

class CategorySelected with ChangeNotifier {
  // List

  List<Category> categories = [
    Category(CupertinoIcons.graph_circle_fill, 'All', null, 'all'),
    Category(CupertinoIcons.square_favorites_alt_fill, 'Favorite', null, 'favorite'),
    // Category(CupertinoIcons.square_favorites_alt_fill, 'Likes', null, 'likes'),
    Category(CupertinoIcons.person_3_fill, 'Winners', null, 'winners'),
    Category(CupertinoIcons.playpause_fill, 'follows', null, 'all'),
    Category(CupertinoIcons.text_badge_checkmark, 'tutorials', null, ''),
  ];


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
