import 'package:flutter/material.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messagerKey =
      new GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message) {
    final snackBar = SnackBar(
      backgroundColor: Preferences.isDarkmode ? Colors.white : Colors.black,
      content: Container(
          margin: EdgeInsets.symmetric(horizontal: 70),
          child: Text(message,
              style: TextStyle(
                  color:
                      Preferences.isDarkmode ? Colors.black45 : Colors.white70,
                  fontSize: 15))),
    );

    messagerKey.currentState!.showSnackBar(snackBar);
  }
}
