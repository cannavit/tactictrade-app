import 'dart:convert';
// import 'dart:js';
import 'dart:io';

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
import 'package:tactictrade/services/yahoo_finance_service.dart';
import 'package:tactictrade/share_preferences/preferences.dart';
import 'package:tactictrade/widgets/strategy_symbol_widget.dart';
import 'package:yahoofin/yahoofin.dart';

import '../models/trading_config_view.dart';
import '../providers/select_broker_trading_config_provider.dart';
import '../providers/trading_config_short_provider.dart';
import '../services/broker_service.dart';
import '../services/notifications_service.dart';
import '../services/trading_config.dart';
import '../services/trading_config_view.dart';
import '../widgets/asset_price_widget.dart';
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
  CreateFollowTrade({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dynamic args = ModalRoute.of(context)?.settings.arguments;

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

    // final tradingConfigViewService =
    // Provider.of<TradingConfigViewService>(context);

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
                isActive: false,
                isVerify: false,
                strategyName: args['strategyName'],
                symbolName: args['symbolName'],
                timeTrade: args['timeTrade'],
                urlPusher: args['urlPusher'],
                urlSymbol: args['urlSymbol'],
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
    required this.urlSymbol,
    required this.urlPusher,
    required this.timeTrade,
    required this.strategyName,
    required this.isActive,
    required this.isVerify,
    required this.symbolName,
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

  final String urlSymbol;
  final String urlPusher;
  final String timeTrade;
  final String strategyName;
  final bool isActive;
  final bool isVerify;
  final String symbolName;

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final strategyNameCtrl = TextEditingController();
  final symbolCtrl = TextEditingController();
  final timeTradeCtrl = TextEditingController();
  final strategyUrlCtrl = TextEditingController();

  // final isPublic = TextEditingController();
  // final isActive = TextEditingController();

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

  // @override
  // void initState() {
  //   super.initState();

  // };

  @override
  Widget build(BuildContext context) {
    // final ticketData = yahooFinance.getPrice(widget.symbolName);

    final tradingConfig = Provider.of<TradingConfig>(context);
    final brokerServices = Provider.of<BrokerServices>(context);
    final brokerConfig = Provider.of<BrokerConfig>(context);

    final tradingConfigViewService =
        Provider.of<TradingConfigViewService>(context);

    final tradingConfigInputLongProvider =
        Provider.of<TradingConfigInputLongProvider>(context);

    final GlobalKey<ScaffoldMessengerState> messagedKey =
        GlobalKey<ScaffoldMessengerState>();

    final selectBrokerTradingConfig =
        Provider.of<SelectBrokerTradingConfig>(context);

    var _btnEnabled = false;

    if (brokerConfig.isLoading) return const LoadingView();

    return Container(
      child: _widgetTradingConfigForm(
          widget: widget,
          brokerServices: brokerServices,
          selectBrokerTradingConfig: selectBrokerTradingConfig,
          tradingConfigViewService: tradingConfigViewService,
          tradingConfigInputLongProvider: tradingConfigInputLongProvider,
          tradingConfig: tradingConfig),
    );
  }
}

class _widgetTradingConfigForm extends StatelessWidget {
  const _widgetTradingConfigForm({
    Key? key,
    required this.widget,
    required this.brokerServices,
    required this.selectBrokerTradingConfig,
    required this.tradingConfigViewService,
    required this.tradingConfigInputLongProvider,
    required this.tradingConfig,
  }) : super(key: key);

  final _Form widget;
  final BrokerServices brokerServices;
  final SelectBrokerTradingConfig selectBrokerTradingConfig;
  final TradingConfigViewService tradingConfigViewService;
  final TradingConfigInputLongProvider tradingConfigInputLongProvider;
  final TradingConfig tradingConfig;

  @override
  Widget build(BuildContext context) {



    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [

            Container(
              width: 220,
              child: StrategySymbolWidget(
                  isActive: widget.isActive,
                  isVerify: widget.isVerify,
                  strategyName: widget.strategyName,
                  urlSymbol: widget.urlSymbol,
                  timeTrade: widget.timeTrade,
                  urlPusher: widget.urlPusher,
                  symbolName: widget.symbolName,
                  hideFlags: true),
            ),

            Expanded(child: Container()),

            AssetPriceWidget(
                  symbolName: widget.symbolName,
                  ),
          ],
        ),

        const SizedBox(height: 10),

        Container(
          alignment: AlignmentDirectional.centerStart,
          margin: EdgeInsets.only(left: 12),
          child: Text('Add trading parameters',
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                  color: Colors.white,
                  letterSpacing: .4,
                  fontSize: 14,
                  height: 1,
                ),
              )),
        ),

        const SizedBox(
          height: 20,
        ),

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

        //! LONG --------------------------------------------------------------

        Visibility(
          visible: tradingConfigViewService.tradingConfigView.long.length > 0,
          child: _SwiftListLong(
            themeColors: widget.themeColors,
            themeProvider: widget.themeProvider,
            iconColor: Colors.green,
            iconSwift: Icons.arrow_circle_up_outlined,
            textSwift: 'Trading Long',
          ),
        ),

        AnimatedOpacity(
          opacity: Provider.of<TradingConfigProvider>(context, listen: true)
                  .longRead()
              ? 1
              : 0,
          duration: Duration(milliseconds: 1000),
          child: Visibility(
            visible: Provider.of<TradingConfigProvider>(context, listen: true)
                .longRead(),
            child: _TradingLongForm(
                operation: 'long',
                widget: widget,
                tradingConfigViewService: tradingConfigViewService),
          ),
        ),

        // Input quantity, stoploss, isActive, takeProfit, isDynamicStopLoss

        const Divider(
          color: Colors.white30,
        ),

        const SizedBox(
          height: 20,
        ),

        Visibility(
          visible: tradingConfigViewService.tradingConfigView.short.length > 0,
          child: _SwiftListShort(
            themeColors: widget.themeColors,
            themeProvider: widget.themeProvider,
            iconColor: Colors.red,
            iconSwift: Icons.arrow_circle_down_rounded,
            textSwift: 'Trading Short',
          ),
        ),

        AnimatedOpacity(
          opacity: Provider.of<TradingConfigProvider>(context, listen: true)
                  .shortRead()
              ? 1
              : 0,
          duration: Duration(milliseconds: 1000),
          child: Visibility(
            visible: Provider.of<TradingConfigProvider>(context, listen: true)
                .shortRead(),
            child: _TradingLongForm(
                operation: 'short',
                widget: widget,
                tradingConfigViewService: tradingConfigViewService),
          ),
        ),

        const Text(
          '',
          style: TextStyle(fontSize: 15),
        ),

        const SizedBox(height: 20),

        // Select your broker

        Visibility(
          visible: Provider.of<TradingConfigProvider>(context, listen: true)
              .showButtom(),
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
                final requestBody =
                    tradingConfigInputLongProvider.pre_process_body();

                final variables = requestBody['tradingConfigBody'];
                variables.add('broker');
                variables.add('strategyNews');

                final valuesVariables = requestBody['tradingConfigBodyValue'];
                valuesVariables.add(Preferences.brokerSelectedPreferences);
                valuesVariables.add(widget.strategyId);

                var count = -1;
                final Map<String, dynamic> data = {};
                for (var r in valuesVariables) {
                  count++;

                  if (r != "") {
                    data[variables[count]] = r;
                  }
                }

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


class _TradingLongForm extends StatelessWidget {
  const _TradingLongForm({
    Key? key,
    required this.widget,
    required this.tradingConfigViewService,
    this.operation = "long",
  }) : super(key: key);

  final _Form widget;
  final String operation;

  final TradingConfigViewService tradingConfigViewService;

  @override
  Widget build(BuildContext context) {
    final tradingConfigInputLongProvider =
        Provider.of<TradingConfigInputLongProvider>(context);

    return Container(
      child: Column(
        children: [
          Container(
            height: 250,
            child: Container(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  // controller: scrollController,
                  itemCount: operation == "long"
                      ? tradingConfigViewService.tradingConfigView.long.length
                      : tradingConfigViewService.tradingConfigView.short.length,
                  itemBuilder: (BuildContext context, int index) =>
                      _TradingConfigQuantity(
                          tradingConfigData: operation == "long"
                              ? tradingConfigViewService
                                  .tradingConfigView.long[index]
                              : tradingConfigViewService
                                  .tradingConfigView.short[index],
                          tradingConfigInputLongProvider:
                              tradingConfigInputLongProvider,
                          widget: widget,
                          operation: operation)),
            ),
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
    required this.tradingConfigData,
    this.operation = "long",
  }) : super(key: key);

  final TradingConfigInputLongProvider tradingConfigInputLongProvider;
  final _Form widget;
  final dynamic tradingConfigData;
  final String operation;

  @override
  State<_TradingConfigQuantity> createState() => _TradingConfigQuantityState();
}

class _TradingConfigQuantityState extends State<_TradingConfigQuantity> {
  @override
  Widget build(BuildContext context) {
    print(widget.tradingConfigData);

    final customTradingConfigView = widget.tradingConfigData;
    final isButtonOne = true;

    return Container(
      child: Row(
        children: [
          // Button 'USD' or 'UNIT';
          Visibility(
            visible: customTradingConfigView.showButtonUnit,
            child: _ButtonTradingConfig(
                operation: widget.operation,
                customTradingConfigView: customTradingConfigView),
          ),

          Visibility(
              visible: customTradingConfigView.showButtonUnit,
              child: const SizedBox(width: 10)),
          Expanded(
            child: GeneralInputFieldV2(
              operation: widget.operation,
              customTradingConfigView: customTradingConfigView,
              textInputType: TextInputType.number,
              textController:
                  widget.tradingConfigInputLongProvider.controller(),
              validatorType: 'useQty',
            ),
          ),
          _AddOrSubstract(
            customTradingConfigView: customTradingConfigView,
          ),
        ],
      ),
    );
  }
}

class _ButtonTradingConfig extends StatefulWidget {
  const _ButtonTradingConfig({
    Key? key,
    required this.customTradingConfigView,
    required this.operation,
  }) : super(key: key);

  final dynamic customTradingConfigView;
  final String operation;

  @override
  State<_ButtonTradingConfig> createState() => _ButtonTradingConfigState();
}

class _ButtonTradingConfigState extends State<_ButtonTradingConfig> {
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

    return Container(
      height: 48,
      width: 70,
      child: RaisedButton(
          elevation: 2,
          highlightElevation: 5,
          color: tradingConfigInputLongProvider.buttonValuesRead(
                  widget.customTradingConfigView.dbFieldOne +
                      "_${widget.operation}")
              ? Colors.blue
              : Colors.blue.shade600,
          child: Container(
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

            print(test);

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
          }),
    );
  }
}

class _AddOrSubstract extends StatefulWidget {
  const _AddOrSubstract({
    Key? key,
    // required this.providerSelector,
    required this.customTradingConfigView,
  }) : super(key: key);

  // final String providerSelector;
  final dynamic customTradingConfigView;

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
          Container(
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
            configTradeProvider.longValue(value);
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
            configTradeProvider.shortValue(value);
          }),
    );
  }
}
