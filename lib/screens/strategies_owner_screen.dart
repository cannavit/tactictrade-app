import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../widgets/dinamicCard/strategy_card_widget.dart';
import 'navigation_screen.dart';

class StrategiesOwnerScreen extends StatelessWidget {
  const StrategiesOwnerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) => StrategyCard(
        initialCapitalLogn: 120,
        initialCapitalShort: 110,
        currentCapitalLogn: 110,
        currentCapitalShort: 120,
        percentageProfitLong: -1.2,
        percentageProfitShort: 2,
        urlPusher: "https://s3.tradingview.com/userpics/6171439-Hlns_big.png",
        strategyName: "StrategyArgon2",
        pusherName: "TradingView",
        brokerName: "Alpaca",
        brokerUrl: "https://res.cloudinary.com/apideck/icons/alpaca-markets",
        closedTradeLong: "11",
        closedTradeShort: "2",
        timeTrade: "1h",
        symbol: "TSLA",
        symbolUrl: "https://universal.hellopublic.com/companyLogos/TSLA@2x.png",
      ),
    )
    );
  }
}
