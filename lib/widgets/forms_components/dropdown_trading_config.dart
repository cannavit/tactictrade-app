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

class DropdownTradingConfig extends StatefulWidget {
  const DropdownTradingConfig({Key? key, required this.tradingConfigId})
      : super(key: key);

  final int tradingConfigId;
  @override
  State<DropdownTradingConfig> createState() => _DropdownTradingConfigState();
}

class _DropdownTradingConfigState extends State<DropdownTradingConfig> {
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            customButton: const Icon(
              // Icons.settings_backup_restore_sharp,
              CupertinoIcons.settings,
              // Icons.control_camera_sharp,

              size: 20,
              color: Colors.blue,
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

              if (value.controlVariable == 'delete') {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      PopUpDeleteTradingConfigSecure(
                    tradingConfigId: widget.tradingConfigId,
                    titleHeader: 'Are you sure to delete this strategy?',
                    message:
                        ' ⛔️ We will not be able to close trades opened by you. In case of continuing make sure to close your position manually.',
                  ),
                );
              }

              if (value.controlVariable == 'openLong') {
                
                  await showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      PopUpOpenTradeLong(
                    tradingConfigId: widget.tradingConfigId,
                    titleHeader: 'Open Long Trade',
                    message:
                        ' Do you want create Long trade',
                  ),
                );
              }

              if (value.controlVariable == 'openShort') {
                
                  await showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      PopUpOpenTradeShort(
                    tradingConfigId: widget.tradingConfigId,
                    titleHeader: 'Open Short Trade',
                    message:
                        ' Do you want create Short trade',
                  ),
                );
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
      text: 'Edit',
      icon: Icons.edit,
      color: Colors.white,
      controlVariable: 'edit');

  static const buyShort = MenuItem(
      text: 'Open Short',
      icon: CupertinoIcons.arrow_down_right,
      color: Colors.white,
      controlVariable: 'openShort');

  static const buyLong = MenuItem(
      text: 'Open Long',
      icon: CupertinoIcons.arrow_up_right,
      color: Colors.white,
      controlVariable: 'openLong');

  static const delete = MenuItem(
      text: 'Delete',
      icon: Icons.delete_forever_outlined,
      color: Colors.red,
      controlVariable: 'delete');

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
