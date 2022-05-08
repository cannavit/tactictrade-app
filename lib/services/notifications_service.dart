import 'package:flutter/material.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messagedKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(context, String message) {
    //  final snackBar = SnackBar(
    //           content: const Text('Yay! A SnackBar!'),
    //           action: SnackBarAction(
    //             label: 'Undo',
    //             onPressed: () {
    //               // Some code to undo the change.
    //             },
    //           ),
    //         );

    //         ScaffoldMessenger.of(context).showSnackBar(snackBar);

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

    // messagedKey.currentState!.showSnackBar(snackBar);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
