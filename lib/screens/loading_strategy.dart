import 'package:flutter/material.dart';

class LoadingStrategies extends StatelessWidget {
  const LoadingStrategies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: Colors.blue));
  }
}
