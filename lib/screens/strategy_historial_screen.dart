import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:http/http.dart' as http;

class StrategyHistorialScreen extends StatefulWidget {
  @override
  _StrategyHistorialScreenState createState() => _StrategyHistorialScreenState();
}

class _StrategyHistorialScreenState extends State<StrategyHistorialScreen> {
  List<Candle> candles = [];
  bool themeIsDark = false;

  @override
  void initState() {
    fetchCandles().then((value) {
      setState(() {
        candles = value;
      });
    });
    super.initState();
  }

  Future<List<Candle>> fetchCandles() async {
    final uri = Uri.parse(
        "https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=1h");
    final res = await http.get(uri);
    return (jsonDecode(res.body) as List<dynamic>)
        .map((e) => Candle.fromJson(e))
        .toList()
        .reversed
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeIsDark ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
     
        body: Column(
          children: [
            Container(
              height: 400,
              child: Center(
              child: Candlesticks(
                candles: candles,
              ),
          ),
            ),


          ]
        ),
      ),
    );
  }
}