// To parse this JSON data, do
//
//     final recordModel = recordModelFromMap(jsonString);

import 'dart:convert';

class RecordModel {
  RecordModel({
    this.count,
    this.next,
    this.previous,
    required this.results,
  });

  int? count;
  dynamic next;
  dynamic previous;
  List<Record> results;

  factory RecordModel.fromJson(String str) =>
      RecordModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecordModel.fromMap(Map<String, dynamic> json) => RecordModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Record>.from(json["results"].map((x) => Record.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
      };
}

class Record {
  Record({
    required this.id,
    required this.isPaperTrading,
    required this.order,
    required this.operation,
    required this.qtyOpen,
    required this.qtyClose,
    required this.priceOpen,
    required this.priceClosed,
    required this.baseCost,
    required this.closeCost,
    required this.amountOpen,
    required this.amountClose,
    required this.spread,
    required this.status,
    required this.createAt,
    required this.updatedAt,
    required this.isClosed,
    required this.stopLoss,
    required this.stopLossQty,
    required this.takeProfit,
    required this.takeProfitQty,
    required this.isWinner,
    required this.brokerTransactionId,
    required this.numberStock,
    required this.closeType,
    required this.idTransaction,
    required this.lastStatus,
    required this.profit,
    required this.profitPercentage,
    required this.owner,
    required this.strategyNews,
    required this.broker,
    required this.tradingConfig,
    required this.symbol,
  });

  int id;
  bool isPaperTrading;
  String order;
  String operation;
  double qtyOpen;
  double qtyClose;
  double priceOpen;
  double priceClosed;
  double baseCost;
  double closeCost;
  double amountOpen;
  double amountClose;
  double spread;
  String status;
  String createAt;
  String updatedAt;
  bool isClosed;
  dynamic? stopLoss;
  double stopLossQty;
  double takeProfit;
  double takeProfitQty;
  bool isWinner;
  dynamic? brokerTransactionId;
  double numberStock;
  String closeType;
  dynamic? idTransaction;
  String? lastStatus;
  double profit;
  double profitPercentage;
  int owner;
  int strategyNews;
  int broker;
  int tradingConfig;
  int symbol;

  factory Record.fromJson(String str) => Record.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Record.fromMap(Map<String, dynamic> json) => Record(
        id: json["id"],
        isPaperTrading: json["is_paper_trading"],
        order: json["order"],
        operation: json["operation"],
        qtyOpen: json["qty_open"],
        qtyClose: json["qty_close"],
        priceOpen: json["price_open"].toDouble(),
        priceClosed: json["price_closed"].toDouble(),
        baseCost: json["base_cost"],
        closeCost: json["close_cost"].toDouble(),
        amountOpen: json["amount_open"],
        amountClose: json["amount_close"],
        spread: json["spread"],
        status: json["status"],
        createAt: DateTime.parse(json["create_at"]).toString(),
        updatedAt: DateTime.parse(json["updated_at"]).toString(),
        isClosed: json["isClosed"],
        stopLoss: json["stop_loss"],
        stopLossQty: json["stop_loss_qty"],
        takeProfit: json["take_profit"],
        takeProfitQty: json["take_profit_qty"],
        isWinner: json["is_winner"],
        brokerTransactionId: json["broker_transaction_id"],
        numberStock: json["number_stock"],
        closeType: json["closeType"],
        idTransaction: json["idTransaction"],
        lastStatus: json["last_status"],
        profit: json["profit"].toDouble(),
        profitPercentage: json["profit_percentage"].toDouble(),
        owner: json["owner"],
        strategyNews: json["strategyNews"],
        broker: json["broker"],
        tradingConfig: json["trading_config"],
        symbol: json["symbol"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "is_paper_trading": isPaperTrading,
        "order": order,
        "operation": operation,
        "qty_open": qtyOpen,
        "qty_close": qtyClose,
        "price_open": priceOpen,
        "price_closed": priceClosed,
        "base_cost": baseCost,
        "close_cost": closeCost,
        "amount_open": amountOpen,
        "amount_close": amountClose,
        "spread": spread,
        "status": status,
        "create_at": createAt,
        "updated_at": updatedAt,
        "isClosed": isClosed,
        "stop_loss": stopLoss,
        "stop_loss_qty": stopLossQty,
        "take_profit": takeProfit,
        "take_profit_qty": takeProfitQty,
        "is_winner": isWinner,
        "broker_transaction_id": brokerTransactionId,
        "number_stock": numberStock,
        "closeType": closeType,
        "idTransaction": idTransaction,
        "last_status": lastStatus,
        "profit": profit,
        "profit_percentage": profitPercentage,
        "owner": owner,
        "strategyNews": strategyNews,
        "broker": broker,
        "trading_config": tradingConfig,
        "symbol": symbol,
      };
}
