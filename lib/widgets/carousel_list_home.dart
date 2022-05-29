import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/providers/home_categories_provider.dart';
import 'package:tactictrade/services/strategies_services.dart';
import 'package:tactictrade/services/trading_config.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

import '../services/market_data_service.dart';

class CarouselListHome extends StatelessWidget {
  final dynamic categoriesList;

  const CarouselListHome(
      {Key? key,
      required this.categoriesList,
      this.pageCarausel = '',
      this.dynamicCarousel = false})
      : super(key: key);

  final String pageCarausel;
  final bool dynamicCarousel;

  @override
  Widget build(BuildContext context) {
    final categoriesList = Provider.of<CategorySelected>(context);
    final themeColors = Theme.of(context);
    final marketDataService = Provider.of<MarketDataService>(context);

    var categoryData = [];
    if (!dynamicCarousel) {
      categoryData = categoriesList.categories;
    }
    const period = '1m';
    

    return SizedBox(
      width: double.infinity,
      height: 35,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: categoriesList.categories.length,
        itemBuilder: (BuildContext context, int index) {
          final cName = categoriesList.categories[index].name;
          return GestureDetector(
            onTap: () {
              print(categoriesList.categories[index].name);

              categoriesList.selectedCategory =
                  categoriesList.categories[index].name;

              print(categoriesList.categories[index].parameterFilter);

              if (pageCarausel == '') {
                Preferences.categoryStrategySelected =
                    categoriesList.categories[index].parameterFilter;

                final strategies =
                    Provider.of<StrategyLoadServices>(context, listen: false);

                strategies.loadStrategy();
              }

              if (pageCarausel == 'ownerStrategies') {
                Preferences.categoryStrategyOwnerSelected =
                    categoriesList.categories[index].parameterFilter;

                final tradingConfig =
                    Provider.of<TradingConfig>(context, listen: false);

                tradingConfig.readv2();
              }

              if (pageCarausel == 'carousel_graph_candle') {
                // Preferences.

                marketDataService
                    .read(
                      period,
                      categoriesList.categories[index].parameterFilter);
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
                    // Icon
                    Container(
                        // width: 12,
                        height: categoriesList.categories[index].icon != null
                            ? 30
                            : 0,
                        margin: categoriesList.categories[index].icon != null
                            ? const EdgeInsets.symmetric(horizontal: 14)
                            : const EdgeInsets.symmetric(horizontal: 0),
                        child: categoriesList.categories[index].icon != null
                            ? Icon(
                                categoriesList.categories[index].icon,
                                //Todo add dynamics colors.
                                // color: Colors.black54,
                                color:
                                    (categoriesList.selectedCategory == cName)
                                        ? themeColors.colorScheme.secondary
                                        : const Color(0xff142A32),
                              )
                            : const Icon(null)),

                    Text('${cName[0].toUpperCase()}${cName.substring(1)}',
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: (categoriesList.selectedCategory == cName)
                                  ? themeColors.colorScheme.secondary
                                  : Colors.white,
                              fontSize: 12,
                              fontWeight:
                                  (categoriesList.selectedCategory == cName)
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
