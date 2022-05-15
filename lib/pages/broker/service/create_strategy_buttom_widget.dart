import 'dart:convert';
import 'package:provider/provider.dart';
import '../../../providers/new_strategy_provider.dart';
import 'package:flutter/material.dart';
import '../../../services/notifications_service.dart';
import '../../../share_preferences/preferences.dart';
import 'broker_service.dart';

class ButtonCreateBroker extends StatelessWidget {
  const ButtonCreateBroker({
    Key? key,
    required this.bodyRequest,
    required this.btnEnabled,
    this.buttonText = 'Connect Strategy',
  }) : super(key: key);

  final dynamic bodyRequest;
  final bool btnEnabled;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    final brokerService = Provider.of<BrokerServices>(context, listen: false);

    return RaisedButton(
        elevation: 2,
        highlightElevation: 5,
        color: Colors.blue,
        shape: const StadiumBorder(),
        child: Container(
          width: double.infinity,
          height: 55,
          child: Center(
            child: Text(buttonText,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        onPressed: true
            ? () async {
                // Validate form. ----------------------------------------------------

                var isMandatory = false;

                bodyRequest.forEach((k, v) {
                  var bd = bodyRequest[k];
                  try {
                    bd = bd.text;
                    if (bd == "") {
                      isMandatory = true;
                    }
                  } catch (e) {
                    print(e);
                  }
                });

                if (isMandatory) {
                  NotificationsService.showSnackbar(
                      context, 'It has fields that are mandatory empty');
                  return null;
                }

                var brokerName = bodyRequest["brokerName"];
                brokerName = brokerName.text;

                var ApiKey = bodyRequest["ApiKey"];
                ApiKey = ApiKey.text;

                var SecretKey = bodyRequest["SecretKey"];
                SecretKey = SecretKey.text;

                final data = {
                  "brokerName": brokerName,
                  "broker": "alpaca",
                  "APIKeyID": ApiKey,
                  "SecretKey": SecretKey,
                  "isPaperTrading": Preferences.isPaperTrading
                };

                final responseBroker = await brokerService.createBroker(data);

                if (responseBroker.statusCode != 201) {
                  var message = jsonDecode(responseBroker.body);

                  NotificationsService.showSnackbar(
                      context, message["message"]);
                  return null;
                }

                brokerService.loadBroker();

                Navigator.pushReplacementNamed(context, 'navigation');

                // brokerService.brokerList();
              }
            : null);
  }
}
