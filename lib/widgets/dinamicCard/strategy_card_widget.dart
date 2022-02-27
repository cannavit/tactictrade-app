import 'package:folding_cell/folding_cell.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StrategyCard extends StatelessWidget {
  final _foldingCellKey = GlobalKey<SimpleFoldingCellState>();

  StrategyCard({
    Key? key,
    required this.initialCapitalLogn,
    required this.initialCapitalShort,
    required this.currentCapitalLogn,
    required this.currentCapitalShort,
    required this.percentageProfitLong,
    required this.percentageProfitShort,
    required this.urlPusher,
    required this.strategyName,
    required this.pusherName,
    required this.brokerName,
    required this.brokerUrl,
    required this.closedTradeLong,
    required this.closedTradeShort,
    required this.timeTrade,
    required this.symbol,
    required this.symbolUrl,
  }) : super(key: key);

  final double initialCapitalLogn;
  final double initialCapitalShort;
  final double currentCapitalLogn;
  final double currentCapitalShort;
  final double percentageProfitLong;
  final double percentageProfitShort;

  final String urlPusher;
  final String strategyName;
  final String pusherName;
  final String brokerName;
  final String brokerUrl;
  final String closedTradeLong;
  final String closedTradeShort;

  final String timeTrade;
  final String symbol;
  final String symbolUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.topCenter,
      child: SimpleFoldingCell.create(
        // padding: EdgeInsets.all(1),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        key: _foldingCellKey,
        frontWidget: _buildFrontWidget(),
        innerWidget: _buildInnerWidget(),
        cellSize: Size(MediaQuery.of(context).size.width, 195),
        animationDuration: Duration(milliseconds: 400),
        borderRadius: 10,
        onOpen: () => print('cell opened'),
        onClose: () => print('cell closed'),
      ),
    );
  }

  Widget _buildFrontWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: _BackgroundCardColor(),
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(
            children: [
              PusherStrategyImageText(
                urlPusher: urlPusher,
                strategyName: strategyName,
                pusherName: pusherName,
              ),
              Expanded(child: Container()),
              BrokerImageText(
                brokerName: brokerName,
                brokerUrl: brokerUrl,
              ),
            ],
          ),
          Divider(
            height: 1,
            color: Colors.white,
          ),
          StrategyCardSimple(
            symbolUrl: symbolUrl,
            symbol: symbol,
            timeTrade: timeTrade,
          ),
          // Expanded(child: Container()),
          Container(
            child: Center(
              child: IconButton(
                onPressed: () => _foldingCellKey.currentState?.toggleFold(),
                icon: Icon(Icons.arrow_drop_down_sharp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _BackgroundCardColor() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(4.0),
      gradient: const LinearGradient(
          colors: [Color.fromRGBO(23, 25, 26, 1), Color.fromRGBO(0, 0, 0, 1)]),
    );
  }

  Widget _buildInnerWidget() {
    return Container(
      // color: Color(0xFFecf2f9),
      // padding: EdgeInsets.only(top: 10),
      decoration: _BackgroundCardColor(),
      child: Column(
        children: [
          Row(
            children: [
              PusherStrategyImageText(
                  urlPusher: urlPusher,
                  strategyName: strategyName,
                  pusherName: pusherName),
              Expanded(child: Container()),
              BrokerImageText(brokerName: brokerName, brokerUrl: brokerUrl),
            ],
          ),
          Divider(
            height: 2,
            color: Colors.white,
          ),
          StrategyCardSimple(
              symbolUrl: symbolUrl, symbol: symbol, timeTrade: timeTrade),

          // ADD TEXT -------------------------------------------------------->>
          _tableProfit(
            initialCapitalLogn: initialCapitalLogn,
            initialCapitalShort: initialCapitalShort,
            currentCapitalLogn: currentCapitalLogn,
            currentCapitalShort: currentCapitalShort,
            percentageProfitLong: percentageProfitLong,
            percentageProfitShort: percentageProfitShort,
            closedTradeShort: closedTradeShort,
            closedTradeLong: closedTradeLong,
          ),

          // ADD TEXT --------------------------------------------------------<<

          // ADD Switch -----------------------------------------------
          _ControlButtoms(),
          // ----------------------------------------------------------
          // Control Icons ----
          Row(
            children: [
              Expanded(child: Container()),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete_outline, color: Colors.red)),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.settings, color: Colors.grey.shade600))
            ],
          ),

          Expanded(child: Container()),
          Center(
            child: TextButton(
              onPressed: () => _foldingCellKey.currentState?.toggleFold(),
              child: Icon(
                Icons.arrow_drop_up,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _textHeaderTableStyle() {
    return TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w300,
        height: 1.2,
        letterSpacing: .1,
        fontFamily: 'Oswald');
  }

  TextStyle _textHeaderTableStyleBlue() {
    return TextStyle(
      fontFamily: 'Oswald',
      fontSize: 20,
      height: 1.8,
      letterSpacing: .3,
      color: Colors.blue,
    );
  }
}

class _ControlButtoms extends StatelessWidget {
  const _ControlButtoms({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 160,
            child: SwitchListTile(
                value: true,
                title: Text('Active Trading Long',
                    style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        letterSpacing: .5,
                        fontSize: 11,
                        height: 1,
                      ),
                    )),
                onChanged: (value) {}),
          ),
          Expanded(child: Container()),
          Container(
            width: 160,
            child: SwitchListTile(
                value: true,
                title: Text('Active Trading Short',
                    style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        letterSpacing: .5,
                        fontSize: 11,
                        height: 1.4,
                      ),
                    )),
                onChanged: (value) {}),
          ),
        ],
      ),
    );
  }
}

