import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/providers/theme_provider.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // final themeProvider =
    // Provider.of<ThemeProviderCustom>(context, listen: false);

    // final isDarkmode = themeProvider.is
    return Center(
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          children:  [
            // Read the Image Logo from one file
            //TODO add the image Logo
            Image(image: Preferences.isDarkmode ? AssetImage('assets/TacticTradeLight.png') : AssetImage('assets/TacticTradeDark.png')),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
