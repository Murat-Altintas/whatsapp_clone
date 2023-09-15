import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/View/ChatListView/chat_list_main.dart';
import 'package:whatsapp_clone/View/core/divider_widget.dart';
import 'package:whatsapp_clone/View/core/drop_down_list_widget.dart';
import 'package:whatsapp_clone/View/core/top_bar_widget.dart';
import 'package:whatsapp_clone/View/core/text_field_widget.dart';
import 'package:whatsapp_clone/utils/extensions.dart';
import 'package:whatsapp_clone/utils/text_theme.dart';
import '../utils/coloors.dart';

class AddPhoneNumber extends StatefulWidget {
  const AddPhoneNumber({super.key});

  @override
  State<AddPhoneNumber> createState() => _AddPhoneNumberState();
}

class _AddPhoneNumberState extends State<AddPhoneNumber> {
  TextEditingController _codecontroller =  TextEditingController();
  final textTheme = MyTextTheme.instance!;
  final colorScheme = Coloors.instance!;
  String phoneNumber = "", _data = "", smscode = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;

  _signInWithMobileNumber() async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: '+91' + _codecontroller.text.trim(),
          verificationCompleted: (PhoneAuthCredential authCredential) async {
            await _auth.signInWithCredential(authCredential).then((value) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatList()));
            });
          },
          verificationFailed: ((error) {
            "verification Faild Error is:  + $error".log();
          }),
          codeSent: (String verificationId, [int? forceResendingToken]) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                      title: Text("Enter OTP"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: _codecontroller,
                          )
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              FirebaseAuth auth = FirebaseAuth.instance;
                              smscode = _codecontroller.text;
                              PhoneAuthCredential _credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smscode);
                              auth.signInWithCredential(_credential).then((result) {
                                if (result != null) {
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatList()));
                                  "RESULT IS: $result".log();
                                }
                              }).catchError((e) {
                                "CATCH ERROR IS: $e".log();
                              });
                            },
                            child: Text("Done"))
                      ],
                    ));
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            verificationId = verificationId;
          },
          timeout: Duration(seconds: 2));
    } catch (e) {}
  }

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
                      //_data = phoneNumber;
                      //phoneNumber = "";
                      setState(() {});
                      _codecontroller.log();
                      _signInWithMobileNumber();
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
                textEditingController: _codecontroller,
                flex: 1,
                labelText: "    +1",
                textStyle: textTheme.hLBlack.copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: 27,
                ),
              ),

              /*
              iTextFieldWidget(
                flex: 3,
                labelText: "phone number",
                textStyle: textTheme.hLGrey.copyWith(fontWeight: FontWeight.w300, fontSize: 27),
              ),
               */
            ],
          ),
        ],
      ),
    );
  }
}
