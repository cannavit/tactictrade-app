import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tactictrade/share_preferences/preferences.dart';
import '../providers/strtegy_categories_filter_provider.dart';
import '../services/trading_config.dart';
import '../widgets/carousel_list_home.dart';
import '../widgets/dinamicCard/strategy_card_widget.dart';
import 'loading_strategy.dart';
import 'navigation_screen.dart';

class StrategiesOwnerScreen extends StatelessWidget {
  const StrategiesOwnerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tradingConfig = Provider.of<TradingConfig>(context, listen: true);
    final filterList =
        Provider.of<FiltersStrategiesSelected>(context, listen: true);

    if (tradingConfig.isLoading) return LoadingStrategies();

    RefreshController _refreshController =
        RefreshController(initialRefresh: false);

    return ChangeNotifierProvider(
      create: (_) => new NavigationModel(),
      child: Scaffold(
          body: Column(
        children: [
          Container(
            height: 30,
            width: double.infinity,
            child: CarouselListHome(
                categoriesList: filterList, pageCarausel: 'ownerStrategies'),
          ),
          Expanded(
            child: SmartRefresher(
              controller: _refreshController,
              child: _ListViewStrategies(tradingConfig),
              enablePullDown: true,
              header: WaterDropHeader(
                complete: Icon(Icons.check, color: Colors.blue[400]),
                waterDropColor: Colors.blue.shade400,
              ),
              onRefresh: () {
                Preferences.updateStrategyOwnerSelected = true;
                tradingConfig.readv2();

                _refreshController.refreshCompleted();
              },
            ),
          ),
        ],
      )),
    );
  }

  ListView _ListViewStrategies(TradingConfig tradingConfig) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => Divider(),
      physics: BouncingScrollPhysics(),
      itemCount: tradingConfig.tradingConfigList.length,
      itemBuilder: (BuildContext context, int index) => StrategyCard(
        totalOfTrades: tradingConfig.tradingConfigList[index].totalOfTrades,
        totalProfitUSD: tradingConfig.tradingConfigList[index].totalProfitUsd,
        totalTradingProfit:
            tradingConfig.tradingConfigList[index].totalTradingProfit,
        totalNumberOfWinTrades:
            tradingConfig.tradingConfigList[index].totalNumberOfWinTrades,
        tradingConfigId: tradingConfig.tradingConfigList[index].id,
        initialCapitalLong:
            tradingConfig.tradingConfigList[index].initialCapitalUsdLong,
        initialCapitalShort:
            tradingConfig.tradingConfigList[index].initialCapitalUsdShort,
        currentCapitalLong:
            tradingConfig.tradingConfigList[index].quantityUsdLong,
        currentCapitalShort:
            tradingConfig.tradingConfigList[index].quantityUsdShort,
        percentageProfitLong:
            tradingConfig.tradingConfigList[index].profitPorcentageLong,
        percentageProfitShort:
            tradingConfig.tradingConfigList[index].profitPorcentageShort,
        urlPusher: tradingConfig.tradingConfigList[index].strategyNewsPusher
            .toString(),
        strategyName:
            tradingConfig.tradingConfigList[index].strategyNewsName.toString(),
        pusherName: "TradingView",
        brokerName: tradingConfig.tradingConfigList[index].brokerBrokerName,
        brokerType: tradingConfig.tradingConfigList[index].brokerName,
        brokerUrl:
            tradingConfig.tradingConfigList[index].brokerName == "Papertrade"
                ? "assets/ReduceBrokerTacticTradeIcon.png"
                : "assets/AlpacaMiniLogo.png",
        closedTradeLong:
            tradingConfig.tradingConfigList[index].closedTradeLong.toString(),
        closedTradeShort:
            tradingConfig.tradingConfigList[index].closedTradeShort.toString(),
        timeTrade: tradingConfig.tradingConfigList[index].symbolTime,
        symbol: tradingConfig.tradingConfigList[index].symbolName,
        symbolUrl: tradingConfig.tradingConfigList[index].symbolUrl,
        isActiveTradeLong: tradingConfig.tradingConfigList[index].isActiveLong,
        isActiveTradeShort:
            tradingConfig.tradingConfigList[index].isActiveShort,
      ),
    );
  }
}
