import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/screens/loading_strategy.dart';
import 'package:tactictrade/screens/navigation_screen.dart';
import 'package:tactictrade/services/strategies_services.dart';
import 'package:tactictrade/widgets/strategyCard.dart';

class StrategyScreen extends StatelessWidget {
  StrategyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strategies = Provider.of<StrategyLoadServices>(context);

    // TODO update product part

    final themeColors = Theme.of(context);

    if (strategies.isLoading) return LoadingStrategies();

    return ChangeNotifierProvider(
        create: (_) => new NavigationModel(),
        child: Scaffold(
          // appBar: GenericAppBar(themeColors, context, 'Strategies'),
          body: ListView.builder(
              itemCount: strategies.strategyList.length,
              itemBuilder: (BuildContext context, int index) => ProductCard(
                  isFavorite: strategies.strategyList[index]['is_liked'],
                  isStarred: strategies.strategyList[index]['is_favorite'],
                  urlUser: strategies.strategyList[index]['owner']
                      ['profile_image'],
                  strategyName: strategies.strategyList[index]['strategyNews'],
                  urlSymbol: strategies.strategyList[index]['symbolUrl'],
                  timeTrade: strategies.strategyList[index]['timeTrade'],
                  mantainerName: strategies.strategyList[index]['owner']
                      ['username'],
                  urlPusher: strategies.strategyList[index]['pusher'],
                  descriptionText: strategies.strategyList[index]
                      ['description'],
                  isActive: strategies.strategyList[index]['is_active'],
                  isVerify: strategies.strategyList[index]['is_verified'],
                  imageNetwork: strategies.strategyList[index]['post_image'],
                  historicalData: [],
                  profitable: strategies.strategyList[index]
                      ['percentage_profitable'],
                  maxDrawdown: strategies.strategyList[index]['max_drawdown'],
                  netProfit: strategies.strategyList[index]['net_profit'],
                  likesNumber: strategies.strategyList[index]['likes_number'],
                  idStrategy: strategies.strategyList[index]['id'])),

          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'create_strategy');
            },
          ),
        ));
  }
}
