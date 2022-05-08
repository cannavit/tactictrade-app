import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tactictrade/models/menu_home_categories.dart';

import '../share_preferences/preferences.dart';

class TradingConfigInputLongProvider with ChangeNotifier {
  late TextEditingController inputController;
  double investValue = 0.0;
  double investValueShort = 0.0;

  // LONG ---------------------------- ------------------------------------------

  // Level 1
  String buttomSelectorChangeText = 'USD';
  String labelText = 'Amount to invest [USD]';
  String hintText = 'example 100usd';
  bool useQty = false;
  final controllerData = TextEditingController();

  // Level 2
  bool percentage = false;
  String buttomSelectorChangeTextPercentage = '%';
  String labelTextPercentage = 'Take Profit [%]';
  String hintTextPercentage = 'example -5%';
  dynamic results = {};
  final controllerDataPercentage = TextEditingController();

  // Level 3
  bool takeprofit = false;
  String buttomSelectorChangeTextTakeProfit = '%';
  String labelTextTakeProfit = 'Take Profit [%]';
  String hintTextTakeProfit = 'example 10%';
  final controllerDataTakeprofit = TextEditingController();

  // Level 4
  bool lossesallowed = false;
  String buttomSelectorChangeTextLossesAllowed = 'events';
  String labelTextLossesAllowed = 'Losses Allowed [events]';
  String hintTextLossesAllowed = 'stop losses > 3';
  final controllerLossesAllowed = TextEditingController();

  // SHORT ---------------------------------------------------------------------

  // Level 1
  String buttomSelectorChangeTextShort = 'USD';
  String labelTextShort = 'Amount to invest [USD]';
  String hintTextShort = 'example 100usd';
  bool useQtyShort = false;
  final controllerDataShort = TextEditingController();

  // Level 2
  bool percentageShort = false;
  String buttomSelectorChangeTextPercentageShort = '%';
  String labelTextPercentageShort = 'Stop Loss [%]';
  String hintTextPercentageShort = 'example 5%';
  dynamic resultsShort = {};
  final controllerDataPercentageShort = TextEditingController();

  // Level 3
  bool takeprofitShort = false;
  String buttomSelectorChangeTextTakeProfitShort = '%';
  String labelTextTakeProfitShort = 'Stop Loss [%]';
  String hintTextTakeProfitShort = 'example 10%';
  final controllerDataTakeprofitShort = TextEditingController();

  // Level 4
  bool lossesallowedShort = false;
  String buttomSelectorChangeTextLossesAllowedShort = 'events';
  String labelTextLossesAllowedShort = 'Losses Allowed [events]';
  String hintTextLossesAllowedShort = 'stop losses > 3';
  final controllerLossesAllowedShort = TextEditingController();

  write(bool value) {
    useQty = value;

    if (useQty == true) {
      this.buttomSelectorChangeText = 'QTY';
      this.labelText = 'Invest Amount [Units]';
      this.hintText = 'example 1unit';
    } else {
      this.buttomSelectorChangeText = 'USD';
      this.labelText = 'Invest Amount [QTY]';
      this.hintText = 'example 100usd';
    }

    notifyListeners();
  }

  percentageWrite(bool value) {
    percentage = value;

    if (percentage == true) {
      this.buttomSelectorChangeTextPercentage = 'QTY';
      this.labelTextPercentage = 'Stop Loss [%]';
      this.hintTextPercentage = 'example 1unit';
    } else {
      this.buttomSelectorChangeTextPercentage = '%';
      this.labelTextPercentage = 'Stop Loss [QTY]';
      this.hintTextPercentage = 'example 100usd';
    }

    notifyListeners();
  }

  takeprofitWrite(bool value) {
    takeprofit = value;

    if (takeprofit == true) {
      this.buttomSelectorChangeTextTakeProfit = 'QTY';
      this.labelTextTakeProfit = 'Take Profit [%]';
      this.hintTextTakeProfit = 'example 10%';
    } else {
      this.buttomSelectorChangeTextTakeProfit = '%';
      this.labelTextTakeProfit = 'Take Profit [QTY]';
      this.hintTextTakeProfit = 'example 100usd';
    }

    notifyListeners();
  }

