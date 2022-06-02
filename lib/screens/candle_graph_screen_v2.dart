import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/models/market_data_model.dart';
import 'package:tactictrade/share_preferences/preferences.dart';
import 'package:tactictrade/widgets/grap_candle_stock_volume_painter.dart';

import '../providers/show_graph2d_profit_provider.dart';
import '../providers/timer_categories_provider.dart';
import '../services/market_data_service.dart';
import '../widgets/carousel_list_home.dart';
import 'loading_strategy.dart';

class CustomPaintGraphScreen extends StatelessWidget {
  const CustomPaintGraphScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO connect this with the input of the strategy

    return Scaffold(body: CandleGraphCustom());
  }
}

class CandleGraphCustom extends StatelessWidget {
  const CandleGraphCustom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final marketDataService = Provider.of<MarketDataService>(context);

    if (marketDataService.isLoading) return const LoadingView();
    final filterList = Provider.of<TimeFilterSelected>(context, listen: true);

    filterList.categories =
        filterList.dynamicCategoryCarousel(filterList.period);

    final marketDataList = marketDataService.MarketDataList;
    final operations = marketDataService.operations;

    return Container(
      height: 210,
      child: Column(
        children: [
          const SizedBox(height: 10),

          // Candle Graph
          Container(
              height: 145,
              // color: Colors.green,
              child: CustomPaint(
                  size: Size.infinite,
                  painter: CandleGraphPainter(
                    operations: operations,
                    stockData: marketDataList,
                  ))),
          Container(
              height: 40,
              child: GraphVolumeCandle(marketDataList: marketDataList)),

          // Volume Graph
        ],
      ),
    );
  }
}

class GraphVolumeCandle extends StatelessWidget {
  const GraphVolumeCandle({
    Key? key,
    required this.marketDataList,
  }) : super(key: key);

  final List<Candle> marketDataList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // color: Colors.green,
        child: CustomPaint(
      size: Size.infinite,
      painter: StockVolumePainter(
        stockData: marketDataList,
      ),
    ));
  }
}

class CandleGraphPainter extends CustomPainter {
  CandleGraphPainter({required this.stockData, required this.operations})
      : _wickPaint = Paint()..color = Colors.grey,
        _grainPaint = Paint()..color = Colors.green,
        _lossPaint = Paint()..color = Colors.red,
        _longOperationColor = Paint()..color = Color.fromARGB(60, 76, 175, 79);

  final longWindow = new Paint()
    ..color = Colors.green.shade500
    ..style = PaintingStyle.stroke;

  final List<Candle> stockData;
  final List operations;
  final Paint _wickPaint;
  final Paint _grainPaint;
  final Paint _lossPaint;
  final Paint _longOperationColor;

  final double _wickWidth = 1.0;
  final double _candleWidth = 3.0;

  final List<Offset> pointsLine = [];

  final dynamic pointsLineDictionary = {};

