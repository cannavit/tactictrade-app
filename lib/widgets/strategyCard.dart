import 'dart:math';

import 'package:expandable_text/expandable_text.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/share_preferences/preferences.dart';
import 'package:tactictrade/widgets/popUpTradeDataStrategy.dart';

import '../pages/broker/service/broker_service.dart';
import '../screens/createFollowerTrade.dart';
import '../services/strategies_services.dart';

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
      required this.isFollower})
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

            Container(
              height: 70,
              child: _headCardWidget(
                mantainerName: mantainerName,
                urlUser: urlUser,
              ),
            ),

            const Divider(height: 10, color: Color(0xff797979)),

            _labelTwoStockAndPusher(
              isActive: isActive,
              isVerify: isVerify,
              strategyName: strategyName,
              urlSymbol: urlSymbol,
              timeTrade: timeTrade,
              urlPusher: urlPusher,
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
            const Divider(height: 10, color: Color(0xff797979)),

            _statisticsValues(
              profitable: profitable,
              maxDrawdown: maxDrawdown,
              netProfit: netProfit,
            ),

            // Add Image

            const SizedBox(width: 10),

            // _graph2d(data: historicalData),

            // ,

            _likeIcons(
                isOwner: isOwner,
                isFollower: isFollower,
                isFavorite: isFavorite,
                isStarred: isStarred,
                likesNumber: likesNumber,
                strategyId: idStrategy)
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

class _likeIcons extends StatelessWidget {
  const _likeIcons({
    Key? key,
    required this.isStarred,
    required this.isFavorite,
    required this.likesNumber,
    required this.strategyId,
    required this.isOwner,
    required this.isFollower,
  }) : super(key: key);

  final bool isStarred;
  final bool isFavorite;
  final int likesNumber;
  final int strategyId;
  final bool isOwner;
  final bool isFollower;

  @override
  Widget build(BuildContext context) {
    final strategySocial = Provider.of<StrategySocial>(context);
    final brokerServices = Provider.of<BrokerServices>(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              FavoriteButton(
                iconSize: 40,
                isFavorite: isFavorite,
                valueChanged: (_isFavorite) {
                  print('Is Favorite $_isFavorite)');

                  strategySocial.put(strategyId, {"likes": _isFavorite});

                  // if (_isFavorite) {
                  //   likesNumber = likesNumber + 1;
                  // }

                  // if (_isFavorite == false) {
                  //   likesNumber = likesNumber + 1;
                  // }
                },
              ),
              Text('$likesNumber',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w300)),
            ],
          ),
          Column(
            children: [
              StarButton(
                iconColor: Colors.yellow.shade900,
                iconSize: 40,
                isStarred: isStarred,
                valueChanged: (_isFavorite) {
                  print('Is Favorite $_isFavorite)');
                  strategySocial.put(strategyId, {"favorite": _isFavorite});
                },
              ),
              const Text('Favorite',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w300)),
            ],
          ),
          Column(
            children: const [
              Icon(Icons.share),
              Text('Share',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w300)),
            ],
          ),
          _FollowButton(
              isFollower: isFollower,
              brokerServices: brokerServices,
              strategyId: strategyId),
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
  }) : super(key: key);

  final bool isFollower;
  final BrokerServices brokerServices;
  final int strategyId;

  @override
  Widget build(BuildContext context) {
    return Column(
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

            Navigator.pushReplacementNamed(context, 'create_follow_trade');
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

class _labelTwoStockAndPusher extends StatelessWidget {
  //
  const _labelTwoStockAndPusher({
    Key? key,
    required this.urlSymbol,
    required this.urlPusher,
    required this.timeTrade,
    required this.strategyName,
    required this.isActive,
    required this.isVerify,
  }) : super(key: key);

  final String urlSymbol;
  final String urlPusher;
  final String timeTrade;
  final String strategyName;
  final bool isActive;
  final bool isVerify;

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
                  Icon(Icons.timer_rounded, color: Colors.white70, size: 14)
                ],
              ),
            ],
          ),

          Expanded(child: Container()),

          Row(
            children: [
              Icon(
                  isActive
                      ? Icons.check_circle
                      : Icons.check_circle_outline_outlined,
                  color: Color(0xff08BEFB)),
              Icon(
                  isVerify
                      ? Icons.check_circle
                      : Icons.check_circle_outline_outlined,
                  color: Color(0xff08BEFB)),
            ],
          ),

          const SizedBox(width: 5),
        ],
      ),
    );
  }
}

class _headCardWidget extends StatelessWidget {
  const _headCardWidget({
    Key? key,
    required this.urlUser,
    required this.mantainerName,
  }) : super(key: key);

  final String urlUser;
  final String mantainerName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleImage(urlImage: urlUser, radius: 50, size: 50),
        _mantainerName(mantainerName: mantainerName, followers: 200),
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
              const SizedBox(width: 10),
              FavoriteButton(
                iconSize: 40,
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
  const _cardTextPorcentaje({
    Key? key,
    required this.variable,
    required this.value,
    this.forceColor = null,
  }) : super(key: key);

  final String variable;
  final double value;
  final Color? forceColor;

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

  const _mantainerName({
    Key? key,
    required this.mantainerName,
    required this.followers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Mantainer',
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
        backgroundImage: NetworkImage(urlImage),
      ),

      // decoration:
    );
  }
}
