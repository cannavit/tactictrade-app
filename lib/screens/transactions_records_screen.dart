import 'dart:convert';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/widgets/carousel_list_home.dart';

import '../models/record_model.dart';
import '../providers/show_graph2d_profit_provider.dart';
import '../providers/timer_categories_provider.dart';
import '../services/transactions_record_service.dart';
import '../share_preferences/preferences.dart';
import '../widgets/strategyCard.dart';
import '../widgets/transaction_record_row_widget.dart';
import 'loading_strategy.dart';

class TransactionPageScreen extends StatelessWidget {
  const TransactionPageScreen({
    Key? key,
    this.isPrivateRecord: false,
    this.strategyId: -1,
    required this.urlSymbol,
    required this.urlPusher,
    required this.timeTrade,
    required this.strategyName,
    required this.isActive,
    required this.isVerify,
    required this.symbolName,
    required this.mantainerName,
    required this.urlUser,
    this.titleLevelOne = 'Mantainer',
    required this.recordsProvider,
    required this.isPrivate,
  }) : super(key: key);

  final bool isPrivateRecord;
  final int strategyId;

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
  final bool isPrivate;

  final TransactionRecordsServices recordsProvider;

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context);
    var showGraph = true;

    final filterList =
        Provider.of<CategoryTimerSelected>(context, listen: false);

    final data = json.encode({
      'strategyId': strategyId,
      'body': {"private": false}
    });

    // final recordsProvider =
    //     Provider.of<TransactionRecordsServices>(context, listen: true);

    if (recordsProvider.isLoading) return LoadingView();

    // Build the data for Graph

    return FutureBuilder(
        future: recordsProvider
            .getTransactionRecord(strategyId, {"private": isPrivate}),
        builder: (_, AsyncSnapshot<List<Record>> snapshot) {
          if (!snapshot.hasData) return const LoadingView();

          final List<double> recordsShortProfit = [];
          final List<double> recordsLongProfit = [];

          var countElement = -1;
          for (var r in recordsProvider.recordsList) {
            countElement = countElement + 1;
            if (r.operation == 'short') {
              recordsShortProfit.add(r.profitPercentage);
            } else {
              recordsLongProfit.add(r.profitPercentage);
            }
          }

          if (recordsProvider.recordsList.length == 0) {
            recordsShortProfit.add(0);
            recordsShortProfit.add(0);
            recordsShortProfit.add(0);
            recordsLongProfit.add(0);
            recordsLongProfit.add(0);
            recordsLongProfit.add(0);
          }

          var recordsShortProfitReverser =
              new List.from(recordsShortProfit.reversed);

          var recordsLongProfitReverser =
              new List.from(recordsLongProfit.reversed);

          final totalList = new List.from(recordsShortProfit)
            ..addAll(recordsLongProfit);

          final value1 = (recordsLongProfit.reduce(max));
          final value2 = (recordsLongProfit.reduce(min));

          var xMaxValue;
          var xMinValue;

          if (value1 > value2) {
            xMaxValue = value1;
            xMinValue = value2;
          } else {
            xMaxValue = value2;
            xMinValue = value1;
          }
// reversed
          List<FlSpot> recordsShortProfitSpots =
              recordsShortProfitReverser.asMap().entries.map((e) {
            return FlSpot(e.key.toDouble(), e.value);
          }).toList();

          List<FlSpot> recordsLongProfitSpots =
              recordsLongProfitReverser.asMap().entries.map((e) {
            return FlSpot(e.key.toDouble(), e.value);
          }).toList();

          print(recordsShortProfit);

          return Scaffold(
              appBar: AppBar(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Preferences.isDarkmode
                      ? Brightness.dark
                      : Brightness.light,
                  statusBarBrightness: Preferences.isDarkmode
                      ? Brightness.light
                      : Brightness.dark,
                ),
                title: Text('Strategy Transactions Records',
                    style: TextStyle(
                        color: themeColors.secondaryHeaderColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w300)),
                backgroundColor: Colors.transparent,
                leading: BackButton(
                  color: themeColors.primaryColor,
                  onPressed: () {
                    Preferences.navigationCurrentPage = 0;
                    Preferences.tempStrategyImage = "";
                    recordsProvider.isLoading = true;
                    Navigator.pushReplacementNamed(context, 'navigation');
                  },
                ),
                actions: [],
                elevation: 0,
              ),
              body: Column(
                children: [
                  MantainerCardStrategyWidget(
                      mantainerName: mantainerName,
                      urlUser: urlUser,
                      titleLevelOne: titleLevelOne),

                  labelTwoStockAndPusher(
                    isActive: isActive,
                    isVerify: isVerify,
                    strategyName: strategyName,
                    urlPusher: urlPusher,
                    timeTrade: timeTrade,
                    symbolName: symbolName,
                    urlSymbol: urlSymbol,
                  ),

                  Divider(height: 1),

                  // Graph 2D -----------------------------------------
                  _2dGraphProfit(
                      xMinValue: xMinValue,
                      xMaxValue: xMaxValue,
                      recordsShortProfit: recordsShortProfit,
                      recordsLongProfit: recordsLongProfit,
                      recordsShortProfitSpots: recordsShortProfitSpots,
                      recordsLongProfitSpots: recordsLongProfitSpots),

                  // -------------------------------------------------
                  const SizedBox(height: 20),

                  // Row Filters --------------------------------------
                  Container(
                    height: 25,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          child: _buttonChangeGraph(),
                        ),
                        Expanded(
                          child: CarouselListHome(
                              categoriesList: filterList, pageCarausel: 'year'),
                        ),
                      ],
                    ),
                  ),

                  ColumnTitlesTransactionsRecordsWidget(),

                  Expanded(
                    // height: double.infinity,
                    child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(),
                        itemCount: recordsProvider.recordsList.length,
                        itemBuilder: (BuildContext context, int index) => TransactionRecordRowWidget(
                            order: recordsProvider.recordsList[index].order,
                            operation:
                                recordsProvider.recordsList[index].operation,
                            qty_open:
                                recordsProvider.recordsList[index].qtyOpen,
                            qty_close:
                                recordsProvider.recordsList[index].qtyClose,
                            price_open:
                                recordsProvider.recordsList[index].priceOpen,
                            price_closed:
                                recordsProvider.recordsList[index].priceClosed,
                            base_cost:
                                recordsProvider.recordsList[index].baseCost,
                            close_cost:
                                recordsProvider.recordsList[index].closeCost,
                            amount_open:
                                recordsProvider.recordsList[index].amountOpen,
                            amount_close:
                                recordsProvider.recordsList[index].amountClose,
                            spread: recordsProvider.recordsList[index].spread,
                            create_at:
                                recordsProvider.recordsList[index].createAt,
                            updated_at:
                                recordsProvider.recordsList[index].updatedAt,
                            is_winner:
                                recordsProvider.recordsList[index].isWinner,
                            profit: recordsProvider.recordsList[index].profit,
                            profit_percentage: recordsProvider.recordsList[index].profitPercentage)),
                  ),

                  // Create table:

                  // Center(child: Text('TransactionPage Screen ${strategyId}')
                ],
              ));
        });
  }
}

