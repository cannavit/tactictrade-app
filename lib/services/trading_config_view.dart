import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tactictrade/models/create_strategy.dart';
import 'package:tactictrade/models/environments_models.dart';
import 'package:tactictrade/models/trading_config_model.dart';
import 'package:tactictrade/models/trading_config_view.dart';
import 'package:tactictrade/services/auth_service.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

class TradingConfigViewService extends ChangeNotifier {
  dynamic tradingConfigView = {};

  TradingConfigViewService() {
    this.read('paperTrade');
  }

  Future read(String brokerSelect) async {
    notifyListeners();

    final url = Uri.http(Environment.baseUrl, '/trading/view_flutter');
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token_access') ?? '';

    if (token == '') {
      return '';
    }

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer ' + token
      },
    );

    print(response);

    final tradingConfigViewData =
        await TradingConfigViewModel.fromJson(response.body);

    if (brokerSelect == 'paperTrade') {
      tradingConfigView = tradingConfigViewData.paperTrade;
    } else if (brokerSelect == 'alpaca') {
      tradingConfigView = tradingConfigViewData.alpaca;
    }

    notifyListeners();

    return tradingConfigView;
  }
}
