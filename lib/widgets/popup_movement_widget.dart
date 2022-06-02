import 'package:flutter/material.dart';

import '../share_preferences/preferences.dart';



class PopUpMovement extends StatelessWidget {
  const PopUpMovement({
    Key? key,
    required this.titleHeader,
    required this.message,
    this.navigationTo = 'navigation', 
    this.continueText = 'Continue',
    this.cancelText = 'Cancel',

  }) : super(key: key);

  final String titleHeader;
  final String message;
  final String navigationTo;
  final String continueText;
  final String cancelText;


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titleHeader),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(message),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          // textColor: Theme.of(context).primaryColor,
          child: Row(
            children: [
              TextButton(
                child:  Text(continueText,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.w700)),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, navigationTo);
                  Preferences.tempStrategyImage = '';
                  Preferences.formValidatorCounter = 0;
                },
              ),
              Expanded(child: Container()),
              TextButton(
                child:  Text(cancelText,
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.w700)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}