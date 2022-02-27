import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness:
            Preferences.isDarkmode ? Brightness.dark : Brightness.light,
        statusBarBrightness:
            Preferences.isDarkmode ? Brightness.light : Brightness.dark,
      ),
      title: const Text(
        'Positions Page',
        style: TextStyle(color: Colors.black87),
      ),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.exit_to_app, color: Colors.black87),
        onPressed: () {
          Navigator.pushReplacementNamed(context, 'login');
        },
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: Icon(Icons.check_circle, color: Colors.blue[400]),
          // child: Icon(Icons.offline_bolt, color: Colors.red[400]),
        )
      ],
    );
  }
}
