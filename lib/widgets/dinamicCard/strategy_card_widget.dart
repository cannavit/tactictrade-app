import 'package:folding_cell/folding_cell.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/share_preferences/preferences.dart';
import 'package:tactictrade/widgets/forms_components/dropdown_trading_config.dart';

import '../../providers/theme_provider.dart';
import '../../screens/transactions_records_screen.dart';
import '../../services/trading_config.dart';
import '../../services/transactions_record_service.dart';

class StrategyCard extends StatelessWidget {
  final _foldingCellKey = GlobalKey<SimpleFoldingCellState>();

  StrategyCard({
    Key? key,
    required this.initialCapitalLong,
    required this.initialCapitalShort,
    required this.currentCapitalLong,
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
    required this.brokerType,
    required this.tradingConfigId,
    required this.totalNumberOfWinTrades,
    required this.totalTradingProfit,
    required this.totalProfitUSD,
    required this.totalOfTrades,
    required this.isActiveTradeLong,
    required this.isActiveTradeShort,
    required this.strategyNewsId,
  }) : super(key: key);

  final double initialCapitalLong;
  final double initialCapitalShort;
  final double currentCapitalLong;
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
  final String brokerType;
  final int tradingConfigId;
  final int totalNumberOfWinTrades;
  final double totalTradingProfit;
  final double totalProfitUSD;
  final int totalOfTrades;

  final bool isActiveTradeShort;
  final bool isActiveTradeLong;

  final int strategyNewsId;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final themeColors = Theme.of(context);

