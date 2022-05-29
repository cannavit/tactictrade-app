import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/providers/theme_provider.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

import '../services/auth_service.dart';
import '../services/settings_services.dart';
import 'loading_strategy.dart';

class SettingsScreen extends StatelessWidget {

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const icon = CupertinoIcons.moon_circle;
    final themeColors = Theme.of(context);

    final settingServices = Provider.of<SettingServices>(context);

    if (settingServices.isLoading) return const LoadingView();

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
              Navigator.pushReplacementNamed(context, 'navigation');
            },
          ),
          actions: const [],
          elevation: 0,
        ),
        body: const _DarkModeSetting(icon: icon));
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

    final authService = Provider.of<AuthService>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final settingsService = Provider.of<SettingServices>(context, listen: true);

    if (settingsService.isLoading) return const LoadingView();

    return SizedBox(
      width: double.infinity,
      // height: 1000,
      child: ListView.builder(
          itemCount: settingsService.settingList.length,
          itemBuilder: (BuildContext context, int index) => Column(
                children: [
                  // Create dynamic title name.
                  const Divider(),
                  Container(
                    child: ListTile(
                      title: Text('${settingsService.settingFamily[index]}'),
                    ),
                  ),

                  // Expanded(
                  // width: double.infinity,
                  // height: 16,

                  _settingSwitch(
                    settingsService: settingsService,
                    themeColors: themeColors,
                    index: index,
                  ),
                ],
              )),
    );
  }
}

class _settingSwitch extends StatefulWidget {
  const _settingSwitch({
    Key? key,
    required this.settingsService,
    required this.themeColors,
    required this.index,
  }) : super(key: key);

  final SettingServices settingsService;
  final ThemeData themeColors;
  final int index;

  @override
  State<_settingSwitch> createState() => _settingSwitchState();
}

class _settingSwitchState extends State<_settingSwitch> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: double.infinity,
      height: 200,

      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: widget
              .settingsService
              .settingList[
                  '${widget.settingsService.settingFamily[widget.index]}']
              .length,
          itemBuilder: (BuildContext context, int index2) => Row(children: [
                Expanded(
                  child: SwitchListTile.adaptive(
                      activeColor: Colors.blue,
                      secondary: Icon(
                          IconData(
                              int.parse(widget
                                  .settingsService
                                  .settingList[
                                      '${widget.settingsService.settingFamily[widget.index]}']
                                      [index2]
                                  .icon
                                  ),
                              fontFamily: 'MaterialIcons'),

                          // Icons.notifications_active_outlined,
                          size: 20,
                          color: widget.themeColors.primaryColor),
                      value: widget
                          .settingsService
                          .settingList[
                              '${widget.settingsService.settingFamily[widget.index]}']
                              [index2]
                          .boolValue,
                      title: Text(
                          widget
                              .settingsService
                              .settingList[
                                  '${widget.settingsService.settingFamily[widget.index]}']
                                  [index2]
                              .setting,
                          style: const TextStyle(fontWeight: FontWeight.w300)),
                      onChanged: (value) {
                        final settings = widget.settingsService.settingList[
                                '${widget.settingsService.settingFamily[widget.index]}']
                            [index2];

                        settings.boolValue = value;

                        widget.settingsService.put(settings);

                        setState(() {});

                        // setState(() {});
                      }),
                ),
              ])),
    );
  }
}
