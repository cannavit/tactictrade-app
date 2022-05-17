import 'package:flutter/material.dart';
import 'package:tactictrade/share_preferences/preferences.dart';
import 'package:yahoofin/yahoofin.dart';

import 'dart:math';

double roundDouble(double value, int places) {
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

class YahooFinance extends ChangeNotifier {
  final yfin = YahooFin();
  dynamic data;
  bool isMarketOpen = true;

  YahooFinance() {
    getPrice(Preferences.assetSelectedInTradingConfig);
  }

  bool isLoading = false;

  read(String assetSymbol) async {
    bool doesExist = await yfin.checkSymbol(assetSymbol);

    // Fix symbol for yahoo.

    if (!doesExist) {
      final fixAssetOne = assetSymbol.substring(0, 3);
      final fixAssetTwo = assetSymbol.substring(3, 6);
      assetSymbol = fixAssetOne + '-' + fixAssetTwo;
      doesExist = await yfin.checkSymbol(assetSymbol);
    }

    if (doesExist) {
      isMarketOpen = true;
      StockInfo info = yfin.getStockInfo(ticker: assetSymbol);
      StockQuote price = await yfin.getPrice(stockInfo: info);
      StockQuote priceChange = await yfin.getPriceChange(stockInfo: info);

      var isWinner = true;

      if (priceChange.fiftyDayAverageChange! < 0) {
        isWinner = false;
      }

      data = {
        "currentPrice": price.currentPrice,
        "regularMarketChange": priceChange.regularMarketChange,
        "regularMarketChangePercent": priceChange.regularMarketChangePercent,
        "isWinner": isWinner,
      };

      isLoading = false;

      notifyListeners();
    } else {
      data = {};
    }
  }

  getPrice(String assetSymbol) async {
    isLoading = true;

    notifyListeners();

    await read(assetSymbol);

    isLoading = false;
    notifyListeners();
  }

  reload(String assetSymbol) async {
      await read(assetSymbol);
      notifyListeners();
  }
}
