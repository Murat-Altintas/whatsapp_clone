import 'package:flutter/material.dart';

class ITextField extends StatelessWidget {
  final int flex;
  final TextStyle textStyle;
  final String labelText;

  const ITextField({super.key, required this.flex, required this.labelText, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelStyle: textStyle,
          labelText: labelText,
        ),
      ),
    );
  }
}