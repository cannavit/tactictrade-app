import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tactictrade/models/menu_home_categories.dart';

import '../share_preferences/preferences.dart';

class TradingConfigInputLongProvider with ChangeNotifier {
  late TextEditingController inputController;

  dynamic buttonValues = {};
  dynamic buttonText = {};
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

  buttonTextWrite(String variable, newValue) {
    
    buttonText[variable] = newValue;

    notifyListeners();

    return buttonText;
  }

  buttonTextRead(String variable) {
    return buttonText[variable];
  }

  buttonValuesWrite(String variable, newValue) {
    buttonValues[variable] = newValue;

    try {
      notifyListeners();
    } catch (e) {
      print("@Note-01 ---- 1710912487 -----");
    }

    return buttonValues;
  }

  buttonValuesRead(String variable) {
    return buttonValues[variable];
  }

  selectorData(dynamic variable, String operation) {
    final buttonValuesOne = buttonValues[variable.dbFieldOne + "_$operation"];
    final buttonTextOne = buttonText[variable.dbFieldOne + "_$operation"];

    if (data[variable.dbFieldOne + "_$operation"] == null) {
      data[variable.dbFieldOne + "_$operation"] = {};
    }

    if (variable.buttonOneText == buttonTextOne) {
      data[variable.dbFieldOne + "_$operation"]['buttonText'] =
          variable.buttonOneText;
      data[variable.dbFieldOne + "_$operation"]['dbField'] =
          variable.dbFieldOne;
      data[variable.dbFieldOne + "_$operation"]['hintText'] =
          variable.hintTextOne;
      data[variable.dbFieldOne + "_$operation"]['labelText'] =
          variable.labelTextOne;
      data[variable.dbFieldOne + "_$operation"]['isPercent'] =
          variable.isPercentOne;
    } else {
      data[variable.dbFieldOne + "_$operation"]['buttonText'] =
          variable.buttonTwoText;
      data[variable.dbFieldOne + "_$operation"]['dbField'] =
          variable.dbFieldTwo;
      data[variable.dbFieldOne + "_$operation"]['hintText'] =
          variable.hintTextTwo;
      data[variable.dbFieldOne + "_$operation"]['labelText'] =
          variable.labelTextTwo;
      data[variable.dbFieldOne + "_$operation"]['isPercent'] =
          variable.isPercentTwo;
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

  //! --------------------------------------------------------------------------
  //! --------------------------------------------------------------------------
  //! PRE-PROCESS DATA -----------------------------------------------------
  //! --------------------------------------------------------------------------
  //! --------------------------------------------------------------------------

  pre_process_body() {
    final tradingConfigBody = [];
    final tradingConfigBodyValue = [];

    final isActiveShort = Preferences.brokerNewUseTradingShort;
    final isActiveLong = Preferences.brokerNewUseTradingLong;

    print(buttonValues);
    print(buttonText);
    print(data);

    final variableList = [];

    for (String key in buttonText.keys) {
      if (key.contains('_dbField')) {
        variableList.add(buttonText[key]);
      }
    }

    for (String dbField in variableList) {
      tradingConfigBody.add(dbField);

      for (String key in buttonText.keys) {
        if (key.contains(dbField) && key.contains('_value')) {
          tradingConfigBodyValue.add(buttonText[key]);
        }
      }
    }

    return {
      'tradingConfigBody': tradingConfigBody,
      'tradingConfigBodyValue': tradingConfigBodyValue
    };
  }
}
