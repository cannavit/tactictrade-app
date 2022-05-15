import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/providers/login_form_provider.dart';

class CustomInput extends StatelessWidget {
  // Inputs

  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool validateEmail;

  final String validatorType;

  const CustomInput({
    Key? key,
    // Required parameters

    required this.icon,
    required this.placeholder,
    required this.textController,
    this.validatorType = '',

    // Add default values
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.validateEmail = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    final themeColors = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Container(
          child: TextFormField(
            // cursorColor: Colors.red,

            style: TextStyle(color: Colors.black87),
            controller: textController,
            autocorrect: false,
            keyboardType: keyboardType,
            obscureText: isPassword,

            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(30.0, 14.0, 20.0, 10.0),
              prefixIcon: Icon(icon),
              prefixIconColor: Colors.yellow,
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: placeholder,
              hintStyle: TextStyle(color: themeColors.primaryColorLight),
            ),

            validator: (value) {
              // Validate Email Input

              if (validatorType == 'email') {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);
                return regExp.hasMatch(value ?? '') ? null : 'Check your email';
              }

              if (validatorType == 'password') {
                // Validate Password
                if (value != null && value.length < 6) {
                  return 'Password must be at least 6 characters long';
                }
                return null;
              }
              ;
            },
          ),
        ),
      ),
    );
  }
}

class CustomInputPassword extends StatefulWidget {
  // Inputs

  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool validateEmail;

  final String validatorType;

  const CustomInputPassword({
    Key? key,
    // Required parameters

    required this.icon,
    required this.placeholder,
    required this.textController,
    this.validatorType = '',

    // Add default values
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.validateEmail = false,
  }) : super(key: key);

  @override
  State<CustomInputPassword> createState() => _CustomInputPasswordState();
}

class _CustomInputPasswordState extends State<CustomInputPassword> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);
    final themeColors = Theme.of(context);

    return Container(
      padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Container(
          child: TextFormField(
            // cursorColor: Colors.red,

            style: TextStyle(color: Colors.black87),
            controller: widget.textController,
            autocorrect: false,
            keyboardType: widget.keyboardType,
            obscureText: _isObscure,

            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(30.0, 14.0, 20.0, 10.0),
                prefixIcon: Icon(widget.icon),
                prefixIconColor: Colors.yellow,
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: widget.placeholder,
                //  labelText: 'Password',

                hintStyle: TextStyle(color: themeColors.primaryColorLight),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    print("@Note-01 ---- 1438344309 -----");
                      _isObscure = !_isObscure;

                    setState(() {
                    });
                  },
                )),

            validator: (value) {
              // Validate Email Input
              // Validate Password
              if (value != null && value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              return null;
              ;
            },
          ),
        ),
      ),
    );
  }
}
