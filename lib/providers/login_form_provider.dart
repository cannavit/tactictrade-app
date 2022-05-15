import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String email = '';
  String password = '';

  // bool isLoading;
  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
