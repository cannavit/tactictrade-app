import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/environments_models.dart';

class PositionServices extends ChangeNotifier {

  bool isLoading = true;
  List positionsList = [];

  PositionServices() {
    this.read();
  }

  Future read() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.http(Environment.baseUrl, '/transactions/opens');
    final _storage = new FlutterSecureStorage();

    final token = await _storage.read(key: 'token_access') ?? '';

    if (token == '') {
      return '';
    }

    final response = await http.get(url, headers: {
      'Content-Type': 'applicaction/json',
      'Authorization': 'Bearer ' + token
    });

    final data = json.decode(response.body)['results'];

    this.positionsList = data;

    this.isLoading = false;
    notifyListeners();

    return this.positionsList;
  }
}
