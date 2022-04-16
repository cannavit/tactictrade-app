import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/screens/loading_strategy.dart';
import 'package:tactictrade/screens/navigation_screen.dart';
import 'package:tactictrade/services/strategies_services.dart';
import 'package:tactictrade/widgets/strategyCard.dart';

import '../providers/strategies_categories_provider.dart';
import '../widgets/carousel_list_home.dart';

class StrategyScreen extends StatefulWidget {
  StrategyScreen({Key? key}) : super(key: key);

  @override
  State<StrategyScreen> createState() => _StrategyScreenState();
}

class _StrategyScreenState extends State<StrategyScreen> {
  @override
  Widget build(BuildContext context) {
    final strategies = Provider.of<StrategyLoadServices>(context);
    final ScrollController scrollController = ScrollController();

    final themeColors = Theme.of(context);
    final categoriesList = Provider.of<CategoryStrategiesSelected>(context);

    if (strategies.isLoading) return LoadingStrategies();

    @override
    void initState() {
      super.initState();
      scrollController.addListener(() {
        print(
            '${scrollController.position.pixels}, ${scrollController.position.maxScrollExtent}');
      });
    }

    return ChangeNotifierProvider(
        create: (_) => new NavigationModel(),
        child: Scaffold(
          body: Column(
            children: [
              Container(
                height: 30,
                width: double.infinity,
                child: CarouselListHome(categoriesList: categoriesList),
              ),
              Expanded(
                // height: double.infinity,
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: strategies.strategyList.results.length,
                    itemBuilder: (BuildContext context, int index) =>
                        ProductCard(
                          isOwner: strategies.strategyList.results[index].isOwner,
                          isFollower: strategies.strategyList.results[index].isFollower,
                          isFavorite: strategies.strategyList.results[index].isLiked,
                          isStarred: strategies.strategyList.results[index].isFavorite,
                          urlUser: strategies.strategyList.results[index].owner.profileImage,
                          strategyName: strategies.strategyList.results[index].strategyNews,
                          urlSymbol: strategies.strategyList.results[index].symbolUrl,
                          timeTrade: strategies.strategyList.results[index].timeTrade,
                          mantainerName: strategies.strategyList.results[index].owner.username,
                          urlPusher: strategies.strategyList.results[index].pusher,
                          descriptionText: strategies.strategyList.results[index].description,
                          isActive: strategies.strategyList.results[index].isActive,
                          isVerify: strategies.strategyList.results[index].isVerified,
                          imageNetwork: strategies.strategyList.results[index].postImage,
                          historicalData: [],
                          profitable: strategies.strategyList.results[index].percentageProfitable,
                          maxDrawdown: strategies.strategyList.results[index].maxDrawdown,
                          netProfit: strategies.strategyList.results[index].netProfit,
                          likesNumber: strategies.strategyList.results[index].likesNumber,
                          idStrategy: strategies.strategyList.results[index].id,
                          symbolName: strategies.strategyList.results[index].symbolName
                        )),
              ),
            ],
          ),
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
