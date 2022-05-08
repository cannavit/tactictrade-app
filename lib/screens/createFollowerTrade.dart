import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/models/trading_config_one_model.dart';
import 'package:tactictrade/pages/broker/broker_page.dart';
import 'package:tactictrade/pages/broker/service/broker_service.dart';
import 'package:tactictrade/providers/providers.dart';
import 'package:tactictrade/providers/strategies_categories_provider.dart';
import 'package:tactictrade/providers/trading_config_input_long_provider.dart';
import 'package:tactictrade/screens/navigation_screen.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

import '../providers/select_broker_trading_config_provider.dart';
import '../providers/trading_config_short_provider.dart';
import '../services/broker_service.dart';
import '../services/notifications_service.dart';
import '../services/trading_config.dart';
import '../widgets/forms_components/dropdown_custom.dart';
import '../widgets/forms_components/general_input_field.dart';
import '../widgets/strategyCard.dart';
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
    // Recive arguments.
    final strategyObj = ModalRoute.of(context)?.settings.arguments;
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

  final tradingLongValue = false;
  final tradingShortValue = false;

  final List<String> itemsData = [
    'minutes',
    'hours',
    'days',
    'weeks',
  ];

  @override
  Widget build(BuildContext context) {
    final tradingConfig = Provider.of<TradingConfig>(context);
    final brokerServices = Provider.of<BrokerServices>(context);
    final brokerConfig = Provider.of<BrokerConfig>(context);

    final GlobalKey<ScaffoldMessengerState> messagedKey =
        GlobalKey<ScaffoldMessengerState>();

    final selectBrokerTradingConfig =
        Provider.of<SelectBrokerTradingConfig>(context);

    if (brokerConfig.isLoading) return LoadingStrategies();

    var _btnEnabled = false;
    //

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Add your trading parameters',
            style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                color: Colors.white,
                letterSpacing: .4,
                fontSize: 14,
                height: 1,
              ),
            )),

        const SizedBox(
          height: 20,
        ),

        // Container(
        //   child: const Text(
        //     'Select your broker',
        //     style: TextStyle(fontSize: 15),
        //   ),
        // ),

        // DropDsownSelectBroker(brokerList: brokerConfig.BrokerConfigList),

        const Divider(
          color: Colors.white30,
        ),

        cardBrokerWidget(
          simpleView: true,
          broker: brokerServices.brokerList[selectBrokerTradingConfig.read()]
              ['broker'],
          tagBroker: brokerServices.brokerList[selectBrokerTradingConfig.read()]
              ['tagBroker'],
          brokerName: brokerServices
              .brokerList[selectBrokerTradingConfig.read()]['brokerName'],
          capital: brokerServices.brokerList[selectBrokerTradingConfig.read()]
              ['capital'],
          tagPrice: brokerServices.brokerList[selectBrokerTradingConfig.read()]
              ['tagPrice'],
        ),

        const SizedBox(
          height: 20,
        ),

        _SwiftListLong(
          themeColors: widget.themeColors,
          themeProvider: widget.themeProvider,
          iconColor: Colors.green,
          iconSwift: Icons.arrow_circle_up_outlined,
          textSwift: 'Trading Long',
        ),

        AnimatedOpacity(
          opacity: Provider.of<TradingConfigProvider>(context, listen: true)
                  .long_read()
              ? 1
              : 0,
          duration: Duration(milliseconds: 1000),
          child: _TradingLongForm(widget: widget),
        ),

        // Input quantity, stoploss, isActive, takeProfit, isDynamicStopLoss

        const Divider(
          color: Colors.white30,
        ),

        const SizedBox(
          height: 10,
        ),

        const SizedBox(
          height: 20,
        ),

        _SwiftListShort(
          themeColors: widget.themeColors,
          themeProvider: widget.themeProvider,
          iconColor: Colors.red,
          iconSwift: Icons.arrow_circle_down_rounded,
          textSwift: 'Trading Short',
        ),

        AnimatedOpacity(
          opacity: Provider.of<TradingConfigProvider>(context, listen: true)
                  .short_read()
              ? 1
              : 0,
          duration: Duration(milliseconds: 1000),
          child: _TradingShortForm(widget: widget),
        ),

        const Text(
          '',
          style: TextStyle(fontSize: 15),
        ),

        const SizedBox(height: 20),

        // Select your broker

        Visibility(
          visible: Provider.of<TradingConfigProvider>(context, listen: true)
              .show_buttom(),
          child: Container(
            // width: 340,
            // height: 45,
            constraints: BoxConstraints(minWidth: 150, maxWidth: 300),
            child: RaisedButton(
              elevation: 2,
              highlightElevation: 5,
              color: Colors.blue,
              shape: const StadiumBorder(),
              child: Container(
                width: double.infinity,
                height: 50,
                child: Center(
                  child: Text('Connect Strategy Trading',
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          letterSpacing: .8,
                          fontSize: 16,
                          height: 1,
                        ),
                      )),
                ),
              ),
              onPressed: () async {
                final brokerSelected =
                    Preferences.selectedBrokerInFollowStrategy;

                if (Preferences.brokerNewUseTradingLong == false &&
                    Preferences.brokerNewUseTradingShort == false) {
                  NotificationsService.showSnackbar(
                      context, 'Plase Select Short or Long Trading');
                  return null;
                }

                // Controls for Long.
                if (Preferences.brokerNewUseTradingLong) {
                  if (widget.longQtyCtrl.text == '') {
                    NotificationsService.showSnackbar(
                        context, 'Add your Quantity');
                    return null;
                  }
                }

                if (Preferences.brokerNewUseTradingShort) {
                  if (widget.shortQtyCtrl.text == '') {
                    NotificationsService.showSnackbar(
                        context, 'Add your Quantity ');
                    return null;
                  }
                }

                // var brokerId = Preferences.bro

                final test = widget.strategyId.toInt().toDouble();

                final variables = [
                  'broker',
                  'strategyNews',
                  'quantityUSDLong',
                  'stopLossLong',
                  'takeProfitLong',
                  'quantityUSDShort',
                  'stopLossShort',
                  'takeProfitShort',
                  'consecutiveLossesShort',
                  'consecutiveLossesLong',
                  'useLong',
                  'useShort'
                ];

                final valuesVariables = [
                  Preferences.brokerSelectedPreferences,
                  widget.strategyId,
                  widget.longQtyCtrl.text,
                  widget.longStopLossCtrl.text,
                  widget.longTakeProfitCtrl.text,
                  widget.shortQtyCtrl.text,
                  widget.shortStopLossCtrl.text,
                  widget.shortTakeProfitCtrl.text,
                  widget.consecutiveLossessAllowedShort.text,
                  widget.consecutiveLossessAllowedLong.text,
                  Preferences.brokerNewUseTradingLong,
                  Preferences.brokerNewUseTradingShort,
                ];

                var count = -1;
                final Map<String, dynamic> data = {};
                for (var r in valuesVariables) {
                  count++;

                  if (r != "") {
                    data[variables[count]] = r;
                  }
                }

                final tradingConfigOneObj = TradingConfigOne.fromMap(data);

                final message = await tradingConfig.create(data);

                if (message == "Trading Parameter created successfully") {
                  await NotificationsService.showSnackbar(
                      context, ' 👍 Super Now your bot is connected!!!');
                } else if (message == "This trading_config already exist") {
                  await NotificationsService.showSnackbar(
                      context, 'You are already a follower of this strategy');
                  return null;
                } else {
                  await NotificationsService.showSnackbar(context, message);
                  return null;
                }

                Preferences.brokerNewUseTradingLong = false;
                Preferences.brokerNewUseTradingShort = false;

                Navigator.pushReplacementNamed(context, 'navigation');

                tradingConfig.read();
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _TradingShortForm extends StatelessWidget {
  const _TradingShortForm({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final _Form widget;

  @override
  Widget build(BuildContext context) {
    final tradingConfigInputLongProvider =
        Provider.of<TradingConfigInputLongProvider>(context);

    return Visibility(
      visible: Provider.of<TradingConfigProvider>(context, listen: true)
          .short_read(),
      child: Column(
        children: [
          Row(
            children: [

              _ButtonTradingConfig(
                  buttonText: tradingConfigInputLongProvider
                      .readShort()['buttomSelectorChangeTextShort'],
                  controllerButton: 'useQtyShort',
                  value: tradingConfigInputLongProvider.readShort()['useQtyShort']
                ),
              
              const SizedBox(width: 10),

              Expanded(
                child: GeneralInputField(
                    // enabled: Provider.of<TradingConfigProvider>(context).short_read(),
                    textInputType: TextInputType.number,
                    textController: tradingConfigInputLongProvider.controllerShort(),
                    labelText: tradingConfigInputLongProvider.readShort()['labelTextShort'],
                    hintText:  tradingConfigInputLongProvider.readShort()['hintTextShort'],
                    validatorType: 'useQtyShort',
                    icon: const Icon(
                      Icons.attach_money_outlined,
                      color: Colors.grey,
                    )),
              ),

              const _AddOrSubstract(providerSelector: "short_invest"),

            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [

              _ButtonTradingConfig(
                  buttonText: tradingConfigInputLongProvider
                      .readShort()['buttomSelectorChangeTextPercentageShort'],
                  controllerButton: 'percentageShort',
                  value: tradingConfigInputLongProvider.readShort()['percentageShort']),

              const SizedBox(width: 10),

              Expanded(
                child: GeneralInputField(
                    // enabled: Provider.of<TradingConfigProvider>(context).short_read(),
                    textInputType: TextInputType.number,
                    textController: tradingConfigInputLongProvider.controllerPorcentageShort(),
                    labelText: tradingConfigInputLongProvider.readShort()['labelTextPercentageShort'],
                    hintText: tradingConfigInputLongProvider.readShort()['hintTextPercentageShort'],
                    validatorType: 'porcentaje',
                    icon: const Icon(
                      Icons.stop_outlined,
                      color: Colors.grey,
                    )),
              ),

              const _AddOrSubstract(providerSelector: "short_stop_loss"),

            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              
              _ButtonTradingConfig(
                  buttonText: tradingConfigInputLongProvider
                      .readShort()['buttomSelectorChangeTextTakeprofitShort'],
                  controllerButton: 'takeprofitShort',
                  value: tradingConfigInputLongProvider.readShort()['takeprofitShort']),
              
              const SizedBox(width: 10),

              Expanded(
                child: GeneralInputField(
                    // enabled: Provider.of<TradingConfigProvider>(context).short_read(),
                    textInputType: TextInputType.number,
                    textController: tradingConfigInputLongProvider.controllerDataTakeprofitShort,
                    labelText: tradingConfigInputLongProvider
                        .readShort()['labelTextTakeprofitShort'],
                    hintText: tradingConfigInputLongProvider
                        .readShort()['hintTextTakeprofitShort'],
                    validatorType: 'takeprofitShort',
                    icon: const Icon(
                      Icons.waving_hand_outlined,
                      color: Colors.grey,
                    )),
              ),

              const _AddOrSubstract(providerSelector: "takeprofitShort"),

            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: GeneralInputField(
                    // enabled: Provider.of<TradingConfigProvider>(context).short_read(),
                    textInputType: TextInputType.number,
                    textController: tradingConfigInputLongProvider.controllerLossesAllowedShort,
                    labelText: 'Consecutive Losses Allowed',
                    hintText: 'example: 3',
                    validatorType: 'porcentaje',
                    icon: const Icon(
                      Icons.cut,
                      color: Colors.grey,
                    )),
              ),

              const _AddOrSubstract(providerSelector: "short_losses_allowed"),

            ],
          ),
        ],
      ),
    );
  }
}

class _TradingLongForm extends StatelessWidget {
  const _TradingLongForm({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final _Form widget;

  @override
  Widget build(BuildContext context) {
    final tradingConfigInputLongProvider =
        Provider.of<TradingConfigInputLongProvider>(context);

    final test = tradingConfigInputLongProvider.read();

    return Visibility(
      visible:
          Provider.of<TradingConfigProvider>(context, listen: true).long_read(),
      child: Column(
        children: [
          _TradingConfigQuantity(
              tradingConfigInputLongProvider: tradingConfigInputLongProvider,
              widget: widget),
          const SizedBox(
            height: 20,
          ),



          Row(
            children: [

              _ButtonTradingConfig(
                  buttonText: tradingConfigInputLongProvider
                      .read()['buttomSelectorChangeTextPercentage'],
                  controllerButton: 'percentage',
                  value: tradingConfigInputLongProvider.read()['percentage']),
              
              const SizedBox(width: 10),
             
              Expanded(
                child: GeneralInputField(
                    enabled: Provider.of<TradingConfigProvider>(context,
                            listen: true)
                        .long_read(),
                    textInputType: TextInputType.number,
                    textController:
                        tradingConfigInputLongProvider.controllerPorcentage(),
                    labelText: tradingConfigInputLongProvider
                        .read()['labelTextPercentage'],
                    hintText: tradingConfigInputLongProvider
                        .read()['hintTextPercentage'],
                    validatorType: 'porcentaje',
                    icon: const Icon(
                      Icons.stop_outlined,
                      color: Colors.grey,
                    )),
              ),

              const _AddOrSubstract(providerSelector: "long_stop_loss"),

            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              
              _ButtonTradingConfig(
                  buttonText: tradingConfigInputLongProvider
                      .read()['buttomSelectorChangeTextTakeprofit'],
                  controllerButton: 'takeprofit',
                  value: tradingConfigInputLongProvider.read()['takeprofit']),
              
              const SizedBox(width: 10),

              Expanded(
                child: GeneralInputField(
                    enabled: Provider.of<TradingConfigProvider>(context,
                            listen: true)
                        .long_read(),
                    textInputType: TextInputType.number,
                    textController:
                        tradingConfigInputLongProvider.controllerDataTakeprofit,
                    labelText: tradingConfigInputLongProvider
                        .read()['labelTextTakeprofit'],
                    hintText: tradingConfigInputLongProvider
                        .read()['hintTextTakeprofit'],
                    validatorType: 'takeprofit',
                    icon: const Icon(
                      Icons.waving_hand_outlined,
                      color: Colors.grey,
                    )),
              ),
              const _AddOrSubstract(providerSelector: "takeprofit"),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: GeneralInputField(
                    enabled: Provider.of<TradingConfigProvider>(context,
                            listen: true)
                        .long_read(),
                    textInputType: TextInputType.number,
                    textController:
                        tradingConfigInputLongProvider.controllerLossesAllowed,
                    labelText: 'Consecutive Losses Allowed',
                    hintText: 'example: 3',
                    validatorType: 'porcentaje',
                    icon: const Icon(
                      Icons.cut,
                      color: Colors.grey,
                    )),
              ),
              const _AddOrSubstract(providerSelector: "long_losses_allowed"),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class _TradingConfigQuantity extends StatefulWidget {
  const _TradingConfigQuantity({
    Key? key,
    required this.tradingConfigInputLongProvider,
    required this.widget,
  }) : super(key: key);

  final TradingConfigInputLongProvider tradingConfigInputLongProvider;
  final _Form widget;

  @override
  State<_TradingConfigQuantity> createState() => _TradingConfigQuantityState();
}

class _TradingConfigQuantityState extends State<_TradingConfigQuantity> {
  @override
  Widget build(BuildContext context) {
    // final button

    return Container(
      // color: Color.fromARGB(255, 77, 76, 66),
      child: Row(
        children: [

          _ButtonTradingConfig(

              buttonText: widget.tradingConfigInputLongProvider
                  .read()['buttomSelectorChangeText'],
              controllerButton: 'useQty',
              value: widget.tradingConfigInputLongProvider.read()['useQty']),


          const SizedBox(width: 10),
          Expanded(
            child: GeneralInputField(
                textInputType: TextInputType.number,
                // textController: widget.widget.longQtyCtrl,
                textController:
                    widget.tradingConfigInputLongProvider.controller(),
                labelText:
                    widget.tradingConfigInputLongProvider.read()['labelText'],
                hintText:
                    widget.tradingConfigInputLongProvider.read()['hintText'],
                validatorType: 'useQty',
                icon: const Icon(
                  Icons.attach_money_outlined,
                  color: Colors.grey,
                )),
          ),
          const _AddOrSubstract(providerSelector: "long_invest"),
        ],
      ),
    );
  }
}

class _ButtonTradingConfig extends StatefulWidget {
  const _ButtonTradingConfig({
    Key? key,
    required this.value,
    required this.buttonText,
    required this.controllerButton,
  }) : super(key: key);

  final bool value;
  final String buttonText;
  final String controllerButton;

  @override
  State<_ButtonTradingConfig> createState() => _ButtonTradingConfigState();
}

class _ButtonTradingConfigState extends State<_ButtonTradingConfig> {
  @override
  Widget build(BuildContext context) {
    final tradingConfigInputLongProvider =
        Provider.of<TradingConfigInputLongProvider>(context);

    return Container(
      height: 48,
      width: 60,
      child: RaisedButton(
          elevation: 2,
          highlightElevation: 5,
          color: widget.value ? Colors.blue : Colors.blue.shade600,
          child: Container(
            width: double.infinity,
            // height: 30,
            child: Center(
              child: Text(
                widget.buttonText,
              ),
            ),
          ),
          onPressed: () {

            // Long Config
            if (widget.controllerButton == 'useQty') {
              tradingConfigInputLongProvider.write(!widget.value);
            }

            if (widget.controllerButton == 'percentage') {
              tradingConfigInputLongProvider.percentageWrite(!widget.value);
            }

            if (widget.controllerButton == 'takeprofit') {
              tradingConfigInputLongProvider.takeprofitWrite(!widget.value);
            }

            // Short Config
            if (widget.controllerButton == 'useQtyShort') {
              tradingConfigInputLongProvider.writeShort(!widget.value);
            }

            if (widget.controllerButton == 'percentageShort') {
              tradingConfigInputLongProvider.percentageWriteShort(!widget.value);
            }

            if (widget.controllerButton == 'takeprofitShort') {
              tradingConfigInputLongProvider.takeprofitWriteShort(!widget.value);
            }
            

            setState(() {});
          }),
    );
  }
}

class _AddOrSubstract extends StatefulWidget {
  const _AddOrSubstract({
    Key? key,
    required this.providerSelector,
  }) : super(key: key);

  final String providerSelector;

  @override
  State<_AddOrSubstract> createState() => _AddOrSubstractState();
}

class _AddOrSubstractState extends State<_AddOrSubstract> {
  @override
  Widget build(BuildContext context) {
    final tradingConfigInputLongProvider =
        Provider.of<TradingConfigInputLongProvider>(context);

    return Container(
      width: 25,
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Column(
        children: [
          Container(
            height: 30,
            child: Container(
              child: IconButton(
                  onPressed: () {

                    // Long 
                    
                    if (widget.providerSelector == "long_invest") {
                      tradingConfigInputLongProvider.addOne();
                    }

                    if (widget.providerSelector == 'long_stop_loss') {
                      tradingConfigInputLongProvider.addOnePercentage();
                    }

                    if (widget.providerSelector == 'takeprofit') {
                      tradingConfigInputLongProvider.addOneTakeprofit();
                    }

                    if (widget.providerSelector == 'long_losses_allowed') {
                      tradingConfigInputLongProvider.addOneLossesAllowed();
                    }

                    // Short
                    if (widget.providerSelector == "short_invest") {
                      tradingConfigInputLongProvider.addOneShort();
                    }

                    if (widget.providerSelector == "short_stop_loss") {
                      tradingConfigInputLongProvider.addOnePercentageShort();
                    }

                    if (widget.providerSelector == 'takeprofitShort') {
                      tradingConfigInputLongProvider.addOneTakeprofitShort();
                    }

                    if (widget.providerSelector == 'short_losses_allowed') {
                      tradingConfigInputLongProvider.addOneLossesAllowedShort();
                    }
                    // widget.addOne;
                    setState(() {});
                  },
                  icon: const Icon(
                    CupertinoIcons.arrowtriangle_up_fill,
                    color: Colors.blue,
                    size: 14,
                  )),
            ),
          ),
          Container(
            height: 30,
            child: IconButton(
                onPressed: () {
                  if (widget.providerSelector == "long_invest") {
                    tradingConfigInputLongProvider.subtractOne();
                  }

                  if (widget.providerSelector == 'long_stop_loss') {
                    tradingConfigInputLongProvider.subtractOnePercentage();
                  }

                  if (widget.providerSelector == 'takeprofit') {
                    tradingConfigInputLongProvider.subtractOneTakeprofit();
                  }

                  if (widget.providerSelector == 'long_losses_allowed') {
                    tradingConfigInputLongProvider.subtractOneLossesAllowed();
                  }

                  // Short
                  if (widget.providerSelector == "short_invest") {
                    tradingConfigInputLongProvider.subtractOneShort();
                  }

                  if (widget.providerSelector == 'short_stop_loss') {
                    tradingConfigInputLongProvider.subtractOnePercentageShort();
                  }

                  if (widget.providerSelector == 'takeprofitShort') {
                    tradingConfigInputLongProvider.subtractOneTakeprofitShort();
                  }

                  if (widget.providerSelector == 'short_losses_allowed') {
                    tradingConfigInputLongProvider.subtractOneLossesAllowedShort();
                  }

                  // widget.tradingConfigInputLongProvider.subtractOne();
                  setState(() {});
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

class _SwiftListLong extends StatefulWidget {
  const _SwiftListLong({
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
  State<_SwiftListLong> createState() => _SwiftListLongState();
}

class _SwiftListLongState extends State<_SwiftListLong> {
  @override
  Widget build(BuildContext context) {
    final configTradeProvider = Provider.of<TradingConfigProvider>(context);

    return Container(
      child: SwitchListTile.adaptive(
          activeColor: Colors.blue,
          secondary: Icon(widget.iconSwift, size: 27, color: widget.iconColor),
          value: Preferences.brokerNewUseTradingLong,
          title: Text(widget.textSwift,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
          onChanged: (value) {
            configTradeProvider.long_value(value);
            setState(() {});
          }),
    );
  }
}

class _SwiftListShort extends StatefulWidget {
  const _SwiftListShort({
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
  State<_SwiftListShort> createState() => _SwiftListShortState();
}

class _SwiftListShortState extends State<_SwiftListShort> {
  @override
  Widget build(BuildContext context) {
    final configTradeProvider = Provider.of<TradingConfigProvider>(context);

    return Container(
      child: SwitchListTile.adaptive(
          activeColor: Colors.blue,
          secondary: Icon(widget.iconSwift, size: 27, color: widget.iconColor),
          value: Preferences.brokerNewUseTradingShort,
          title: Text(widget.textSwift,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
          onChanged: (value) {
            configTradeProvider.short_value(value);
            setState(() {});
          }),
    );
  }
}
