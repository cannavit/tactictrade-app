import 'package:flutter/material.dart';

class BrokerInfo extends StatelessWidget {
  const BrokerInfo({
    Key? key,
    required this.tagBroker,
    required this.broker,
    this.simpleView = false,
  }) : super(key: key);

  final String tagBroker;
  final String broker;
  final bool simpleView;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // color: Preferences.isDarkmode ? Color(0xffA6B4B9) : Colors.black,
        height: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
                visible: simpleView ? false : (tagBroker == '' ? false : true),
                child: Container(
                  // margin: EdgeInsets.symmetric(vertical: 10),
                  margin: const EdgeInsets.only(top: 10, left: 10),
                  decoration: BoxDecoration(
                      // color: PositionData.isActive ? Colors.green[300] : Colors.red,
                      color: const Color(0xff37E74F),
                      borderRadius: BorderRadius.circular(100)),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(tagBroker,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w300)),
                )),
            Container(
              height: simpleView ? 80 : 110,
              width: simpleView ? 80 : 110,
              margin: const EdgeInsets.all(10),
              child: Image(
                  image: AssetImage(broker == 'alpaca'
                      ? 'assets/BrokerAlpacaDark.png'
                      : 'assets/TacticTradeBroker.png')),
            )
          ],
        ));
  }
}
