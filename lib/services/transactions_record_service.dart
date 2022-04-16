import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tactictrade/models/create_strategy.dart';
import 'package:tactictrade/models/environments_models.dart';
import 'package:tactictrade/services/auth_service.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

class TransactionRecordsServices extends ChangeNotifier {
  bool isLoading = false;
  List recordsList = [];

  TransactionRecordsServices() {
    this.loadTransactionsRecords();
  }

  Future loadTransactionsRecords() async {
    this.isLoading = true;

    notifyListeners();

    final params = Preferences.transactionRecordsServicesData;
    final data2 = json.decode(params);

    final strategyId = data2["strategyId"];
    final body = data2['body'];

    final url =
        Uri.http(Environment.baseUrl, '/transactions/records/${strategyId}');

    final _storage = new FlutterSecureStorage();

    final token = await _storage.read(key: 'token_access') ?? '';

    if (token == '') {
      return '';
    }

    final body_json = json.encode(body);

    final response = await http.get(url, headers: {
      'Content-Type': 'applicaction/json',
      'Authorization': 'Bearer ' + token,
    });

    final data = json.decode(response.body)['results'];
    Preferences.transactionRecordsServicesData = '';

    this.isLoading = false;
    this.recordsList = data;
    notifyListeners();

    return data;
  }
}
