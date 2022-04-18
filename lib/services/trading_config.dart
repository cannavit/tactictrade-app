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
    this.read();
  }

//   // int strategyId
  Future create(dynamic data) async {
    final url = Uri.http(Environment.baseUrl, '/trading/tradingvalues');
    final _storage = new FlutterSecureStorage();
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
    this.isLoading = true;

    notifyListeners();

    final url = Uri.http(Environment.baseUrl, '/trading/all');
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

    final tradingConfigData = TradingConfigModel.fromJson(response.body);

    this.tradingConfigList = tradingConfigData.results;

    this.isLoading = false;
    notifyListeners();

    return this.tradingConfigList;
  }

  Future readv2() async {
    final category = Preferences.categoryStrategyOwnerSelected;
    final updateList = Preferences.updateStrategyOwnerSelected;
    final categoryListData = categoriesStrategy[category];
    // Check if the data exist in memory
    if (categoriesStrategy[category] != null && !updateList) {
      this.tradingConfigList = categoriesStrategy[category];
      Preferences.updateStrategyOwnerSelected = false;
      return categoriesStrategy[category];
    }

    final url =
        Uri.http(Environment.baseUrl, '/trading/all', {'category': category});

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

    final tradingConfigData = TradingConfigModel.fromJson(response.body);

    this.tradingConfigList = tradingConfigData.results;

    categoriesStrategy[category] = tradingConfigData.results;

    notifyListeners();

    return this.tradingConfigList;
  }

  Future delete(tradingConfigId) async {
    this.isLoading = true;

    notifyListeners();

    final url = Uri.http(
        Environment.baseUrl, '/trading/tradingvalues/${tradingConfigId}');
    final _storage = new FlutterSecureStorage();
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

    print(data);

    this.tradingConfigList = data;

    this.isLoading = false;
    notifyListeners();

    return this.tradingConfigList;
  }

  Future edit_tradingconfig(int tradingConfigId, dynamic body) async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token_access') ?? '';

    if (token == '') {
      return '';
    }

    final body_json = json.encode(body);

    final url = Uri.http(
        Environment.baseUrl, '/trading/tradingvalues/${tradingConfigId}');

    final response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          'Authorization': 'Bearer ' + token
        },
        body: body_json);

    final message = json.decode(response.body)['message'];

    // final body = json.encode(data);
  }
}
