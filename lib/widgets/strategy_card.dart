import 'dart:math';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/models/strategy_models.dart';
import 'package:tactictrade/share_preferences/preferences.dart';
import 'package:tactictrade/widgets/statistics_values_widgets.dart';

import '../pages/broker/service/broker_service.dart';
import '../providers/trading_config_short_provider.dart';
import '../screens/transactions_records_screen.dart';
import '../services/strategies_services.dart';
import '../services/trading_config_view.dart';
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
        margin: EdgeInsets.only(top: 20),
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
                                ? AssetImage('assets/giphy.gif')
                                : AssetImage('assets/giphyDarkLoading.gif'),
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
              isOwner: strategyData.isOwner,
              isFollower: strategyData.isFollower,
              strategyId: strategyData.id,
              isActive: strategyData.isActive,
              isVerify: strategyData.isVerified,
              strategyName: strategyData.strategyNews,
              symbolName: strategyData.symbolName,
              timeTrade: strategyData.timeTrade,
              urlPusher: strategyData.pusher,
              urlSymbol: strategyData.symbolUrl,
              mantainerName: strategyData.owner.username,
              urlUser: strategyData.owner.profileImage,
            )
          ],
        ),
      ),
    );
  }


  BoxDecoration _cardBorder() => BoxDecoration(
          color: Color(0xff181B25),
          borderRadius: BorderRadius.circular(0),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 0), blurRadius: 10)
          ]);
}

class _likeIcons extends StatelessWidget {
  const _likeIcons(
      {Key? key,
      // required this.likesNumber,
      required this.strategyId,
      required this.isOwner,
      required this.isFollower,
      required this.urlSymbol,
      required this.urlPusher,
      required this.timeTrade,
      required this.strategyName,
      required this.isActive,
      required this.isVerify,
      required this.symbolName,
      required this.mantainerName,
      required this.urlUser,
      this.titleLevelOne = 'Mantainer'})
      : super(key: key);

  // final int likesNumber;
  final int strategyId;
  final bool isOwner;
  final bool isFollower;

  final String urlSymbol;
  final String urlPusher;
  final String timeTrade;
  final String strategyName;
  final bool isActive;
  final bool isVerify;
  final String symbolName;

  final String mantainerName;
  final String urlUser;
  final String titleLevelOne;

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
                icon: Icon(Icons.history),
                onPressed: () {
                  final isPrivateRecord = false;

                  // transactionServiceData
                  //     .getTransactionRecord(strategyId, {"private": false});

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TransactionPageScreen(
                                isPrivateRecord: false,
                                strategyId: strategyId,
                                urlSymbol: urlSymbol,
                                isActive: isActive,
                                isVerify: isVerify,
                                strategyName: strategyName,
                                symbolName: symbolName,
                                timeTrade: timeTrade,
                                urlPusher: urlPusher,
                                mantainerName: mantainerName,
                                urlUser: urlUser,
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
              isFollower: isFollower,
              brokerServices: brokerServices,
              strategyId: strategyId,
              mantainerName: mantainerName,
              titleLevelOne: titleLevelOne,
              isActive: false,
              isVerify: false,
              strategyName: strategyName,
              symbolName: symbolName,
              timeTrade: timeTrade,
              urlPusher: urlPusher,
              urlSymbol: urlSymbol),
        ],
      ),
    );
  }
}
