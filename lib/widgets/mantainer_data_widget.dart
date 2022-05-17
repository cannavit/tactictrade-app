import 'package:flutter/material.dart';

import '../share_preferences/preferences.dart';
import 'circle_image_widget.dart';

class MantainerDataWidget extends StatelessWidget {
  const MantainerDataWidget(
      {Key? key,
      required this.mantainerName,
      required this.urlUser,
      this.titleLevelOne = 'Mantainer'})
      : super(key: key);

  final String mantainerName;
  final String urlUser;
  final String titleLevelOne;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: _headCardWidget(
        mantainerName: mantainerName,
        urlUser: urlUser,
        titleLevelOne: titleLevelOne,
      ),
    );
  }
}

class _headCardWidget extends StatelessWidget {
  const _headCardWidget(
      {Key? key,
      required this.urlUser,
      required this.mantainerName,
      this.titleLevelOne = 'Mantainer'})
      : super(key: key);

  final String urlUser;
  final String mantainerName;
  final String titleLevelOne;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleImage(urlImage: urlUser, radius: 50, size: 50),
        _mantainerName(
            mantainerName: mantainerName,
            followers: 200,
            titleLevelOne: titleLevelOne),
        Expanded(child: Container()),
        const Text('+Follow',
            style: TextStyle(
                color: Color(0xff08BEFB),
                fontSize: 15,
                fontWeight: FontWeight.w300)),
        const SizedBox(width: 20),
      ],
    );
  }
}

class _mantainerName extends StatelessWidget {
  final String mantainerName;
  final int followers;
  final String titleLevelOne;

  const _mantainerName(
      {Key? key,
      required this.mantainerName,
      required this.followers,
      this.titleLevelOne = 'Mantainer'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${titleLevelOne}',
              style: TextStyle(
                  color: Preferences.isDarkmode
                      ? Colors.black45
                      : Color(0xffCECECE),
                  fontSize: 13,
                  fontWeight: FontWeight.w300)),
          Text(mantainerName,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 3),
          Text('Followers: ${followers}',
              style: const TextStyle(
                  color: Color(0xff08BEFB),
                  fontSize: 13,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}

class _strategyName extends StatelessWidget {
  final String strategyName;

  const _strategyName({
    Key? key,
    required this.strategyName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Strategy name',
              style: TextStyle(
                  color:
                      Preferences.isDarkmode ? Colors.black45 : Colors.white60,
                  fontSize: 15,
                  fontWeight: FontWeight.w300)),
          Text(strategyName,
              style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 20,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
