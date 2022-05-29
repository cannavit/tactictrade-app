import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/environments_models.dart';

class PositionServices extends ChangeNotifier {
  bool isLoading = true;
  List positionsList = [];

  PositionServices() {
    read();
  }

  Future read() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.http(Environment.baseUrl, '/transactions/opens');
    const _storage = FlutterSecureStorage();

    final token = await _storage.read(key: 'token_access') ?? '';

    if (token == '') {
      return '';
    }

    final response = await http.get(url, headers: {
      'Content-Type': 'applicaction/json',
      'Authorization': 'Bearer ' + token
    });

    final data = json.decode(response.body)['results'];

    positionsList = data;

    isLoading = false;
    notifyListeners();

    return positionsList;
  }


  Future readv2() async {

    final url = Uri.http(Environment.baseUrl, '/transactions/opens');
    const _storage = FlutterSecureStorage();

    final token = await _storage.read(key: 'token_access') ?? '';

    if (token == '') {
      return '';
    }

    final response = await http.get(url, headers: {
      'Content-Type': 'applicaction/json',
      'Authorization': 'Bearer ' + token
    });

    final data = json.decode(response.body)['results'];

    positionsList = data;
    notifyListeners();


    return positionsList;
  }


  Future close(transactionId) async {
    notifyListeners();

    final url = Uri.http(
        Environment.baseUrl, '/transactions/close_manual/$transactionId');
    const _storage = FlutterSecureStorage();

    final token = await _storage.read(key: 'token_access') ?? '';

    if (token == '') {
      return '';
    }

    final dataSocial = json.encode({  "is_paper_trading": true,  "order": "buy",  "operation": "long",  "qty_open": 0,  "price_open": 0,  "price_closed": 0,  "base_cost": 0,  "profit": 0,  "profit_percentage": 0,  "isClosed": true,  "stop_loss": 0,  "take_profit": 0,  "is_winner": true,  "broker_transaction_id": "string",  "number_stock": 0,  "owner": 0,  "strategyNews": 0,  "broker": 0,  "symbol": 0});

    final response = await http.put(url,
        headers: {
          'Content-Type': 'applicaction/json',
          'Authorization': 'Bearer ' + token
        },
        body: dataSocial);

    final data = json.decode(response.body)['results'];

    positionsList = data;

    isLoading = false;
    notifyListeners();

    return positionsList;
  }
}