class _2dGraphProfit extends StatelessWidget {
  const _2dGraphProfit({
    Key? key,
    required this.xMinValue,
    required this.xMaxValue,
    required this.recordsShortProfit,
    required this.recordsLongProfit,
    required this.recordsShortProfitSpots,
    required this.recordsLongProfitSpots,
  }) : super(key: key);

  final xMinValue;
  final xMaxValue;
  final List<double> recordsShortProfit;
  final List<double> recordsLongProfit;
  final List<FlSpot> recordsShortProfitSpots;
  final List<FlSpot> recordsLongProfitSpots;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Visibility(
        visible: Provider.of<ShowGraph2dProfitProvider>(context, listen: true)
            .read(),
        child: _2dProfitGraph(
            xMinValue: xMinValue,
            xMaxValue: xMaxValue,
            recordsShortProfit: recordsShortProfit,
            recordsLongProfit: recordsLongProfit,
            recordsShortProfitSpots: recordsShortProfitSpots,
            recordsLongProfitSpots: recordsLongProfitSpots),
      ),
    );
  }
}

class _2dProfitGraph extends StatelessWidget {
  const _2dProfitGraph({
    Key? key,
    required this.xMinValue,
    required this.xMaxValue,
    required this.recordsShortProfit,
    required this.recordsLongProfit,
    required this.recordsShortProfitSpots,
    required this.recordsLongProfitSpots,
  }) : super(key: key);

