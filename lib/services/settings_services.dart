import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tactictrade/models/environments_models.dart';
import 'package:tactictrade/models/settings_model.dart';

class SettingServices extends ChangeNotifier {
  bool isLoading = true;
  dynamic settingList = [];
  List settingFamily = [];

  SettingServices() {
    read();
  }
//   // int strategyId
  Future read() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.http(Environment.baseUrl, '/settings/v1',
        {'is_active': 'true', 'is_switch_on': 'true'});

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

    final dataModel = SettingsModel.fromJson(response.body);

    final familyList = {};

    for (var i in dataModel.results) {
      if (familyList[i.family] == null) {
        familyList[i.family] = [];
        familyList[i.family].add(i);
        settingFamily.add(i.family);
      } else {
        familyList[i.family].add(i);
      }
    }

    settingFamily = settingFamily;
    settingList = familyList;

    isLoading = false;
    notifyListeners();

    return familyList;
  }

  Future put(Setting settings) async {
    final url = Uri.http(Environment.baseUrl, '/settings/v1/${settings.id}');

    const _storage = FlutterSecureStorage();

    final token = await _storage.read(key: 'token_access') ?? '';

    if (token == '') {
      return '';
    }

    final data = settings.toJson();

    final response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          'Authorization': 'Bearer ' + token
        },
        body: data);

    // this.settingList[settings.family][]
    var count = -1;
    for (var i in settingList[settings.family]) {
      count = count + 1;

      if (i.id == settings.id) {
        settingList[settings.family][count] = settings;
      }
    }

    settingList = settingList;
    notifyListeners();
    return settingList;
  }
}
