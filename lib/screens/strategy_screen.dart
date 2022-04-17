import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/models/strategy_models.dart';
import 'package:tactictrade/screens/loading_strategy.dart';
import 'package:tactictrade/screens/navigation_screen.dart';
import 'package:tactictrade/services/strategies_services.dart';
import 'package:tactictrade/widgets/strategyCard.dart';

import '../providers/strategies_categories_provider.dart';
import '../widgets/carousel_list_home.dart';

class StrategyScreen extends StatefulWidget {
  StrategyScreen({Key? key, required this.strategyProvider}) : super(key: key);

  final StrategyLoadServices strategyProvider;
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
        print("Load New Values");
        print("Load New Values");

        print("Load New Values");
        print("Load New Values");
        print("Load New Values");
        print("Load New Values");


        widget.strategyProvider.loadStrategy();
        // widget.

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final strategies = Provider.of<StrategyLoadServices>(context);

    final strategies = widget.strategyProvider;

    final themeColors = Theme.of(context);
    final categoriesList = Provider.of<CategoryStrategiesSelected>(context);

    // if (strategies.isLoading) return LoadingStrategies();

    void addStrategies() {
      final lastId = strategies.strategyList.last;
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
                    physics: const BouncingScrollPhysics(),
                    controller: scrollController,
                    itemCount: strategies.strategyList.length,
                    itemBuilder: (BuildContext context, int index) =>
                        ProductCard(
                            isOwner: strategies.strategyList[index].isOwner,
                            isFollower:
                                strategies.strategyList[index].isFollower,
                            isFavorite: strategies.strategyList[index].isLiked,
                            isStarred:
                                strategies.strategyList[index].isFavorite,
                            urlUser: strategies
                                .strategyList[index].owner.profileImage,
                            strategyName:
                                strategies.strategyList[index].strategyNews,
                            urlSymbol: strategies.strategyList[index].symbolUrl,
                            timeTrade: strategies.strategyList[index].timeTrade,
                            mantainerName:
                                strategies.strategyList[index].owner.username,
                            urlPusher: strategies.strategyList[index].pusher,
                            descriptionText:
                                strategies.strategyList[index].description,
                            isActive: strategies.strategyList[index].isActive,
                            isVerify: strategies.strategyList[index].isVerified,
                            imageNetwork:
                                strategies.strategyList[index].postImage,
                            historicalData: [],
                            profitable: strategies
                                .strategyList[index].percentageProfitable,
                            maxDrawdown:
                                strategies.strategyList[index].maxDrawdown,
                            netProfit: strategies.strategyList[index].netProfit,
                            likesNumber:
                                strategies.strategyList[index].likesNumber,
                            idStrategy: strategies.strategyList[index].id,
                            symbolName:
                                strategies.strategyList[index].symbolName)),
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
