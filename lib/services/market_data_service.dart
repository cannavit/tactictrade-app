import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tactictrade/models/environments_models.dart';
import 'package:tactictrade/models/market_data_model.dart';

class MarketDataService extends ChangeNotifier {
  bool isLoading = true;
  int volumeMax = 0;
  dynamic marketDataCache = {};
  List<Candle> MarketDataList = [];
  List operations = [];
  dynamic operationCache = {};

  currendData() {
    return MarketDataList;
  }

  read(
    String symbol,
    String period,
    String interval,
    int strategyId,
  ) async {
    var dataMarket;

    var findNewData = true;
    // Get data if exist inside of the cache.
    if (marketDataCache[symbol] != null) {
      if (marketDataCache[symbol][period] != null) {
        if (marketDataCache[symbol][period][interval] != null) {
          isLoading = false;
          dataMarket = marketDataCache[symbol][period][interval];
          MarketDataList = dataMarket;

          operations = operationCache[symbol][period][interval];

          findNewData = false;
          notifyListeners();
        }
      }
    }

    if (findNewData) {
      isLoading = true;

      final url = Uri.http(Environment.baseUrl,
          '/market_data/yahoo/$symbol/$period/$interval/$strategyId');

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

      final data = json.decode(response.body)['results'];

      final dataList = MarketData.fromJson(response.body);

      // Init array
      if (marketDataCache[symbol] == null) {
        marketDataCache[symbol] = {};
        operationCache[symbol] = {};
      }

      if (marketDataCache[symbol][period] == null) {
        marketDataCache[symbol][period] = {};
        operationCache[symbol][period] = {};

      }

      marketDataCache[symbol][period][interval] = dataList.results;
      dataMarket = dataList.results;
      isLoading = false;

      operationCache[symbol][period][interval] = dataList.operations;
      operations = dataList.operations;
      MarketDataList = dataMarket;
    }

    notifyListeners();
    return dataMarket;
  }
}
