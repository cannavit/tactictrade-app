import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/pages/broker/service/broker_service.dart';
import 'package:tactictrade/pages/broker/widgets/broker_capital_widget.dart';
import 'package:tactictrade/pages/broker/widgets/broker_info_widget.dart';
import 'package:tactictrade/screens/loading_strategy.dart';
import 'package:tactictrade/screens/navigation_screen.dart';

class BrokersPages extends StatelessWidget {
  BrokersPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brokerServices = Provider.of<BrokerServices>(context);
    // final themeColors = Theme.of(context);

    if (brokerServices.isLoading) return LoadingStrategies();

    return ChangeNotifierProvider(
      create: (_) => new NavigationModel(),
      child: Scaffold(
        body: ListView.builder(
          itemCount: brokerServices.brokerList.length,
          itemBuilder: (BuildContext context, int index) => cardBrokerWidget(
            broker: brokerServices.brokerList[index]['broker'],
            tagBroker: brokerServices.brokerList[index]['tagBroker'],
            brokerName: brokerServices.brokerList[index]['brokerName'],
            capital: brokerServices.brokerList[index]['capital'],
            tagPrice: brokerServices.brokerList[index]['tagPrice'],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'create_broker');
          },
        ),
      ),
    );
  }
}

class cardBrokerWidget extends StatelessWidget {
  const cardBrokerWidget({
    Key? key,
    required this.broker,
    required this.tagBroker,
    required this.brokerName,
    required this.capital,
    required this.tagPrice,
  }) : super(key: key);

  final String broker;
  final String tagBroker;
  final String brokerName;
  final double capital;
  final String tagPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BrokerInfo(tagBroker: tagBroker, broker: broker),
            BrokerCapitalWidget(
                brokerName: brokerName,
                capital: capital,
                tagBroker: tagBroker,
                tagPrice: tagPrice),
          ],
        ),
      ),
    );
  }
}
