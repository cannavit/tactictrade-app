import 'dart:math';

import 'package:expandable_text/expandable_text.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/share_preferences/preferences.dart';
import 'package:tactictrade/widgets/popUpTradeDataStrategy.dart';

import '../pages/broker/service/broker_service.dart';
import '../providers/trading_config_short_provider.dart';
import '../screens/createFollowerTrade.dart';
import '../screens/transactions_records_screen.dart';
import '../services/strategies_services.dart';
import '../services/trading_config_view.dart';
import '../services/transactions_record_service.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {Key? key,
      required this.urlUser,
      required this.strategyName,
      required this.urlSymbol,
      required this.timeTrade,
      required this.mantainerName,
      required this.urlPusher,
      this.descriptionText = '',
      this.isActive = false,
      this.isVerify = false,
      this.imageNetwork = null,
      required this.historicalData,
      required this.profitable,
      required this.maxDrawdown,
      required this.netProfit,
      required this.isStarred,
      required this.isFavorite,
      required this.likesNumber,
      required this.idStrategy,
      required this.isOwner,
      required this.isFollower,
      required this.symbolName,
      this.titleLevelOne = 'Mantainer'})
      : super(key: key);

  final String urlUser;
  final String strategyName;
  final String urlSymbol;
  final String timeTrade;
  final String mantainerName;
  final String urlPusher;
  final String descriptionText;
  final bool isActive;
  final bool isVerify;
  final String? imageNetwork;
  final dynamic historicalData;
  final double profitable;
  final double maxDrawdown;
  final double netProfit;

  final bool isStarred;
  final bool isFavorite;
  final int likesNumber;
  final int idStrategy;
  final bool isOwner;
  final bool isFollower;
  final String symbolName;
  final String titleLevelOne;

  @override
  Widget build(BuildContext context) {
    final strategySocial = Provider.of<StrategySocial>(context);

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

            MantainerCardStrategyWidget(
                mantainerName: mantainerName,
                urlUser: urlUser,
                titleLevelOne: titleLevelOne),

            const Divider(height: 10, color: Color(0xff797979)),

            labelTwoStockAndPusher(
              isActive: isActive,
              isVerify: isVerify,
              strategyName: strategyName,
              urlSymbol: urlSymbol,
              timeTrade: timeTrade,
              urlPusher: urlPusher,
              symbolName: symbolName,
            ),

            // Add Description
            Container(
              margin: const EdgeInsets.all(10),
              child: ExpandableText(
                descriptionText,
                expandText: 'show more',
                collapseText: 'show less',
                maxLines: 2,
                linkColor: Colors.blue,
              ),
            ),

            const SizedBox(height: 5),

            // Image Strategy
            Stack(
              children: [
                Visibility(
                  visible: imageNetwork == "" ? false : true,
                  maintainSize: false,
                  child: Container(
                    child: imageNetwork == null
                        ? null
                        : FadeInImage(
                            placeholder: Preferences.isDarkmode
                                ? AssetImage('assets/giphy.gif')
                                : AssetImage('assets/giphyDarkLoading.gif'),
                            image: NetworkImage(imageNetwork!)),
                  ),
                ),
                _IconsFavoriteLinke(
                    isFavorite: isFavorite,
                    strategySocial: strategySocial,
                    idStrategy: idStrategy,
                    likesNumber: likesNumber,
                    isStarred: isStarred),
              ],
            ),

            const Divider(height: 10, color: Color(0xff797979)),

            _statisticsValues(
              profitable: profitable,
              maxDrawdown: maxDrawdown,
              netProfit: netProfit,
            ),

            _likeIcons(
                isOwner: isOwner,
                isFollower: isFollower,
                isFavorite: isFavorite,
                isStarred: isStarred,
                likesNumber: likesNumber,
                strategyId: idStrategy,
                isActive: isActive,
                isVerify: isVerify,
                strategyName: strategyName,
                symbolName: symbolName,
                timeTrade: timeTrade,
                urlPusher: urlPusher,
                urlSymbol: urlSymbol,
                mantainerName: mantainerName,
                urlUser: urlUser)
          ],
        ),
      ),
    );
  }

  Container _StrategyStatistics() {
    return Container(
      margin: EdgeInsets.only(left: 20),
      width: 180,
      height: 100,
      child: Column(
        children: const [
          _cardTextPorcentaje(
            variable: 'Profitable: ',
            value: 39.5,
          ),
          SizedBox(height: 8),
          _cardTextPorcentaje(
            variable: 'Max Drawdown: ',
            value: 5.42,
            forceColor: Colors.red,
          ),
          SizedBox(height: 8),
          _cardTextPorcentaje(
            variable: 'Net Profit: ',
            value: 61.29,
          ),
          SizedBox(height: 8),
        ],
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

class _IconsFavoriteLinke extends StatefulWidget {
  const _IconsFavoriteLinke({
    Key? key,
    required this.isFavorite,
    required this.strategySocial,
    required this.idStrategy,
    required this.likesNumber,
    required this.isStarred,
  }) : super(key: key);

  final bool isFavorite;
  final StrategySocial strategySocial;
  final int idStrategy;
  final int likesNumber;
  final bool isStarred;

  @override
  State<_IconsFavoriteLinke> createState() => _IconsFavoriteLinkeState();
}

class _IconsFavoriteLinkeState extends State<_IconsFavoriteLinke> {
  @override
  Widget build(BuildContext context) {
    final strategySocial = Provider.of<StrategySocial>(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          // Like Icon

        Container(
            // Star Favorite
            child: Row(
              children: [
                StarButton(
                  iconColor: Colors.yellow.shade900,
                  iconDisabledColor: Color.fromARGB(161, 178, 178, 178),
                  iconSize: 40,
                  isStarred: widget.isStarred,
                  valueChanged: (_isFavorite) {
                    Preferences.updateTheStrategies = true;
                    print('Is Favorite $_isFavorite)');
                    widget.strategySocial
                        .put(widget.idStrategy, {"favorite": _isFavorite});
                  },
                ),
              ],
            ),
          ),

              const SizedBox(width: 10),


          Row(
            children: [

              FavoriteButton(
                iconSize: 30,
                isFavorite: widget.isFavorite,
                iconDisabledColor: Color.fromARGB(161, 178, 178, 178),

                valueChanged: (_isFavorite) {
                  print('Is Favorite $_isFavorite)');

                  Preferences.updateTheStrategies = true;

                  widget.strategySocial
                      .put(widget.idStrategy, {"likes": _isFavorite});

                  setState(() {});
                },
              ),

              const SizedBox(width: 10),

              Text('${widget.likesNumber}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w300)),
            ],
          ),

          Expanded(child: Container()),

    
        ],
      ),
    );
  }
}

class MantainerCardStrategyWidget extends StatelessWidget {
  const MantainerCardStrategyWidget(
      {Key? key,
      required this.mantainerName,
      required this.urlUser,
      this.titleLevelOne = 'Mantainer'})
      : super(key: key);

  final String mantainerName;
  final String urlUser;
  final String titleLevelOne;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: _headCardWidget(
        mantainerName: mantainerName,
        urlUser: urlUser,
        titleLevelOne: titleLevelOne,
      ),
    );
  }
}

