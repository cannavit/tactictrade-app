import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/models/market_data_model.dart';
import 'package:tactictrade/share_preferences/preferences.dart';
import 'package:tactictrade/widgets/grap_candle_stock_volume_painter.dart';

import '../providers/show_graph2d_profit_provider.dart';
import '../providers/strtegy_categories_filter_provider.dart';
import '../providers/timer_categories_provider.dart';
import '../services/market_data_service.dart';
import '../widgets/carousel_list_home.dart';
import 'loading_strategy.dart';

class CustomPaintGraphScreen extends StatelessWidget {
  const CustomPaintGraphScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO connect this with the input of the strategy

    final marketDataService = Provider.of<MarketDataService>(context);

    if (marketDataService.isLoading) return LoadingView();

    final filterList = Provider.of<TimeFilterSelected>(context, listen: true);

    filterList.categories = filterList.dynamicCategoryCarousel('30m');

    final marketDataList = marketDataService.MarketDataList;

    print(marketDataService);

    return Scaffold(
        body: Column(
      children: [
        const SizedBox(height: 100),

        // Candle Graph
        Container(
            height: 195,
            // color: Colors.green,
            child: CustomPaint(
                size: Size.infinite,
                painter: CandleGraphPainter(
                  stockData: marketDataService.MarketDataList,
                ))),
        const SizedBox(height: 5),

        // Volume Graph
        Container(
            height: 30,
            // color: Colors.green,
            child: CustomPaint(
              size: Size.infinite,
              painter: StockVolumePainter(
                stockData: marketDataList,
              ),
            )),

        // Control Dates

        Container(
          height: 25,
          width: double.infinity,
          child: Row(
            children: [
              // Container(
              //   height: 30,
              //   width: 30,
              //   child: _buttonChangeGraph(),
              // ),
              Expanded(
                child: CarouselListHome(
                    categoriesList: filterList,
                    pageCarausel: 'carousel_graph_candle'),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

class CandleGraphPainter extends CustomPainter {
  CandleGraphPainter({required this.stockData})
      : _wickPaint = Paint()..color = Colors.grey,
        _grainPaint = Paint()..color = Colors.green,
        _lossPaint = Paint()..color = Colors.red;

  final List<Candle> stockData;
  final Paint _wickPaint;
  final Paint _grainPaint;
  final Paint _lossPaint;
  final double _wickWidth = 1.0;
  final double _candleWidth = 3.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (stockData == null) return;

    List<Candletick> candleticks = _generateCandlesticks(size);

    // Paint the CandleSticks
    for (Candletick candletick in candleticks) {
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
    }
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

  Candletick(
      {required this.centerX,
      required this.wickHeighY,
      required this.wickLowY,
      required this.candleHightY,
      required this.candleLowY,
      required this.candlePlaint});
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
                CupertinoIcons.add_circled,
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
