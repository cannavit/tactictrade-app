

import 'package:flutter/material.dart';

import '../models/market_data_model.dart';





class StockVolumePainter extends CustomPainter {
  StockVolumePainter({required this.stockData})
      : _grainPaint = Paint()..color = Colors.green.withOpacity(0.5),
        _lossPaint = Paint()..color = Colors.red.withOpacity(0.5);

  final List<Candle> stockData;
  final Paint _grainPaint;
  final Paint _lossPaint;

  @override
  void paint(Canvas canvas, Size size) {
    if (stockData.length == null) {
      return;
    }

    List<Bar> bars = _generateBars(size);

    // Get volume max.
    // Paint Bars
    for (Bar bar in bars) {
      canvas.drawRect(
          Rect.fromLTWH(bar.centerX - (bar.width / 2), size.height - bar.heigth,
              bar.width, bar.heigth),
          bar.paint);
    }
  }


  List<Bar> _generateBars(Size availableSpace) {
    // Get maximum bar.

    // Get the maximum volume data.
    final List volume = [];
    // Get Color Red or Green
    final increasingVolume = [];
    var initVolume = 0;
    for (int i = 0; i < stockData.length; ++i) {
      volume.add(stockData[i].volume);

      if (i != 0) {
        //TODO fix this with the right form of volume
        if (stockData[i].volume > stockData[i - 1].volume) {
          increasingVolume.add(true);
        } else {
          increasingVolume.add(false);
        }
      } else {
        increasingVolume.add(false);
      }
    }
    volume.sort();
    final maxVol = volume[volume.length - 1];

    final pixelsPerTimeWindow = availableSpace.width / (stockData.length + 1);
    final pixelsPerStockOrder = availableSpace.height / maxVol;

    List<Bar> bars = [];
    for (int i = 0; i < stockData.length; ++i) {
      final Candle window = stockData[i];

      bars.add(Bar(
          width: 3.0,
          heigth: window.volume * pixelsPerStockOrder,
          centerX: (i + 1) * pixelsPerTimeWindow,
          paint: stockData[i].isGreen  ? _grainPaint : _lossPaint));
    }

    return bars;
  }

  @override
  bool shouldRepaint(StockVolumePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(StockVolumePainter oldDelegate) => false;
}

class Bar {
  Bar({
    required this.width,
    required this.heigth,
    required this.centerX,
    required this.paint,
  });

  final double width;
  final double heigth;
  final double centerX;
  final Paint paint;
}