class _likeIcons extends StatelessWidget {
  const _likeIcons(
      {Key? key,
      required this.isStarred,
      required this.isFavorite,
      required this.likesNumber,
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

  final bool isStarred;
  final bool isFavorite;
  final int likesNumber;
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
          _FollowButton(
              isFollower: isFollower,
              brokerServices: brokerServices,
              strategyId: strategyId,
              mantainerName: mantainerName,
              titleLevelOne: titleLevelOne,
              urlUser: urlUser,
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

class _FollowButton extends StatelessWidget {
  const _FollowButton({
    Key? key,
    required this.isFollower,
    required this.brokerServices,
    required this.strategyId,
    required this.urlUser,
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

  final String urlUser;
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

class _statisticsValues extends StatelessWidget {
  const _statisticsValues({
    Key? key,
    required this.profitable,
    required this.maxDrawdown,
    required this.netProfit,
  }) : super(key: key);

  final double profitable;
  final double maxDrawdown;
  final double netProfit;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Strategy Parameters: ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w300)),
            const SizedBox(height: 5),
            Row(
              children: [
                _cardTextPorcentaje(
                  variable: 'Profitable: ',
                  value: profitable,
                ),
                Expanded(child: Container()),
                _cardTextPorcentaje(
                  variable: 'Max Drawdown: ',
                  value: maxDrawdown,
                  forceColor: Colors.red,
                ),
                Expanded(child: Container()),
                _cardTextPorcentaje(
                  variable: 'Net Profit: ',
                  value: netProfit,
                ),

                // const SizedBox(width: 0 ),
              ],
            )
          ],
        ));
  }
}

class labelTwoStockAndPusher extends StatelessWidget {
  //
  const labelTwoStockAndPusher(
      {Key? key,
      required this.urlSymbol,
      required this.urlPusher,
      required this.timeTrade,
      required this.strategyName,
      required this.isActive,
      required this.isVerify,
      required this.symbolName, 
       this.hideFlags = false})
      : super(key: key);

