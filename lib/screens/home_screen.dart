import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/providers/home_categories_provider.dart';
import 'package:tactictrade/share_preferences/preferences.dart';
import 'package:tactictrade/widgets/carousel_list_home.dart';
import 'navigation_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  Map<String, double> dataMap = {
    'Profits': 300,
    'Loss': 50,
    'Available': 1000,
    'Opened': 300
  };

  List<Color> colorList = [
    Colors.green.shade400,
    Colors.red.shade400,
    Colors.grey.shade400,
    Colors.orange.shade400
  ];

  Widget pieChartTradingAbstract() {
    return PieChart(
        dataMap: dataMap,
        initialAngleInDegree: 10,
        animationDuration: const Duration(microseconds: 900),
        chartType: ChartType.ring,
        // chartType: ChartType.disc,
        chartRadius: 180,
        ringStrokeWidth: 32,
        colorList: colorList,
        chartLegendSpacing: 25.0,
        legendOptions: const LegendOptions(
          legendPosition: LegendPosition.right,
          legendTextStyle: TextStyle(),
        )
        // legendOptions: LengendOp
        );
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context);

    Preferences.selectedAppBarName = 'Home';

    final categoriesList = Provider.of<CategorySelected>(context);

    return ChangeNotifierProvider(
        create: (_) => NavigationModel(),
        child: Scaffold(
          // appBar: GenericAppBar(themeColors, context, 'Home'),
          body: Column(
            children: <Widget>[
              CarouselListHome(categoriesList: categoriesList),
              Container(),
              Divider(color: themeColors.dividerColor),
              SizedBox(
                // color: Colors.black,
                height: 250,
                width: double.infinity,
                child: Column(
                  children: [
                    const Text('Bots Trading Report',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w300)),
                    const SizedBox(height: 25),
                    pieChartTradingAbstract(),
                    const DoughnutChart()
                  ],
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
        ));
  }
}

class DoughnutChart extends StatelessWidget {
  const DoughnutChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
