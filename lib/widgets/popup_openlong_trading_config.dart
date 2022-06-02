import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/trading_config.dart';

class PopUpOpenTradeLong extends StatelessWidget {
  const PopUpOpenTradeLong({
    Key? key,
    required this.titleHeader,
    required this.message,
    required this.tradingConfigId,
  }) : super(key: key);

  final String titleHeader;
  final String message;
  final int tradingConfigId;

  @override
  Widget build(BuildContext context) {
    final tradingConfig = Provider.of<TradingConfig>(context);

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
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          // textColor: Theme.of(context).primaryColor,
          child: Row(
            children: [
              TextButton(
                child: const Text('Create Trade',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                        fontWeight: FontWeight.w700)),
                onPressed: () {
                  tradingConfig.openLong(tradingConfigId);

                  // tradingConfig.read();
                  Navigator.of(context).pop();
                },
              ),
              Expanded(child: Container()),
              TextButton(
                child: const Text('Cancel',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.w700)),
                onPressed: () {
                  Navigator.of(context).pop();
                  return;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
