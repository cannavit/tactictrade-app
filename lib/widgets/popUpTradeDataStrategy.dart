import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/providers/new_strategy_provider.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

import 'editfield_custom.dart';

class PopUpTradeDataStrategy extends StatelessWidget {
  const PopUpTradeDataStrategy(BuildContext context);

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
                    width: MediaQuery.of(context).size.width * 0.8,
                    
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Add your trading parameters',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Select your broker',
                            style: TextStyle(fontSize: 15),
                          ),


                          //TODO add the select broker here.
                          
                          const Divider(
                              color: Colors.white30,
                          ),


                          const Text(
                            'Trading Long Parameters',
                            style: TextStyle(fontSize: 15),
                          ),

                          //TODO 
                          // Input quantity, stoploss, isActive, takeProfit, isDynamicStopLoss


                          const SizedBox(
                            height: 20,
                          ),

                          const Text(
                            '',
                            style: TextStyle(fontSize: 15),
                          ),
                        


                          Container(
                            width: double.infinity,
                            alignment: Alignment.bottomCenter,
                            height: 150,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "/Users/ceciliocannavaciuolo/Documents/workspace/codeSchool/flutterCourse_01_helloWorld/newsapp/tactictrade/assets/TutorialLoadStrategy1.png"),
                                    fit: BoxFit.cover)),
                          ),
                     
            
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
                      top: -40,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 40,
                        child: ClipRRect(
                          child: Image.asset('assets/MoniIconLogo.png'),
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