class _tableProfit extends StatelessWidget {
  const _tableProfit({
    Key? key,
    required this.initialCapitalLogn,
    required this.initialCapitalShort,
    required this.currentCapitalLogn,
    required this.currentCapitalShort,
    required this.percentageProfitLong,
    required this.percentageProfitShort,
    required this.closedTradeShort,
    required this.closedTradeLong,
  }) : super(key: key);

  final double initialCapitalLogn;
  final double initialCapitalShort;
  final double currentCapitalLogn;
  final double currentCapitalShort;
  final double percentageProfitLong;
  final double percentageProfitShort;
  final String closedTradeShort;
  final String closedTradeLong;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ColumnTableE(
              titleOne: 'TRADING',
              titleTwo: 'TYPE',
              valueOne: 'LONG',
              valueTwo: 'SHORT'),
          _ColumnTableE(
              titleOne: 'CLOSED',
              titleTwo: 'TRADES',
              valueOne: closedTradeLong,
              valueTwo: closedTradeShort),
          _ColumnTableUSD(
              titleOne: 'INITIAL',
              titleTwo: 'CAPITAL',
              valueOne: initialCapitalLogn,
              valueTwo: initialCapitalShort),
          _ColumnTableUSDCurrent(
            titleOne: 'CURRENT',
            titleTwo: 'CAPITAL',
            currentCapitalLogn: currentCapitalLogn,
            currentCapitalShort: currentCapitalShort,
            initialCapitalLogn: initialCapitalLogn,
            initialCapitalShort: initialCapitalShort,
          ),
          _ColumnTablePercentage(
              titleOne: 'PROFIT',
              titleTwo: 'PORCENTAGE',
              percentageProfitLong: percentageProfitLong,
              percentageProfitShort: percentageProfitShort),
        ],
      ),
    );
  }
}

class _ColumnTableE extends StatelessWidget {
  const _ColumnTableE({
    Key? key,
    required this.titleOne,
    required this.titleTwo,
    required this.valueOne,
    required this.valueTwo,
  }) : super(key: key);

  final String titleOne;
  final String titleTwo;
  final String valueOne;
  final String valueTwo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titleOne,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: Colors.white,
                    letterSpacing: .5,
                    fontSize: 11,
                    height: 1,
                  ),
                )),
            Text(titleTwo,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: Colors.white,
                    letterSpacing: .5,
                    fontSize: 11,
                    height: 1,
                  ),
                )),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$valueOne',
                style: GoogleFonts.oswald(
                  textStyle: TextStyle(
                    color: Colors.blue, letterSpacing: .5,
                    fontSize: 18,
                    height: 1.4,
                    // letterSpacing: .1,
                  ),
                )),
            Text('$valueTwo',
                style: GoogleFonts.oswald(
                  textStyle: TextStyle(
                    color: Colors.orange, letterSpacing: .5,
                    fontSize: 18,
                    height: 1.4,
                    // letterSpacing: .1,
                  ),
                )),
          ],
        ),
      ],
    );
  }
}

class _ColumnTablePercentage extends StatelessWidget {
  const _ColumnTablePercentage({
    Key? key,
    required this.titleOne,
    required this.titleTwo,
    required this.percentageProfitShort,
    required this.percentageProfitLong,
  }) : super(key: key);

