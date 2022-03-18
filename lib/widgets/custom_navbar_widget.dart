import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/screens/navigation_screen.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

class CustomNavbar extends StatelessWidget {
  const CustomNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<NavigationModel>(context);
    final themeColors = Theme.of(context);

    return BottomNavigationBar(
      
      showSelectedLabels: true,
      showUnselectedLabels: false,
      unselectedItemColor: themeColors.secondaryHeaderColor,
      selectedItemColor: themeColors.primaryColor,
      currentIndex: navigationModel.currentPage,
      backgroundColor: Colors.red,
      onTap: (i) => navigationModel.currentPage = i,
      elevation: 0,

      // backgroundColor: ,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow), label: 'Strategies'),
        BottomNavigationBarItem(icon: Icon(Icons.transform_sharp), label: 'Opens'),
        BottomNavigationBarItem(icon: Icon(Icons.graphic_eq), label: 'Broker'),
      ],
    );
  }
}
