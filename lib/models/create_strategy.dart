import 'package:meta/meta.dart';
import 'dart:convert';

class StrategyData {
  StrategyData({
    required this.strategyNews,
    required this.symbol,
    required this.isPublic,
    required this.isActive,
    required this.netProfit,
    required this.percentageProfitable,
    required this.maxDrawdown,
    required this.profitFactor,
    required this.period,
    required this.timer,
    required this.description,
  });

  String strategyNews;
  String symbol;
  String isPublic;
  String isActive;
  String netProfit;
  String percentageProfitable;
  String maxDrawdown;
  String profitFactor;
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
        netProfit: json["net_profit"].toDouble(),
        percentageProfitable: json["percentage_profitable"].toDouble(),
        maxDrawdown: json["max_drawdown"].toDouble(),
        profitFactor: json["profit_factor"].toDouble(),
        period: json["period"],
        timer: json["timer"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "strategyNews": strategyNews,
        "symbol": symbol,
        "is_public": isPublic,
        "is_active": isActive,
        "net_profit": netProfit,
        "percentage_profitable": percentageProfitable,
        "max_drawdown": maxDrawdown,
        "profit_factor": profitFactor,
        "period": period,
        "timer": timer,
        "description": description,
      };
}
