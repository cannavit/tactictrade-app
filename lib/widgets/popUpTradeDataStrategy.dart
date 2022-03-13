import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/providers/new_strategy_provider.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

import '../pages/broker/service/broker_service.dart';
import '../providers/theme_provider.dart';
import '../screens/create_strategy_screen.dart';
import '../screens/loading_strategy.dart';
import '../services/strategies_services.dart';
import '../services/trading_config.dart';
import 'editfield_custom.dart';
import 'forms_components/general_input_field.dart';

class PopUpTradeDataStrategy extends StatelessWidget {
  // PopUpTradeDataStrategy(BuildContext context, dynamic dataBroker);

  PopUpTradeDataStrategy({Key? key, this.dataBroker, required this.strategyId})
      : super(key: key);

  final dataBroker;
  final int strategyId;

  @override
  Widget build(BuildContext context) {
    final List<String> itemsData = [
      'minutes',
      'hours',
      'days',
      'weeks',
    ];

    // final dynamic dataBroker;
    Preferences.brokerNewUseTradingShort =
        true; //TODO delete this only use for test

    final strategyPreferences =
        Provider.of<NewStrategyProvider>(context, listen: false);

    final tradingConfig = Provider.of<TradingConfig>(context);

    final themeColors = Theme.of(context);
    final aboutCtrl = TextEditingController(text: Preferences.about);
    final webhookCtrl =
        TextEditingController(text: strategyPreferences.selectedWebhook);
    final messageCtrl =
        TextEditingController(text: strategyPreferences.selectedMessage);

    final longQtyCtrl = TextEditingController();
    final longStopLossCtrl = TextEditingController();
    final longTakeProfitCtrl = TextEditingController();
    final consecutiveLossessAllowedLong = TextEditingController();

    final shortQtyCtrl = TextEditingController();
    final shortStopLossCtrl = TextEditingController();
    final shortTakeProfitCtrl = TextEditingController();
    final consecutiveLossessAllowedShort = TextEditingController();

    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Container(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Dialog(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              insetPadding: EdgeInsets.only(top: 40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)),
              child: Stack(
                overflow: Overflow.visible,
                alignment: Alignment.center,
                children: [
                  _FormCard(
                      strategyId: strategyId,
                      themeColors: themeColors,
                      themeProvider: themeProvider,
                      longQtyCtrl: longQtyCtrl,
                      longStopLossCtrl: longStopLossCtrl,
                      longTakeProfitCtrl: longTakeProfitCtrl,
                      shortQtyCtrl: shortQtyCtrl,
                      shortStopLossCtrl: shortStopLossCtrl,
                      shortTakeProfitCtrl: shortTakeProfitCtrl,
                      consecutiveLossessAllowedLong:
                          consecutiveLossessAllowedLong,
                      consecutiveLossessAllowedShort:
                          consecutiveLossessAllowedShort),
                  Positioned(
                      top: -40,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 40,
                        child: ClipRRect(
                          child: Image.asset('assets/MoniIconLogo.png'),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      )),
                ],
              )),
        ),
      ),
    );
  }
}

class _FormCard extends StatefulWidget {
  const _FormCard(
      {Key? key,
      required this.themeColors,
      required this.themeProvider,
      required this.longQtyCtrl,
      required this.longStopLossCtrl,
      required this.longTakeProfitCtrl,
      required this.shortQtyCtrl,
      required this.shortStopLossCtrl,
      required this.shortTakeProfitCtrl,
      required this.consecutiveLossessAllowedShort,
      required this.consecutiveLossessAllowedLong,
      required this.strategyId})
      : super(key: key);

  final ThemeData themeColors;
  final ThemeProvider themeProvider;
  final TextEditingController longQtyCtrl;
  final TextEditingController longStopLossCtrl;
  final TextEditingController longTakeProfitCtrl;
  final TextEditingController shortQtyCtrl;
  final TextEditingController shortStopLossCtrl;
  final TextEditingController shortTakeProfitCtrl;
  final TextEditingController consecutiveLossessAllowedShort;
  final TextEditingController consecutiveLossessAllowedLong;
  final int strategyId;

