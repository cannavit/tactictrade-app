// To parse this JSON data, do
//
//     final TradingConfigViewModel = TradingConfigViewModelFromMap(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

class TradingConfigViewModel {
  TradingConfigViewModel({
    required this.status,
    required this.message,
    required this.paperTrade,
    required this.alpaca,
  });

  String status;
  String message;
  Alpaca paperTrade;
  Alpaca alpaca;

  factory TradingConfigViewModel.fromJson(String str) =>
      TradingConfigViewModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TradingConfigViewModel.fromMap(Map<String, dynamic> json) =>
      TradingConfigViewModel(
        status: json["status"],
        message: json["message"],
        paperTrade: Alpaca.fromMap(json["paperTrade"]),
        alpaca: Alpaca.fromMap(json["alpaca"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "paperTrade": paperTrade.toMap(),
        "alpaca": alpaca.toMap(),
      };
}

class Alpaca {
  Alpaca({
    required this.long,
    required this.short,
  });

  List<Long> long;
  List<Long> short;

  factory Alpaca.fromJson(String str) => Alpaca.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Alpaca.fromMap(Map<String, dynamic> json) => Alpaca(
        long: List<Long>.from(json["long"].map((x) => Long.fromMap(x))),
        short: List<Long>.from(json["short"].map((x) => Long.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "long": List<dynamic>.from(long.map((x) => x.toMap())),
        "short": List<dynamic>.from(short.map((x) => x.toMap())),
      };
}

class Long {
  Long(
      {required this.showButtonUnit,
      required this.showButtonLevels,
      required this.dbFieldOne,
      required this.dbFieldTwo,
      required this.buttonOneText,
      required this.buttonTwoText,
      required this.labelTextOne,
      required this.labelTextTwo,
      required this.hintTextOne,
      required this.hintTextTwo,
      required this.isMandatory,
      required this.isDouble,
      required this.isInt,
      this.textEditingController,
      this.icon,
      required this.isPercentOne,
      required this.isPercentTwo});

  bool showButtonUnit;
  bool showButtonLevels;
  String dbFieldOne;
  String dbFieldTwo;
  String? buttonOneText;
  String? buttonTwoText;
  String labelTextOne;
  String labelTextTwo;
  String? hintTextOne;
  String? hintTextTwo;
  bool isMandatory;
  bool isDouble;
  bool isInt;
  TextEditingController? textEditingController;
  int? icon;
  bool isPercentOne;
  bool isPercentTwo;

  factory Long.fromJson(String str) => Long.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Long.fromMap(Map<String, dynamic> json) => Long(
      showButtonUnit: json["show_button_unit"],
      showButtonLevels: json["show_button_levels"],
      dbFieldOne: json["db_field_one"],
      dbFieldTwo: json["db_field_two"],
      buttonOneText: json["button_one_text"],
      buttonTwoText: json["button_two_text"],
      labelTextOne: json["labelText_one"],
      labelTextTwo: json["labelText_two"],
      hintTextOne: json["hintText_one"],
      hintTextTwo: json["hintText_two"],
      isMandatory: json["is_mandatory"],
      isDouble: json["is_double"],
      isInt: json["is_int"],
      icon: json["icon"] != "" ? int.parse(json["icon"]) : 0,
      textEditingController: TextEditingController(),
      isPercentOne: json["is_percent_one"],
      isPercentTwo: json["is_percent_two"],

      );

  Map<String, dynamic> toMap() => {
        "show_button_unit": showButtonUnit,
        "show_button_levels": showButtonLevels,
        "db_field_one": dbFieldOne,
        "db_field_two": dbFieldTwo,
        "button_one_text": buttonOneText,
        "button_two_text": buttonTwoText,
        "labelText_one": labelTextOne,
        "labelText_two": labelTextTwo,
        "hintText_one": hintTextOne,
        "hintText_two": hintTextTwo,
        "is_mandatory": isMandatory,
        "is_double": isDouble,
        "is_int": isInt,
        "icon": icon,
      };
}
