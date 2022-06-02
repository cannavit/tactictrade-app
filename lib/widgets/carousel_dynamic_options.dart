import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/models/strategy_models.dart';
import 'package:tactictrade/providers/carousel_dynamic_provider.dart';
import 'package:tactictrade/providers/home_categories_provider.dart';
import 'package:tactictrade/services/trading_config.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

import '../services/market_data_service.dart';

class CarouselDynamicOption extends StatelessWidget {
  final dynamic categoriesList;

  const CarouselDynamicOption(
      {Key? key,
      required this.categoriesList,
      this.providerStringFlag = '',
      this.dynamicCarousel = false,
      required this.controllerCandleGraph,
      required this.controllerCandleDefault,
      required this.symbolName, required this.strategyId})
      : super(key: key);

  final String providerStringFlag;
  final bool dynamicCarousel;
  final List<ControllerCandleGraph>? controllerCandleGraph;
  final ControllerCandleGraph? controllerCandleDefault;
  final String symbolName;
  final int strategyId;

  @override
  Widget build(BuildContext context) {
    final categoriesList = Provider.of<CategorySelected>(context);
    final themeColors = Theme.of(context);

    final marketDataService = Provider.of<MarketDataService>(context);

    marketDataService.read(symbolName, controllerCandleDefault!.period,
        controllerCandleDefault!.interval, strategyId);

    final carouselDynamicProvider =
        Provider.of<CarouselDynamicProvider>(context);

    carouselDynamicProvider.controllerCandleDefaultSelected =
        controllerCandleDefault!;

    var categoryData = [];
    if (!dynamicCarousel) {
      categoryData = categoriesList.categories;
    }

    return SizedBox(
      width: double.infinity,
      height: 35,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: controllerCandleGraph?.length,
        itemBuilder: (BuildContext context, int index) {
          final cName = controllerCandleGraph![index].title;
          final interval = controllerCandleGraph![index].interval;
          final period = controllerCandleGraph![index].period;

          return GestureDetector(
            onTap: () {
              print("-------------- SELECTED CAROUSEL DATA:");
              print("NAME: " + cName);
              print("INTERVAL: " + interval);
              print("PERIOD: " + period);

              carouselDynamicProvider.controllerCandleDefaultSelected.title =
                  cName;
              carouselDynamicProvider.controllerCandleDefaultSelected.interval =
                  interval;
              carouselDynamicProvider.controllerCandleDefaultSelected.period =
                  period;

              carouselDynamicProvider.write(
                  carouselDynamicProvider.controllerCandleDefaultSelected);

              marketDataService.read(symbolName, period, interval, strategyId);

              if (providerStringFlag == 'cande_graph_v1') {
                // Preferences.categoryStrategyOwnerSelected =
                //     categoriesList.categories[index].parameterFilter;

              }
            },
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Preferences.isDarkmode
                        ? const Color.fromARGB(0, 0, 0, 0)
                        : const Color.fromARGB(255, 33, 37, 50),
                    borderRadius: BorderRadius.circular(14)),
                child: Row(
                  children: [
                    Text('${cName}',
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: (carouselDynamicProvider
                                          .controllerCandleDefaultSelected
                                          .title ==
                                      cName)
                                  ? themeColors.colorScheme.secondary
                                  : Colors.white,
                              fontSize: 12,
                              fontWeight: (carouselDynamicProvider
                                          .controllerCandleDefaultSelected
                                          .title ==
                                      cName)
                                  ? FontWeight.w600
                                  : FontWeight.w400),
                        )),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
