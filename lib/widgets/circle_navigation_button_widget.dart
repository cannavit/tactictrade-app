import 'package:flutter/material.dart';

class CircleNavigationButtonWidget extends StatelessWidget {
  const CircleNavigationButtonWidget({
    Key? key, this.navigationTo='create_strategy',
  }) : super(key: key);

  final String navigationTo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 3,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushReplacementNamed(context, navigationTo);
        },
      ),
    );
  }
}