    return Container(
      width: double.infinity,
      alignment: Alignment.topCenter,
      child: SimpleFoldingCell.create(
        // padding: EdgeInsets.all(1),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        key: _foldingCellKey,
        frontWidget: _buildFrontWidget(context),
        innerWidget: _buildInnerWidget(context),
        cellSize: Size(MediaQuery.of(context).size.width, 195),
        animationDuration: const Duration(milliseconds: 400),
        borderRadius: 10,
        onOpen: () => print('cell opened'),
        onClose: () => print('cell closed'),
      ),
    );
  }

  Widget _buildFrontWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: _BackgroundCardColor(context),
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
                  brokerType: brokerType),
            ],
          ),
          const Divider(
            height: 1,
            color: Colors.white,
          ),
          StrategyCardSimple(
            totalOfTrades: totalOfTrades,
            totalProfitUSD: totalProfitUSD,
            totalTradingProfit: totalTradingProfit,
            totalNumberOfWinTrades: totalNumberOfWinTrades,
            symbolUrl: symbolUrl,
            symbol: symbol,
            timeTrade: timeTrade,
          ),
          // Expanded(child: Container()),
          Container(
            child: Center(
              child: IconButton(
                onPressed: () => _foldingCellKey.currentState?.toggleFold(),
                icon: const Icon(Icons.arrow_drop_down_sharp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _BackgroundCardColor(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return BoxDecoration(
      borderRadius: BorderRadius.circular(4.0),
      gradient: LinearGradient(colors: [
        themeProvider.currentTheme.scaffoldBackgroundColor,
        themeProvider.currentTheme.scaffoldBackgroundColor
      ]),
    );
  }

  Widget _buildInnerWidget(BuildContext context) {
    final tradingConfig = Provider.of<TradingConfig>(context, listen: true);
    final transactionServiceData =
        Provider.of<TransactionRecordsServices>(context, listen: true);

    return Container(
      // color: Color(0xFFecf2f9),
      // padding: EdgeInsets.only(top: 10),
      decoration: _BackgroundCardColor(context),
      child: Column(
        children: [
          Row(
            children: [
              PusherStrategyImageText(
                  urlPusher: urlPusher,
                  strategyName: strategyName,
                  pusherName: pusherName),
              Expanded(child: Container()),
              BrokerImageText(
                brokerName: brokerName,
                brokerUrl: brokerUrl,
                brokerType: brokerType,
              ),
            ],
          ),

          const Divider(
            height: 2,
            color: Colors.white,
          ),

          StrategyCardSimple(
              totalOfTrades: totalOfTrades,
              totalProfitUSD: totalProfitUSD,
              totalTradingProfit: totalTradingProfit,
              symbolUrl: symbolUrl,
              symbol: symbol,
              timeTrade: timeTrade,
              totalNumberOfWinTrades: totalNumberOfWinTrades),

          // ADD TEXT -------------------------------------------------------->>
          _tableProfit(
            initialCapitalLong: initialCapitalLong,
            initialCapitalShort: initialCapitalShort,
            currentCapitalLong: currentCapitalLong,
            currentCapitalShort: currentCapitalShort,
            percentageProfitLong: percentageProfitLong,
            percentageProfitShort: percentageProfitShort,
            closedTradeShort: closedTradeShort,
            closedTradeLong: closedTradeLong,
          ),

          _ControlButtoms(
            isActiveTradeLong: isActiveTradeLong,
            isActiveTradeShort: isActiveTradeShort,
            tradingConfigId: tradingConfigId,
          ),

          Container(
            // color: Colors.green,
            // height: 100,
            // width: 10,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                // Expanded(child: Container()),

                Container(
                    color: Colors.red,
                    width: 20,
                    height: 20,
                    child: DropdownTradingConfig(
                      tradingConfigId: tradingConfigId,
                    )),

                const SizedBox(width: 20),

                IconButton(
                  icon: const Icon(
                    Icons.remove_red_eye_outlined,
                    color: Colors.blue,
                    size: 20,
                  ),


                  onPressed: () {

                    transactionServiceData.getTransactionRecord(
                        strategyNewsId, {"private": true});

                    // final recordsProvider =
                    //   Provider.of<TransactionRecordsServices>(context, listen: true);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TransactionPageScreen(
                                  isPrivateRecord: false,
                                  strategyId: strategyNewsId,
                                  urlSymbol: symbolUrl,
                                  isActive: isActiveTradeLong,
                                  isVerify: true,
                                  strategyName: strategyName,
                                  symbolName: symbol,
                                  timeTrade: timeTrade,
                                  urlPusher: urlPusher,
                                  mantainerName: brokerName,
                                  urlUser: brokerUrl,
                                  titleLevelOne: 'Broker',
                                  recordsProvider: transactionServiceData,
                                  isPrivate: true,
                                )));

                    // do something
                  },
                ),

                //   Expanded(child: Container()),

                // IconButton(
                //     onPressed: () {},
                //     icon: Icon(Icons.settings, color: Colors.grey.shade600))
              ],
            ),
          ),

          // Expanded(child: Container()),
          Center(
            child: TextButton(
              onPressed: () => _foldingCellKey.currentState?.toggleFold(),
              child: const Icon(
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
    return const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w300,
        height: 1.2,
        letterSpacing: .1,
        fontFamily: 'Oswald');
  }

  TextStyle _textHeaderTableStyleBlue() {
    return const TextStyle(
      fontFamily: 'Oswald',
      fontSize: 20,
      height: 1.8,
      letterSpacing: .3,
      color: Colors.blue,
    );
  }
}

class _ControlButtoms extends StatefulWidget {
  _ControlButtoms({
    Key? key,
    required this.isActiveTradeLong,
    required this.isActiveTradeShort,
    required this.tradingConfigId,
  }) : super(key: key);

  late bool isActiveTradeLong;
  late bool isActiveTradeShort;
  final int tradingConfigId;

  @override
  State<_ControlButtoms> createState() => _ControlButtomsState();
}

class _ControlButtomsState extends State<_ControlButtoms> {
  @override
  Widget build(BuildContext context) {
    final tradingConfig = Provider.of<TradingConfig>(context, listen: true);

    return Container(
      child: Row(
        children: [
          SizedBox(
            width: 160,
            child: SwitchListTile(
                activeColor: Colors.blue,
                value: widget.isActiveTradeLong,
                title: Text('Active Trading Long',
                    style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        letterSpacing: .5,
                        fontSize: 11,
                        height: 1,
                      ),
                    )),
                onChanged: (value) {
                  Preferences.updateStrategyOwnerSelected = true;

                  widget.isActiveTradeLong = value;

                  tradingConfig.edit_tradingconfig(
                      widget.tradingConfigId, {"is_active_long": value});

                  setState(() {});
                }),
          ),
          Expanded(child: Container()),
          SizedBox(
            width: 160,
            child: SwitchListTile(
                activeColor: Colors.blue,
                value: widget.isActiveTradeShort,
                title: Text('Active Trading Short',
                    style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        letterSpacing: .5,
                        fontSize: 11,
                        height: 1.4,
                      ),
                    )),
                onChanged: (value) {
                  Preferences.updateStrategyOwnerSelected = true;

                  widget.isActiveTradeShort = value;

                  tradingConfig.edit_tradingconfig(
                      widget.tradingConfigId, {"is_active_short": value});

                  setState(() {});
                }),
          ),
        ],
      ),
    );
  }
}

