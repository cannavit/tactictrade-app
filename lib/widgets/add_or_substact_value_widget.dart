import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/trading_config_input_long_provider.dart';



class AddOrSubstractValueWidget extends StatefulWidget {
  const AddOrSubstractValueWidget({
    Key? key,
    // required this.providerSelector,
    required this.customTradingConfigView,
  }) : super(key: key);

  // final String providerSelector;
  final dynamic customTradingConfigView;

  @override
  State<AddOrSubstractValueWidget> createState() =>
      AddOrSubstractValueWidgetState();
}

class AddOrSubstractValueWidgetState extends State<AddOrSubstractValueWidget> {
  @override
  Widget build(BuildContext context) {
    final tradingConfigInputLongProvider =
        Provider.of<TradingConfigInputLongProvider>(context);

    return Container(
      width: 25,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Column(
        children: [
          SizedBox(
            height: 30,
            child: Container(
              child: IconButton(
                  onPressed: () {
                    tradingConfigInputLongProvider
                        .addOne(widget.customTradingConfigView);
                  },
                  icon: const Icon(
                    CupertinoIcons.arrowtriangle_up_fill,
                    color: Colors.blue,
                    size: 14,
                  )),
            ),
          ),
          SizedBox(
            height: 30,
            child: IconButton(
                onPressed: () {
                  tradingConfigInputLongProvider
                      .subtractOne(widget.customTradingConfigView);
                },
                icon: const Icon(
                  CupertinoIcons.arrowtriangle_down_fill,
                  color: Colors.blue,
                  size: 14,
                )),
          ),
        ],
      ),
    );
  }
}
