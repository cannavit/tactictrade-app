import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/screens/broker_screen.dart';
import 'package:tactictrade/services/broker_service.dart';
import 'package:tactictrade/providers/providers.dart';
import 'package:tactictrade/providers/trading_config_input_long_provider.dart';
import 'package:tactictrade/screens/navigation_screen.dart';
import 'package:tactictrade/share_preferences/preferences.dart';
import 'package:tactictrade/widgets/strategy_symbol_widget.dart';
import 'package:flutter/material.dart';
import '../providers/select_broker_trading_config_provider.dart';
import '../providers/trading_config_short_provider.dart';
import '../services/broker_service.dart';
import '../services/notifications_service.dart';
import '../services/trading_config.dart';
import '../services/trading_config_view.dart';
import '../widgets/add_or_substact_value_widget.dart';
import '../widgets/asset_price_widget.dart';
import '../widgets/button_trading_config_widget.dart';
import '../widgets/forms_components/general_input_field.dart';
import '../widgets/navigations/popup_navigation_back.dart';
import 'loading_strategy.dart';

class CreateFollowTrade extends StatelessWidget {
  const CreateFollowTrade({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dynamic args = ModalRoute.of(context)?.settings.arguments;

    final themeColors = Theme.of(context);

    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return ChangeNotifierProvider(
      create: (_) => NavigationModel(),
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
                builder: (BuildContext context) => const PopUpMovement(
                  titleHeader: 'Exit of Follow Strategy',
                  message: 'You are sure of move it? Current data will be lost',
                ),
              );
            },
          ),
          actions: const [],
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(), // Same efect in Android
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _Form(
                themeColors: themeColors,
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
  final tradingLongValue = false;
  final tradingShortValue = false;

  @override
  Widget build(BuildContext context) {
    final brokerConfig = Provider.of<BrokerConfig>(context);
    final GlobalKey<ScaffoldMessengerState> messagedKey =
        GlobalKey<ScaffoldMessengerState>();
    final selectBrokerTradingConfig =
        Provider.of<SelectBrokerTradingConfig>(context);

    if (brokerConfig.isLoading) return const LoadingView();

    return _widgetTradingConfigForm(
      widget: widget,
      selectBrokerTradingConfig: selectBrokerTradingConfig,
    );
  }
}

class _widgetTradingConfigForm extends StatelessWidget {
  const _widgetTradingConfigForm({
    Key? key,
    required this.widget,
    required this.selectBrokerTradingConfig,
  }) : super(key: key);

  final _Form widget;
  final SelectBrokerTradingConfig selectBrokerTradingConfig;

  @override
  Widget build(BuildContext context) {
    final tradingConfig = Provider.of<TradingConfig>(context);

    final tradingConfigViewService =
        Provider.of<TradingConfigViewService>(context);

    final tradingConfigInputLongProvider =
        Provider.of<TradingConfigInputLongProvider>(context);

    final brokerServices = Provider.of<BrokerServices>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            SizedBox(
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

        const Divider(
          color: Colors.white30,
        ),

        const SizedBox(height: 10),

        Container(
          alignment: AlignmentDirectional.centerStart,
          margin: const EdgeInsets.only(left: 12),
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
          duration: const Duration(milliseconds: 1000),
          child: Visibility(
            visible: Provider.of<TradingConfigProvider>(context, listen: true)
                .longRead(),
            child: TradingConfigInputForm(
                operation: 'long',
                widget: widget,
                tradingConfigViewService: tradingConfigViewService),
          ),
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
          duration: const Duration(milliseconds: 1000),
          child: Visibility(
            visible: Provider.of<TradingConfigProvider>(context, listen: true)
                .shortRead(),
            child: TradingConfigInputForm(
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

            constraints: const BoxConstraints(minWidth: 150, maxWidth: 300),

            child: TextButton(
              // elevation: 2,
              // highlightElevation: 5,
              // color: Colors.blue,
              // shape: const StadiumBorder(),
              child: SizedBox(
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
                  return;
                } else {
                  await NotificationsService.showSnackbar(context, message);
                  return;
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

class TradingConfigInputForm extends StatelessWidget {
  const TradingConfigInputForm({
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
          SizedBox(
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

    return Row(
      children: [
        // Button 'USD' or 'UNIT';
        Visibility(
          visible: customTradingConfigView.showButtonUnit,
          child: ButtonTradingConfigWidget(
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
            textController: widget.tradingConfigInputLongProvider.controller(),
          ),
        ),

        AddOrSubstractValueWidget(
          customTradingConfigView: customTradingConfigView,
        ),
      ],
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
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
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
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
          onChanged: (value) {
            configTradeProvider.shortValue(value);
          }),
    );
  }
}