  read() {
    results = {
      'buttomSelectorChangeText': buttomSelectorChangeText,
      'labelText': labelText,
      'investValue': investValue,
      'useQty': useQty,
      'hintText': hintText,
      
      'buttomSelectorChangeTextPercentage': buttomSelectorChangeTextPercentage,
      'labelTextPercentage': labelTextPercentage,
      'hintTextPercentage': hintTextPercentage,
      'percentage': percentage,
      'buttomSelectorChangeTextTakeprofit': buttomSelectorChangeTextTakeProfit,
      'labelTextTakeprofit': labelTextTakeProfit,
      'hintTextTakeprofit': hintTextTakeProfit,
      'takeprofit': takeprofit,
    };

    return results;
  }

  // Level 1
  addOne() {
    if (controllerData.text == "") {
      controllerData.text = "0.0";
    }

    final newValue = double.parse(controllerData.text) + 1;
    controllerData.text = newValue.toString();

    notifyListeners();
  }

  subtractOne() {
    if (controllerData.text == "") {
      controllerData.text = "0.0";
    }

    final newValue = double.parse(controllerData.text) - 1;
    controllerData.text = newValue.toString();

    notifyListeners();
  }

  controller() {
    return controllerData;
  }

  // Level 2
  addOnePercentage() {
    if (controllerDataPercentage.text == "") {
      controllerDataPercentage.text = "0.0";
    }

    final newValue = double.parse(controllerDataPercentage.text) + 1;
    controllerDataPercentage.text = newValue.toString();

    notifyListeners();
  }

  subtractOnePercentage() {
    if (controllerDataPercentage.text == "") {
      controllerDataPercentage.text = "0.0";
    }

    final newValue = double.parse(controllerDataPercentage.text) - 1;
    controllerDataPercentage.text = newValue.toString();

    notifyListeners();
  }

  controllerPorcentage() {
    return controllerDataPercentage;
  }

  // Level 3

  addOneTakeprofit() {
    if (controllerDataTakeprofit.text == "") {
      controllerDataTakeprofit.text = "0.0";
    }

    final newValue = double.parse(controllerDataTakeprofit.text) + 1;
    controllerDataTakeprofit.text = newValue.toString();

    notifyListeners();
  }

  subtractOneTakeprofit() {
    if (controllerDataTakeprofit.text == "") {
      controllerDataTakeprofit.text = "0.0";
    }

    final newValue = double.parse(controllerDataTakeprofit.text) - 1;
    controllerDataTakeprofit.text = newValue.toString();

    notifyListeners();
  }

  controllerTakeprofit() {
    return controllerDataTakeprofit;
  }

  // Level 4

  addOneLossesAllowed() {
    if (controllerLossesAllowed.text == "") {
      controllerLossesAllowed.text = "0.0";
    }

    final newValue = double.parse(controllerLossesAllowed.text) + 1;
    controllerLossesAllowed.text = newValue.toString();

    notifyListeners();
  }

  subtractOneLossesAllowed() {
    if (controllerLossesAllowed.text == "") {
      controllerLossesAllowed.text = "0.0";
    }

    final newValue = double.parse(controllerLossesAllowed.text) - 1;
    controllerLossesAllowed.text = newValue.toString();

    notifyListeners();
  }

  controller_LossesAllowed() {
    return controllerLossesAllowed;
  }

  //! [SHORT] ------------------------------------------

  writeShort(bool value) {
    useQtyShort = value;

    if (useQtyShort == true) {
      this.buttomSelectorChangeTextShort = 'QTY';
      this.labelTextShort = 'Invest Amount [Units]';
      this.hintTextShort = 'example 1unit';
    } else {
      this.buttomSelectorChangeTextShort = 'USD';
      this.labelTextShort = 'Invest Amount [QTY]';
      this.hintTextShort = 'example 100usd';
    }

    notifyListeners();
  }

  percentageWriteShort(bool value) {
    percentageShort = value;

    if (percentageShort == true) {
      this.buttomSelectorChangeTextPercentageShort = 'QTY';
      this.labelTextPercentageShort = 'Stop Loss [%]';
      this.hintTextPercentageShort = 'example 1unit';
    } else {
      this.buttomSelectorChangeTextPercentageShort = '%';
      this.labelTextPercentageShort = 'Stop Loss [QTY]';
      this.hintTextPercentageShort = 'example 100usd';
    }

    notifyListeners();
  }

