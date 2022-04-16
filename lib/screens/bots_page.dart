import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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

    RefreshController _refreshController =
        RefreshController(initialRefresh: false);

    if (positions.isLoading) return LoadingStrategies();

    return ChangeNotifierProvider(
      create: (_) => new NavigationModel(),
      child: Scaffold(
          body: SmartRefresher(
        controller: _refreshController,
        child: _listViewOperations(positions),
        enablePullDown: true,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Colors.blue.shade400,
        ),
        onRefresh: () {
          positions.readv2();
          _refreshController.refreshCompleted();
        },
      )),
    );
  }

  ListView _listViewOperations(PositionServices positions) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(),
        physics: BouncingScrollPhysics(),
        itemCount: positions.positionsList.length,
        itemBuilder: (BuildContext context, int index) => Dismissible(
              key: Key("${positions.positionsList[index]['id']}"),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {
                print('Add options here');
                // return null;
              },
              confirmDismiss: (DismissDirection direction) async {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                          " ⚠️ Close ${positions.positionsList[index]['symbol']} "),
                      content: Text(
                          "Do you sure of close this operation  ${positions.positionsList[index]['symbol']} with one profit of: ${positions.positionsList[index]['profit']}. The current price of the accion is ${positions.positionsList[index]['current_price']} ?"),
                      actions: <Widget>[
                        FlatButton(
                            onPressed: () {

                              Navigator.of(context).pop(true);

                              Provider.of<PositionServices>(context, listen: false)
                                  .close(positions.positionsList[index]['id']);


                            },
                            child: const Text("CLOSE TRADE")),
                        FlatButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("CANCEL"),
                        ),
                      ],
                    );
                  },
                );
              },
              background: Container(
                color: Color.fromARGB(255, 0, 97, 176),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Icon(Icons.sell_rounded),
                    const SizedBox(width: 10),
                    Text('Close Trade Manual',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              child: OpenPositionsWidgets(
                symbolUrl: positions.positionsList[index]['symbolUrl'],
                is_paper_trading: positions.positionsList[index]
                    ['is_paper_trading'],
                order: positions.positionsList[index]['order'],
                operation: positions.positionsList[index]['operation'],
                qty_open: positions.positionsList[index]['qty_open'],
                priceOpen: positions.positionsList[index]['price_open'],
                price_closed: positions.positionsList[index]['price_closed'],
                base_cost: positions.positionsList[index]['base_cost'],
                profit: positions.positionsList[index]['profit'],
                profitPercentage: positions.positionsList[index]
                    ['profit_percentage'],
                isClosed: positions.positionsList[index]['isClosed'],
                stop_loss: positions.positionsList[index]['stop_loss'],
                take_profit: positions.positionsList[index]['take_profit'],
                is_winner: positions.positionsList[index]['is_winner'],
                number_stock: positions.positionsList[index]['number_stock'],
                broker: positions.positionsList[index]['broker'],
                symbol: positions.positionsList[index]['symbol'],
                currentPrice: positions.positionsList[index]['current_price'],
                price: positions.positionsList[index]['price'],
                isClose: positions.positionsList[index]['isClose'],
                symbolName: positions.positionsList[index]['symbol'],
                brokerName: positions.positionsList[index]['brokerName'],
              ),
            ));
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
    required this.profitPercentage,
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
    required this.brokerName,
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
  final double profitPercentage;
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
  final String brokerName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(children: [
        Row(
          children: [
            CircleImage(
              size: 50,
              urlImage: symbolUrl,
            ),
            const SizedBox(width: 5),

            // SECOND CLUMN
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: broker == 'paperTrade'
                                ? AssetImage(
                                    'assets/ReduceBrokerTacticTradeIcon.png')
                                : AssetImage('assets/AlpacaMiniLogo.png'),
                            fit: BoxFit.fill),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(symbolName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
                Text('Trade $operation',
                    style: TextStyle(
                        color: operation == 'long'
                            ? Colors.blue
                            : Colors.amber.shade500,
                        fontSize: 14,
                        fontWeight: FontWeight.w300)),
                Text('$brokerName',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w300)),
              ],
            ),

            const SizedBox(width: 20),
            Expanded(child: Container()),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text('Invest ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w300)),
                    Text('USD',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
                Text('$base_cost',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w500)),
                Text('$currentPrice',
                    style: TextStyle(
                        color: operation == 'long' ? currentPrice - priceOpen < 0
                            ? Colors.red
                            : Colors.green : currentPrice - priceOpen < 0
                            ? Colors.green
                            : Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w300)),
              ],
            ),

            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('$profit',
                        style: TextStyle(
                            color: profit < 0 ? Colors.red : Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                    // Text('USD',
                    //     style: TextStyle(
                    //         color: profit < 0 ? Colors.red : Colors.green,
                    //         fontSize: 12,
                    //         fontWeight: FontWeight.w300)),
                  ],
                ),
                Row(
                  children: [
                    Text('$profitPercentage',
                        style: TextStyle(
                            color: profit < 0 ? Colors.red : Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                    Text('%',
                        style: TextStyle(
                            color: profit < 0 ? Colors.red : Colors.green,
                            fontSize: 12,
                            fontWeight: FontWeight.w300)),
                  ],
                ),
              ],
            ),

            const SizedBox(width: 20),
          ],
        ),

        //  Divider(
        //     height: 1,
        //     color: Colors.grey,
        //   ),
      ]),
    );
  }
}
