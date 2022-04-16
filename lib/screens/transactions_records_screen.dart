import 'dart:convert';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context);

    final data = json.encode({
      'strategyId': strategyId,
      'body': {"private": false}
    });

    Preferences.transactionRecordsServicesData = data;

    final records = Provider.of<TransactionRecordsServices>(context);

    if (records.isLoading) return LoadingStrategies();


    // Build the data for Graph
    final List<double> recordsShortProfit = [];
    final List<double> recordsLongProfit = [];

    var countElement = -1;
    for (var r in records.recordsList) {
      countElement = countElement + 1;
      if (r['operation'] == 'short') {
        recordsShortProfit.add(r['profit_percentage']);
      } else {
        recordsLongProfit.add(r['profit_percentage']);
      }
    }



    var recordsShortProfitReverser = new List.from(recordsShortProfit.reversed);
    var recordsLongProfitReverser = new List.from(recordsLongProfit.reversed);

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
            statusBarIconBrightness:
                Preferences.isDarkmode ? Brightness.dark : Brightness.light,
            statusBarBrightness:
                Preferences.isDarkmode ? Brightness.light : Brightness.dark,
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

              records.isLoading = true;

              Navigator.pushReplacementNamed(context, 'navigation');
            },
          ),
          actions: [],
          elevation: 0,
        ),
        body: Column(
          children: [
            MantainerCardStrategyWidget(
                mantainerName: mantainerName, urlUser: urlUser),

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
            Container(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                width: double.infinity,
                height: 200,
                child: LineChart(
                  LineChartData(
                    minY: xMinValue,
                    maxY: xMaxValue,
                    minX: 0,
                    maxX: recordsShortProfit.length > recordsLongProfit.length ? recordsShortProfit.length.toDouble() - 1 :  recordsLongProfit.length.toDouble() - 1,
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
                        color: Colors.green

                      ),
                      // The orange line
                      LineChartBarData(
                          spots: recordsLongProfitSpots,
                          isCurved: true,
                          barWidth: 3,
                          color: Colors.blue
                          
                          ),
                      // The blue line
                    ],
                  ),
                ),
              ),
            ),

            // -------------------------------------------------
            const SizedBox(height: 20),

            ColumnTitlesTransactionsRecordsWidget(),

            Expanded(
              // height: double.infinity,
              child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                  itemCount: records.recordsList.length,
                  itemBuilder: (BuildContext context, int index) =>
                      TransactionRecordRowWidget(
                        order: records.recordsList[index]['order'],
                        operation: records.recordsList[index]['operation'],
                        qty_open: records.recordsList[index]['qty_open'],
                        qty_close: records.recordsList[index]['qty_close'],
                        price_open: records.recordsList[index]['price_open'],
                        price_closed: records.recordsList[index]
                            ['price_closed'],
                        base_cost: records.recordsList[index]['base_cost'],
                        close_cost: records.recordsList[index]['close_cost'],
                        amount_open: records.recordsList[index]['amount_open'],
                        amount_close: records.recordsList[index]
                            ['amount_close'],
                        spread: records.recordsList[index]['spread'],
                        create_at: records.recordsList[index]['create_at'],
                        updated_at: records.recordsList[index]['updated_at'],
                        is_winner: records.recordsList[index]['is_winner'],
                        profit: records.recordsList[index]['profit'],
                        profit_percentage: records.recordsList[index]
                            ['profit_percentage'],
                      )),
            ),

            // Create table:

            // Center(child: Text('TransactionPage Screen ${strategyId}')
          ],
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

// order "buy",
// operation "long",
// qty_open 7.5,
// qty_close 7.5,
// price_open 132.7,
// price_closed 132.7,
// base_cost 1000.0,
// close_cost 999.8,
// amount_open 999.8,
// amount_close 999.8,
// spread 0.1675,
// create_at "2022-04-05T08:39:12.632000Z",
// updated_at "2022-04-05T08:39:12.632000Z",
// is_winner false,
// profit -0.16,
// profit_percentage -0.016,
