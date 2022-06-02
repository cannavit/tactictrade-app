import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:http/http.dart' as http;







class CandleGraphScreen  extends StatefulWidget {

  const CandleGraphScreen({Key? key}) : super(key: key);

  @override
  State<CandleGraphScreen> createState() => _CandleGraphScreenState();
}

class _CandleGraphScreenState extends State<CandleGraphScreen> {
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
        "https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=1d");
    final res = await http.get(uri);
    return (jsonDecode(res.body) as List<dynamic>)
        .map((e) => Candle.fromJson(e))
        .toList()
        .reversed
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("BTCUSDT 1H Chart"),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  themeIsDark = !themeIsDark;
                });
              },
              icon: Icon(
                themeIsDark
                    ? Icons.wb_sunny_sharp
                    : Icons.nightlight_round_outlined,
              ),
            )
          ],
        ),
        body: Center(
          child: Candlesticks(
            candles: candles,
          ),
        ),
      
    );
  }
}