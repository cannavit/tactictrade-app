import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        margin: EdgeInsets.only(top: 20),
        width: double.infinity,
        height: 230,
        decoration: _cardBorder(),
        child: Column(
          children: [
            // Header Cards ........

            Container(
              height: 70,
              child: const _headCardWidget(
                timeTrade: '1h',
                urlPusher:
                    'https://s3.tradingview.com/userpics/6171439-Hlns_big.png',
                urlUser:
                    'https://www.shareicon.net/data/512x512/2016/09/15/829452_user_512x512.png',
                urlSymbol: 'https://universal.hellopublic.com/companyLogos/' +
                    'FB' +
                    '@2x.png',
              ),
            ),

            Row(
              children: [
                Expanded(
                    child: Container(
                        height: 150,
                        child: Column(
                          children: [
                            Expanded(
                                child: Container(
                              height: 130,
                              // color: Colors.orange,
                              child: _StrategyStatistics(),
                            )),
                            Container(
                              height: 40,
                              child: GroupLikeButtons(
                                numberLikes: '200',
                              ),
                            ),
                          ],
                        ))),
                Expanded(
                    child: Container(
                  height: 150,
                  child: _graph2D(
                    data: [
                      2.2,
                      4.4,
                      -1.5,
                      2.0,
                      10.0,
                      -2.0,
                      -0.5,
                      2.3,
                      4.5,
                      5.0
                    ],
                  ),
                )),
              ],
            )

            // ,
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
          const SizedBox(height: 8),
          _cardTextPorcentaje(
            variable: 'Max Drawdown: ',
            value: 5.42,
            forceColor: Colors.red,
          ),
          const SizedBox(height: 8),
          _cardTextPorcentaje(
            variable: 'Net Profit: ',
            value: 61.29,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  BoxDecoration _cardBorder() => BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 7), blurRadius: 10)
          ]);
}

class _headCardWidget extends StatelessWidget {
  const _headCardWidget({
    Key? key,
    required this.urlSymbol,
    required this.urlUser,
    required this.urlPusher,
    required this.timeTrade,
  }) : super(key: key);

  final String urlSymbol;
  final String urlUser;
  final String urlPusher;
  final String timeTrade;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleImage(
          urlImage: urlSymbol,
        ),
        const _strategyName(strategyName: 'Argon2020'),
        Expanded(child: Container()),
        Container(
          margin: EdgeInsets.all(10),
          child: Row(
            children: [
              Text(timeTrade,
                  style: const TextStyle(
                      color: Colors.white70, //TODO add dynamic color
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
              CircleImage(
                size: 40,
                urlImage: urlUser,
              ),
              CircleImage(
                size: 40,
                urlImage: urlPusher,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GroupLikeButtons extends StatelessWidget {
  final String numberLikes;

  const GroupLikeButtons({
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
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500))
            ],
          )),
          StarButton(
            iconSize: 40,
            valueChanged: (_isFavorite) {
              print('Is Favorite $_isFavorite)');
            },
          ),
          Expanded(child: Container()),
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

class _graph2D extends StatelessWidget {
  const _graph2D({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<double> data;
  //  data = [2.2, 4.4, -1.5, 2.0, 10.0, -2.0, -0.5, 2.3, 4.5, 5.0];

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            width: 100,
            height: 80,
            // color: Colors.black87,
            child: Sparkline(
                data: data,
                useCubicSmoothing: true,
                cubicSmoothingFactor: 0.1,
                enableGridLines: true,
                fillMode: FillMode.below,
                fillGradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade100, Colors.transparent],
                ))));
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
    return Row(
      children: [
        Text(
          variable,
          style: TextStyle(
              color: Preferences.isDarkmode ? Colors.black87 : Colors.white,
              fontSize: 14,
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
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class _strategyName extends StatelessWidget {
  final String strategyName;

  const _strategyName({
    Key? key,
    required this.strategyName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Strategy name',
              style: TextStyle(
                  color:
                      Preferences.isDarkmode ? Colors.black45 : Colors.white60,
                  fontSize: 15,
                  fontWeight: FontWeight.w300)),
          Text(strategyName,
              style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 20,
                  fontWeight: FontWeight.w700)),
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
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.all(3),

      width: size,
      height: size,

      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(radius)),

      child: CircleAvatar(
        backgroundImage: NetworkImage(urlImage),
      ),

      // decoration:
    );
  }
}
