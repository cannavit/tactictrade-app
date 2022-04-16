import 'package:flutter/material.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

class BrokerInfo extends StatelessWidget {
  const BrokerInfo({
    Key? key,
    required this.tagBroker,
    required this.broker,
  }) : super(key: key);

  final String tagBroker;
  final String broker;

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Preferences.isDarkmode ? Color(0xffA6B4B9) : Colors.black,
        height: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
                visible: tagBroker == '' ? false : true,
                child: Container(
                  // margin: EdgeInsets.symmetric(vertical: 10),
                  margin: EdgeInsets.only(top: 10, left: 10),
                  decoration: BoxDecoration(
                      // color: PositionData.isActive ? Colors.green[300] : Colors.red,
                      color: Color(0xff37E74F),
                      borderRadius: BorderRadius.circular(100)),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(tagBroker,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w300)),
                )),
            Container(
              height: 110,
              width: 110,
              margin: EdgeInsets.all(10),
              child: Image(
                  image: AssetImage(broker == 'alpaca'
                      ? 'lib/pages/broker/assets/BrokerAlpacaDark.png'
                      : 'lib/pages/broker/assets/TacticTradeBroker.png')),
            )
          ],
        ));
  }
}