class _tableProfit extends StatelessWidget {
  const _tableProfit({
    Key? key,
    required this.initialCapitalLong,
    required this.initialCapitalShort,
    required this.currentCapitalLong,
    required this.currentCapitalShort,
    required this.percentageProfitLong,
    required this.percentageProfitShort,
    required this.closedTradeShort,
    required this.closedTradeLong,
  }) : super(key: key);

  final double initialCapitalLong;
  final double initialCapitalShort;
  final double currentCapitalLong;
  final double currentCapitalShort;
  final double percentageProfitLong;
  final double percentageProfitShort;
  final String closedTradeShort;
  final String closedTradeLong;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _ColumnTableE(
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
              valueOne: initialCapitalLong,
              valueTwo: initialCapitalShort),
          _ColumnTableUSDCurrent(
            titleOne: 'CURRENT',
            titleTwo: 'CAPITAL',
            currentCapitalLong: currentCapitalLong,
            currentCapitalShort: currentCapitalShort,
            initialCapitalLong: initialCapitalLong,
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
                  textStyle: const TextStyle(
                    color: Colors.white,
                    letterSpacing: .5,
                    fontSize: 11,
                    height: 1,
                  ),
                )),
            Text(titleTwo,
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
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
            Text(valueOne,
                style: GoogleFonts.oswald(
                  textStyle: const TextStyle(
                    color: Colors.blue, letterSpacing: .5,
                    fontSize: 18,
                    height: 1.4,
                    // letterSpacing: .1,
                  ),
                )),
            Text(valueTwo,
                style: GoogleFonts.oswald(
                  textStyle: const TextStyle(
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
                  textStyle: const TextStyle(
                    color: Colors.white,
                    letterSpacing: .5,
                    fontSize: 11,
                    height: 1,
                  ),
                )),
            Text(titleTwo,
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
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
                  textStyle: const TextStyle(
                    color: Colors.white,
                    letterSpacing: .5,
                    fontSize: 11,
                    height: 1,
                  ),
                )),
            Text(titleTwo,
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
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
                      textStyle: const TextStyle(
                        color: Colors.green, letterSpacing: .5,
                        fontSize: 16,
                        height: 1.4,
                        // letterSpacing: .1,
                      ),
                    )),
                Text('USD',
                    style: GoogleFonts.oswald(
                      textStyle: const TextStyle(
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
                      textStyle: const TextStyle(
                        color: Colors.green, letterSpacing: .5,
                        fontSize: 18,
                        height: 1.4,
                        // letterSpacing: .1,
                      ),
                    )),
                Text('USD',
                    style: GoogleFonts.oswald(
                      textStyle: const TextStyle(
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
    required this.currentCapitalLong,
    required this.currentCapitalShort,
    required this.initialCapitalLong,
    required this.initialCapitalShort,
  }) : super(key: key);

  final String titleOne;
  final String titleTwo;
  final double currentCapitalLong;
  final double currentCapitalShort;
  final double initialCapitalLong;
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
                  textStyle: const TextStyle(
                    color: Colors.white,
                    letterSpacing: .5,
                    fontSize: 11,
                    height: 1,
                  ),
                )),
            Text(titleTwo,
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
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
                Text('$currentCapitalLong',
                    style: GoogleFonts.oswald(
                      textStyle: TextStyle(
                        color: initialCapitalLong < currentCapitalLong
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
                        color: initialCapitalLong < currentCapitalLong
                            ? Colors.green
                            : Colors.red,
                        letterSpacing: .5,
                        fontSize: 11,
                        height: 1,
                        // letterSpacing: .1,
                      ),
                    )),
              ],
            ),
            Row(
              children: [
                Text('$currentCapitalShort',
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
                        fontSize: 11,
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
    required this.totalNumberOfWinTrades,
    required this.totalTradingProfit,
    required this.totalProfitUSD,
    required this.totalOfTrades,
  }) : super(key: key);

  final String symbolUrl;
  final String symbol;
  final String timeTrade;
  final int totalNumberOfWinTrades;
  final double totalTradingProfit;
  final double totalProfitUSD;
  final int totalOfTrades;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 1, right: 5),
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
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(timeTrade,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.timer,
                              color: Colors.white,
                              size: 18,
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
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Win Trade',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w300)),
                Row(
                  children: [
                    Text('$totalNumberOfWinTrades',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.w700)),
                    const Text('/',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300)),
                    Text('$totalOfTrades',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 0, top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Trading Profit',
                    style: TextStyle(
                        color: totalTradingProfit >= 0
                            ? const Color(0xff1BC232)
                            : const Color.fromARGB(255, 226, 46, 40),
                        fontSize: 15,
                        fontWeight: FontWeight.w300)),
                Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('$totalTradingProfit',
                            style: TextStyle(
                                color: totalTradingProfit >= 0
                                    ? const Color(0xff1BC232)
                                    : const Color.fromARGB(255, 194, 33, 27),
                                fontSize: 30,
                                fontWeight: FontWeight.w700)),
                        Text('%',
                            style: TextStyle(
                                color: totalTradingProfit >= 0
                                    ? const Color(0xff1BC232)
                                    : const Color.fromARGB(255, 194, 33, 27),
                                fontSize: 15,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('$totalProfitUSD',
                              style: TextStyle(
                                  color: totalTradingProfit >= 0
                                      ? const Color(0xff1BC232)
                                      : const Color.fromARGB(255, 194, 33, 27),
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700)),
                          Text('USD',
                              style: TextStyle(
                                  color: totalTradingProfit >= 0
                                      ? const Color(0xff1BC232)
                                      : const Color.fromARGB(255, 194, 33, 27),
                                  fontSize: 11,
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
      margin: const EdgeInsets.symmetric(vertical: 5),
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
            margin: const EdgeInsets.only(left: 5),
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
        margin: const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.all(1),
        width: radioImage,
        height: radioImage,
        decoration: BoxDecoration(
            color: colorBorder,
            borderRadius: BorderRadius.circular(radioImage / 2)),
        child: urlPrusher.startsWith('http')
            ? CircleAvatar(
                radius: radioImage, backgroundImage: NetworkImage(urlPrusher))
            : Image(image: AssetImage(urlPrusher)));
  }
}

class BrokerImageText extends StatelessWidget {
  const BrokerImageText({
    Key? key,
    this.mainTextColor = Colors.white54,
    required this.brokerName,
    required this.brokerUrl,
    this.radioImage = 40,
    required this.brokerType,
  }) : super(key: key);

  final Color mainTextColor;
  final String brokerName;
  final String brokerUrl;
  final double radioImage;
  final String brokerType;

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Align(
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('Broker',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400)),
                Text(brokerName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400)),
                Text(brokerType,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w300)),
              ],
            ),
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
        SizedBox(
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

class _PopUpDelete extends StatelessWidget {
  const _PopUpDelete({
    Key? key,
    required this.titleHeader,
    required this.message,
  }) : super(key: key);

  final String titleHeader;
  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titleHeader),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(message),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: Row(
            children: [
              TextButton(
                child: const Text('Continue',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.w700)),
                onPressed: () {},
              ),
              Expanded(child: Container()),
              TextButton(
                child: const Text('Cancel',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.w700)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
