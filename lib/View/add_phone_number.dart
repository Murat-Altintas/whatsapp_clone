import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/View/ChatListView/chat_list_main.dart';
import 'package:whatsapp_clone/View/core/divider_widget.dart';
import 'package:whatsapp_clone/View/core/drop_down_list_widget.dart';
import 'package:whatsapp_clone/View/core/indicator_widget.dart';
import 'package:whatsapp_clone/View/core/top_bar_widget.dart';
import 'package:whatsapp_clone/View/core/text_field_widget.dart';
import 'package:whatsapp_clone/utils/text_theme.dart';
import '../utils/coloors.dart';
import 'PhoneAuth/view-model/phone_auth_bloc.dart';

class AddPhoneNumber extends StatefulWidget {
  const AddPhoneNumber({super.key});

  @override
  State<AddPhoneNumber> createState() => _AddPhoneNumberState();
}

class _AddPhoneNumberState extends State<AddPhoneNumber> {
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _otpCode = TextEditingController();
  final textTheme = MyTextTheme.instance!;
  final colorScheme = Coloors.instance!;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneAuthBloc, PhoneAuthState>(
      listener: (context, state) {
        if (state is PhoneAuthVerified) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => ChatList()));
        }
      },
      builder: (context, state) {
        if (state is PhoneAuthLoading) {
          return LoadingState();
        }
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
                    if (state is! PhoneAuthCodeSentSuccess)
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            context.read<PhoneAuthBloc>().add(SendOtpToPhoneEvent(phoneNumber: "+90" + _phoneNumber.text));
                          },
                          child: Text(
                            "Phone",
                            style: textTheme.hLGrey,
                          ),
                        ),
                      ),
                    if (state is PhoneAuthCodeSentSuccess)
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            context.read<PhoneAuthBloc>().add(VerifySentOtpEvent(_otpCode.text, state.verificationId));
                          },
                          child: Text(
                            "Otp",
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
              if (state is! PhoneAuthCodeSentSuccess)
                Row(
                  children: [
                    iTextFieldWidget(
                      textEditingController: _phoneNumber,
                      flex: 1,
                      labelText: "Phone Number",
                      textStyle: textTheme.hLBlack.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: 27,
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 20,
              ),
              if (state is PhoneAuthCodeSentSuccess)
                Row(
                  children: [
                    iTextFieldWidget(
                      textEditingController: _otpCode,
                      flex: 1,
                      labelText: "Otp Code",
                      textStyle: textTheme.hLBlack.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: 27,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}

class LoadingState extends StatelessWidget {
  const LoadingState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: IndicatorWidget(),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Loading..."),
        ],
      ),
    );
  }
}
