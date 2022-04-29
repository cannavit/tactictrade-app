import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/trading_config.dart';

class PopUpOpenTradeShort extends StatelessWidget {
  const PopUpOpenTradeShort({
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

    return new AlertDialog(
      title: Text(titleHeader),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(message),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: Row(
            children: [
              TextButton(
                child: Text('Create Trade',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                        fontWeight: FontWeight.w700)),
                onPressed: () {
                  tradingConfig.openShort(tradingConfigId);

                  // tradingConfig.read();
                  Navigator.of(context).pop();
                },
              ),
              Expanded(child: Container()),
              TextButton(
                child: Text('Cancel',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.w700)),
                onPressed: () {
                  print('-------- Cancel');
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
