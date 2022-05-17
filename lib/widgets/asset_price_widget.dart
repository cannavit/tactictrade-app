import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../screens/loading_strategy.dart';
import '../services/yahoo_finance_service.dart';
import '../share_preferences/preferences.dart';

class AssetPriceWidget extends StatefulWidget {
  const AssetPriceWidget({
    Key? key,
    required this.symbolName,
  }) : super(key: key);

  final String symbolName;

  @override
  State<AssetPriceWidget> createState() => _AssetPriceWidgetState();
}

class _AssetPriceWidgetState extends State<AssetPriceWidget> {
  @override
  Widget build(BuildContext context) {
    Preferences.assetSelectedInTradingConfig = widget.symbolName;

    final yahooFinance = Provider.of<YahooFinance>(context);

    if (yahooFinance.isLoading) return const LoadingView();

    yahooFinance.reload(Preferences.assetSelectedInTradingConfig);


    final currentPrice = yahooFinance.data['currentPrice'];
    final regularMarketChange = yahooFinance.data['regularMarketChange'];
    final regularMarketChangePercent =
        yahooFinance.data['regularMarketChangePercent'];
    final regularMarketChangeString = regularMarketChange.toStringAsFixed(3);
    final regularMarketChangePercentString =
        regularMarketChangePercent.toStringAsFixed(3);

    final currentPriceString = currentPrice.toStringAsFixed(3);

    

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            child: Text('$currentPriceString',
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    letterSpacing: .4,
                    fontSize: 18,
                    height: 1,
                  ),
                )),
          ),
          Container(
            child: Text(
                regularMarketChange > 0
                    ? '+$regularMarketChangeString'
                    : '$regularMarketChangeString',
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: regularMarketChange > 0 ? Colors.green : Colors.red,
                    letterSpacing: .4,
                    fontSize: 16,
                    height: 1,
                  ),
                )),
          ),
          Text(
              regularMarketChange > 0
                  ? '(+$regularMarketChangePercentString%)'
                  : '($regularMarketChangePercentString%)',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  color: regularMarketChange > 0 ? Colors.green : Colors.red,
                  letterSpacing: .4,
                  fontSize: 14,
                  height: 1,
                ),
              )),
        ],
      ),
    );
  }
}
