import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tactictrade/models/menu_home_categories.dart';

class FiltersStrategiesSelected with ChangeNotifier {
  // List

  List<Category> categories = [
    Category(null, 'All', null, 'all'),    
    Category(null, 'Active Strategies', null, 'active'),
    Category(null, 'Inactive Strategies', null,'inactive'),
    Category(null, 'Winners Strategies', null,'winners'),
    Category(null, 'Losses Strategies', null,'losses'),
  ];

  FiltersStrategiesSelected() {

  }
  
  String _selectedCategory = 'All';
  String get selectedCategory => _selectedCategory;
  set selectedCategory(String value) {
    _selectedCategory = value;
    notifyListeners();
  }

  getArticulesByCategory(String category) async {
    //TODO call the API
  }
}
