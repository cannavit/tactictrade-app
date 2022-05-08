import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tactictrade/share_preferences/preferences.dart';
import 'package:tactictrade/widgets/popUpCreateStrategy.dart';
import 'package:tactictrade/widgets/select_broker_pop_up.dart';

class BrokerCapitalWidget extends StatelessWidget {
  const BrokerCapitalWidget(
      {Key? key,
      required this.brokerName,
      required this.capital,
      required this.tagBroker,
      required this.tagPrice,
      required this.simpleView,
      this.hideEditIcon = false})
      : super(key: key);

  final String brokerName;
  final double capital;
  final String tagBroker;
  final String tagPrice;
  final bool simpleView;
  final bool hideEditIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      color: Colors.transparent,
      // color: Preferences.isDarkmode ? Color(0xffE7EDEF) : Color.fromARGB(255, 24, 26, 27),
      width: MediaQuery.of(context).size.width * (simpleView ? 0.400 : 0.55),
      // width: double.infinity,
      // height: MediaQuery.of(context).size.width * 0.4,
      child: Column(children: [
        Row(
          children: [
            Text(
              brokerName,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  letterSpacing: .5,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ),
            Expanded(child: Container()),
            Visibility(
              maintainSize: false,
              visible: !hideEditIcon,
              child: IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.blue,
                  size: simpleView ? 20 : 20,
                ),
                onPressed: () {
                  if (simpleView == true) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          SelectBrokerPopUp(context),
                    );
                  }

                  // do something
                },
              ),
            ),
          ],
        ),
        Visibility(
          visible: simpleView ? true : true,
          child: Row(
            children: [
              Expanded(child: Container()),
              Text(
                'Available Capital',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: Color(0xff1BC232),
                      letterSpacing: 1.5,
                      fontSize: simpleView ? 13 : 17,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: simpleView ? true : true,
          child: Row(
            children: [
              Expanded(child: Container()),
              Text(
                '$capital',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: Color(0xff1BC232),
                      letterSpacing: 0.7,
                      fontSize: simpleView ? 15 : 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                'USD',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: Color(0xff1BC232),
                      letterSpacing: 0.7,
                      fontSize: simpleView ? 10 : 20,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: simpleView ? false : true,
          child: Row(
            children: [
              Visibility(
                  visible:
                      simpleView ? false : (tagBroker == '' ? false : true),
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
                            fontSize: 15, fontWeight: FontWeight.w300)),
                  )),
              Expanded(child: Container()),
            ],
          ),
        ),
      ]),
    );
  }
}