  final String titleOne;
  final String titleTwo;
  final double percentageProfitShort;
  final double percentageProfitLong;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titleOne,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: Colors.white,
                    letterSpacing: .5,
                    fontSize: 11,
                    height: 1,
                  ),
                )),
            Text(titleTwo,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: Colors.white,
                    letterSpacing: .5,
                    fontSize: 11,
                    height: 1,
                  ),
                )),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('$percentageProfitLong',
                    style: GoogleFonts.oswald(
                      textStyle: TextStyle(
                        color: percentageProfitLong >= 0
                            ? Colors.green
                            : Colors.red,
                        letterSpacing: .5,
                        fontSize: 18,
                        height: 1.4,
                        // letterSpacing: .1,
                      ),
                    )),
                Text('%',
                    style: GoogleFonts.oswald(
                      textStyle: TextStyle(
                        color: percentageProfitLong >= 0
                            ? Colors.green
                            : Colors.red,
                        letterSpacing: .5,
                        fontSize: 14,
                        height: 1,
                        // letterSpacing: .1,
                      ),
                    )),
              ],
            ),
            Row(
              children: [
                Text('$percentageProfitShort',
                    style: GoogleFonts.oswald(
                      textStyle: TextStyle(
                        color: percentageProfitShort >= 0
                            ? Colors.green
                            : Colors.red,
                        letterSpacing: .5,
                        fontSize: 18,
                        height: 1.4,
                        // letterSpacing: .1,
                      ),
                    )),
                Text('%',
                    style: GoogleFonts.oswald(
                      textStyle: TextStyle(
                        color: percentageProfitShort >= 0
                            ? Colors.green
                            : Colors.red,
                        letterSpacing: .5,
                        fontSize: 14,
                        height: 1,
                        // letterSpacing: .1,
                      ),
                    )),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _ColumnTableUSD extends StatelessWidget {
  const _ColumnTableUSD({
    Key? key,
    required this.titleOne,
    required this.titleTwo,
    required this.valueOne,
    required this.valueTwo,
  }) : super(key: key);

  final String titleOne;
  final String titleTwo;
  final double valueOne;
  final double valueTwo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titleOne,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: Colors.white,
                    letterSpacing: .5,
                    fontSize: 11,
                    height: 1,
                  ),
                )),
            Text(titleTwo,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: Colors.white,
                    letterSpacing: .5,
                    fontSize: 11,
                    height: 1,
                  ),
                )),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('$valueOne',
                    style: GoogleFonts.oswald(
                      textStyle: TextStyle(
                        color: Colors.green, letterSpacing: .5,
                        fontSize: 18,
                        height: 1.4,
                        // letterSpacing: .1,
                      ),
                    )),
                Text('USD',
                    style: GoogleFonts.oswald(
                      textStyle: TextStyle(
                        color: Colors.green, letterSpacing: .5,
                        fontSize: 13,
                        height: 1,
                        // letterSpacing: .1,
                      ),
                    )),
              ],
            ),
            Row(
              children: [
                Text('$valueTwo',
                    style: GoogleFonts.oswald(
                      textStyle: TextStyle(
                        color: Colors.green, letterSpacing: .5,
                        fontSize: 18,
                        height: 1.4,
                        // letterSpacing: .1,
                      ),
                    )),
                Text('USD',
                    style: GoogleFonts.oswald(
                      textStyle: TextStyle(
                        color: Colors.green, letterSpacing: .5,
                        fontSize: 13,
                        height: 1,
                        // letterSpacing: .1,
                      ),
                    )),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _ColumnTableUSDCurrent extends StatelessWidget {
  const _ColumnTableUSDCurrent({
    Key? key,
    required this.titleOne,
    required this.titleTwo,
    required this.currentCapitalLogn,
    required this.currentCapitalShort,
    required this.initialCapitalLogn,
    required this.initialCapitalShort,
  }) : super(key: key);

  final String titleOne;
  final String titleTwo;
  final double currentCapitalLogn;
  final double currentCapitalShort;
  final double initialCapitalLogn;
  final double initialCapitalShort;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titleOne,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: Colors.white,
                    letterSpacing: .5,
                    fontSize: 11,
                    height: 1,
                  ),
                )),
            Text(titleTwo,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: Colors.white,
                    letterSpacing: .5,
                    fontSize: 11,
                    height: 1,
                  ),
                )),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('${currentCapitalLogn}',
                    style: GoogleFonts.oswald(
                      textStyle: TextStyle(
                        color: initialCapitalLogn < currentCapitalLogn
                            ? Colors.green
                            : Colors.red,
                        letterSpacing: .5,
                        fontSize: 18,
                        height: 1.4,
                        // letterSpacing: .1,
                      ),
                    )),
                Text('USD',
                    style: GoogleFonts.oswald(
                      textStyle: TextStyle(
                        color: initialCapitalLogn < currentCapitalLogn
                            ? Colors.green
                            : Colors.red,
                        letterSpacing: .5,
                        fontSize: 13,
                        height: 1,
                        // letterSpacing: .1,
                      ),
                    )),
              ],
            ),
            Row(
              children: [
                Text('${currentCapitalShort}',
                    style: GoogleFonts.oswald(
                      textStyle: TextStyle(
                        color: initialCapitalShort < currentCapitalShort
                            ? Colors.green
                            : Colors.red,
                        letterSpacing: .5,
                        fontSize: 18,
                        height: 1.4,
                        // letterSpacing: .1,
                      ),
                    )),
                Text('USD',
                    style: GoogleFonts.oswald(
                      textStyle: TextStyle(
                        color: initialCapitalShort < currentCapitalShort
                            ? Colors.green
                            : Colors.red,
                        letterSpacing: .5,
                        fontSize: 13,
                        height: 1,
                        // letterSpacing: .1,
                      ),
                    )),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class StrategyCardSimple extends StatelessWidget {
  const StrategyCardSimple({
    Key? key,
    required this.symbolUrl,
    required this.symbol,
    required this.timeTrade,
  }) : super(key: key);

  final String symbolUrl;
  final String symbol;
  final String timeTrade;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5, left: 1, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ImageCircleBorder(
                      urlPrusher: symbolUrl,
                      radioImage: 50,
                      colorBorder: Colors.white,
                    ),
                    const SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(symbol,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(timeTrade,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.timer,
                              color: Colors.white,
                              size: 20,
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Win Trade',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w300)),
                Row(
                  children: const [
                    Text('6',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.w700)),
                    Text('/',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300)),
                    Text('10',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 0, top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Trading Profit',
                    style: TextStyle(
                        color: Color(0xff1BC232),
                        fontSize: 15,
                        fontWeight: FontWeight.w300)),
                Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('3',
                            style: TextStyle(
                                color: Color(0xff1BC232),
                                fontSize: 35,
                                fontWeight: FontWeight.w700)),
                        Text('%',
                            style: TextStyle(
                                color: Color(0xff1BC232),
                                fontSize: 15,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('130',
                              style: TextStyle(
                                  color: Color(0xff1BC232),
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700)),
                          Text('USD',
                              style: TextStyle(
                                  color: Color(0xff1BC232),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PusherStrategyImageText extends StatelessWidget {
  const PusherStrategyImageText({
    Key? key,
    this.mainTextColor = Colors.white,
    required this.urlPusher,
    required this.strategyName,
    required this.pusherName,
  }) : super(key: key);

  final Color mainTextColor;
  final String strategyName;
  final String pusherName;
  final String urlPusher;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      // --------------------
      // Logo (TradingView)
      //      (StrategyName)
      //      (Pusher Name)
      // --------------------

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ImageCircleBorder(
            urlPrusher: urlPusher,
            radioImage: 40,
            colorBorder: mainTextColor,
          ),
          Container(
            margin: EdgeInsets.only(left: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  'Strategy',
                  style: TextStyle(
                      color: mainTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  strategyName,
                  style: TextStyle(
                      color: mainTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  pusherName,
                  style: TextStyle(
                      color: mainTextColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ImageCircleBorder extends StatelessWidget {
  const ImageCircleBorder({
    Key? key,
    this.radioImage = 43,
    required this.urlPrusher,
    this.colorBorder = Colors.white,
  }) : super(key: key);

  final double radioImage;
  final String urlPrusher;
  final Color colorBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.all(1),

      width: radioImage,
      height: radioImage,

      decoration: BoxDecoration(
          color: colorBorder,
          borderRadius: BorderRadius.circular(radioImage / 2)),

      child: CircleAvatar(
        backgroundImage: NetworkImage(urlPrusher),
      ),

      // decoration:
    );
  }
}

class BrokerImageText extends StatelessWidget {
  const BrokerImageText({
    Key? key,
    this.mainTextColor = Colors.white54,
    required this.brokerName,
    required this.brokerUrl, this.radioImage = 40,
  }) : super(key: key);

  final Color mainTextColor;
  final String brokerName;
  final String brokerUrl;
  final double radioImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              Text('Broker',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
              Text(brokerName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
            ],
          ),
        ),
        ImageCircleBorder(
          urlPrusher: brokerUrl,
          radioImage: radioImage,
        ),
      ],
    );
  }
}

class BoardingPassData {}

class _SimpleSwitchTrade extends StatefulWidget {
  const _SimpleSwitchTrade({
    Key? key,
    required this.titleTextStyle,
    required this.TextSwitch,
  }) : super(key: key);

  final TextStyle titleTextStyle;
  final String TextSwitch;

  @override
  State<_SimpleSwitchTrade> createState() => _SimpleSwitchTradeState();
}

class _SimpleSwitchTradeState extends State<_SimpleSwitchTrade> {
  @override
  Widget build(BuildContext context) {
    bool status = false;

    return Column(
      children: [
        const SizedBox(height: 5),
        Column(
          children: [
            Text('Active'.toUpperCase(), style: widget.titleTextStyle),
            Text(widget.TextSwitch.toUpperCase(), style: widget.titleTextStyle)
          ],
        ),
        Container(
          height: 25,
          width: 120,
          child: Switch(
            value: status,
            activeColor: Colors.blue,
            onChanged: (value) {
              setState(() {
                status = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
