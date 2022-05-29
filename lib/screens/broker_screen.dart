import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tactictrade/services/broker_service.dart';
import 'package:tactictrade/screens/loading_strategy.dart';
import 'package:tactictrade/screens/navigation_screen.dart';
import 'package:tactictrade/widgets/broker_capital_widget.dart';
import 'package:tactictrade/widgets/broker_info_widget.dart';

import '../widgets/circle_navigation_button_widget.dart';

class BrokersPages extends StatelessWidget {
  const BrokersPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brokerServices = Provider.of<BrokerServices>(context);
    // final themeColors = Theme.of(context);
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);

    if (brokerServices.isLoading) {
      // brokerServices.loadBroker();
      const LoadingView();
    }

    return ChangeNotifierProvider(
      create: (_) => NavigationModel(),
      child: Scaffold(
        floatingActionButton: const CircleNavigationButtonWidget(navigationTo: 'create_broker'),
        body: SmartRefresher(
          controller: _refreshController,
          child: _listViewBrokers(brokerServices),
          enablePullDown: true,
          header: WaterDropHeader(
            complete: Icon(
              Icons.check,
              color: Colors.blue[400],
            ),
            waterDropColor: Colors.blue.shade400,
          ),
          onRefresh: () {
            brokerServices.loadBrokerv2();
            _refreshController.refreshCompleted();
          },
        ),
      ),
    );
  }

  ListView _listViewBrokers(BrokerServices brokerServices) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      physics: const BouncingScrollPhysics(),
      itemCount: brokerServices.brokerList.length,
      itemBuilder: (BuildContext context, int index) => cardBrokerWidget(
        broker: brokerServices.brokerList[index]['broker'],
        tagBroker: brokerServices.brokerList[index]['tagBroker'],
        brokerName: brokerServices.brokerList[index]['brokerName'],
        capital: brokerServices.brokerList[index]['capital'],
        tagPrice: brokerServices.brokerList[index]['tagPrice'],
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
    this.simpleView = false,
    this.hideEditIcon = false,
  }) : super(key: key);

  final String broker;
  final String tagBroker;
  final String brokerName;
  final double capital;
  final String tagPrice;
  final bool simpleView;
  final bool hideEditIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: simpleView ? 100 : 160,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BrokerInfo(
                tagBroker: tagBroker, broker: broker, simpleView: simpleView),
            Container(
              child: BrokerCapitalWidget(
                  hideEditIcon: hideEditIcon,
                  simpleView: simpleView,
                  brokerName: brokerName,
                  capital: capital,
                  tagBroker: tagBroker,
                  tagPrice: tagPrice),
            ),
          ],
        ),
      ),
    );
  }
}
