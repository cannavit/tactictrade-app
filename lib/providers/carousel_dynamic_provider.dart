import 'package:flutter/material.dart';
import 'package:tactictrade/models/strategy_models.dart';

class CarouselDynamicProvider with ChangeNotifier {
  // List

  String carouselSelectedString = "";
  int carouselSelectedInt = 0;

  late ControllerCandleGraph controllerCandleDefaultSelected;

  // Map<String, List<Article>> categoryArticles = {};

  write(ControllerCandleGraph controllerCandleDefaultSelected) {
    this.controllerCandleDefaultSelected = controllerCandleDefaultSelected;
    notifyListeners();
  }

  read() {
    final result = carouselSelectedString;
    return result;
  }

  readId() {
    return carouselSelectedInt;
  }
}
