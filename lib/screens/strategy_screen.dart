import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tactictrade/screens/loading_strategy.dart';
import 'package:tactictrade/screens/navigation_screen.dart';
import 'package:tactictrade/services/strategies_services.dart';

import '../providers/strategies_categories_provider.dart';
import '../share_preferences/preferences.dart';
import '../widgets/carousel_list_home.dart';
import '../widgets/circle_navigation_button_widget.dart';
import '../widgets/strategy_card.dart';

class StrategyScreen extends StatefulWidget {
  const StrategyScreen(
      {Key? key, required this.strategyProvider, required this.categoriesList})
      : super(key: key);

  final StrategyLoadServices strategyProvider;
  final CategoryStrategiesSelected categoriesList;

  @override
  State<StrategyScreen> createState() => _StrategyScreenState();
}

class _StrategyScreenState extends State<StrategyScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if ((scrollController.position.pixels + 500) >=
          scrollController.position.maxScrollExtent) {
        widget.strategyProvider.loadStrategy();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final strategies = Provider.of<StrategyLoadServices>(context);

    // final strategies = widget.strategyProvider;
    final themeColors = Theme.of(context);
    final categoriesList = widget.categoriesList;

    if (strategies.strategyList.isEmpty) {
      if (strategies.isLoading) {
        // strategies.loadStrategy();
        const LoadingView();
      }
    }

    void addStrategies() {
      final lastId = strategies.strategyList.last;
    }

    RefreshController _refreshController =
        RefreshController(initialRefresh: false);

    return ChangeNotifierProvider(
        create: (_) => NavigationModel(),
        child: Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: 30,
                width: double.infinity,
                child: CarouselListHome(categoriesList: categoriesList),
              ),
              Expanded(
                // height: double.infinity,
                child: SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: true,
                  header: WaterDropHeader(
                    complete: Icon(Icons.check, color: Colors.blue[400]),
                    waterDropColor: Colors.blue.shade400,
                  ),
                  onRefresh: () {
                    Preferences.updateTheStrategies = true;
                    strategies.loadStrategy();
                    setState(() {});
                    _refreshController.refreshCompleted();
                  },
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: scrollController,
                      itemCount: strategies.strategyList.length,
                      itemBuilder: (BuildContext context, int index) =>
                          ProductCard(
                            strategyData: strategies.strategyList[index],
                            historicalData: const [],
                          )),
                ),
              ),
            ],
          ),
          floatingActionButton: const CircleNavigationButtonWidget(),
        ));
  }
}
