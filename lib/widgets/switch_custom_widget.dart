import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/providers/providers.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

class SwitchCustom extends StatefulWidget {
  final String swithText;
  final IconData icon;
  final Color color;

  const SwitchCustom({
    Key? key,
    required this.themeColors,
    required this.swithText,
    required this.icon,
    this.color = Colors.white,
  }) : super(key: key);

  final ThemeData themeColors;

  @override
  State<SwitchCustom> createState() => _SwitchCustomState();
}

class _SwitchCustomState extends State<SwitchCustom> {
  @override
  Widget build(BuildContext context) {
    final newStrategy = Provider.of<NewStrategyProvider>(context);

    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: SwitchListTile.adaptive(
        secondary: Icon(widget.icon, size: 20, color: widget.color),
        value: newStrategy.isActive,
        activeColor: Colors.blue,
        title: Text(widget.swithText,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
        onChanged: (bool value) {
          newStrategy.isActive = value;
          Preferences.isActiveNewStrategy = value;
          setState(() {});
        },
      ),
    );
  }
}
