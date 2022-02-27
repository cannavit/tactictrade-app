import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/providers/theme_provider.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  // final icon = CupertinoIcons.;

  @override
  Widget build(BuildContext context) {
    final icon = CupertinoIcons.moon_circle;
    final themeColors = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness:
                Preferences.isDarkmode ? Brightness.dark : Brightness.light,
            statusBarBrightness:
                Preferences.isDarkmode ? Brightness.light : Brightness.dark,
          ),
          title: Text('Settings',
              style: TextStyle(
                  color: themeColors.secondaryHeaderColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w300)),
          backgroundColor: Colors.transparent,
          leading: BackButton(
            color: themeColors.primaryColor,
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'profile');
            },
          ),
          actions: [],
          elevation: 0,
        ),
        body: _DarkModeSetting(icon: icon));
  }
}

class _DarkModeSetting extends StatefulWidget {
  const _DarkModeSetting({
    Key? key,
    required this.icon,
  }) : super(key: key);

  final IconData icon;

  @override
  State<_DarkModeSetting> createState() => _DarkModeSettingState();
}

class _DarkModeSettingState extends State<_DarkModeSetting> {
  bool isDarkmode = false;

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context);

    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return SingleChildScrollView(
      child: Column(
        children: [
          SwitchListTile.adaptive(
              secondary:
                  Icon(widget.icon, size: 30, color: themeColors.primaryColor),
              value: Preferences.isDarkmode,
              title: const Text('Light Mode',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
              onChanged: (value) {
                // print(value);

                Preferences.isDarkmode = value;

                value
                    ? themeProvider.setDarkmode()
                    : themeProvider.setLightMode();

                setState(() {});
              })
        ],
      ),
    );
  }
}
