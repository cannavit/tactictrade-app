import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

class BrokerCapitalWidget extends StatelessWidget {
  const BrokerCapitalWidget({
    Key? key,
    required this.brokerName,
    required this.capital,
    required this.tagBroker,
    required this.tagPrice,
  }) : super(key: key);

  final String brokerName;
  final double capital;
  final String tagBroker;
  final String tagPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
      color: Colors.transparent,
      // color: Preferences.isDarkmode ? Color(0xffE7EDEF) : Color.fromARGB(255, 24, 26, 27),
      width: MediaQuery.of(context).size.width * 0.545,
      // width: double.infinity,
      // height: MediaQuery.of(context).size.width * 0.4,
      child: Column(children: [
        Row(
          children: [
            Text(
              brokerName,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  // color: Preferences.isDarkmode ? Colors.black87 : Colors.white,
                  letterSpacing: .5,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ),
            Expanded(child: Container()),
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.blue,
                size: 20,
              ),
              onPressed: () {
                // do something
              },
            ),
          ],
        ),
        Row(
          children: [
            Expanded(child: Container()),
            Text(
              'Available Capital',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    color: Color(0xff1BC232),
                    letterSpacing: 1.5,
                    fontSize: 17,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(child: Container()),
            Text(
              '$capital',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    color: Color(0xff1BC232),
                    letterSpacing: 0.7,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Text(
              'USD',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    color: Color(0xff1BC232),
                    letterSpacing: 0.7,
                    fontSize: 20,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Visibility(
                visible: tagBroker == '' ? false : true,
                child: Container(
                  // margin: EdgeInsets.symmetric(vertical: 10),
                  margin: EdgeInsets.only(top: 10, left: 10),
                  decoration: BoxDecoration(
                      // color: PositionData.isActive ? Colors.green[300] : Colors.red,
                      color: Color(0xff008CED),
                      borderRadius: BorderRadius.circular(100)),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(tagPrice,
                      style: TextStyle(
                          // color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w300)),
                )),
            Expanded(child: Container()),
          ],
        ),
      ]),
    );
  }
}
