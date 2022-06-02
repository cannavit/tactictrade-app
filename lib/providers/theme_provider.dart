import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  //
  ThemeData currentTheme;

  ThemeProvider({required bool isDarkmode})
      : currentTheme = isDarkmode ? MyThemes.darkTheme : MyThemes.lightTheme;

  setLightMode() {
    currentTheme = MyThemes.lightTheme;
    notifyListeners();
  }

  setDarkmode() {
    currentTheme = MyThemes.darkTheme;
    notifyListeners();
  }
}

class MyThemes {


  static final darkTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: const Color(0xffF2F4F7),
    // colorScheme: ColorScheme.light(),
    dividerColor: const Color(0xff898989),
    primaryColor: const Color(0xff008CED),
    secondaryHeaderColor: Colors.black87,
    // textSelectionColor: const Color(0xff142A32), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xff008CED)),

    
  );

  static final lightTheme = ThemeData.dark().copyWith(
    // scaffoldBackgroundColor: const Color(0xff142A32),
    scaffoldBackgroundColor: const Color(0xff181B25),

    // textSelectionColor: Colors.white,
    secondaryHeaderColor: Colors.white,
    primaryColor: const Color(0xff08BEFB), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xff008CED)),
  );
}

class AppColors {
  final Color textColor = Colors.red;

  const AppColors();
}

