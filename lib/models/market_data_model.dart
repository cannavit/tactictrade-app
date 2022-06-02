// To parse this JSON data, do
//
//     final marketData = marketDataFromMap(jsonString);

import 'dart:convert';

class MarketData {
  MarketData({
    required this.status,
    required this.results,
    required this.operations,
  });

  String status;
  List<Candle> results;
  List<List<dynamic>> operations;
  
  factory MarketData.fromJson(String str) =>
      MarketData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MarketData.fromMap(Map<String, dynamic> json) => MarketData(
        status: json["status"],
        results:
            List<Candle>.from(json["results"].map((x) => Candle.fromMap(x))),
         operations: List<List<dynamic>>.from(json["operations"].map((x) => List<dynamic>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "result": List<dynamic>.from(results.map((x) => x.toMap())),
        "operations": List<dynamic>.from(operations.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

class Candle {
  Candle({
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.adjClose,
    required this.volume,
    required this.date,
    this.isGreen = false,
  });

  double open;
  double high;
  double low;
  double close;
  double adjClose;
  int volume;
  DateTime date;
  bool isGreen = false;

  factory Candle.fromJson(String str) => Candle.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Candle.fromMap(Map<String, dynamic> json) => Candle(
        open: json["Open"].toDouble(),
        high: json["High"].toDouble(),
        low: json["Low"].toDouble(),
        close: json["Close"].toDouble(),
        adjClose: json["Adj Close"].toDouble(),
        volume: json["Volume"],
        isGreen: json["Close"].toDouble() > json["Open"].toDouble(),
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toMap() => {
        "Open": open,
        "High": high,
        "Low": low,
        "Close": close,
        "Adj Close": adjClose,
        "Volume": volume,
        "isGreen": isGreen,
        "date": date.toIso8601String(),
      };
}