  final String urlSymbol;
  final String urlPusher;
  final String timeTrade;
  final String strategyName;
  final bool isActive;
  final bool isVerify;
  final String symbolName;
  final bool hideFlags;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleImage(
                size: 40,
                urlImage: urlSymbol,
              ),
              CircleImage(
                size: 40,
                urlImage: urlPusher,
              ),
            ],
          ),

          const SizedBox(width: 5),
          //
          // Description of the Strategy text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Strategy name',
                  style: TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                      fontWeight: FontWeight.w300)),
              Text(strategyName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Text(timeTrade,
                      style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w300)),
                  const SizedBox(width: 5),
                  Icon(Icons.timer_rounded, color: Colors.white70, size: 14),
                  const SizedBox(width: 5),
                  Text(symbolName,
                      style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          fontWeight: FontWeight.w300))
                ],
              ),
            ],
          ),

          Expanded(child: Container()),

          Visibility(
            visible: !hideFlags,
            child: Row(
              children: [
                Icon(isActive ? Icons.check : Icons.check,
                    color: Color(0xff08BEFB), size: 18),
                Icon(isVerify ? Icons.check : Icons.check,
                    color: Color(0xff08BEFB), size: 18),
              ],
            ),
          ),

          const SizedBox(width: 5),
        ],
      ),
    );
  }
}

class _headCardWidget extends StatelessWidget {
  const _headCardWidget(
      {Key? key,
      required this.urlUser,
      required this.mantainerName,
      this.titleLevelOne = 'Mantainer'})
      : super(key: key);

  final String urlUser;
  final String mantainerName;
  final String titleLevelOne;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleImage(urlImage: urlUser, radius: 50, size: 50),
        _mantainerName(
            mantainerName: mantainerName,
            followers: 200,
            titleLevelOne: titleLevelOne),
        Expanded(child: Container()),
        const Text('+Follow',
            style: TextStyle(
                color: Color(0xff08BEFB),
                fontSize: 15,
                fontWeight: FontWeight.w300)),
        const SizedBox(width: 20),
      ],
    );
  }
}

class _groupOfLikeButtons extends StatelessWidget {
  final String numberLikes;

  const _groupOfLikeButtons({
    Key? key,
    required this.numberLikes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      // color: Colors.orange,
      child: Row(
        children: [
          Expanded(
              child: Row(
            children: [
              // const SizedBox(width: 10),
              FavoriteButton(
                iconSize: 30,
                valueChanged: (_isFavorite) {
                  print('Is Favorite $_isFavorite)');
                },
              ),
              Text(numberLikes,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500))
            ],
          )),
          StarButton(
            iconSize: 40,
            valueChanged: (_isFavorite) {},
          ),
        ],
      ),
    ));
  }
}

class LikeButton extends StatelessWidget {
  const LikeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _cardTextPorcentaje extends StatelessWidget {
  const _cardTextPorcentaje(
      {Key? key,
      required this.variable,
      required this.value,
      this.forceColor = null,
      this.titleLevelOne = 'Mantainer'})
      : super(key: key);

  final String variable;
  final double value;
  final Color? forceColor;
  final String titleLevelOne;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          variable,
          style: TextStyle(
              color: Preferences.isDarkmode ? Colors.black87 : Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(width: 5),
        Text(
          '${value}%',
          style: TextStyle(
              color: forceColor != null
                  ? forceColor
                  : value <= 0
                      ? Colors.red
                      : Colors.green,
              fontSize: 14,
              fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class _mantainerName extends StatelessWidget {
  final String mantainerName;
  final int followers;
  final String titleLevelOne;

  const _mantainerName(
      {Key? key,
      required this.mantainerName,
      required this.followers,
      this.titleLevelOne = 'Mantainer'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${titleLevelOne}',
              style: TextStyle(
                  color: Preferences.isDarkmode
                      ? Colors.black45
                      : Color(0xffCECECE),
                  fontSize: 13,
                  fontWeight: FontWeight.w300)),
          Text(mantainerName,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 3),
          Text('Followers: ${followers}',
              style: const TextStyle(
                  color: Color(0xff08BEFB),
                  fontSize: 13,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}

class CircleImage extends StatelessWidget {
  final double radius;
  final double size;
  final String urlImage;

  const CircleImage({
    Key? key,
    this.radius = 30.0,
    this.size = 60,
    required this.urlImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.all(1),

      width: size,
      height: size,

      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(radius)),

      child: CircleAvatar(
        backgroundImage: urlImage.startsWith('http')
            ? NetworkImage(urlImage)
            : Image.asset(urlImage).image,
      ),

      // decoration:
    );
  }
}
