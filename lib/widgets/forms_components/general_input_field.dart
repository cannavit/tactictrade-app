import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/providers/providers.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

class GeneralInputField extends StatelessWidget {
  //
  final String labelText;
  final String hintText;
  final Widget? icon;
  final String? validatorType;
  final Color colorBorder;
  final Color colorBorderSelected;
  final bool isRequired;
  final String valueType;
  final TextEditingController textController;
  final int maxLine;
  final TextInputType textInputType;
  final bool btnEnabled;
  final bool enabled;

  const GeneralInputField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.icon,
    this.valueType = '',
    this.validatorType = null,
    this.colorBorder = Colors.white,
    this.colorBorderSelected = Colors.blue,
    this.isRequired = false,
    required this.textController,
    this.maxLine = 1,
    this.textInputType = TextInputType.text,
    this.btnEnabled = false, this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
          enabled: enabled,
          maxLines: maxLine,
          controller: textController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          // autovalidateMode: AutovalidateMode.always,
          autocorrect: false,
          keyboardType: textInputType,
          decoration: InputDecoration(
              hintText: hintText,
              labelText: labelText,
              contentPadding: new EdgeInsets.fromLTRB(10, 10, 10, 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorBorderSelected),
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
              prefixIcon: Padding(
                padding: EdgeInsets.all(0.0),
                child: icon, // icon is 48px widget.
              )),
          validator: (value) {
            // Validator minimumCharacters -------------------------

            if (validatorType == 'minimumCharacters') {
              if (value != null && value.length < 6) {
                return 'Name must be at least 6 characters long';
              }
            }

            if (validatorType == 'writeMandatory') {
              if (value != null && value.length < 2) {
                return 'This field is required';
              }
            }

            if (validatorType == 'interger') {
              try {
                final interger = int.parse(value!);
              } catch (error) {
                return 'Need to be interger';
              }
            }

            if (validatorType == 'porcentaje') {
              try {
                final number = double.parse(value!);
              } catch (error) {
                return 'Need to be numeric';
              }
            }

            if (Preferences.formValidatorCounter > 8) {
              Preferences.createNewStrategy = true;
            } else {
              Preferences.createNewStrategy = false;
            }
          }),
    );
  }
}
