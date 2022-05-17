import 'package:flutter/material.dart';

import '../share_preferences/preferences.dart';



class StatisticsValuesWidgets extends StatelessWidget {
  const StatisticsValuesWidgets({
    Key? key,
    required this.profitable,
    required this.maxDrawdown,
    required this.netProfit,
  }) : super(key: key);

  final double profitable;
  final double maxDrawdown;
  final double netProfit;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Strategy Parameters: ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w300)),
            const SizedBox(height: 5),
            Row(
              children: [
                _cardTextPorcentaje(
                  variable: 'Profitable: ',
                  value: profitable,
                ),
                Expanded(child: Container()),
                _cardTextPorcentaje(
                  variable: 'Max Drawdown: ',
                  value: maxDrawdown,
                  forceColor: Colors.red,
                ),
                Expanded(child: Container()),

                _cardTextPorcentaje(
                  variable: 'Net Profit: ',
                  value: netProfit,
                ),

                // const SizedBox(width: 0 ),
              ],
            )
          ],
        ));
  }
}

class _cardTextPorcentaje extends StatelessWidget {
  const _cardTextPorcentaje(
      {Key? key,
      required this.variable,
      required this.value,
      this.forceColor = null,
      this.titleLevelOne = 'Mantainer'})
      : super(key: key);

  final String variable;
  final double value;
  final Color? forceColor;
  final String titleLevelOne;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          variable,
          style: TextStyle(
              color: Preferences.isDarkmode ? Colors.black87 : Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(width: 5),
        Text(
          '${value}%',
          style: TextStyle(
              color: forceColor != null
                  ? forceColor
                  : value <= 0
                      ? Colors.red
                      : Colors.green,
              fontSize: 14,
              fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
