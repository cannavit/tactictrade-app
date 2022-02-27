import 'package:flutter/material.dart';

class SimpleAppBarTextAndButtom extends StatelessWidget {
  const SimpleAppBarTextAndButtom({
    Key? key, required this.text, required this.navigationScreen,
  }) : super(key: key);

  final String text;
  final String navigationScreen;

  @override
  Widget build(BuildContext context) {


    return Container(
        child: Row(
      children: [

        Container(
          width: 26,
          child: IconButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, navigationScreen),
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.white,
            ),
          ),


        ),

        Expanded(child: Container()),

        // const SizedBox(width: 120),
         Container(
           alignment: Alignment.center,
          //  width: MediaQuery.of(context).size.width * 0.9,

           child: Text(text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w300)),
         ),
          const SizedBox(width: 20),
         Expanded(child: Container()),
      ],
    ));
  }
}