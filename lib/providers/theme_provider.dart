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
    dividerColor: Color(0xff898989),
    primaryColor: const Color(0xff008CED),
    secondaryHeaderColor: Colors.black87,
    accentColor: const Color(0xff008CED),
    textSelectionColor: Color(0xff142A32),

    
  );

  static final lightTheme = new ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xff142A32),
    textSelectionColor: Colors.white,
    secondaryHeaderColor: Colors.white,
    primaryColor: const Color(0xff08BEFB),
    accentColor: const Color(0xff008CED),
  );
}

class AppColors {
  final Color textColor = Colors.red;

  const AppColors();
}

// primaryColor: Colors.red,
// primaryColorBrightness: Colors.red,
// primaryColorLight: Colors.red,
// primaryColorDark: Colors.red,
// accentColor: Colors.red,
// accentColorBrightness: Colors.red,
// canvasColor: Colors.red,
// shadowColor: Colors.red,
// bottomAppBarColor: Colors.red,
// cardColor: Colors.red,
// dividerColor: Colors.red,
// focusColor: Colors.red,
// hoverColor: Colors.red,
// highlightColor: Colors.red,
// splashColor: Colors.red,
// selectedRowColor: Colors.red,
// unselectedWidgetColor: Colors.red,
// disabledColor: Colors.red,
// buttonColor: Colors.red,
// secondaryHeaderColor: Colors.red,
// cursorColor: Colors.red,
// textSelectionHandleColor: Colors.red,
// backgroundColor: Colors.red,
// dialogBackgroundColor: Colors.red,
// indicatorColor: Colors.red,
// hintColor: Colors.red,
// errorColor: Colors.red,
// toggleableActiveColor: Colors.red,
