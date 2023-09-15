import 'package:flutter/material.dart';

class iTextFieldWidget extends StatelessWidget {
  final int flex;
  final TextStyle textStyle;
  final String labelText;
  final TextEditingController textEditingController;

  const iTextFieldWidget({super.key, required this.flex, required this.labelText, required this.textStyle, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      child: TextFormField(
        controller: textEditingController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelStyle: textStyle,
          labelText: labelText,
        ),
      ),
    );
  }
}