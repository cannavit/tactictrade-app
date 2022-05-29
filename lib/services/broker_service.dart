import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tactictrade/models/environments_models.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

class BrokerServices extends ChangeNotifier {
  bool isLoading = true;
  List brokerList = [];
  String createBrokerRespone = "";

  BrokerServices() {
    loadBroker();
  }

  Future loadBroker() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.http(Environment.baseUrl, '/broker/v1/all');
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

    brokerList = data;

    isLoading = false;
    notifyListeners();

    return brokerList;
  }

  Future loadBrokerv2() async {

    final url = Uri.http(Environment.baseUrl, '/broker/v1/all');
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


    brokerList = data;
    notifyListeners();


    return brokerList;
  }


  Future createBroker(bodyBroker) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.http(Environment.baseUrl, '/broker/v1/alpaca');
    const _storage = FlutterSecureStorage();

    final token = await _storage.read(key: 'token_access') ?? '';


    if (token == '') {
      return '';
    }

    final data = json.encode(bodyBroker);

    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + token
        },
        body: data);

    isLoading = false;

    notifyListeners();

    return response;
  }
}



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