  @override
  void paint(Canvas canvas, Size size) {
    if (stockData == null) return;

    List<Candletick> candleticks = _generateCandlesticks(size);

    var count = -1;
    var lineCount = -1;
    // final pathLineLong = new Path();

    // Paint the CandleSticks
    for (Candletick candletick in candleticks) {
      count = count + 1;

      canvas.drawRect(
          Rect.fromLTRB(
              candletick.centerX - (_wickWidth - 2),
              size.height - candletick.wickHeighY,
              candletick.centerX + (_wickWidth / 2),
              size.height - candletick.wickLowY),
          _wickPaint);

      // Paint candle
      canvas.drawRect(
          Rect.fromLTRB(
              candletick.centerX - (_candleWidth - 2),
              size.height - candletick.candleHightY,
              candletick.centerX + (_candleWidth / 2),
              size.height - candletick.candleLowY),
          candletick.candlePlaint);

      var isLongOpen = false;
      var isLongClose = false;

      for (List operation in operations) {
        lineCount = lineCount + 1;
        final initDate = DateTime.parse(operation[2]);

        if (operation[3] == null) {
          // If the operation is open
          final closeDate = DateTime.now();
        } else {
          // The operation is closed
          final closeDate = DateTime.parse(operation[3]);
        }

        final oper = operation[1];

        if (candletick.date.compareTo(initDate) >= 0) {
          isLongOpen = true;
          var dataValue;
          var xPoint;
          var yPoint;

          xPoint = candletick.centerX;

          if (oper == 'long') {
            yPoint = candletick.candleLowY;
          }
          if (oper == 'short') {
            yPoint = candletick.candleLowY;

            // dataValue = Offset(
            //     candletick.centerX - 5, candletick.candleLowY * -1 + 160);
          }

          if (pointsLineDictionary[oper] == null) {
            pointsLineDictionary[oper] = {};
          }
          if (pointsLineDictionary[oper][operation[2]] == null) {
            pointsLineDictionary[oper][operation[2]] = [];
          }
          pointsLineDictionary[oper][operation[2]]
              .add({'x': xPoint, 'y': yPoint});
        } else {
          isLongOpen = false;
        }
      }
    }

    // Plot Buy Line --------------
    // final pointMode = PointMode;

    // for (List operation in operations) {
    //   // print(operation);

    //   if (operation[1] == 'long') {
    //     final pathLong = new Path();
    //     var pointsLineLong = pointsLineDictionary['long'][operation[2]];
    //     // Draw the point for the line
    //     for (final point in pointsLineLong) {
    //       pathLong.lineTo(point['x'], point['y']);
    //     }
    //     // canvas.drawPath(pathLong, _grainPaint);
    //     // canvas.drawPoints(pointMode, pointsLineLong, paintLong);
    //     // canvas.drawPath(pathLineLong, paintLong);
    //   }

    //   // if (operation[1] == 'short') {
    //   //   final pointsLineShort = pointsLineDictionary['short'][operation[2]];
    //   //   // canvas.drawPoints(pointMode, pointsLineShort, paintShort);
    //   // }
    // }

    // canvas.drawPoints(pointMode, pointsLine, paint);
  }

  List<Candletick> _generateCandlesticks(Size availableSpace) {
    // Generate the CandleSticks
    List highList = [];
    List lowList = [];
    for (int i = 0; i < stockData.length; ++i) {
      highList.add(stockData[i].high);
    }

    highList.sort();
    final highValue = highList[highList.length - 1];
    lowList.sort();
    final lowValue = highList[0];

    final pixelsPerWindows = availableSpace.width / (stockData.length + 1);
    final pixelsPerDollar = availableSpace.height / (highValue - lowValue);

    final List<Candletick> candletick = [];
    for (int i = 0; i < stockData.length; ++i) {
      final Candle window = stockData[i];

      candletick.add(Candletick(
          date: window.date,
          centerX: (i + 1) * pixelsPerWindows,
          wickHeighY: (window.high - lowValue) * pixelsPerDollar,
          wickLowY: (window.low - lowValue) * pixelsPerDollar,
          candleHightY: (window.open - lowValue) * pixelsPerDollar,
          candleLowY: (window.close - lowValue) * pixelsPerDollar,
          candlePlaint: stockData[i].isGreen
              ? _grainPaint
              : _lossPaint //TODO add controll value

          ));
    }

    return candletick;
  }

  @override
  bool shouldRepaint(CandleGraphPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(CandleGraphPainter oldDelegate) => false;
}

class Candletick {
  final double centerX;
  final double wickHeighY;
  final double wickLowY;
  final double candleHightY;
  final double candleLowY;
  final Paint candlePlaint;
  final DateTime date;

  Candletick({
    required this.centerX,
    required this.wickHeighY,
    required this.wickLowY,
    required this.candleHightY,
    required this.candleLowY,
    required this.candlePlaint,
    required this.date,
  });
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
            ? const Icon(
                CupertinoIcons.add_circled,
                color: Colors.blue,
                size: 16,
              )
            : const Icon(
                CupertinoIcons.graph_circle_fill,
                color: Colors.blue,
                size: 16,
              ));
  }
}
