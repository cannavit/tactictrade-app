import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
import 'package:tactictrade/providers/login_form_provider.dart';
import 'package:tactictrade/services/auth_service.dart';
import 'package:tactictrade/services/notifications_service.dart';
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
              const Text('Login', style: TextStyle(fontSize: 20)),
              ChangeNotifierProvider(
                create: (_) => LoginFormProvider(),
                child: const _Form(),
              ), // Import Provider

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 35),
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
                        NotificationsService.showSnackbar(context, result);
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
  const _Form({Key? key}) : super(key: key);

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
          CustomInputPassword(
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

class _PaperTradingButtom extends StatelessWidget {
  const _PaperTradingButtom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SwitchListTile(
          value: true,
          title: Text('Paper Trading',
              style: TextStyle(
                  color: Colors.blue[500],
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          onChanged: (value) {}),
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

    return TextButton(
        style: ButtonStyle(
          
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          padding: MaterialStateProperty.all(const EdgeInsets.all(1)),

          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            // side: BorderSide(color: Colors.red)
          )
        )
        ),
        // elevation: 2,
        // highlightElevation: 5,
        // color: Colors.blue,
        // shape: const StadiumBorder(),
        child: const SizedBox(
          width: double.infinity,
          height: 55,
          child: Center(
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
          RegExp regExp = RegExp(pattern);

          if (regExp.hasMatch(emailCtrl.text) && passCtrl.text.length >= 6) {
            final String? errorMessage =
                await authService.login(emailCtrl.text, passCtrl.text);

            if (errorMessage == null) {
              Navigator.pushReplacementNamed(context, 'loading');
            } else {
              NotificationsService.showSnackbar(context, errorMessage);
            }

            // Navigator.Push
          }

          loginForm.isValidForm();
        });
  }
}

// Add Labels
class _Labels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              GestureDetector(
                  child: const Text('Sign Up',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w300)),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, 'register');
                  }),
            ],
          ),
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