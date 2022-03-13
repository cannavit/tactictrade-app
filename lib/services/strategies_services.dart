import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tactictrade/models/create_strategy.dart';
import 'package:tactictrade/models/environments_models.dart';
import 'package:tactictrade/services/auth_service.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

class StrategyServices extends ChangeNotifier {
  bool isLoading = true;

  Future postStrategy(StrategyData body) async {
    final urlProfile = Uri.http(Environment.baseUrl, '/strategy/v1/add');

    final _storage = new FlutterSecureStorage();

    final token = await _storage.read(key: 'token_access') ?? '';

    if (token == '') {
      return '';
    }

    Map<String, String> headers = {
      'Content-Type': 'applicaction/json',
      'Authorization': 'Bearer ' + token
    };

    final imageUploadRequest = await http.MultipartRequest('POST', urlProfile);

    imageUploadRequest.headers.addAll(headers);

    final data = json.encode(body);

    imageUploadRequest.fields['symbol'] = body.symbol;
    imageUploadRequest.fields['timer'] = body.timer;
    imageUploadRequest.fields['description'] = body.description;
    imageUploadRequest.fields['is_public'] = body.isPublic;
    imageUploadRequest.fields['is_active'] = body.isActive;
    imageUploadRequest.fields['net_profit'] = body.netProfit;
    imageUploadRequest.fields['percentage_profitable'] = body.netProfit;
    imageUploadRequest.fields['max_drawdown'] = body.maxDrawdown;
    imageUploadRequest.fields['profit_factor'] = body.profitFactor;
    imageUploadRequest.fields['period'] = body.period;
    imageUploadRequest.fields['strategyNews'] = body.strategyNews;

    final String strategyImage = Preferences.tempStrategyImage;
    if (strategyImage != '') {
      print(strategyImage);

      final profile_image =
          await http.MultipartFile.fromPath('post_image', strategyImage);

      imageUploadRequest.files.add(profile_image);

      Preferences.tempStrategyImage = '';
    }

    final resp = await imageUploadRequest.send();

    final respStr = await resp.stream.bytesToString();

    return {'statusCode': resp.statusCode, 'body': respStr};
  }

  Future loadStrategy() async {
    this.isLoading = true;
    notifyListeners();
    final url = Uri.http(Environment.baseUrl, '/strategy/v1/all');

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

    Preferences.selectedTimeNewStrategy = '';

    this.isLoading = false;
    notifyListeners();
  }
}

class StrategyLoadServices extends ChangeNotifier {
  bool isLoading = true;
  List strategyList = [];
  File? newPictureFile;

  StrategyLoadServices() {
    this.loadStrategy();
  }

  Future loadStrategy() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.http(Environment.baseUrl, '/strategy/v1/all');
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

    this.strategyList = data;

    this.isLoading = false;
    notifyListeners();

    return this.strategyList;
  }

  void updateSelectedProductImage(String path) {
    Preferences.tempStrategyImage = path;
    this.newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();
  }
}

class StrategySocial extends ChangeNotifier {
  bool isLoading = true;
  List strategyList = [];
//   // int strategyId
  Future put(int strategyId, dynamic social) async {
    final url =
        Uri.http(Environment.baseUrl, '/strategy/v1/social/${strategyId}');
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token_access') ?? '';

    if (token == '') {
      return '';
    }

    final dataSocial = json.encode(social);

    final response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          'Authorization': 'Bearer ' + token
        },
        body: dataSocial);

    final data = json.decode(response.body)['results'];

    return data;
  }
}

