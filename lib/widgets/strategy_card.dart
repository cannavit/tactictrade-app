import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/models/strategy_models.dart';
import 'package:tactictrade/share_preferences/preferences.dart';
import 'package:tactictrade/widgets/statistics_values_widgets.dart';

import '../services/broker_service.dart';
import '../screens/transactions_records_screen.dart';
import '../services/strategies_services.dart';
import '../services/transactions_record_service.dart';
import 'follow_button_widget.dart';
import 'icons_social_favorite_likes.dart';
import 'mantainer_data_widget.dart';
import 'strategy_symbol_widget.dart';
import 'text_expandable_widget.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {Key? key,
      required this.historicalData,
      this.titleLevelOne = 'Mantainer',
      required this.strategyData})
      : super(key: key);

  final dynamic historicalData;
  final String titleLevelOne;
  final Strategy strategyData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        width: double.infinity,
        // height: 430,
        decoration: _cardBorder(),
        child: Column(
          children: [
            // Header Cards ........
            const SizedBox(height: 10),

            MantainerDataWidget(
                mantainerName: strategyData.owner.username,
                urlUser: strategyData.owner.profileImage,
                titleLevelOne: titleLevelOne),

            const Divider(height: 10, color: Color(0xff797979)),

            StrategySymbolWidget(
              isActive: strategyData.isActive,
              isVerify: strategyData.isVerified,
              strategyName: strategyData.strategyNews,
              urlSymbol: strategyData.symbolUrl,
              timeTrade: strategyData.timeTrade,
              urlPusher: strategyData.pusher,
              symbolName: strategyData.symbolName,
            ),

            // Add Description
            TextExpandableWidget(descriptionText: strategyData.description),

            const SizedBox(height: 5),

            // Image Strategy
            Stack(
              children: [
                Visibility(
                  visible: strategyData.postImage == "" ? false : true,
                  maintainSize: false,
                  child: Container(
                    child: strategyData.postImage == null
                        ? null
                        : FadeInImage(
                            placeholder: Preferences.isDarkmode
                                ? const AssetImage('assets/giphy.gif')
                                : const AssetImage(
                                    'assets/giphyDarkLoading.gif'),
                            image: NetworkImage(strategyData.postImage!)),
                  ),
                ),
                IconsSocialFavoriteLike(
                    isFavorite: strategyData.isLiked,
                    idStrategy: strategyData.id,
                    likesNumber: strategyData.likesNumber,
                    isStarred: strategyData.isFavorite),
              ],
            ),

            const Divider(height: 10, color: Color(0xff797979)),

            StatisticsValuesWidgets(
              profitable: strategyData.percentageProfitable,
              maxDrawdown: strategyData.maxDrawdown,
              netProfit: strategyData.netProfit,
            ),

            _likeIcons(
              strategyData: strategyData,
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorder() => BoxDecoration(
          color: const Color(0xff181B25),
          borderRadius: BorderRadius.circular(0),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 0), blurRadius: 10)
          ]);
}

class _likeIcons extends StatelessWidget {
  const _likeIcons(
      {Key? key, this.titleLevelOne = 'Mantainer', required this.strategyData})
      : super(key: key);

  final String titleLevelOne;
  final Strategy strategyData;

  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    final strategySocial = Provider.of<StrategySocial>(context);
    final brokerServices = Provider.of<BrokerServices>(context);
    final transactionServiceData =
        Provider.of<TransactionRecordsServices>(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              // Icon(Icons.history),
              IconButton(
                splashColor: Colors.amber,
                icon: const Icon(Icons.history),
                onPressed: () {
                  const isPrivateRecord = false;

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TransactionPageScreen(
                                controllerCandleDefault:
                                    strategyData.controllerCandleDefault,
                                controllerCandleGraph:
                                    strategyData.controllerCandleGraph,
                                isPrivateRecord: false,
                                strategyId: strategyData.id,
                                urlSymbol: strategyData.symbolUrl,
                                isActive: strategyData.isActive,
                                isVerify: strategyData.isVerified,
                                strategyName: strategyData.strategyNews,
                                symbolName: strategyData.symbolName,
                                timeTrade: strategyData.timeTrade,
                                urlPusher: strategyData.pusher,
                                mantainerName: strategyData.owner.username,
                                urlUser: strategyData.owner.profileImage,
                                titleLevelOne: titleLevelOne,
                                recordsProvider: transactionServiceData,
                                isPrivate: false,
                              )));
                },
              ),

              const Text('History',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w300)),
            ],
          ),
          FollowButtonWidget(
              isFollower: strategyData.isFollower,
              brokerServices: brokerServices,
              strategyId: strategyData.id,
              mantainerName: strategyData.owner.username,
              titleLevelOne: titleLevelOne,
              isActive: strategyData.isActive,
              isVerify: strategyData.isVerified,
              strategyName: strategyData.strategyNews,
              symbolName: strategyData.symbolName,
              timeTrade: strategyData.timeTrade,
              urlPusher: strategyData.pusher,
              urlSymbol: strategyData.symbolUrl),
        ],
      ),
    );
  }
}
