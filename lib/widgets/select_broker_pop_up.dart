import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/pages/broker/broker_page.dart';
import 'package:tactictrade/pages/broker/service/broker_service.dart';
import 'package:tactictrade/providers/new_strategy_provider.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

import '../providers/select_broker_trading_config_provider.dart';
import '../services/trading_config_view.dart';
import 'editfield_custom.dart';

class SelectBrokerPopUp extends StatefulWidget {
  const SelectBrokerPopUp(BuildContext context);

  @override
  State<SelectBrokerPopUp> createState() => _SelectBrokerPopUpState();
}

class _SelectBrokerPopUpState extends State<SelectBrokerPopUp> {
  @override
  Widget build(BuildContext context) {
    final brokerServices = Provider.of<BrokerServices>(context);
    final selectBrokerTradingConfig =
        Provider.of<SelectBrokerTradingConfig>(context);

    final tradingConfigViewService =
        Provider.of<TradingConfigViewService>(context);

    return Container(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
            margin: EdgeInsets.symmetric(vertical: 20),
            width: 100,
            height: 400,
            child: Dialog(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                // insetPadding: EdgeInsets.symmetric(horizontal: 250, vertical: 100),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)),
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                  physics: BouncingScrollPhysics(),
                  itemCount: brokerServices.brokerList.length,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                          child: ClipOval(
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: cardBrokerWidget(
                                simpleView: true,
                                hideEditIcon: true,
                                broker: brokerServices.brokerList[index]
                                    ['broker'],
                                tagBroker: brokerServices.brokerList[index]
                                    ['tagBroker'],
                                brokerName: brokerServices.brokerList[index]
                                    ['brokerName'],
                                capital: brokerServices.brokerList[index]
                                    ['capital'],
                                tagPrice: brokerServices.brokerList[index]
                                    ['tagPrice'],
                              ),
                            ),
                          ),
                          onTap: () async {
                            final brokerServicesObj =
                                brokerServices.brokerList[index];

                            final brokerId = brokerServicesObj['id'];

                            Preferences.configTradeBrokerSelectPreferences =
                                brokerServicesObj['broker'];

                            // tradingConfigViewService.read(brokerServicesObj['broker']);

                            selectBrokerTradingConfig.write(index, brokerId);

                            // Read the new dynamic tradingConfigView
                            tradingConfigViewService.read(
                                brokerServicesObj['broker'],
                                tradingConfigViewService.strategyIdSelected);

                            setState(() {});

                            Navigator.pop(context, true);
                          }),
                )),
          ),
        ),
      ),
    );
  }
}
