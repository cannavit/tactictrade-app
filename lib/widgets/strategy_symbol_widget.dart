import 'package:flutter/material.dart';

import 'circle_image_widget.dart';

class StrategySymbolWidget extends StatelessWidget {
  //
  const StrategySymbolWidget(
      {Key? key,
      required this.urlSymbol,
      required this.urlPusher,
      required this.timeTrade,
      required this.strategyName,
      required this.isActive,
      required this.isVerify,
      required this.symbolName,
      this.hideFlags = false})
      : super(key: key);

  final String urlSymbol;
  final String urlPusher;
  final String timeTrade;
  final String strategyName;
  final bool isActive;
  final bool isVerify;
  final String symbolName;
  final bool hideFlags;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleImage(
                size: 40,
                urlImage: urlSymbol,
              ),
              CircleImage(
                size: 40,
                urlImage: urlPusher,
              ),
            ],
          ),

          const SizedBox(width: 5),
          //
          // Description of the Strategy text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Strategy name',
                  style: TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                      fontWeight: FontWeight.w300)),
              Text(strategyName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Text(timeTrade,
                      style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w300)),
                  const SizedBox(width: 5),
                  Icon(Icons.timer_rounded, color: Colors.white70, size: 14),
                  const SizedBox(width: 5),
                  Text(symbolName,
                      style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          fontWeight: FontWeight.w300))
                ],
              ),
            ],
          ),

          Expanded(child: Container()),

          Visibility(
            visible: !hideFlags,
            child: Row(
              children: [
                Icon(isActive ? Icons.check : Icons.check,
                    color: Color(0xff08BEFB), size: 18),
                Icon(isVerify ? Icons.check : Icons.check,
                    color: Color(0xff08BEFB), size: 18),
              ],
            ),
          ),

          const SizedBox(width: 5),
        ],
      ),
    );
  }
}
