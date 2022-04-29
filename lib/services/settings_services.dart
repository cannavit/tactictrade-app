import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tactictrade/models/environments_models.dart';
import 'package:tactictrade/models/settings_model.dart';
import 'package:tactictrade/models/settings_one_models.dart';

class SettingServices extends ChangeNotifier {
  bool isLoading = true;
  dynamic settingList = [];
  List settingFamily = [];

  SettingServices() {
    this.read();
  }
//   // int strategyId
  Future read() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.http(Environment.baseUrl, '/settings/v1',
        {'is_active': 'true', 'is_switch_on': 'true'});

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

    final dataModel = SettingsModel.fromJson(response.body);

    final family_list = {};

    for (var i in dataModel.results) {
      if (family_list[i.family] == null) {
        family_list[i.family] = [];
        family_list[i.family].add(i);
        settingFamily.add(i.family);
      } else {
        family_list[i.family].add(i);
      }
    }

    this.settingFamily = settingFamily;
    this.settingList = family_list;

    this.isLoading = false;
    notifyListeners();

    return family_list;
  }

  Future put(Setting settings) async {
    final url = Uri.http(Environment.baseUrl, '/settings/v1/${settings.id}');

    final _storage = new FlutterSecureStorage();

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
        this.settingList[settings.family][count] = settings;
      }
    }

    this.settingList = this.settingList;
    notifyListeners();
    return this.settingList;
  }
}
