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
import 'editfield_custom.dart';
import 'forms_components/general_input_field.dart';

class PopUpTradeDataStrategy extends StatelessWidget {
  // PopUpTradeDataStrategy(BuildContext context, dynamic dataBroker);

  PopUpTradeDataStrategy({Key? key, this.dataBroker}) : super(key: key);

  final dataBroker;

  @override
  Widget build(BuildContext context) {
    final List<String> itemsData = [
      'minutes',
      'hours',
      'days',
      'weeks',
    ];

    // final dynamic dataBroker;

    final strategyPreferences =
        Provider.of<NewStrategyProvider>(context, listen: false);

    final themeColors = Theme.of(context);
    final aboutCtrl = TextEditingController(text: Preferences.about);
    final webhookCtrl =
        TextEditingController(text: strategyPreferences.selectedWebhook);
    final messageCtrl =
        TextEditingController(text: strategyPreferences.selectedMessage);

    final longQtyCtrl = TextEditingController();
    final longStopLossCtrl = TextEditingController();
    final longTakeProfitCtrl = TextEditingController();

    final shortQtyCtrl = TextEditingController();
    final shortStopLossCtrl = TextEditingController();
    final shortTakeProfitCtrl = TextEditingController();

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
                      themeColors: themeColors,
                      themeProvider: themeProvider,
                      longQtyCtrl: longQtyCtrl,
                      longStopLossCtrl: longStopLossCtrl,
                      longTakeProfitCtrl: longTakeProfitCtrl,
                      shortQtyCtrl: shortQtyCtrl,
                      shortStopLossCtrl: shortStopLossCtrl,
                      shortTakeProfitCtrl: shortTakeProfitCtrl),
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
  const _FormCard({
    Key? key,
    required this.themeColors,
    required this.themeProvider,
    required this.longQtyCtrl,
    required this.longStopLossCtrl,
    required this.longTakeProfitCtrl,
    required this.shortQtyCtrl,
    required this.shortStopLossCtrl,
    required this.shortTakeProfitCtrl,
  }) : super(key: key);

  final ThemeData themeColors;
  final ThemeProvider themeProvider;
  final TextEditingController longQtyCtrl;
  final TextEditingController longStopLossCtrl;
  final TextEditingController longTakeProfitCtrl;
  final TextEditingController shortQtyCtrl;
  final TextEditingController shortStopLossCtrl;
  final TextEditingController shortTakeProfitCtrl;

  @override
  State<_FormCard> createState() => _FormCardState();
}

class _FormCardState extends State<_FormCard> {
  @override
  Widget build(BuildContext context) {
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
                textController: widget.longTakeProfitCtrl,
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
                textController: widget.shortTakeProfitCtrl,
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
                // Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, 'navigation');
              },
              color: Colors.blue,
              child: const Text(
                'Done',
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
  }) : super(key: key);

  final ThemeData themeColors;
  final ThemeProvider themeProvider;
  final IconData iconSwift;
  final Color iconColor;
  final String textSwift;

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
            Preferences.brokerNewUseTradingLong = value;
            // setState(() {});

            setState(() {
              Preferences.brokerNewUseTradingLong = value;
            });
          }),
    );
  }
}

class DropDownBrokers extends StatefulWidget {
  const DropDownBrokers({
    Key? key,
    required this.descriptionCtrl,
  }) : super(key: key);

  final List<dynamic> descriptionCtrl;

  @override
  State<DropDownBrokers> createState() => _DropDownState();
}

class _DropDownState extends State<DropDownBrokers> {
  @override
  Widget build(BuildContext context) {
    var selectedValue;

    return DropdownButtonHideUnderline(
      child: Container(
        // width: MediaQuery.of(context).size.width * 0.3,
        height: 47,
        child: Container(
          //TODO active this
          child: DropdownButton2(
            hint: Row(
              children: [
                const SizedBox(width: 6),
                const Icon(
                  Icons.calendar_view_month_sharp,
                  color: Colors.white60,
                ),
                Text(
                  'Select Time',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ],
            ),
            items: widget.descriptionCtrl
                .map((item) => DropdownMenuItem(
                      value: item['id'],
                      child: Row(
                        children: [
                          const SizedBox(width: 6),

                          // Text(
                          //   item['brokerName'] == null ? "" : item['brokerName'],
                          //   style: const TextStyle(
                          //     fontSize: 17,
                          //   ),
                          // ),
                        ],
                      ),
                    ))
                .toList(),
            value: "",
            onChanged: (value) {
              // if (value is String) {
              //   Preferences.selectedTimeNewStrategy = value;
              // } else {
              //   Preferences.selectedTimeNewStrategy = '';
              // }
              // setState(() {});
            },
            buttonHeight: 40,
            buttonWidth: double.infinity,
            itemHeight: 40,
            buttonDecoration: BoxDecoration(
                // color: Colors.transparent,
                ),
          ),
        ),
      ),
    );
  }
}
