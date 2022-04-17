import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/models/environments_models.dart';
import 'package:tactictrade/pages/broker/broker_page.dart';
import 'package:tactictrade/pages/broker/service/broker_service.dart';
import 'package:tactictrade/pages/broker/create_broker_screen.dart';
import 'package:tactictrade/providers/home_categories_provider.dart';
import 'package:tactictrade/providers/providers.dart';
import 'package:tactictrade/providers/strtegy_categories_filter_provider.dart';
import 'package:tactictrade/screens/createFollowerTrade.dart';
import 'package:tactictrade/screens/screens.dart';
import 'package:tactictrade/screens/strategy_historial_screen.dart';
import 'package:tactictrade/screens/transactions_records_screen.dart';
import 'package:tactictrade/services/broker_service.dart';
import 'package:tactictrade/services/transactions_record_service.dart';
import 'package:tactictrade/share_preferences/preferences.dart';
import 'package:tactictrade/widgets/forms_components/dropdown_custom.dart';
import 'package:tactictrade/widgets/social_login/google_login_widget.dart';
import 'services/services.dart';
import 'package:firebase_core/firebase_core.dart';

import 'services/trading_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await dotenv.load(fileName: Environment.fileName);

  await dotenv.load(
    fileName: '.env',
  );
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
      ChangeNotifierProvider(create: (_) => StrategyLoadServices(), lazy: false,),
      ChangeNotifierProvider(create: (_) => StrategySocial(),lazy: false,),
      ChangeNotifierProvider(create: (_) => BrokerServices(),lazy: false,),
      ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
      ChangeNotifierProvider(create: (_) => TradingConfig(),lazy: false),
      ChangeNotifierProvider(create: (_) => BrokerConfig()),
      ChangeNotifierProvider(create: (_) => PositionServices()),
      ChangeNotifierProvider(create: (_) => FiltersStrategiesSelected()),
      ChangeNotifierProvider(create: (_) => TransactionRecordsServices()),


      // ChangeNotifierProvider(create: (_) => )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: NotificationsService.messagerKey,
      title: 'Material App',
      initialRoute: 'loading',
      routes: {
        // 'test': (_) => DropDownSelectBroker(),
        // 'strategy_historial': (_) => StrategyHistorialScreen(),
        'home': (_) => HomeScreen(),
        'login': (_) => const LoginScreen(),
        'loading': (_) => LoadingScreen(),
        'navigation': (_) => const NavigationScreen(),
        'profile': (_) => const ProfileScreen(),
        'edit_profile': (_) => EditProfileScreen(),
        'settings': (_) => const SettingsScreen(),
        'strategy': (_) => StrategyScreen(strategyProvider: Provider.of<StrategyLoadServices>(context),),
        'create_strategy': (_) => CreateStrategyScreen(),
        'list_strategies': (_) => ListStrategyScreen(),
        'brokers': (_) => BrokersPages(),
        'create_broker': (_) => const NewBrokerScreen(),
        'create_follow_trade': (_) => CreateFollowTrade(),
        // 'transactions_records': (_) =>TransactionPageScreen(),
      },
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}
