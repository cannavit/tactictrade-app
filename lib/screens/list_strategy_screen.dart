import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/providers/strategies_categories_provider.dart';
import 'package:tactictrade/screens/navigation_screen.dart';
import 'package:tactictrade/widgets/carousel_list_home.dart';

class ListStrategyScreen extends StatelessWidget {
  ListStrategyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoriesList = Provider.of<CategoryStrategiesSelected>(context);

    final themeColors = Theme.of(context);
    return ChangeNotifierProvider(
      create: (_) => new NavigationModel(),
      child: Scaffold(
        // appBar: GenericAppBar(themeColors, context, 'Strategies'),
        //
        body: Column(children: [
          CarouselListHome(categoriesList: categoriesList),
          const SizedBox(height: 100),
          const Center(
            child: Text('All Strategies dashboard',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 25,
                    fontWeight: FontWeight.w300)),
          ),

          // Strategies Cars.

          // ListView.builder(
          //   itemCount: 10,
          //   itemBuilder: (BuildContext context, int index) => Text('Items $index')),
        ]),
      ),
    );
  }
}
