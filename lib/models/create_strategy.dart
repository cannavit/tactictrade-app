import 'dart:convert';

class StrategyData {
  StrategyData({
    required this.strategyNews,
    required this.symbol,
    required this.isPublic,
    required this.isActive,
    required this.period,
    required this.timer,
    required this.description,
  });

  String strategyNews;
  String symbol;
  String isPublic;
  String isActive;
  String period;
  String timer;
  String description;

  factory StrategyData.fromJson(String str) =>
      StrategyData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StrategyData.fromMap(Map<String, dynamic> json) => StrategyData(
        strategyNews: json["strategyNews"],
        symbol: json["symbol"],
        isPublic: json["is_public"],
        isActive: json["is_active"],
        period: json["period"],
        timer: json["timer"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "strategyNews": strategyNews,
        "symbol": symbol,
        "is_public": isPublic,
        "is_active": isActive,
        "period": period,
        "timer": timer,
        "description": description,
      };
}
