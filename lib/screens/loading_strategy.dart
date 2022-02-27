import 'package:flutter/material.dart';


class LoadingStrategies  extends StatelessWidget {
  const LoadingStrategies ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: Colors.blue,)
      ),
    );
  }
}