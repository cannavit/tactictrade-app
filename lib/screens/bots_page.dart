import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/screens/position_screens.dart';

import '../services/positions_service.dart';
import '../widgets/strategyCard.dart';
import 'loading_strategy.dart';
import 'navigation_screen.dart';

class BotsScreen extends StatelessWidget {
  const BotsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final positions = Provider.of<PositionServices>(context);
    // final themeColors = Theme.of(context);

    if (positions.isLoading) return LoadingStrategies();

    return ChangeNotifierProvider(
      create: (_) => new NavigationModel(),
      child: Scaffold(
          body: ListView.builder(
              itemCount: positions.positionsList.length,
              itemBuilder: (BuildContext context, int index) =>
                  OpenPositionsWidgets(
                    symbolUrl: positions.positionsList[index]['symbolUrl'],
                    is_paper_trading: positions.positionsList[index]
                        ['is_paper_trading'],
                    order: positions.positionsList[index]['order'],
                    operation: positions.positionsList[index]['operation'],
                    qty_open: positions.positionsList[index]['qty_open'],
                    priceOpen: positions.positionsList[index]['price_open'],
                    price_closed: positions.positionsList[index]
                        ['price_closed'],
                    base_cost: positions.positionsList[index]['base_cost'],
                    profit: positions.positionsList[index]['profit'],
                    profit_percentage: positions.positionsList[index]
                        ['profit_percentage'],
                    isClosed: positions.positionsList[index]['isClosed'],
                    stop_loss: positions.positionsList[index]['stop_loss'],
                    take_profit: positions.positionsList[index]['take_profit'],
                    is_winner: positions.positionsList[index]['is_winner'],
                    number_stock: positions.positionsList[index]
                        ['number_stock'],
                    broker: positions.positionsList[index]['broker'],
                    symbol: positions.positionsList[index]['symbol'],
                    currentPrice: positions.positionsList[index]
                        ['current_price'],
                    price: positions.positionsList[index]['price'],
                    isClose: positions.positionsList[index]['isClose'],
                    symbolName: positions.positionsList[index]['symbol'],
                  ))),
    );
  }
}

class OpenPositionsWidgets extends StatelessWidget {
  const OpenPositionsWidgets({
    Key? key,
    required this.symbolUrl,
    required this.symbolName,
    required this.is_paper_trading,
    required this.order,
    required this.operation,
    required this.qty_open,
    required this.priceOpen,
    required this.price_closed,
    required this.base_cost,
    required this.profit,
    required this.profit_percentage,
    required this.isClosed,
    required this.stop_loss,
    required this.take_profit,
    required this.is_winner,
    required this.number_stock,
    required this.broker,
    required this.symbol,
    required this.currentPrice,
    required this.price,
    required this.isClose,
  }) : super(key: key);

  final String symbolUrl;
  final String symbolName;
  final bool is_paper_trading;
  final String order;
  final String operation;
  final double qty_open;
  final double priceOpen;
  final double price_closed;
  final double base_cost;
  final double profit;
  final double profit_percentage;
  final bool isClosed;
  final double stop_loss;
  final double take_profit;
  final bool is_winner;
  final double number_stock;
  final String broker;
  final String symbol;
  final double currentPrice;
  final double price;
  final bool isClose;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          CircleImage(
            size: 50,
            urlImage: symbolUrl,
          ),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(symbolName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400)), 

              Text('Trade $operation',
                  style: TextStyle(
                      color: operation == 'long' ? Colors.blue : Colors.amber.shade500,
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),

              Text('$currentPrice / $priceOpen',
                  style: TextStyle(
                      color: currentPrice - priceOpen < 0 ? Colors.red : Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.w300)),

            ],
          ),
          const SizedBox(width: 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

  
              Container(
                child: Text(operation,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300)),
              ),



            ],
          ),

          const SizedBox(width: 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text('Stock',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
  
              Container(
                child: Text(operation,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300)),
              ),



            ],
          ),
        ],
      ),
      const SizedBox(height: 10),
    ]);
  }
}
