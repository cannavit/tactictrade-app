import 'package:flutter/material.dart';
import 'package:tactictrade/share_preferences/preferences.dart';
// import 'package:tactictrade/utils/preferences.dart';

class PopUpMovement extends StatelessWidget {
  const PopUpMovement({
    Key? key,
    required this.titleHeader,
    required this.message,
  }) : super(key: key);

  final String titleHeader;
  final String message;

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: Text(titleHeader),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(message),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: Row(
            children: [
              TextButton(
                child: Text('Continue',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.w700)),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, 'navigation');
                  Preferences.tempStrategyImage = '';
                  Preferences.formValidatorCounter = 0;
                },
              ),
              Expanded(child: Container()),
              TextButton(
                child: Text('Cancel',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.w700)),
                onPressed: () {
                  print('-------- Cancel');
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
