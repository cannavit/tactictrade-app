import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tactictrade/models/environments_models.dart';
import 'package:tactictrade/models/market_data_model.dart';

class MarketDataService extends ChangeNotifier {
  bool isLoading = true;
  int volumeMax = 0;

  // Map<String, List<Candle>> MarketDataList;

  List<Candle> MarketDataList = [];

  MarketDataService() {
    read('1w','1h');
  }


  // getCarrousel

  Future read(String period, String interval, ) async {
    isLoading = true;

    notifyListeners();       

    // Example of use of the API
    // /market_data/yahoo/SOL-USD/1mo/30m
    final url = Uri.http(Environment.baseUrl, '/market_data/yahoo/SOL-USD/$period/$interval');

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

    MarketDataList = dataList.results;

    isLoading = false;

    notifyListeners();

    return MarketDataList;
  }
}
