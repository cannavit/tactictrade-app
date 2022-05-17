import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/broker/service/broker_service.dart';
import '../providers/trading_config_short_provider.dart';
import '../services/trading_config_view.dart';
import '../share_preferences/preferences.dart';


class FollowButtonWidget extends StatelessWidget {
  const FollowButtonWidget({
    Key? key,
    required this.isFollower,
    required this.brokerServices,
    required this.strategyId,
    // required this.urlUser,
    required this.titleLevelOne,
    required this.mantainerName,
    required this.urlSymbol,
    required this.urlPusher,
    required this.timeTrade,
    required this.strategyName,
    required this.isActive,
    required this.isVerify,
    required this.symbolName,
  }) : super(key: key);

  final bool isFollower;
  final BrokerServices brokerServices;
  final int strategyId;

  // final String urlUser;
  final String titleLevelOne;
  final String mantainerName;

  final String urlSymbol;
  final String urlPusher;
  final String timeTrade;
  final String strategyName;
  final bool isActive;
  final bool isVerify;
  final String symbolName;

  @override
  Widget build(BuildContext context) {
    
    final tradingConfigViewService =
        Provider.of<TradingConfigViewService>(context);

    final configTradeProvider = Provider.of<TradingConfigProvider>(context);

    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    return Row(
      children: [
        IconButton(
          splashColor: Colors.amber,
          icon: Icon(
            isFollower ? Icons.play_arrow_rounded : Icons.stop_outlined,
            color: isFollower ? Colors.blue : Colors.white,
          ),
          onPressed: () async {
            final dataBroker = await brokerServices.loadBroker();

            Preferences.newFollowStrategyId = strategyId;
            Preferences.brokerNewUseTradingLong = false;
            Preferences.brokerNewUseTradingShort = false;
            Preferences.selectedBrokerInFollowStrategy = "{}";

            Preferences.navigationCurrentPage = 0;
            Preferences.tempStrategyImage = "";
            Preferences.selectedBrokerInFollowStrategy = "{}";

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("  Connect/Follower Strategy"),
                  content:
                      Text("Do you want use this strategy for doing trade?"),
                  actions: <Widget>[
                    FlatButton(
                        color: Colors.green,
                        onPressed: () {
                          // Reset las configuration open
                          configTradeProvider.reset();

                          tradingConfigViewService.read("", strategyId);

                          Navigator.pushReplacementNamed(
                              context, 'create_follow_trade',
                              arguments: {
                                "urlSymbol": urlSymbol,
                                "urlPusher": urlPusher,
                                "timeTrade": timeTrade,
                                "strategyName": strategyName,
                                "isActive": isActive,
                                "isVerify": isVerify,
                                "symbolName": symbolName,
                              });

                          tradingConfigViewService.strategyIdSelected =
                              strategyId;
                        },
                        child: const Text("USE FOR TRADE")),
                    // const SizedBox(width:30 ),
                    FlatButton(
                      color: Colors.red,
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("CANCEL"),
                    ),
                  ],
                );
              },
            );
          },
        ),
        // Icon(Icons.play_arrow_rounded),

        Text(isFollower ? 'Followed' : 'Follow',
            style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w300)),


      ],
    );
  }
}