  final xMinValue;
  final xMaxValue;
  final List<double> recordsShortProfit;
  final List<double> recordsLongProfit;
  final List<FlSpot> recordsShortProfitSpots;
  final List<FlSpot> recordsLongProfitSpots;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      width: double.infinity,
      height: 200,
      child: LineChart(
        LineChartData(
          minY: xMinValue,
          maxY: xMaxValue,
          minX: 0,
          maxX: recordsShortProfit.length > recordsLongProfit.length
              ? recordsShortProfit.length.toDouble() - 1
              : recordsLongProfit.length.toDouble() - 1,
          // maxX: recordsShortProfit.length > recordsLongProfit.length  ? recordsShortProfit.length : recordsShortProfit.length,
          titlesData: FlTitlesData(show: false),
          gridData: FlGridData(show: true, drawVerticalLine: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            // The red line
            LineChartBarData(
                spots: recordsShortProfitSpots,
                isCurved: true,
                barWidth: 3,
                color: Colors.green),
            // The orange line
            LineChartBarData(
                spots: recordsLongProfitSpots,
                isCurved: true,
                barWidth: 3,
                color: Colors.blue),
            // The blue line
          ],
        ),
      ),
    );
  }
}

class _buttonChangeGraph extends StatefulWidget {
  const _buttonChangeGraph({
    Key? key,
  }) : super(key: key);

  @override
  State<_buttonChangeGraph> createState() => _buttonChangeGraphState();
}

class _buttonChangeGraphState extends State<_buttonChangeGraph> {
  @override
  Widget build(BuildContext context) {
    final showGraph2dProfitProvider =
        Provider.of<ShowGraph2dProfitProvider>(context);

    return IconButton(
        onPressed: () {
          print(Preferences.showProfitGraph);
          setState(() {
            Preferences.showProfitGraph = !Preferences.showProfitGraph;
            showGraph2dProfitProvider.value(Preferences.showProfitGraph);
          });
        },
        icon: Preferences.showProfitGraph
            ? Icon(
                CupertinoIcons.graph_circle,
                color: Colors.blue,
                size: 16,
              )
            : Icon(
                CupertinoIcons.graph_circle_fill,
                color: Colors.blue,
                size: 16,
              ));
  }
}

class ColumnTitlesTransactionsRecordsWidget extends StatelessWidget {
  const ColumnTitlesTransactionsRecordsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Column(
            children: [
              Text('Type',
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600))),
              // const SizedBox(height: 8),

              Text('Trade',
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600))),
            ],
          ),
          const SizedBox(width: 68),
          Column(
            children: [
              Text('Date',
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600))),
              // const SizedBox(height: 8),

              Text('Transaction',
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600))),
            ],
          ),
          const SizedBox(width: 30),
          Column(
            children: [
              Text('QTY',
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600))),
              // const SizedBox(height: 8),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              Text('Price',
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600))),
              // const SizedBox(height: 8),
              Text('USD',
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600))),
            ],
          ),
          const SizedBox(width: 12),
          Column(
            children: [
              Text('Invested',
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600))),
              // const SizedBox(height: 8),

              Text('(not real)',
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600))),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              Text('Percent.',
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600))),
              // const SizedBox(height: 8),

              Text('Profit',
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600))),
            ],
          ),
        ],
      ),
    );
  }
}
