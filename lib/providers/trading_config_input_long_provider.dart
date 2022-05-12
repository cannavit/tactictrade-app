import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tactictrade/models/menu_home_categories.dart';

import '../share_preferences/preferences.dart';

class TradingConfigInputLongProvider with ChangeNotifier {
  late TextEditingController inputController;

  dynamic buttomValues = {};
  dynamic buttomText = {};
  dynamic data = {};

  double investValue = 0.0;
  double investValueShort = 0.0;

  // ERROR MESSAGE
  String errorMessage = "";
  // LONG ---------------------------- -----------------------------------------

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

  buttomTextWrite(String variable, newValue) {
    buttomText[variable] = newValue;

    notifyListeners();

    return buttomText;
  }

  buttomTextRead(String variable) {
    return buttomText[variable];
  }

  buttomValuesWrite(String variable, newValue) {
    buttomValues[variable] = newValue;

    notifyListeners();

    return buttomValues;
  }

  buttomValuesRead(String variable) {
    return buttomValues[variable];
  }

  selectorData(dynamic variable) {
    final buttomValuesOne = buttomValues[variable.dbFieldOne];
    final buttomTextOne = buttomText[variable.dbFieldOne];

    if (data[variable.dbFieldOne] == null) {
      data[variable.dbFieldOne] = {};
    }

    if (variable.buttonOneText == buttomTextOne) {
      data[variable.dbFieldOne]['buttonText'] = variable.buttonOneText;
      data[variable.dbFieldOne]['dbField'] = variable.dbFieldOne;
      data[variable.dbFieldOne]['hintText'] = variable.hintTextOne;
      data[variable.dbFieldOne]['labelText'] = variable.labelTextOne;
      data[variable.dbFieldOne]['isPercent'] = variable.isPercentOne;
    } else {
      data[variable.dbFieldOne]['buttonText'] = variable.buttonTwoText;
      data[variable.dbFieldOne]['dbField'] = variable.dbFieldTwo;
      data[variable.dbFieldOne]['hintText'] = variable.hintTextTwo;
      data[variable.dbFieldOne]['labelText'] = variable.labelTextTwo;
      data[variable.dbFieldOne]['isPercent'] = variable.isPercentTwo;
    }

    return data;
  }

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
  addOne(dynamic customTradingConfigView) {
    if (customTradingConfigView.textEditingController.text == "") {
      if (customTradingConfigView.isInt) {
        customTradingConfigView.textEditingController.text = "0";
      } else {
        customTradingConfigView.textEditingController.text = "0.0";
      }
    }

    if (customTradingConfigView.isInt) {
      var newValue =
          int.parse(customTradingConfigView.textEditingController.text) + 1;

      customTradingConfigView.textEditingController.text = newValue.toString();
    } else {
      
      var newValue =
          double.parse(customTradingConfigView.textEditingController.text) + 1;

      customTradingConfigView.textEditingController.text = newValue.toString();
    }

    notifyListeners();
  }

  subtractOne(dynamic customTradingConfigView) {

    if (customTradingConfigView.textEditingController.text == "") {
      if (customTradingConfigView.isInt) {
        customTradingConfigView.textEditingController.text = "0";
      } else {
        customTradingConfigView.textEditingController.text = "0.0";
      }
    }

    if (customTradingConfigView.isInt) {
      var newValue =
          int.parse(customTradingConfigView.textEditingController.text) - 1;

      customTradingConfigView.textEditingController.text = newValue.toString();
    } else {
      
      var newValue =
          double.parse(customTradingConfigView.textEditingController.text) - 1;

      customTradingConfigView.textEditingController.text = newValue.toString();
    }
    notifyListeners();
  }

  controller() {
    return controllerData;
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

  //! --------------------------------------------------------------------------
  //! --------------------------------------------------------------------------
  //! PRE-PROCESS DATA -----------------------------------------------------
  //! --------------------------------------------------------------------------
  //! --------------------------------------------------------------------------

  pre_process_body() {
    final tradingConfigBody = [];
    final tradingConfigBodyValue = [];

    //? Active LONG ------------------------------------------------------------
    if (useQty) {
      // Level 1 (Quantity Data)
      if (buttomSelectorChangeText == 'USD') {
        tradingConfigBody.add('quantityUSDLong');
      } else {
        tradingConfigBody.add('quantityUSDLong');
      }

      tradingConfigBodyValue.add(controllerData.text);

      // Level 2 (Stop Loss %)
      if (controllerDataPercentage.text != '') {
        if (buttomSelectorChangeTextPercentage == '%') {
          tradingConfigBody.add('stopLossLong');
        } else {
          tradingConfigBody.add('stopLossLongUsd');
        }
        tradingConfigBodyValue.add(controllerDataPercentage.text);
      }

      // Level 3 (Take Profit)
      if (controllerDataTakeprofit.text != '') {
        if (buttomSelectorChangeTextTakeProfit == '%') {
          tradingConfigBody.add('takeProfitLong');
        } else {
          tradingConfigBody.add('takeProfitLongUsd');
        }
        tradingConfigBodyValue.add(controllerDataTakeprofit.text);
      }

      // Level 4 (Consecutive Losses Allowed)
      if (controllerLossesAllowed.text != '') {
        tradingConfigBody.add('consecutiveLossesLong');
        tradingConfigBodyValue.add(controllerLossesAllowed.text);
      }
    } else {
      errorMessage = 'Is mandatory add the quantity';
      notifyListeners();
    }

    //? Active SHORT ------------------------------------------------------------

    print("@Note-01 ---- 1437231374 -----");
    print(tradingConfigBody);
    print(tradingConfigBodyValue);

    // 'broker',
    // 'strategyNews',
    // 'quantityUSDLong',
    // 'stopLossLong',
    // 'takeProfitLong',
    // 'quantityUSDShort',
    // 'stopLossShort',
    // 'takeProfitShort',
    // 'consecutiveLossesShort',
    // 'consecutiveLossesLong',
    // 'useLong',
    // 'useShort'
  }
}
