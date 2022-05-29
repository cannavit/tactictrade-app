import 'package:flutter/material.dart';

class Category {
  final IconData? icon;
  final String name;
  final String? navigationPage;
  final String parameterFilter;

  Category(this.icon, this.name, this.navigationPage, this.parameterFilter);
}