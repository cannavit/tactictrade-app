import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:avatars/avatars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

import 'forms_components/dropdown_profile.dart';
import 'forms_components/dropdown_trading_config.dart';

AppBar GenericAppBar(
    ThemeData themeColors, BuildContext context, String textNavBar) {
  const icon = CupertinoIcons.settings;

  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness:
          Preferences.isDarkmode ? Brightness.dark : Brightness.light,
      statusBarBrightness:
          Preferences.isDarkmode ? Brightness.light : Brightness.dark,
    ),
    leadingWidth: 700,
    leading: Container(
      margin: EdgeInsets.only(left: 8),
      child: Row(
        children: [
          Container(
              width: 40,
              child: Image(image: AssetImage('assets/ReduceBrokerTacticTradeIconV2.png'))),

        ],
      ),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      Container(
        margin: const EdgeInsets.only(right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [

       Container(
                  // margin: EdgeInsets.symmetric(vertical: 10),
                  margin: EdgeInsets.only(top: 0, left: 1),
                  padding: EdgeInsets.symmetric(horizontal: 1, vertical: 2),

                  decoration: BoxDecoration(
                      // color: Preferences.isPaperTrading ? Color.fromARGB(255, 12, 108, 186) : Color.fromARGB(255, 222, 168, 7),
                      borderRadius: BorderRadius.circular(40)),
                  child: Text(Preferences.isPaperTrading ? 'Paper Trading' : 'Real Trading',
                      style: GoogleFonts.openSans( textStyle:TextStyle(
                          color: Preferences.isPaperTrading ? Color.fromARGB(255, 12, 108, 186) : Color.fromARGB(255, 222, 168, 7),
                          fontSize: 11,
                          fontWeight: FontWeight.w500))),
                ),


                const SizedBox(width: 10),
                // IconButton(
                //   icon: const Icon(
                //     icon,
                //     color: const Color(0xff008CED),
                //     size: 25,
                //   ),
                //   onPressed: () {
                //     // do something
                //     // Navigator.pushReplacementNamed(context, 'settings');
                //   },
                // ),

                Container(
                      color: Colors.red,
                      width: 35,
                      height: 35,
                      child:  DropdownProfile(tradingConfigId: 1,)
                      ),
              ],
            )
          ],
        ),
      ),
    ],
  );
}
