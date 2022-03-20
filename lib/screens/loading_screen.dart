import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/screens/login_screens.dart';
import 'package:tactictrade/services/auth_service.dart';
import 'package:tactictrade/share_preferences/preferences.dart';
import 'package:tactictrade/widgets/logo_center_widget.dart';

import 'navigation_screen.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder(
          future: checkLoginState(context),
          builder: (context, snapshot) {
            return Container(
              child: Center(
                child: Column(
                  children: const [
                    SizedBox(height: 50),
                    Text('Use Collaborative Trading Bots',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    SizedBox(height: 10),
                    Text('Doing Trade with a co-pilot',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    SizedBox(height: 5),
                    LogoImage(),
                    Text('Trade safely!!!',
                        style: TextStyle(color: Colors.blue, fontSize: 20)),
                    SizedBox(height: 60),
                    Image(image: AssetImage('assets/TradingImage.png')),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ));
  }

  Future checkLoginState(BuildContext context) async {
    Preferences.tempProfileImage = Preferences.profileImage;

    final authService = Provider.of<AuthService>(context, listen: false);

    final loggedResult = await authService.isLoggedIn();

    final bool logged = loggedResult['isLogged'];
    final String token = loggedResult['token'];

    Preferences.selectedTimeNewStrategy = 'minutes';

    if (logged) {
      final profileData = await authService.readProfileData(token);

      Preferences.about = profileData['about'];
      Preferences.username = profileData['username'];
      Preferences.profileImage = profileData['profile_image'];
      Preferences.tempProfileImage = profileData['profile_image'];
    }

    // Profile Image.

    if (logged) {
      // Navigator.pushReplacementNamed(context, 'positions');
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => const NavigationScreen(),
              transitionDuration: const Duration(seconds: 0)));
    } else {
      // Navigator.pushReplacementNamed(context, 'login');
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => const LoginScreen(),
              transitionDuration: const Duration(seconds: 0)));
    }
  }
}
