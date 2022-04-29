import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/share_preferences/preferences.dart';
import 'package:tactictrade/widgets/popup_openlong_trading_config.dart';

import '../../models/trading_config_model.dart';
import '../popup_delete_trading_config.dart';
import '../popup_openshort_trading_config.dart';

class DropdownProfile extends StatefulWidget {
  const DropdownProfile({Key? key, required this.tradingConfigId})
      : super(key: key);

  final int tradingConfigId;
  @override
  State<DropdownProfile> createState() => _DropdownProfileState();
}

class _DropdownProfileState extends State<DropdownProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            customButton: CircleAvatar(
              backgroundColor: Colors.red,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(Preferences.profileImage),
              ),
            ),
            customItemsIndexes: const [3],
            customItemsHeight: 8,
            items: [
              ...MenuItems.firstItems.map(
                (item) => DropdownMenuItem<MenuItem>(
                  value: item,
                  child: MenuItems.buildItem(item),
                ),
              ),
              const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
              ...MenuItems.secondItems.map(
                (item) => DropdownMenuItem<MenuItem>(
                  value: item,
                  child: MenuItems.buildItem(item),
                ),
              ),
            ],
            onChanged: (value) async {
              MenuItems.onChanged(context, value as MenuItem);

              final controlVariable = value.controlVariable;
              Preferences.selectedOptionStrategiesSettings =
                  value.controlVariable;

              if (value.controlVariable == 'settings') {
                Navigator.pushReplacementNamed(context, 'settings');
              }

              if (value.controlVariable == 'notifications') {}

              if (value.controlVariable == 'profile') {
                Navigator.pushReplacementNamed(context, 'profile');
              }

              if (value.controlVariable == 'login') {
                Navigator.pushReplacementNamed(context, 'login');
              }
            },
            itemHeight: 45,
            itemPadding: const EdgeInsets.only(left: 16, right: 16),
            dropdownWidth: 160,
            dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Color.fromARGB(255, 37, 42, 56),
            ),
            dropdownElevation: 8,
            offset: const Offset(0, 8),
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  final String text;
  final IconData icon;
  final Color color;
  final String controlVariable;

  const MenuItem(
      {required this.text,
      required this.icon,
      required this.color,
      required this.controlVariable});
}

class MenuItems {
  static const List<MenuItem> firstItems = [buyShort, buyLong, edit];
  static const List<MenuItem> secondItems = [delete];

  static const edit = MenuItem(
      text: 'Settings',
      icon: CupertinoIcons.settings,
      color: Colors.blue,
      controlVariable: 'settings');

  static const buyShort = MenuItem(
      text: 'Notifications',
      icon: Icons.notifications_none,
      color: Colors.blue,
      controlVariable: 'notifications');

  static const buyLong = MenuItem(
      text: 'Profile',
      icon: CupertinoIcons.profile_circled,
      color: Colors.blue,
      controlVariable: 'profile');

  static const delete = MenuItem(
      text: 'Sign Out',
      icon: CupertinoIcons.arrow_down_left_square,
      color: Colors.blue,
      controlVariable: 'login');

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: item.color, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.buyLong:
        break;
      case MenuItems.buyShort:
        break;
      case MenuItems.edit:
        break;
      case MenuItems.delete:
        break;
    }
  }
}
