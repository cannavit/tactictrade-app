import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/trading_config_input_long_provider.dart';



class ButtonTradingConfigWidget extends StatefulWidget {
  const ButtonTradingConfigWidget({
    Key? key,
    required this.customTradingConfigView,
    required this.operation,
  }) : super(key: key);

  final dynamic customTradingConfigView;
  final String operation;

  @override
  State<ButtonTradingConfigWidget> createState() =>
      ButtonTradingConfigWidgetState();
}

class ButtonTradingConfigWidgetState extends State<ButtonTradingConfigWidget> {
  @override
  Widget build(BuildContext context) {
    final tradingConfigInputLongProvider =
        Provider.of<TradingConfigInputLongProvider>(context);

    //? Init Values

    if (tradingConfigInputLongProvider.buttonText[
            widget.customTradingConfigView.dbFieldOne +
                "_${widget.operation}"] ==
        null) {
      tradingConfigInputLongProvider.buttonTextWrite(
          widget.customTradingConfigView.dbFieldOne + "_${widget.operation}",
          widget.customTradingConfigView.buttonOneText);
    }

    if (tradingConfigInputLongProvider.buttonValues[
            widget.customTradingConfigView.dbFieldOne +
                "_${widget.operation}"] ==
        null) {
      tradingConfigInputLongProvider.buttonValuesWrite(
          widget.customTradingConfigView.dbFieldOne + "_${widget.operation}",
          true);
    }

    return SizedBox(
      height: 48,
      width: 70,
      child: TextButton(
          // elevation: 2,
          // highlightElevation: 5,
          // color: tradingConfigInputLongProvider.buttonValuesRead(
          //         widget.customTradingConfigView.dbFieldOne +
          //             "_${widget.operation}")
          //     ? Colors.blue
          //     : Colors.blue.shade600,
          child: SizedBox(
            width: double.infinity,
            // height: 30,
            child: Center(
              child: Text(
                tradingConfigInputLongProvider.buttonTextRead(
                    widget.customTradingConfigView.dbFieldOne +
                        "_${widget.operation}"),
              ),
            ),
          ),
          onPressed: () async {
            final buttonValue = tradingConfigInputLongProvider.buttonValuesRead(
                widget.customTradingConfigView.dbFieldOne +
                    "_${widget.operation}");

            tradingConfigInputLongProvider.buttonValuesWrite(
                widget.customTradingConfigView.dbFieldOne, !buttonValue);

            final test = tradingConfigInputLongProvider.buttonValues[
                widget.customTradingConfigView.dbFieldOne +
                    "_${widget.operation}"];


            if (tradingConfigInputLongProvider.buttonValues[
                widget.customTradingConfigView.dbFieldOne +
                    "_${widget.operation}"]) {
              tradingConfigInputLongProvider.buttonTextWrite(
                  widget.customTradingConfigView.dbFieldOne +
                      "_${widget.operation}",
                  widget.customTradingConfigView.buttonTwoText);
            } else {
              tradingConfigInputLongProvider.buttonTextWrite(
                  widget.customTradingConfigView.dbFieldOne +
                      "_${widget.operation}",
                  widget.customTradingConfigView.buttonOneText);
            }

            // Control button USD/UNIT dynamic using json.
            tradingConfigInputLongProvider.buttonValues[
                    widget.customTradingConfigView.dbFieldOne +
                        "_${widget.operation}"] =
                !tradingConfigInputLongProvider.buttonValues[
                    widget.customTradingConfigView.dbFieldOne +
                        "_${widget.operation}"];

            setState(() {});
          }),
    );
  }
}
