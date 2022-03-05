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
import 'package:tactictrade/screens/screens.dart';
import 'package:tactictrade/share_preferences/preferences.dart';
import 'package:tactictrade/widgets/social_login/google_login_widget.dart';
import 'services/services.dart';
import 'package:firebase_core/firebase_core.dart';

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
      ChangeNotifierProvider(create: (_) => StrategyLoadServices()),
      ChangeNotifierProvider(create: (_) => StrategySocial()),
      ChangeNotifierProvider(create: (_) => BrokerServices()),
      ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),

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
        'home': (_) => HomeScreen(),
        'login': (_) => const LoginScreen(),
        'positions': (_) => const PositionScreen(),
        'loading': (_) => LoadingScreen(),
        'navigation': (_) => const NavigationScreen(),
        'profile': (_) => const ProfileScreen(),
        'edit_profile': (_) => EditProfileScreen(),
        'settings': (_) => const SettingsScreen(),
        'strategy': (_) => StrategyScreen(),
        'create_strategy': (_) => CreateStrategyScreen(),
        'list_strategies': (_) => ListStrategyScreen(),
        'brokers': (_) => BrokersPages(),
        'create_broker': (_) => const NewBrokerScreen(),
      },
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}
