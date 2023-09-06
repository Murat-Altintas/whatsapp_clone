import 'package:flutter/material.dart';
import 'package:whatsapp_clone/View/core/divider_widget.dart';
import 'package:whatsapp_clone/View/core/drop_down_list_widget.dart';
import 'package:whatsapp_clone/View/core/top_bar_widget.dart';
import 'package:whatsapp_clone/View/core/text_field_widget.dart';
import 'package:whatsapp_clone/utils/text_theme.dart';
import '../utils/coloors.dart';

class AddPhoneNumber extends StatefulWidget {
  const AddPhoneNumber({super.key});

  @override
  State<AddPhoneNumber> createState() => _AddPhoneNumberState();
}

class _AddPhoneNumberState extends State<AddPhoneNumber> {
  final textTheme = MyTextTheme.instance!;
  final colorScheme = Coloors.instance!;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          iTopBarWidgetWidget(
            alignment: Alignment.bottomCenter,
            height: 100,
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Expanded(
                  flex: 4,
                  child: Text(
                    "Phone number",
                    style: textTheme.hLBlack,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/second");
                    },
                    child: Text(
                      "Done",
                      style: textTheme.hLGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            heightFactor: 2,
            child: SizedBox(
                width: 280,
                child: Text(
                  "Please confirm your country code and enter your phone number",
                  style: textTheme.subBlack,
                  textAlign: TextAlign.center,
                )),
          ),

          iDividerWidget(height: 20, indent: 0),
          //TODO: https://restcountries.com/v3.1/independent?
          SizedBox(width: Size.infinite.width, height: 50, child: iDropDownListWidget(dropDownValue: "Turkey")),
          Row(
            children: [
              iTextFieldWidget(
                flex: 1,
                labelText: "    +1",
                textStyle: textTheme.hLBlack.copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: 27,
                ),
              ),
              iTextFieldWidget(
                flex: 3,
                labelText: "phone number",
                textStyle: textTheme.hLGrey.copyWith(fontWeight: FontWeight.w300, fontSize: 27),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
