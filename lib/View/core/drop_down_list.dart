import 'package:flutter/material.dart';
import 'package:whatsapp_clone/utils/extensions.dart';

import '../../utils/text_theme.dart';

//TODO: this widget can be Stateless?
class DropDownList extends StatefulWidget {
  DropDownList({super.key, required this.dropDownValue});

  String dropDownValue;

  @override
  State<DropDownList> createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  final textTheme = MyTextTheme.instance!;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      iconSize: 15,
      style: textTheme.hLBlue,
      value: widget.dropDownValue,
      icon: Icon(Icons.navigate_next),
      isExpanded: true,
      padding: context.padHorizontal,
      items: <String>['United States', 'Turkey', 'Italy', 'Algeria'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          widget.dropDownValue = newValue!;
        });
      },
    );
  }
}
