import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

AppBar userAppBar(BuildContext context) {
  const icon = CupertinoIcons.settings;
  final themeColors = Theme.of(context);

  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness:
          Preferences.isDarkmode ? Brightness.dark : Brightness.light,
      statusBarBrightness:
          Preferences.isDarkmode ? Brightness.light : Brightness.dark,
    ),
    title: Text(
      'Profile',
      style: TextStyle(color: themeColors.secondaryHeaderColor),
    ),
    leading: BackButton(
      color: themeColors.primaryColor,
      onPressed: () {
        Navigator.pushReplacementNamed(context, 'home');
      },
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      ThemeSwitcher(
        builder: (context) => IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'settings');
            },
            icon: Icon(icon, color: themeColors.primaryColor)),
      )
    ],
  );
}
