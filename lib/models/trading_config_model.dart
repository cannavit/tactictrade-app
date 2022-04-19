// To parse this JSON data, do
//
//     final tradingConfigModel = tradingConfigModelFromMap(jsonString);

import 'dart:convert';

class TradingConfigModel {
    TradingConfigModel({
        this.count,
        this.next,
        this.previous,
        required this.results,
    });

    int? count;
    dynamic next;
    dynamic previous;
    List<TradingConfig> results;

    factory TradingConfigModel.fromJson(String str) => TradingConfigModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TradingConfigModel.fromMap(Map<String, dynamic> json) => TradingConfigModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<TradingConfig>.from(json["results"].map((x) => TradingConfig.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
    };
}

class TradingConfig {
    TradingConfig({
        required this.owner,
        required this.strategyNews,
        required this.broker,
        required this.useLong,
        required this.stopLossLong,
        required this.takeProfitLong,
        required this.consecutiveLossesLong,
        required this.quantityUsdShort,
        required this.quantityUsdLong,
        required this.quantityQtyShort,
        required this.quantityQtyLong,
        required this.useShort,
        required this.stopLossShort,
        required this.takeProfitShort,
        required this.consecutiveLossesShort,
        required this.isActive,
        required this.isActiveShort,
        required this.isActiveLong,
        required this.closeTradeLongAndDeactivate,
        required this.closeTradeShortAndDeactivate,
        required this.initialCapitalUsdLong,
        required this.initialCapitalUsdShort,
        required this.initialCapitalQtyLong,
        required this.initialCapitalQtyShort,
        required this.winTradeLong,
        required this.winTradeShort,
        required this.closedTradeShort,
        required this.closedTradeLong,
        required this.profitPorcentageShort,
        required this.profitPorcentageLong,
        required this.strategyNewsId,
        required this.strategyNewsName,
        required this.strategyNewsPusher,
        required this.symbolUrl,
        required this.symbolName,
        required this.symbolSymbolName,
        required this.symbolTime,
        required this.brokerName,
        required this.brokerBrokerName,
        required this.totalNumberOfWinTrades,
        required this.totalTradingProfit,
        required this.totalOfTrades,
        required this.totalProfitUsd,
        required this.id,
    });

    int owner;
    int strategyNews;
    int broker;
    bool useLong;
    double stopLossLong;
    double takeProfitLong;
    int consecutiveLossesLong;
    double? quantityUsdShort;
    double? quantityUsdLong;
    double? quantityQtyShort;
    double? quantityQtyLong;
    bool? useShort;
    double? stopLossShort;
    double? takeProfitShort;
    int consecutiveLossesShort;
    bool isActive;
    bool isActiveShort;
    bool isActiveLong;
    bool closeTradeLongAndDeactivate;
    bool closeTradeShortAndDeactivate;
    double?  initialCapitalUsdLong;
    double?  initialCapitalUsdShort;
    double?  initialCapitalQtyLong;
    double?  initialCapitalQtyShort;
    double?  winTradeLong;
    double?  winTradeShort;
    int closedTradeShort;
    int closedTradeLong;
    double profitPorcentageShort;
    double profitPorcentageLong;
    int strategyNewsId;
    String strategyNewsName;
    String strategyNewsPusher;
    String symbolUrl;
    String symbolName;
    String symbolSymbolName;
    String symbolTime;
    String brokerName;
    String brokerBrokerName;
    int totalNumberOfWinTrades;
    double totalTradingProfit;
    int totalOfTrades;
    double totalProfitUsd;
    int id;

