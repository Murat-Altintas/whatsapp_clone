import 'package:flutter/material.dart';

class Coloors {
  static Coloors? _instace;

  static Coloors? get instance {
    _instace ??= Coloors._init();
    return _instace;
  }

  Coloors._init();

  static const Color lightGreen = Colors.teal;
  static const Color lightBlue = Colors.blueAccent;
  static const Color lightGrey = Colors.grey;
  static const Color lightWhite = Colors.black26;
  static const Color chatBG = Colors.blueGrey;
  static const Color chatBubbleGreen = Colors.greenAccent;
  static const Color chatBubbleWhite = Colors.white;
  static const Color errorColor = Colors.red;
}
