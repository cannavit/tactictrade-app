import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/screens/bots_page.dart';
import 'package:tactictrade/screens/strategies_owner_screen.dart';
import 'package:tactictrade/screens/strategy_screen.dart';
import 'package:tactictrade/share_preferences/preferences.dart';
import 'package:tactictrade/widgets/custom_navbar_widget.dart';
import 'package:tactictrade/widgets/generic_appbar_widget.dart';

import 'broker_screen.dart';
import '../providers/strategies_categories_provider.dart';
import '../services/strategies_services.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context);

    return ChangeNotifierProvider(
        create: (_) => NavigationModel(),
        child: Scaffold(
            appBar: GenericAppBar(
                themeColors, context, Preferences.selectedAppBarName),
            body: const _Pages(),
            bottomNavigationBar: const CustomNavbar()));
  }
}

class _Pages extends StatelessWidget {
  const _Pages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<NavigationModel>(context);
    final strategies = Provider.of<StrategyLoadServices>(context);
    final categoriesList = Provider.of<CategoryStrategiesSelected>(context);

    return PageView(
      controller: navigationModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        StrategyScreen(
            strategyProvider: strategies, categoriesList: categoriesList),
        const StrategiesOwnerScreen(),
        const BotsScreen(),
        const BrokersPages(),
      ],
    );
  }
}

class NavigationModel with ChangeNotifier {
  // int _currentPage = Preferences.navigationCurrentPage
  int _currentPage = 0;
  final PageController _pageController = PageController();

  // Change Value of the NavBar
  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;
    Preferences.navigationCurrentPage = value;

    _pageController.animateToPage(value,
        duration: const Duration(microseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  // Change selected page
  PageController get pageController => _pageController;
}
