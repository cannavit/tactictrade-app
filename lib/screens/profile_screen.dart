import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tactictrade/screens/login_screens.dart';
import 'package:tactictrade/share_preferences/preferences.dart';
import 'package:tactictrade/widgets/custom_profile_widget.dart';
import 'package:tactictrade/widgets/user_appbar_widget.dart';

// https://www.youtube.com/watch?v=gSl-MoykYYk

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context);

    // TODO Add the user info
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness:
                Preferences.isDarkmode ? Brightness.dark : Brightness.light,
            statusBarBrightness:
                Preferences.isDarkmode ? Brightness.light : Brightness.dark,
          ),
          title: Text('Profile',
              style: TextStyle(
                  color: themeColors.secondaryHeaderColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w300)),
          backgroundColor: Colors.transparent,
          leading: BackButton(
            color: themeColors.primaryColor,
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'navigation');
            },
          ),
          actions: [],
          elevation: 0,
        ),
        body: ListView(
          children: [
            CustomProfilImage(
                imagePath: Preferences.profileImage,
                onClicked: () {
                  Navigator.pushReplacementNamed(context, 'edit_profile');
                }),
            const SizedBox(height: 24),
            _Username(),
            const SizedBox(height: 24),
            _upgradeButton(),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Container()),
                const infoUserWidget(
                  value: '4.8',
                  text: 'Ranking',
                ),
                Expanded(child: Container()),
                const infoUserWidget(
                  value: '10',
                  text: 'Followers',
                ),
                Expanded(child: Container()),
                const infoUserWidget(
                  value: '90.2%',
                  text: 'Effectiveness',
                ),
                Expanded(child: Container()),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              margin: const EdgeInsets.only(left: 30),
              child: Text('About',
                  style: TextStyle(
                      color: themeColors.secondaryHeaderColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w700)),
            ),
            const SizedBox(height: 14),
            Container(
              margin: const EdgeInsets.all(20),
              child: Text(Preferences.about,
                  style: TextStyle(
                      color: themeColors.secondaryHeaderColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300)),
            )
          ],
        ));
  }
}

class infoUserWidget extends StatelessWidget {
  final String value;
  final String text;

  const infoUserWidget({
    Key? key,
    required this.value,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(text,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class _Username extends StatelessWidget {
  const _Username({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(Preferences.username,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    );
  }
}

class _upgradeButton extends StatelessWidget {
  const _upgradeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // color: Colors.black87,
    final themeColors = Theme.of(context);

    return Center(
      child: MaterialButton(
        color: themeColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        onPressed: () {},
        child: const Text('Upgrade Plan',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}
