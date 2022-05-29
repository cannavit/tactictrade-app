import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tactictrade/models/create_strategy.dart';
import 'package:tactictrade/models/environments_models.dart';
import 'package:tactictrade/models/trading_config_model.dart';
import 'package:tactictrade/services/auth_service.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

class TradingConfig extends ChangeNotifier {
  bool isLoading = true;
  List tradingConfigList = [];
  List<TradingConfig> tradingConfigData = [];

  Map categoriesStrategy = {};

  TradingConfig() {
    read();
  }

//   // int strategyId
  Future create(dynamic data) async {
    final url = Uri.http(Environment.baseUrl, '/trading/tradingvalues');

    const _storage = FlutterSecureStorage();

    final token = await _storage.read(key: 'token_access') ?? '';

    if (token == '') {
      return '';
    }

    final body = json.encode(data);

    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          'Authorization': 'Bearer ' + token
        },
        body: body);

    final message = json.decode(response.body)['message'];

    notifyListeners();

    return message;
  }

  Future read() async {
    isLoading = true;

    notifyListeners();

    final url = Uri.http(Environment.baseUrl, '/trading/all');
    const _storage = FlutterSecureStorage();
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

    if (jsonDecode(response.body)['code'] == 'user_not_found') {
      final GlobalKey<NavigatorState> navigatorKey =
          GlobalKey<NavigatorState>();
      navigatorKey.currentState?.pushNamed('login');
    }

    final tradingConfigData = TradingConfigModel.fromJson(response.body);

    tradingConfigList = tradingConfigData.results;

    isLoading = false;
    notifyListeners();

    return tradingConfigList;
  }

  Future readv2() async {
    final category = Preferences.categoryStrategyOwnerSelected;
    final updateList = Preferences.updateStrategyOwnerSelected;
    final categoryListData = categoriesStrategy[category];
    // Check if the data exist in memory
    if (categoriesStrategy[category] != null && !updateList) {
      tradingConfigList = categoriesStrategy[category];
      Preferences.updateStrategyOwnerSelected = false;
      return categoriesStrategy[category];
    }

    final url =
        Uri.http(Environment.baseUrl, '/trading/all', {'category': category});

    const _storage = FlutterSecureStorage();
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

    final tradingConfigData = TradingConfigModel.fromJson(response.body);

    tradingConfigList = tradingConfigData.results;

    categoriesStrategy[category] = tradingConfigData.results;

    notifyListeners();

    return tradingConfigList;
  }

  Future delete(tradingConfigId) async {
    isLoading = true;

    notifyListeners();

    final url = Uri.http(
        Environment.baseUrl, '/trading/tradingvalues/$tradingConfigId');
    const _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token_access') ?? '';

    if (token == '') {
      return '';
    }

    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer ' + token
      },
    );

    final data = json.decode(response.body)['results'];


    tradingConfigList = data;

    isLoading = false;
    notifyListeners();

    return tradingConfigList;
  }

  Future edit_tradingconfig(int tradingConfigId, dynamic body) async {
    const _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token_access') ?? '';

    if (token == '') {
      return '';
    }

    final bodyJson = json.encode(body);

    final url = Uri.http(
        Environment.baseUrl, '/trading/tradingvalues/$tradingConfigId');

    final response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          'Authorization': 'Bearer ' + token
        },
        body: bodyJson);

    final message = json.decode(response.body)['message'];

    // final body = json.encode(data);
  }

  Future openLong(int tradingConfigId) async {
    const _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token_access') ?? '';

    if (token == '') {
      return '';
    }

    final url =
        Uri.http(Environment.baseUrl, '/trading/openlong/$tradingConfigId');

    final response = await http.post(url, headers: {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Authorization': 'Bearer ' + token
    });

    // final body = json.encode(data);
  }

  Future openShort(int tradingConfigId) async {
    const _storage = FlutterSecureStorage();

    final token = await _storage.read(key: 'token_access') ?? '';

    if (token == '') {
      return '';
    }

    final url =
        Uri.http(Environment.baseUrl, '/trading/openshort/$tradingConfigId');

    final response = await http.post(url, headers: {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Authorization': 'Bearer ' + token
    });


    // final message = json.decode(response.body)['message'];

    // final body = json.encode(data);
  }
}
