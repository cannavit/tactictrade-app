// To parse this JSON data, do
//
//     final tradingConfigOne = tradingConfigOneFromMap(jsonString);

import 'dart:convert';

class TradingConfigOne {
    TradingConfigOne({
        required this.broker,
        required this.strategyNews,
        this.quantityUsdLong="",
        this.quantityQtyLong="",
        required this.stopLossLong,
        required this.takeProfitLong,
        this.quantityUsdShort="",
        this.quantityQtyShort="",
        required this.stopLossShort,
        required this.takeProfitShort,
        required this.consecutiveLossesShort,
        required this.consecutiveLossesLong,
        required this.useLong,
        required this.useShort,
    });

    int broker;
    int strategyNews;
    String? quantityUsdLong;
    String? quantityQtyLong;
    String? stopLossLong;
    String? takeProfitLong;
    String? quantityUsdShort;
    String? quantityQtyShort;
    String? stopLossShort;
    String? takeProfitShort;
    String? consecutiveLossesShort;
    String? consecutiveLossesLong;
    bool useLong;
    bool useShort;

    factory TradingConfigOne.fromJson(String str) => TradingConfigOne.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TradingConfigOne.fromMap(Map<String, dynamic> json) => TradingConfigOne(
        broker: json["broker"],
        strategyNews: json["strategyNews"],
        quantityUsdLong: json["quantityUSDLong"],
        quantityQtyLong: json["quantityQTYLong"],
        stopLossLong: json["stopLossLong"],
        takeProfitLong: json["takeProfitLong"],
        quantityUsdShort: json["quantityUSDShort"],
        quantityQtyShort: json["quantityQTYShort"],
        stopLossShort: json["stopLossShort"],
        takeProfitShort: json["takeProfitShort"],
        consecutiveLossesShort: json["consecutiveLossesShort"],
        consecutiveLossesLong: json["consecutiveLossesLong"],
        useLong: json["useLong"],
        useShort: json["useShort"],
    );

    Map<String, dynamic> toMap() => {
        "broker": broker,
        "strategyNews": strategyNews,
        "quantityUSDLong": quantityUsdLong,
        "quantityQTYLong": quantityQtyLong,
        "stopLossLong": stopLossLong,
        "takeProfitLong": takeProfitLong,
        "quantityUSDShort": quantityUsdShort,
        "quantityQTYShort": quantityQtyShort,
        "stopLossShort": stopLossShort,
        "takeProfitShort": takeProfitShort,
        "consecutiveLossesShort": consecutiveLossesShort,
        "consecutiveLossesLong": consecutiveLossesLong,
        "useLong": useLong,
        "useShort": useShort,
    };
}
