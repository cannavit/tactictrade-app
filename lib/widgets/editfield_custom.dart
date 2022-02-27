import 'package:flutter/material.dart';

class EditTextField extends StatelessWidget {
  const EditTextField({
    Key? key,
    required this.themeColors,
    required this.usernameCtrl,
    required this.nameEditField,
    this.maxLines = 1,
    this.readOnly = false,
    this.colorFilled = Colors.transparent,
    this.suffixIcon = null, 
    this.fontSize=20,
    // this.textStyle = ,
  }) : super(key: key);

  final ThemeData themeColors;
  final TextEditingController usernameCtrl;
  final String nameEditField;
  final int maxLines;
  final bool readOnly;
  final Color colorFilled;
  final IconButton? suffixIcon;
  final double fontSize;
  // final  TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(nameEditField,
              style: TextStyle(
                  color: themeColors.hintColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          Container(
            child: TextField(
              readOnly: readOnly,
              controller: usernameCtrl,
              maxLines: maxLines,
              style: TextStyle(fontSize: fontSize),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: colorFilled,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18)),
                  suffixIcon: suffixIcon != null ? suffixIcon : null),
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
