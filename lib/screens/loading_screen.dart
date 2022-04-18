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
                    // Text('Use Collaborative Trading with Strategies',
                    // style: TextStyle(color: Colors.white, fontSize: 15)),
                    SizedBox(height: 10),
                    SizedBox(height: 5),
                    LogoImage(),
                    // Text('Trade safely!!!',
                    //     style: TextStyle(color: Colors.blue, fontSize: 20)),
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

    var loggedResult = await authService.isLoggedIn();

    var logged = loggedResult['isLogged'];
    var token = loggedResult['token'];

    Preferences.selectedTimeNewStrategy = 'minutes';
    Preferences.updateTheStrategies = false;
    Preferences.categoryStrategySelected = 'all';
    Preferences.categoryStrategyOwnerSelected = 'all';
    Preferences.updateStrategyOwnerSelected = false;

    // Remember me password. 
    if (!logged && Preferences.rememberMeLoginData) {

      final email = Preferences.emailLoginSaved;
      final password = Preferences.passwordLoginSaved;

      await authService.login(email, password);

      loggedResult = await authService.isLoggedIn();

      logged = loggedResult['isLogged'];
      token = loggedResult['token'];
    }

    if (logged) {
      final profileData = await authService.readProfileData(token);

      if (profileData == '') {
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                pageBuilder: (_, __, ___) => const LoginScreen(),
                transitionDuration: const Duration(seconds: 0)));
      }

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