  @override
  State<_FormCard> createState() => _FormCardState();
}

class _FormCardState extends State<_FormCard> {
  @override
  Widget build(BuildContext context) {
    final tradingConfig = Provider.of<TradingConfig>(context);

    return Container(
      // height: 400,
      width: MediaQuery.of(context).size.width * 0.8,

      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Add your trading parameters',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),

            const SizedBox(
              height: 20,
            ),

            const Text(
              'Select your broker',
              style: TextStyle(fontSize: 15),
            ),

            // DropDownSelectBroker(),
            // TODO add list here

            const Divider(
              color: Colors.white30,
            ),

            const Text(
              'Trading Long Parameters',
              style: TextStyle(fontSize: 15),
            ),

            const SizedBox(
              height: 20,
            ),
            //TODO

            _SwiftList(
              isTradingLong: true,
              themeColors: widget.themeColors,
              themeProvider: widget.themeProvider,
              iconColor: Colors.green,
              iconSwift: Icons.arrow_circle_up_outlined,
              textSwift: 'Trading Long',
            ),

            // Input quantity, stoploss, isActive, takeProfit, isDynamicStopLoss
            GeneralInputField(
                enabled: Preferences.brokerNewUseTradingLong,
                textInputType: TextInputType.number,
                textController: widget.longQtyCtrl,
                labelText: 'Quantity USD',
                hintText: 'example: 435',
                validatorType: 'porcentaje',
                icon: const Icon(
                  Icons.attach_money_outlined,
                  color: Colors.grey,
                )),

            const SizedBox(
              height: 20,
            ),

            GeneralInputField(
                enabled: Preferences.brokerNewUseTradingLong,
                textInputType: TextInputType.number,
                textController: widget.longStopLossCtrl,
                labelText: 'Stop Loss %',
                hintText: 'example: -5',
                validatorType: 'porcentaje',
                icon: const Icon(
                  Icons.stop_outlined,
                  color: Colors.grey,
                )),

            const SizedBox(
              height: 20,
            ),

            GeneralInputField(
                enabled: Preferences.brokerNewUseTradingLong,
                textInputType: TextInputType.number,
                textController: widget.longTakeProfitCtrl,
                labelText: 'Take Profit %',
                hintText: 'example: 10',
                validatorType: 'porcentaje',
                icon: const Icon(
                  Icons.waving_hand_outlined,
                  color: Colors.grey,
                )),

            const SizedBox(
              height: 20,
            ),

            GeneralInputField(
                enabled: Preferences.brokerNewUseTradingLong,
                textInputType: TextInputType.number,
                textController: widget.consecutiveLossessAllowedLong,
                labelText: 'Consecutive Losses Allowed',
                hintText: 'example: 3',
                validatorType: 'porcentaje',
                icon: const Icon(
                  Icons.cut,
                  color: Colors.grey,
                )),

            const SizedBox(
              height: 20,
            ),

            const Divider(
              color: Colors.white30,
            ),

            const SizedBox(
              height: 10,
            ),

            const Text(
              'Trading Short Parameters',
              style: TextStyle(fontSize: 15),
            ),

            const SizedBox(
              height: 20,
            ),
            //TODO

            _SwiftList(
              isTradingLong: false,
              themeColors: widget.themeColors,
              themeProvider: widget.themeProvider,
              iconColor: Colors.red,
              iconSwift: Icons.arrow_circle_down_rounded,
              textSwift: 'Trading Short',
            ),

            // Input quantity, stoploss, isActive, takeProfit, isDynamicStopLoss
            GeneralInputField(
                enabled: Preferences.brokerNewUseTradingShort,
                textInputType: TextInputType.number,
                textController: widget.shortQtyCtrl,
                labelText: 'Quantity USD',
                hintText: 'example: 435',
                validatorType: 'porcentaje',
                icon: const Icon(
                  Icons.attach_money_outlined,
                  color: Colors.grey,
                )),

            const SizedBox(
              height: 20,
            ),

            GeneralInputField(
                enabled: Preferences.brokerNewUseTradingShort,
                textInputType: TextInputType.number,
                textController: widget.shortStopLossCtrl,
                labelText: 'Stop Loss %',
                hintText: 'example: -5',
                validatorType: 'porcentaje',
                icon: const Icon(
                  Icons.stop_outlined,
                  color: Colors.grey,
                )),

            const SizedBox(
              height: 20,
            ),

            GeneralInputField(
                enabled: Preferences.brokerNewUseTradingShort,
                textInputType: TextInputType.number,
                textController: widget.shortTakeProfitCtrl,
                labelText: 'Take Profit %',
                hintText: 'example: 10',
                validatorType: 'porcentaje',
                icon: const Icon(
                  Icons.waving_hand_outlined,
                  color: Colors.grey,
                )),

            const SizedBox(
              height: 20,
            ),

            GeneralInputField(
                enabled: Preferences.brokerNewUseTradingShort,
                textInputType: TextInputType.number,
                textController: widget.consecutiveLossessAllowedShort,
                labelText: 'Consecutive Losses Allowed',
                hintText: 'example: 3',
                validatorType: 'porcentaje',
                icon: const Icon(
                  Icons.cut,
                  color: Colors.grey,
                )),

            const Text(
              '',
              style: TextStyle(fontSize: 15),
            ),

            RaisedButton(
              onPressed: () {
                final data = {
                  'strategyNews': widget.strategyId,
                  'quantityUSDLong': int.parse(widget.longQtyCtrl.text),
                  'stopLossLong': int.parse(widget.longStopLossCtrl.text),
                  'takeProfitLong': int.parse(widget.longTakeProfitCtrl.text),
                  'quantityUSDShort': int.parse(widget.shortQtyCtrl.text),
                  'stopLossShort': int.parse(widget.shortStopLossCtrl.text),
                  'takeProfitShort': int.parse(widget.shortTakeProfitCtrl.text),
                  'consecutiveLossesShort':
                      int.parse(widget.consecutiveLossessAllowedShort.text),
                  'consecutiveLossesLong':
                      int.parse(widget.consecutiveLossessAllowedLong.text),
                  'useLong': Preferences.brokerNewUseTradingLong,
                  'useShort': Preferences.brokerNewUseTradingShort,
                };

                tradingConfig.create(data);

                Navigator.pop(context, true);
                // Navigator.of(context).pop();
                // Navigator.pushReplacementNamed(context, 'navigation');
              },
              color: Colors.blue,
              child: const Text(
                'Use This Strategy Trade',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SwiftList extends StatefulWidget {
  const _SwiftList({
    Key? key,
    required this.themeColors,
    required this.themeProvider,
    required this.iconSwift,
    required this.iconColor,
    required this.textSwift,
    required this.isTradingLong,
  }) : super(key: key);

  final ThemeData themeColors;
  final ThemeProvider themeProvider;
  final IconData iconSwift;
  final Color iconColor;
  final String textSwift;
  final bool isTradingLong;

  @override
  State<_SwiftList> createState() => _SwiftListState();
}

class _SwiftListState extends State<_SwiftList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SwitchListTile.adaptive(
          secondary: Icon(widget.iconSwift, size: 30, color: widget.iconColor),
          value: Preferences.brokerNewUseTradingLong,
          title: Text(widget.textSwift,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
          onChanged: (value) {
            // setState(() {});

            if (widget.isTradingLong) {
              Preferences.brokerNewUseTradingLong = value;
            } else {
              Preferences.brokerNewUseTradingLong = value;
            }
            setState(() {});
          }),
    );
  }
}