    factory TradingConfig.fromJson(String str) => TradingConfig.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TradingConfig.fromMap(Map<String, dynamic> json) => TradingConfig(
        owner: json["owner"],
        strategyNews: json["strategyNews"],
        broker: json["broker"],
        useLong: json["useLong"],
        stopLossLong: json["stopLossLong"],
        takeProfitLong: json["takeProfitLong"],
        consecutiveLossesLong: json["consecutiveLossesLong"],
        quantityUsdShort: json["quantityUSDShort"],
        quantityUsdLong: json["quantityUSDLong"],
        quantityQtyShort: json["quantityQTYShort"],
        quantityQtyLong: json["quantityQTYLong"],
        useShort: json["useShort"],
        stopLossShort: json["stopLossShort"],
        takeProfitShort: json["takeProfitShort"],
        consecutiveLossesShort: json["consecutiveLossesShort"],
        isActive: json["is_active"],
        isActiveShort: json["is_active_short"],
        isActiveLong: json["is_active_long"],
        closeTradeLongAndDeactivate: json["close_trade_long_and_deactivate"],
        closeTradeShortAndDeactivate: json["close_trade_short_and_deactivate"],
        initialCapitalUsdLong: json["initialCapitalUSDLong"],
        initialCapitalUsdShort: json["initialCapitalUSDShort"],
        initialCapitalQtyLong: json["initialCapitalQTYLong"],
        initialCapitalQtyShort: json["initialCapitalQTYShort"],
        winTradeLong: json["winTradeLong"],
        winTradeShort: json["winTradeShort"],
        closedTradeShort: json["closedTradeShort"],
        closedTradeLong: json["closedTradeLong"],
        profitPorcentageShort: json["profitPorcentageShort"],
        profitPorcentageLong: json["profitPorcentageLong"],
        strategyNewsId: json["strategyNews_id"],
        strategyNewsName: json["strategyNews_name"],
        strategyNewsPusher: json["strategyNews_pusher"],
        symbolUrl: json["symbol_url"],
        symbolName: json["symbol_name"],
        symbolSymbolName: json["symbol_symbolName"],
        symbolTime: json["symbol_time"],
        brokerName: json["broker_name"],
        brokerBrokerName: json["broker_brokerName"],
        totalNumberOfWinTrades: json["totalNumberOfWinTrades"],
        totalTradingProfit: json["totalTradingProfit"],
        totalOfTrades: json["totalOfTrades"],
        totalProfitUsd: json["totalProfitUSD"],
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "owner": owner,
        "strategyNews": strategyNews,
        "broker": broker,
        "useLong": useLong,
        "stopLossLong": stopLossLong,
        "takeProfitLong": takeProfitLong,
        "consecutiveLossesLong": consecutiveLossesLong,
        "quantityUSDShort": quantityUsdShort,
        "quantityUSDLong": quantityUsdLong,
        "quantityQTYShort": quantityQtyShort,
        "quantityQTYLong": quantityQtyLong,
        "useShort": useShort,
        "stopLossShort": stopLossShort,
        "takeProfitShort": takeProfitShort,
        "consecutiveLossesShort": consecutiveLossesShort,
        "is_active": isActive,
        "is_active_short": isActiveShort,
        "is_active_long": isActiveLong,
        "close_trade_long_and_deactivate": closeTradeLongAndDeactivate,
        "close_trade_short_and_deactivate": closeTradeShortAndDeactivate,
        "initialCapitalUSDLong": initialCapitalUsdLong,
        "initialCapitalUSDShort": initialCapitalUsdShort,
        "initialCapitalQTYLong": initialCapitalQtyLong,
        "initialCapitalQTYShort": initialCapitalQtyShort,
        "winTradeLong": winTradeLong,
        "winTradeShort": winTradeShort,
        "closedTradeShort": closedTradeShort,
        "closedTradeLong": closedTradeLong,
        "profitPorcentageShort": profitPorcentageShort,
        "profitPorcentageLong": profitPorcentageLong,
        "strategyNews_id": strategyNewsId,
        "strategyNews_name": strategyNewsName,
        "strategyNews_pusher": strategyNewsPusher,
        "symbol_url": symbolUrl,
        "symbol_name": symbolName,
        "symbol_symbolName": symbolSymbolName,
        "symbol_time": symbolTime,
        "broker_name": brokerName,
        "broker_brokerName": brokerBrokerName,
        "totalNumberOfWinTrades": totalNumberOfWinTrades,
        "totalTradingProfit": totalTradingProfit,
        "totalOfTrades": totalOfTrades,
        "totalProfitUSD": totalProfitUsd,
        "id": id,
    };
}
