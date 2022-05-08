import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/models/create_strategy.dart';
import 'package:tactictrade/providers/providers.dart';
import 'package:tactictrade/providers/strategies_categories_provider.dart';
import 'package:tactictrade/screens/navigation_screen.dart';
import 'package:tactictrade/services/notifications_service.dart';
import 'package:tactictrade/services/strategies_services.dart';
import 'package:tactictrade/share_preferences/preferences.dart';
import 'package:tactictrade/widgets/popUpCreateStrategy.dart';
import 'package:tactictrade/widgets/widgets.dart';
// import 'package:flutter_spinbox/material.dart';

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

class CreateStrategyScreen extends StatelessWidget {
  CreateStrategyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoriesList = Provider.of<CategoryStrategiesSelected>(context);

    final themeColors = Theme.of(context);

    // Inputs.
    // strategyNameCtrl = TextEditingController();

    return ChangeNotifierProvider(
      create: (_) => new NavigationModel(),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness:
                Preferences.isDarkmode ? Brightness.dark : Brightness.light,
            statusBarBrightness:
                Preferences.isDarkmode ? Brightness.light : Brightness.dark,
          ),
          title: Text('Connect Strategy',
              style: TextStyle(
                  color: themeColors.secondaryHeaderColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w300)),
          backgroundColor: Colors.transparent,
          leading: BackButton(
            color: themeColors.primaryColor,
            onPressed: () {
              Preferences.navigationCurrentPage = 0;
              Preferences.tempStrategyImage = "";
              showDialog(
                context: context,
                builder: (BuildContext context) => PopUpMovement(
                  titleHeader: 'Exit of Create Strategy',
                  message: 'You are sure of move it? Current data will be lost',
                ),
              );
            },
          ),
          actions: [],
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(), // Same efect in Android
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _Form(themeColors: themeColors),
              const SizedBox(height: 50),
              // Text Inputs
            ]),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({
    Key? key,
    required this.themeColors,
  }) : super(key: key);

  final ThemeData themeColors;

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final strategyNameCtrl = TextEditingController();
  final symbolCtrl = TextEditingController();
  final timeTradeCtrl = TextEditingController();
  final strategyUrlCtrl = TextEditingController();

  final isPublic = TextEditingController();
  final isActive = TextEditingController();

  final descriptionCtrl = TextEditingController();

  final List<String> itemsData = [
    'minutes',
    'hours',
    'days',
    'weeks',
  ];

  @override
  Widget build(BuildContext context) {
    var _btnEnabled = false;
    //

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        
        Row(
          children: [
            Container(
              child: const Text('use TradingView strategy  ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
            ),
            const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                  'https://pbs.twimg.com/profile_images/1417483329717379079/6PZXeTXJ_400x400.jpg'),
            ),
          ],
        ),


        const Divider(
          color: Colors.white30,
        ),

        ImageUploadWidget(),

        const SizedBox(height: 15),

        GeneralInputField(
            textController: descriptionCtrl,
            labelText: 'Add Strategy Description',
            hintText: 'This strategy .....',
            maxLine: 7,
            icon: const Icon(
              Icons.text_snippet_outlined,
              color: Colors.grey,
            )),

        // Positioned(top: 10, left: 10 ,child: Icon(Icons.ac_unit_outlined)),

        const Divider(
          color: Colors.white30,
        ),

        const SizedBox(height: 20),

        const Text('General Strategy Inputs',
            style: TextStyle(
                color: Colors.white54,
                fontSize: 18,
                fontWeight: FontWeight.w400)),

        const SizedBox(height: 20),

        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: GeneralInputField(
                  textController: strategyNameCtrl,
                  labelText: 'S.Name',
                  hintText: 'example SPY',
                  validatorType: 'writeMandatory',
                  icon: const Icon(
                    Icons.auto_graph,
                    color: Colors.grey,
                  )),
            ),

            // DropDown(),

            Expanded(child: Container()),

            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: GeneralInputField(
                  textController: symbolCtrl,
                  labelText: 'Symbol',
                  hintText: 'example 1h',
                  validatorType: 'writeMandatory',
                  icon: const Icon(
                    Icons.grain_sharp,
                    color: Colors.grey,
                  )),
            ),
          ],
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            // DropDown(),

            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: GeneralInputField(
                  textController: timeTradeCtrl,
                  labelText: 'Time Trade',
                  hintText: 'example 1h',
                  textInputType: TextInputType.number,
                  validatorType: 'interger',
                  icon: const Icon(
                    Icons.timer,
                    color: Colors.grey,
                  )),
            ),

            Expanded(child: Container()),

            DropDown(descriptionCtrl: itemsData),
          ],
        ),

        const SizedBox(height: 20),

        Container(
          // width: MediaQuery.of(context).size.width * 0.4,
          child: GeneralInputField(
              textController: strategyUrlCtrl,
              labelText: 'Strategy URL',
              hintText: 'https://www.tradingview.com/..',
              icon: Icon(
                // Icons.grading,
                Icons.list_alt_sharp,
                color: Colors.grey,
              )),
        ),

        const SizedBox(height: 20),

        const Text('Control Variables',
            style: TextStyle(
                color: Colors.white54,
                fontSize: 18,
                fontWeight: FontWeight.w400)),

        SwitchCustomIsPublic(
            themeColors: widget.themeColors,
            swithText: 'Strategy Public',
            icon: Icons.public,
            color: Colors.white54),

        SwitchCustom(
            themeColors: widget.themeColors,
            swithText: 'Is Active',
            icon: Icons.play_arrow,
            color: Colors.white54),


        const SizedBox(height: 40),

        Container(
            height: 50,
            child: ButtonNext(
              bodyRequest: {
                'strategyNews': this.strategyNameCtrl,
                'symbol': this.symbolCtrl,
                'timeTradeCtrl': this.timeTradeCtrl,
                'strategyUrlCtrl': this.strategyUrlCtrl,
                // 'is_public': true,
                // 'is_active': true,
                'description': this.descriptionCtrl,
              },
              btnEnabled: _btnEnabled,
            )),
      ],
    );
  }
}

