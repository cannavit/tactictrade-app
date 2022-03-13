import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/providers/providers.dart';
import 'package:tactictrade/providers/strategies_categories_provider.dart';
import 'package:tactictrade/screens/navigation_screen.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

import '../services/broker_service.dart';
import '../services/notifications_service.dart';
import '../services/trading_config.dart';
import '../widgets/forms_components/dropdown_custom.dart';
import '../widgets/forms_components/general_input_field.dart';
import 'loading_strategy.dart';

class PopUpMovement extends StatelessWidget {
  const PopUpMovement({
    Key? key,
    required this.titleHeader,
    required this.message,
  }) : super(key: key);

  final String titleHeader;
  final String message;

  @override
  Widget build(BuildContext context) {
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
                child: Text('Continue',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.w700)),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, 'navigation');
                  Preferences.tempStrategyImage = '';
                  Preferences.formValidatorCounter = 0;
                },
              ),
              Expanded(child: Container()),
              TextButton(
                child: Text('Cancel',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.w700)),
                onPressed: () {
                  print('-------- Cancel');
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CreateFollowTrade extends StatelessWidget {
  CreateFollowTrade({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoriesList = Provider.of<CategoryStrategiesSelected>(context);

    final themeColors = Theme.of(context);

    final strategyPreferences =
        Provider.of<NewStrategyProvider>(context, listen: false);

    final tradingConfig = Provider.of<TradingConfig>(context);

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

    return ChangeNotifierProvider(
      create: (_) => new NavigationModel(),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness:
                Preferences.isDarkmode ? Brightness.dark : Brightness.light,
            statusBarBrightness:
                Preferences.isDarkmode ? Brightness.light : Brightness.dark,
          ),
          title: Text('Follow Strategy',
              style: TextStyle(
                  color: themeColors.secondaryHeaderColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w300)),
          backgroundColor: Colors.transparent,
          leading: BackButton(
            color: themeColors.primaryColor,
            onPressed: () {
              Preferences.navigationCurrentPage = 0;
              Preferences.tempStrategyImage = "";
              Preferences.selectedBrokerInFollowStrategy = "{}";
              showDialog(
                context: context,
                builder: (BuildContext context) => PopUpMovement(
                  titleHeader: 'Exit of Follow Strategy',
                  message: 'You are sure of move it? Current data will be lost',
                ),
              );
              //TODO active this.
              // Navigator.pushReplacementNamed(context, 'navigation');
              // Preferences.tempStrategyImage = '';
              // Preferences.formValidatorCounter = 0;
            },
          ),
          actions: [],
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(), // Same efect in Android
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _Form(
                themeColors: themeColors,
                consecutiveLossessAllowedLong: consecutiveLossessAllowedLong,
                consecutiveLossessAllowedShort: consecutiveLossessAllowedShort,
                longQtyCtrl: longQtyCtrl,
                longStopLossCtrl: longStopLossCtrl,
                longTakeProfitCtrl: longTakeProfitCtrl,
                shortQtyCtrl: shortQtyCtrl,
                shortStopLossCtrl: shortStopLossCtrl,
                shortTakeProfitCtrl: shortTakeProfitCtrl,
                strategyId: Preferences.newFollowStrategyId,
                themeProvider: themeProvider,
              ),
              const SizedBox(height: 50),
              // Text Inputs
            ]),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({
    Key? key,
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
    required this.strategyId,
  }) : super(key: key);

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
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final strategyNameCtrl = TextEditingController();
  final symbolCtrl = TextEditingController();
  final timeTradeCtrl = TextEditingController();
  final strategyUrlCtrl = TextEditingController();

  final isPublic = TextEditingController();
  final isActive = TextEditingController();

  final netProfit = TextEditingController();
  final porcentajeProfitable = TextEditingController();
  final maxDrawdown = TextEditingController();
  final profitFactor = TextEditingController();
  final descriptionCtrl = TextEditingController();

  final List<String> itemsData = [
    'minutes',
    'hours',
    'days',
    'weeks',
  ];

  @override
  Widget build(BuildContext context) {
    final tradingConfig = Provider.of<TradingConfig>(context);

    final brokerConfig = Provider.of<BrokerConfig>(context);

    if (brokerConfig.isLoading) return LoadingStrategies();

    var _btnEnabled = false;
    //

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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

        DropDownSelectBroker(brokerList: brokerConfig.BrokerConfigList),

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
            enabled: true,
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
            enabled: true,
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
            enabled: true,
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
            enabled: true,
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
            enabled: true,
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
            enabled: true,
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
            enabled: true,
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
            enabled: true,
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

        const SizedBox(height: 20),
        Container(
          width: 300,
          height: 44,
          child: RaisedButton(
            onPressed: () async {
              final brokerSelected = Preferences.selectedBrokerInFollowStrategy;

              if (Preferences.brokerNewUseTradingLong == false &&
                  Preferences.brokerNewUseTradingShort == false) {
                NotificationsService.showSnackbar(
                    'Plase Select Short or Long Trading');
                return null;
              }

              if (brokerSelected == '{}') {
                NotificationsService.showSnackbar('Select one Broker');
                return null;
              }

              // Controls for Long.
              if (Preferences.brokerNewUseTradingLong) {
                if (widget.longQtyCtrl.text == '') {
                  NotificationsService.showSnackbar('Add your Quantity');
                  return null;
                }
              }

              if (Preferences.brokerNewUseTradingShort) {
                if (widget.shortQtyCtrl.text == '') {
                  NotificationsService.showSnackbar('Add your Quantity ');
                  return null;
                }
              }

              var brokerId = json.decode(brokerSelected);

              final data = {
                'broker': brokerId['id'],
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

              final message = await tradingConfig.create(data);

              if (message == "Trading Parameter created successfully") {
                NotificationsService.showSnackbar(
                    ' 👍 Super Now your bot is connected!!!');
              } else {
                NotificationsService.showSnackbar(message);
                return null;
              }

              Preferences.brokerNewUseTradingLong = false;
              Preferences.brokerNewUseTradingShort = false;

              Navigator.pushReplacementNamed(context, 'navigation');

              tradingConfig.read();
            },
            color: Colors.blue,
            child: const Text(
              'Use This Strategy Trade',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
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
