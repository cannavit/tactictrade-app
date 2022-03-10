import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/providers/new_strategy_provider.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

import 'editfield_custom.dart';

class PopUpCreateStrategy extends StatelessWidget {
  const PopUpCreateStrategy(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final strategyPreferences =
        Provider.of<NewStrategyProvider>(context, listen: false);

    final themeColors = Theme.of(context);
    final aboutCtrl = TextEditingController(text: Preferences.about);
    final webhookCtrl =
        TextEditingController(text: strategyPreferences.selectedWebhook);
    final messageCtrl =
        TextEditingController(text: strategyPreferences.selectedMessage);

    return Container(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Dialog(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              insetPadding: EdgeInsets.only(top: 40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)),
              child: Stack(
                overflow: Overflow.visible,
                alignment: Alignment.center,
                children: [
                  Container(
                    // height: 400,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'The strategy was created',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                          const Text(
                            'successfully!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Please follow the next steps',
                            style: TextStyle(fontSize: 15),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            '1)  Open notifications in your StrategyTester',
                            style: TextStyle(fontSize: 14),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.bottomCenter,
                            height: 150,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/TutorialLoadStrategy1.png"),
                                    fit: BoxFit.cover)),
                          ),
                          EditTextField(
                              themeColors: themeColors,
                              usernameCtrl: webhookCtrl,
                              nameEditField: '2)  Copy this in Webhook URL',
                              colorFilled: const Color(0xff2D333B),
                              readOnly: true,
                              maxLines: 2,
                              fontSize: 15,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  print(webhookCtrl.text);

                                  final data =
                                      ClipboardData(text: webhookCtrl.text);
                                  Clipboard.setData(data);
                                },
                                icon: const Icon(Icons.copy),
                              )),
                          EditTextField(
                              themeColors: themeColors,
                              usernameCtrl: messageCtrl,
                              nameEditField: '2) Copy This in Message',
                              colorFilled: Color(0xff2D333B),
                              readOnly: false,
                              maxLines: 4,
                              fontSize: 15,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  final data =
                                      ClipboardData(text: webhookCtrl.text);
                                  Clipboard.setData(data);
                                },
                                icon: const Icon(Icons.copy),
                              )),
                          RaisedButton(
                            onPressed: () {
                              // Navigator.of(context).pop();
                              Navigator.pushReplacementNamed(
                                  context, 'navigation');
                            },
                            color: Colors.blue,
                            child: const Text(
                              'Done',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: -60,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 60,
                        child: ClipRRect(
                          child: Image.asset('assets/TradingViewStrategy.png'),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      )),
                ],
              )),
        ),
      ),
    );
  }
}
