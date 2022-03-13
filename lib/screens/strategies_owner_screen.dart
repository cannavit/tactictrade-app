import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/trading_config.dart';
import '../widgets/dinamicCard/strategy_card_widget.dart';
import 'loading_strategy.dart';
import 'navigation_screen.dart';

class StrategiesOwnerScreen extends StatelessWidget {
  const StrategiesOwnerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tradingConfig = Provider.of<TradingConfig>(context, listen: true);

    if (tradingConfig.isLoading) return LoadingStrategies();


    return ChangeNotifierProvider(
      create: (_) => new NavigationModel(),
      child: Scaffold(
          body: ListView.builder(
        itemCount: tradingConfig.tradingConfigList.length,
        itemBuilder: (BuildContext context, int index) => StrategyCard(
          totalProfitUSD: tradingConfig.tradingConfigList[index]['totalProfitUSD'],
          totalTradingProfit: tradingConfig.tradingConfigList[index]['totalTradingProfit'],
          totalNumberOfWinTrades: tradingConfig.tradingConfigList[index]['totalNumberOfWinTrades'],
          tradingConfigId: tradingConfig.tradingConfigList[index]['id'],
          initialCapitalLong: tradingConfig.tradingConfigList[index]
              ['initialCapitalUSDLong'],
          initialCapitalShort: tradingConfig.tradingConfigList[index]
              ['initialCapitalUSDShort'],
          currentCapitalLong: tradingConfig.tradingConfigList[index]
              ['quantityUSDLong'],
          currentCapitalShort: tradingConfig.tradingConfigList[index]
              ['quantityUSDShort'],
          percentageProfitLong: tradingConfig.tradingConfigList[index]
              ['profitPorcentageLong'],
          percentageProfitShort: tradingConfig.tradingConfigList[index]
              ['profitPorcentageShort'],
          urlPusher: tradingConfig.tradingConfigList[index]
                  ['strategyNews_pusher']
              .toString(),
          strategyName: tradingConfig.tradingConfigList[index]
                  ['strategyNews_name']
              .toString(),
          pusherName: "TradingView",
          brokerName: tradingConfig.tradingConfigList[index]
              ['broker_brokerName'],
          brokerType: tradingConfig.tradingConfigList[index]['broker_name'],
          brokerUrl: tradingConfig.tradingConfigList[index]['broker_name'] ==
                  "Papertrade"
              ? "assets/ReduceBrokerTacticTradeIcon.png"
              : "assets/AlpacaMiniLogo.png",
          closedTradeLong: tradingConfig.tradingConfigList[index]
                  ['closedTradeLong']
              .toString(),
          closedTradeShort: tradingConfig.tradingConfigList[index]
                  ['closedTradeShort']
              .toString(),
          timeTrade: tradingConfig.tradingConfigList[index]['symbol_time'],
          symbol: tradingConfig.tradingConfigList[index]['symbol_name'],
          symbolUrl: tradingConfig.tradingConfigList[index]['symbol_url'],
        ),
      )),
    );
  }
}
