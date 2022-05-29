import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/screens/navigation_screen.dart';

class CustomNavbar extends StatelessWidget {
  const CustomNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final navigationModel = Provider.of<NavigationModel>(context);

    return SizedBox(
      height: 50,
      child: BottomNavigationBar(
        iconSize: 20,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.blueGrey,
        selectedItemColor: Colors.blue,
        currentIndex: navigationModel.currentPage,

        
// 
        onTap: (i) => navigationModel.currentPage = i,
        elevation: 0,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',
          backgroundColor: Color.fromARGB(0, 63, 63, 63)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow), label: 'Strategies'),
          BottomNavigationBarItem(icon: Icon(Icons.transform_sharp), label: 'Opens'),
          BottomNavigationBarItem(icon: Icon(Icons.graphic_eq), label: 'Broker'),
        ],
      ),
    );
  }
}