  takeprofitWriteShort(bool value) {
    takeprofitShort = value;

    if (takeprofitShort == true) {
      this.buttomSelectorChangeTextTakeProfitShort = 'QTY';
      this.labelTextTakeProfitShort = 'Take Profit [%]';
      this.hintTextTakeProfitShort = 'example 10%';
    } else {
      this.buttomSelectorChangeTextTakeProfitShort = '%';
      this.labelTextTakeProfitShort = 'Take Profit [QTY]';
      this.hintTextTakeProfitShort = 'example 100usd';
    }

    notifyListeners();
  }

  readShort() {
    results = {
      // Level 1
      'buttomSelectorChangeTextShort': buttomSelectorChangeTextShort,
      'labelTextShort': labelTextShort,
      'investValueShort': investValueShort,
      'hintTextShort': hintTextShort,
      'useQtyShort': useQtyShort,


      // Level 2
      'buttomSelectorChangeTextPercentageShort':
          buttomSelectorChangeTextPercentageShort,
      'labelTextPercentageShort': labelTextPercentageShort,
      'hintTextPercentageShort': hintTextPercentageShort,
      'percentageShort': percentageShort,

      // Level 3
      'buttomSelectorChangeTextTakeprofitShort':
          buttomSelectorChangeTextTakeProfitShort,
      'labelTextTakeprofitShort': labelTextTakeProfitShort,
      'hintTextTakeprofitShort': hintTextTakeProfitShort,
      'takeprofitShort': takeprofitShort,
    };

    return results;
  }

  // Level 1

  addOneShort() {
    if (controllerDataShort.text == "") {
      controllerDataShort.text = "0.0";
    }

    final newValue = double.parse(controllerDataShort.text) + 1;
    controllerDataShort.text = newValue.toString();

    notifyListeners();
  }

  subtractOneShort() {
    if (controllerDataShort.text == "") {
      controllerDataShort.text = "0.0";
    }

    final newValue = double.parse(controllerDataShort.text) - 1;
    controllerDataShort.text = newValue.toString();

    notifyListeners();
  }

  controllerShort() {
    return controllerDataShort;
  }

  // Level 2
  addOnePercentageShort() {
    if (controllerDataPercentageShort.text == "") {
      controllerDataPercentageShort.text = "0.0";
    }

    final newValue = double.parse(controllerDataPercentageShort.text) + 1;
    controllerDataPercentageShort.text = newValue.toString();

    notifyListeners();
  }

  subtractOnePercentageShort() {
    if (controllerDataPercentageShort.text == "") {
      controllerDataPercentageShort.text = "0.0";
    }

    final newValue = double.parse(controllerDataPercentageShort.text) - 1;
    controllerDataPercentageShort.text = newValue.toString();

    notifyListeners();
  }

  controllerPorcentageShort() {
    return controllerDataPercentageShort;
  }

  // Level 3

  addOneTakeprofitShort() {
    if (controllerDataTakeprofitShort.text == "") {
      controllerDataTakeprofitShort.text = "0.0";
    }

    final newValue = double.parse(controllerDataTakeprofitShort.text) + 1;
    controllerDataTakeprofitShort.text = newValue.toString();

    notifyListeners();
  }

  subtractOneTakeprofitShort() {
    if (controllerDataTakeprofitShort.text == "") {
      controllerDataTakeprofitShort.text = "0.0";
    }

    final newValue = double.parse(controllerDataTakeprofitShort.text) - 1;
    controllerDataTakeprofitShort.text = newValue.toString();

    notifyListeners();
  }

  controllerTakeprofitShort() {
    return controllerDataTakeprofitShort;
  }

  // Level 4

  addOneLossesAllowedShort() {
    if (controllerLossesAllowedShort.text == "") {
      controllerLossesAllowedShort.text = "0";
    }

    final newValue = double.parse(controllerLossesAllowedShort.text) + 1;
    controllerLossesAllowedShort.text = newValue.toString();

    notifyListeners();
  }

  subtractOneLossesAllowedShort() {
    if (controllerLossesAllowedShort.text == "") {
      controllerLossesAllowedShort.text = "0";
    }

    final newValue = double.parse(controllerLossesAllowedShort.text) - 1;
    controllerLossesAllowedShort.text = newValue.toString();

    notifyListeners();
  }

  controller_LossesAllowedShort() {
    return controllerLossesAllowedShort;
  }
}
