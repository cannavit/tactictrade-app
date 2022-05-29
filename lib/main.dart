import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/providers/providers.dart';
import 'package:tactictrade/screens/screens.dart';
import 'package:tactictrade/share_preferences/preferences.dart';
import 'package:tactictrade/widgets/social_login/google_login_widget.dart';
import 'providers/select_broker_trading_config_provider.dart';
import 'services/services.dart';
import 'package:firebase_core/firebase_core.dart';

import 'services/trading_config.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';





void main() async {
  dotenv.load(
    fileName: '.env',
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PushNotificationService.initializeApp();
  // await dotenv.load(fileName: Environment.fileName);

  WidgetsFlutterBinding.ensureInitialized();

  await Preferences.init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthService()),
      ChangeNotifierProvider(
          create: (_) => ThemeProvider(isDarkmode: Preferences.isDarkmode)),
      ChangeNotifierProvider(create: (_) => CategorySelected()),
      ChangeNotifierProvider(create: (_) => ProfileService()),
      ChangeNotifierProvider(create: (_) => CategoryStrategiesSelected()),
      ChangeNotifierProvider(create: (_) => NewStrategyProvider()),
      ChangeNotifierProvider(create: (_) => StrategyServices()),
      ChangeNotifierProvider(create: (_) => StrategyLoadServices()),
      ChangeNotifierProvider(
        create: (_) => StrategySocial(),
      ),
      ChangeNotifierProvider(
        create: (_) => BrokerServices(),
      ),
      ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
      ChangeNotifierProvider(create: (_) => TradingConfig()),
      ChangeNotifierProvider(create: (_) => BrokerConfig()),
      ChangeNotifierProvider(create: (_) => PositionServices()),
      ChangeNotifierProvider(create: (_) => FiltersStrategiesSelected()),
      ChangeNotifierProvider(create: (_) => TransactionRecordsServices()),
      ChangeNotifierProvider(create: (_) => SettingServices()),
      // ChangeNotifierProvider(create: (_) => SettingServices(), lazy: false),
      ChangeNotifierProvider(create: (_) => CategoryTimerSelected()),
      ChangeNotifierProvider(create: (_) => ShowGraph2dProfitProvider()),
      ChangeNotifierProvider(create: (_) => TradingConfigProvider()),
      ChangeNotifierProvider(create: (_) => SelectBrokerTradingConfig()),
      ChangeNotifierProvider(create: (_) => TradingConfigInputLongProvider()),
      ChangeNotifierProvider(create: (_) => TradingConfigInputLongProvider()),
      ChangeNotifierProvider(create: (_) => TradingConfigViewService()),
      ChangeNotifierProvider(create: (_) => MarketDataService()),
      ChangeNotifierProvider(create: (_) => YahooFinance()),
      ChangeNotifierProvider(create: (_) => TimeFilterSelected()),

      // ChangeNotifierProvider(create: (_) => )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();

    // Push notification services.
    PushNotificationService.messageStreamController.listen((message) {
      // Show snackbar.
      final snackBar = SnackBar(content: Text(message));
      messengerKey.currentState?.showSnackBar(snackBar);

      // Navigation of specific screen
      navigatorKey.currentState?.pushNamed('settings', arguments: message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // scaffoldMessengerKey: NotificationsService.messagerKey,
      scaffoldMessengerKey: messengerKey,

      title: 'Material App',
      initialRoute: 'loading',
      // initialRoute: 'test_custom_paint',

      navigatorKey: navigatorKey,
      routes: {
        // 'test': (_) => DropDownSelectBroker(),
        // 'strategy_historial': (_) => StrategyHistorialScreen(),
        'home': (_) => HomeScreen(),
        'login': (_) => const LoginScreen(),
        'loading': (_) => LoadingScreen(),
        'navigation': (_) => const NavigationScreen(),
        'profile': (_) => const ProfileScreen(),
        'edit_profile': (_) => const EditProfileScreen(),
        'settings': (_) => const SettingsScreen(),
        'strategy': (_) => StrategyScreen(
              strategyProvider: Provider.of<StrategyLoadServices>(context),
              categoriesList: Provider.of<CategoryStrategiesSelected>(context),
            ),
        'create_strategy': (_) => const CreateStrategyScreen(),
        'list_strategies': (_) => const ListStrategyScreen(),
        'brokers': (_) => const BrokersPages(),
        'create_broker': (_) => const NewBrokerScreen(),
        'create_follow_trade': (_) => const CreateFollowTrade(),
        'test_candle': (_) => const CandleGraphScreen(),
        'test_custom_paint': (_) => const CustomPaintGraphScreen()
        // 'test_screen': (_) => ScreenTest(),
        // 'transactions_records': (_) =>TransactionPageScreen(),
      },
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}
