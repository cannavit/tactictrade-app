import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
import 'package:tactictrade/providers/login_form_provider.dart';
import 'package:tactictrade/services/auth_service.dart';
import 'package:tactictrade/services/notifications_service.dart';
import 'package:tactictrade/share_preferences/preferences.dart';
import 'package:tactictrade/widgets/customInputData.dart';
import 'package:tactictrade/widgets/logo_center_widget.dart';

import '../widgets/social_login/google_login_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context);
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(), // Same efect in Android
        child: Container(
          // height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const LogoImage(),
              Text('Login', style: TextStyle(fontSize: 20)),

              ChangeNotifierProvider(
                create: (_) => LoginFormProvider(),
                child: _Form(),
              ), // Import Provider

              Container(
                margin: EdgeInsets.symmetric(horizontal: 35),
                height: 50,
                width: double.infinity,
                child: SignInButton(
                    buttonType: ButtonType.google,
                    onPressed: () async {
                      final providerGoogleSignIn =
                          Provider.of<GoogleSignInProvider>(context,
                              listen: false);

                      final result = await providerGoogleSignIn.googleLogin();

                      if (result == null) {
                        Navigator.pushReplacementNamed(context, 'loading');
                      } else {
                        NotificationsService.showSnackbar(context,result);
                      }
                      // SignInDemo();
                    }),
              )

              // _Form(),
              // Buttom
            ],
          ),
        ),
      ),
    ));
  }
}

// Add Forms Input -----------------------------------
class _Form extends StatefulWidget {
  _Form({Key? key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          const SizedBox(height: 20),

          // Email Input
          CustomInput(
              icon: Icons.alternate_email,
              placeholder: 'Email',
              keyboardType: TextInputType.emailAddress,
              textController: emailCtrl,
              validateEmail: true,
              validatorType: 'email'),

          const SizedBox(height: 20),

          // Password Input
          CustomInput(
              icon: Icons.lock_outline,
              placeholder: 'Password',
              keyboardType: TextInputType.emailAddress,
              textController: passCtrl,
              isPassword: true,
              validatorType: 'password'),

          const SizedBox(height: 20),

          // Buttom ------

          ButtonLogin(emailCtrl: emailCtrl, passCtrl: passCtrl),

          _Labels(),

          const SizedBox(height: 20),

          const _PaperTradingButtom(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _PaperTradingButtom extends StatefulWidget {
  const _PaperTradingButtom({
    Key? key,
  }) : super(key: key);

  @override
  State<_PaperTradingButtom> createState() => _PaperTradingButtomState();
}

class _PaperTradingButtomState extends State<_PaperTradingButtom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SwitchListTile(
          activeTrackColor: Colors.blue.shade300,
          activeColor: Colors.blue,
          // inactiveThumbColor: Colors.amber.shade300,

          value: Preferences.isPaperTrading,
          title: Text('Paper Trading',
              style: TextStyle(
                  color: Colors.blue[500],
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          onChanged: (value) {
            Preferences.isPaperTrading = value;
            setState(() {});
          }),
    );
  }
}

// Button Login ---------------------------------------------------------------
class ButtonLogin extends StatelessWidget {
  const ButtonLogin({
    Key? key,
    required this.emailCtrl,
    required this.passCtrl,
  }) : super(key: key);

  final TextEditingController emailCtrl;
  final TextEditingController passCtrl;

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return RaisedButton(
        elevation: 2,
        highlightElevation: 5,
        color: Colors.blue,
        shape: const StadiumBorder(),
        child: Container(
          width: double.infinity,
          height: 55,
          child: const Center(
            child: Text('Sign In',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        onPressed: () async {
          final authService = Provider.of<AuthService>(context, listen: false);

          print(emailCtrl.text);
          print(passCtrl.text);

          String pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regExp = new RegExp(pattern);

          if (regExp.hasMatch(emailCtrl.text) && passCtrl.text.length >= 6) {
            final String? errorMessage =
                await authService.login(emailCtrl.text, passCtrl.text);

            if (errorMessage == null) {
              Navigator.pushReplacementNamed(context, 'loading');
            } else {
              NotificationsService.showSnackbar(context,errorMessage);
            }

            // Navigator.Push
          }

          loginForm.isValidForm();

          if (Preferences.rememberMeLoginData) {
            Preferences.emailLoginSaved = emailCtrl.text;
            Preferences.passwordLoginSaved = passCtrl.text;
          }
        });
  }
}

// Add Labels
class _Labels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  GestureDetector(
                      child: const Text('Sign Up',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.w300)),
                      onTap: () {
                        Navigator.pushReplacementNamed(context, 'register');
                      }),
                  Expanded(child: Container()),
                  _signUpCheckbox()
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _signUpCheckbox extends StatefulWidget {
  const _signUpCheckbox({
    Key? key,
  }) : super(key: key);

  @override
  State<_signUpCheckbox> createState() => _signUpCheckboxState();
}

class _signUpCheckboxState extends State<_signUpCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Checkbox(
              value: Preferences.rememberMeLoginData,
              activeColor: Colors.blue,
              onChanged: (value) {
                Preferences.rememberMeLoginData =
                    !Preferences.rememberMeLoginData;
                setState(() {});
              }),
          const Text('Remember me',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w300)),
        ],
      ),
    );
  }
}

class name extends StatelessWidget {
  const name({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// ----------------------------------------------------------------------------
//TODO add the field Widget in one separate file.
