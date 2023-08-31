import 'package:flutter/material.dart';

class OnLongPress extends StatefulWidget {
  const OnLongPress({super.key});

  @override
  State<OnLongPress> createState() => _OnLongPressState();
}

class _OnLongPressState extends State<OnLongPress> {

  Color color = Colors.red;
  double w = 100.0;
  double h = 100.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: w,
            height: h,
            color: color,
          ),
          onLongPress: () {
            setState(() {
              color = Colors.blue;
              h = 75.0;
              w = 125.0;
            });
          },
        ),
      ),
    );
  }
}
