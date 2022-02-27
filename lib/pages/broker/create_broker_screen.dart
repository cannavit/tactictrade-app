import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tactictrade/pages/broker/service/create_strategy_buttom_widget.dart';

import '../../screens/create_strategy_screen.dart';
import '../../share_preferences/preferences.dart';
import '../../widgets/forms_components/general_input_field.dart';

class NewBrokerScreen extends StatelessWidget {
  const NewBrokerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context);

    final brokerNameCtrl = TextEditingController();
    final ApiKeyCtrl = TextEditingController();
    final SecretKeyCtrl = TextEditingController();

    var _btnEnabled = false;

    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness:
                Preferences.isDarkmode ? Brightness.dark : Brightness.light,
            statusBarBrightness:
                Preferences.isDarkmode ? Brightness.light : Brightness.dark,
          ),
          title: Text('Create Broker Connection',
              style: TextStyle(
                  color: themeColors.secondaryHeaderColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w300)),
          backgroundColor: Colors.transparent,
          leading: BackButton(
            color: themeColors.primaryColor,
            onPressed: () {
              Preferences.navigationCurrentPage = 4;

              showDialog(
                context: context,
                builder: (BuildContext context) => PopUpMovement(
                  titleHeader: 'Exit of Create Broker Connection',
                  message: 'You are sure of move it? Current data will be lost',
                ),
              );

              Navigator.pushReplacementNamed(context, 'navigation');
            },
          ),
          actions: [],
          elevation: 0,
        ),
        body: Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 70,
                      child: Image(
                          image: AssetImage(
                              'lib/pages/broker/assets/AlpacaRowDart.png'))),
                  const SizedBox(height: 50),
                  Container(
                    // width: MediaQuery.of(context).size.width * 0.4,
                    child: GeneralInputField(
                        textController: brokerNameCtrl,
                        labelText: 'Broker Name',
                        hintText: 'Add Broker Name',
                        textInputType: TextInputType.number,
                        validatorType: 'writeMandatory',
                        icon: const Icon(
                          Icons.broken_image_sharp,
                          color: Colors.grey,
                        )),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    // width: MediaQuery.of(context).size.width * 0.4,
                    child: GeneralInputField(
                        textController: ApiKeyCtrl,
                        labelText: 'Api Key ',
                        hintText: 'Add Broker Name',
                        textInputType: TextInputType.number,
                        validatorType: 'writeMandatory',
                        icon: const Icon(
                          Icons.flip_to_back_rounded,
                          color: Colors.grey,
                        )),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    // width: MediaQuery.of(context).size.width * 0.4,
                    child: GeneralInputField(
                        textController: SecretKeyCtrl,
                        labelText: 'Secret Key ',
                        hintText: 'Add Secret Key',
                        textInputType: TextInputType.number,
                        validatorType: 'writeMandatory',
                        icon: const Icon(
                          Icons.electrical_services_outlined,
                          color: Colors.grey,
                        )),
                  ),
                  Expanded(child: Container()),
                  Container(
                      height: 50,
                      child: ButtonCreateBroker(
                        buttomText: 'Create Broker',
                        bodyRequest: {
                          'brokerName': brokerNameCtrl,
                          'ApiKey': ApiKeyCtrl,
                          'SecretKey': SecretKeyCtrl,
                        },
                        btnEnabled: _btnEnabled,
                      )),
                  const SizedBox(height: 100),
                ])));
  }
}