class DropDown extends StatefulWidget {
  const DropDown({
    Key? key,
    required this.descriptionCtrl,
  }) : super(key: key);

  final List<String> descriptionCtrl;

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    var selectedValue;

    return DropdownButtonHideUnderline(
      child: Container(
        // width: MediaQuery.of(context).size.width * 0.3,
        height: 47,
        child: Container(
            child: DropdownButton2(
              hint: Row(
                children: [

                  const SizedBox(width: 6),
                  
                  Icon(
                    Icons.calendar_view_month_sharp,
                    color: Colors.white60,
                  ),
                  
                  Text(
                    'Select Time',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                
                ],
              ),
              items: widget.descriptionCtrl
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Row(
                          children: [

                            const SizedBox(width: 6),

                            Text(
                              item,
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),

                          ],
                        ),
                      ))
                  .toList(),
              value: Preferences.selectedTimeNewStrategy,
              onChanged: (value) {
                if (value is String) {
                  Preferences.selectedTimeNewStrategy = value;
                } else {
                  Preferences.selectedTimeNewStrategy = '';
                }
                setState(() {});
              },
              buttonHeight: 40,
              buttonWidth: 140,
              itemHeight: 40,
              buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.white,
                ),
                color: Colors.transparent,
              ),
            ),
            ),
      ),
    );
  }
}

class SwitchCustomIsPublic extends StatefulWidget {
  final String swithText;
  final IconData icon;
  final Color color;

  const SwitchCustomIsPublic({
    Key? key,
    required this.themeColors,
    required this.swithText,
    required this.icon,
    this.color = Colors.white,
  }) : super(key: key);

  final ThemeData themeColors;

  @override
  State<SwitchCustomIsPublic> createState() => _SwitchCustomIsPublicState();
}

class _SwitchCustomIsPublicState extends State<SwitchCustomIsPublic> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: SwitchListTile.adaptive(
        secondary: Icon(widget.icon, size: 20, color: widget.color),
        value: Preferences.isPublicNewStrategy,
        activeColor: Colors.blue,
        title: Text(widget.swithText,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
        onChanged: (bool value) {
          Preferences.isPublicNewStrategy = value;
          setState(() {});
        },
      ),
    );
  }
}

class InputDecorations {
  static InputDecoration authInputDecoration(
      {required String hintText,
      required String labelText,
      IconData? prefixIcon}) {
    return InputDecoration(
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(),
        ),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.deepPurple)
            : null);
  }
}

class ButtonNext extends StatelessWidget {
  const ButtonNext({
    Key? key,
    required this.bodyRequest,
    required this.btnEnabled,
    this.buttomText = 'Connect Strategy',
  }) : super(key: key);

  final dynamic bodyRequest;
  final bool btnEnabled;
  final String buttomText;

  @override
  Widget build(BuildContext context) {
    final strategyPreferences =
        Provider.of<NewStrategyProvider>(context, listen: false);

    return RaisedButton(
        elevation: 2,
        highlightElevation: 5,
        color: Colors.blue,
        shape: const StadiumBorder(),
        child: Container(
          width: double.infinity,
          height: 55,
          child: Center(
            child: Text(buttomText,
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

                //TODO fix the validators and notification message
                // if (isMandatory) {
                //   NotificationsService.showSnackbar(
                //       'It has fields that are mandatory empty');
                // }

                final data = StrategyData(
                  strategyNews: bodyRequest["strategyNews"].value.text,
                  description: bodyRequest["description"].value.text,
                  isActive: '${Preferences.isActiveNewStrategy}',
                  isPublic: '${Preferences.isPublicNewStrategy}',
                  period: Preferences.selectedTimeNewStrategy,
                  symbol: bodyRequest["symbol"].value.text,
                  timer: bodyRequest["timeTradeCtrl"].value.text,
                );

                final strategyApi =
                    Provider.of<StrategyServices>(context, listen: false);

                final response = await strategyApi.postStrategy(data);

                var body = json.decode(response['body']);
                body = json.decode(response['body']);

                if (response['statusCode'] != 200) {
                  NotificationsService.showSnackbar(context, body['message']);
                
                  Provider.of<StrategyServices>(context, listen: false)
                      .loadStrategy();
                } else {
                  
                  strategyPreferences.selectedMessage =
                      body["tradingview"]["message"];

                  strategyPreferences.selectedWebhook =
                      body["tradingview"]["webhook"];

                  Preferences.newFollowStrategyId = body["data"]["strategyNewsId"];
                  Preferences.brokerNewUseTradingLong = false;
                  Preferences.brokerNewUseTradingShort = false;
                  Preferences.selectedBrokerInFollowStrategy = "{}";


                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        PopUpCreateStrategy(context),
                  );
                }

          
              }
            : null);
  }
}
