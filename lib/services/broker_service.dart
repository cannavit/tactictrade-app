import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tactictrade/models/create_strategy.dart';
import 'package:tactictrade/models/environments_models.dart';
import 'package:tactictrade/services/auth_service.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

class BrokerConfig extends ChangeNotifier {
  bool isLoading = true;
  List BrokerConfigList = [];
//   // int strategyId

  BrokerConfig() {
    this.read();
  }

  Future read() async {
    this.isLoading = true;

    notifyListeners();

    final url = Uri.http(Environment.baseUrl, '/broker/v1/all');
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

    final data = json.decode(response.body)['results'];


    this.BrokerConfigList = data;
    this.isLoading = false;

    notifyListeners();

    return  this.BrokerConfigList;
  }
}
