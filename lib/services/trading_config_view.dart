import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tactictrade/models/create_strategy.dart';
import 'package:tactictrade/models/environments_models.dart';
import 'package:tactictrade/models/trading_config_model.dart';
import 'package:tactictrade/models/trading_config_view.dart';
import 'package:tactictrade/services/auth_service.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

class TradingConfigViewService extends ChangeNotifier {
  dynamic tradingConfigView = {};
  dynamic response;
  dynamic tradingConfigViewData;

  dynamic tradingConfigViewCache = {};

  late int strategyIdSelected;

  // TradingConfigViewService() {
  //   this.read('paperTrade');
  // }



  Future read(String brokerSelect, int strategyId) async {
    if (brokerSelect == "") {
      brokerSelect = Preferences.configTradeBrokerSelectPreferences;
    }

    if (tradingConfigViewCache[strategyId] == null) {
      if (response == null) {
        final url =
            Uri.http(Environment.baseUrl, '/trading/view_flutter/$strategyId');

        const _storage = FlutterSecureStorage();

        final token = await _storage.read(key: 'token_access') ?? '';

        if (token == '') {
          return '';
        }

        response = await http.get(
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

        tradingConfigViewData =
            TradingConfigViewModel.fromJson(response.body);

        tradingConfigViewCache[strategyId] = tradingConfigViewData;
      }
    } else {
      tradingConfigViewData = tradingConfigViewCache[strategyId];
    }

    if (brokerSelect == 'paperTrade' || brokerSelect == "") {
      tradingConfigView = tradingConfigViewData.paperTrade;
    } else if (brokerSelect == 'alpaca') {
      tradingConfigView = tradingConfigViewData.alpaca;
    }

    notifyListeners();

    return tradingConfigView;
  }
}
