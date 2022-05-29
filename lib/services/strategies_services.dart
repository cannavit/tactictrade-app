import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tactictrade/models/create_strategy.dart';
import 'package:tactictrade/models/environments_models.dart';
import 'package:tactictrade/services/auth_service.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

import '../models/strategy_models.dart';
import '../screens/login_screens.dart';

class StrategyServices extends ChangeNotifier {
  bool isLoading = true;

  Future postStrategy(StrategyData body) async {
    final urlProfile = Uri.http(Environment.baseUrl, '/strategy/v1/add');

    const _storage = FlutterSecureStorage();

    final token = await _storage.read(key: 'token_access') ?? '';

    if (token == '') {
      return '';
    }

    Map<String, String> headers = {
      'Content-Type': 'applicaction/json',
      'Authorization': 'Bearer ' + token
    };

    final imageUploadRequest = http.MultipartRequest('POST', urlProfile);

    imageUploadRequest.headers.addAll(headers);

    final data = json.encode(body);

    imageUploadRequest.fields['symbol'] = body.symbol;
    imageUploadRequest.fields['timer'] = body.timer;
    imageUploadRequest.fields['description'] = body.description;
    imageUploadRequest.fields['is_public'] = body.isPublic;
    imageUploadRequest.fields['is_active'] = body.isActive;
    imageUploadRequest.fields['period'] = body.period;
    imageUploadRequest.fields['strategyNews'] = body.strategyNews;

    final String strategyImage = Preferences.tempStrategyImage;
    if (strategyImage != '') {
      final profileImage =
          await http.MultipartFile.fromPath('post_image', strategyImage);

      imageUploadRequest.files.add(profileImage);

      Preferences.tempStrategyImage = '';
    }

    final resp = await imageUploadRequest.send();

    final respStr = await resp.stream.bytesToString();

    return {'statusCode': resp.statusCode, 'body': respStr};
  }

  Future loadStrategy() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(Environment.baseUrl, '/strategy/v1/all');

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

    Preferences.selectedTimeNewStrategy = '';

    isLoading = false;
    notifyListeners();
  }
}

class StrategyLoadServices extends ChangeNotifier {
  bool isLoading = true;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  List<Strategy> strategyList = [];
  List<Strategy> strategyResults = [];

  Map categoriesStrategy = {};
  Map strategyPageCategory = {};

  int strategyPage = 0;

  File? newPictureFile;

  StrategyLoadServices() {
    loadStrategy();
  }

  Future<String> _getJsonData(String endpoint,
      [int page = 1, String category = 'all']) async {
    final url = Uri.http(Environment.baseUrl, endpoint,
        {'page': '$page', 'category': category});

    const _storage = FlutterSecureStorage();

    final token = await _storage.read(key: 'token_access') ?? '';

    if (token == '') {
      navigatorKey.currentState?.pushNamed('login');
    }

    final response = await http.get(url, headers: {
      'Content-Type': 'applicaction/json',
      'Authorization': 'Bearer ' + token
    });

    return response.body;
  }

  Future loadStrategy() async {
    isLoading = true;
    notifyListeners();

    final category = Preferences.categoryStrategySelected;

    strategyPageCategory[category] = strategyPageCategory[category] ?? 1;

    final page = strategyPageCategory[category];

    // Check if data exist inside of the memory object

    final updateTheStrategies = Preferences.updateTheStrategies;

    if (categoriesStrategy[category] != null && !updateTheStrategies) {
      if (categoriesStrategy[category].length > 0) {
        this.strategyList = categoriesStrategy[category];
        Preferences.categoryStrategySelected = 'all';
        return categoriesStrategy[category];
      }
    }

    Preferences.updateTheStrategies = false;
    strategyPage++;

    // final jsonData =
    // await _getJsonData('/strategy/v1/all', strategyPage, category);

    final jsonData = await _getJsonData('/strategy/v1/all', page, category);

    final strategyList = StrategyModel.fromJson(jsonData);

    strategyResults = categoriesStrategy[category] ?? strategyResults;

    categoriesStrategy[category] = [
      ...strategyResults,
      ...strategyList.results,
    ];

    strategyPageCategory[category] = strategyPageCategory[category]++;
    this.strategyList = categoriesStrategy[category];

    isLoading = false;
    notifyListeners();

    Preferences.categoryStrategySelected = 'all';

    return categoriesStrategy[category];
  }

  void updateSelectedProductImage(String path) {
    Preferences.tempStrategyImage = path;
    newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();
  }
}

class StrategySocial extends ChangeNotifier {
  bool isLoading = true;
  List strategyList = [];

  dynamic readLikes = {};

  read(int likeNumbers) {
    print("@Note-01 ---- -1499031061 -----");

    // if (readLikes[strategyId] == null) {
    //   readLikes[strategyId] = 0;
    // }

    // final result = readLikes[strategyId];

    // // notifyListeners();
    // return result;
  }

//   // int strategyId
  Future put(int strategyId, dynamic social) async {
    final url =
        Uri.http(Environment.baseUrl, '/strategy/v1/social/$strategyId');
    const _storage = FlutterSecureStorage();
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

    final responseJson = jsonDecode(response.body);

    // readLikes[strategyId] = likesNumber;

    notifyListeners();

    return data;
  }
}
