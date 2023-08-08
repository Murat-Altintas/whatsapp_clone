import 'package:flutter/material.dart';

import 'coloors.dart';

class MyTextTheme {
  static MyTextTheme? _instace;
  static MyTextTheme? get instance {
    _instace ??= MyTextTheme._init();
    return _instace;
  }

  final colorScheme = Coloors.instance!;

  MyTextTheme._init();

  final TextStyle hLBlack = const TextStyle(
    fontSize: 17,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );
  final TextStyle hLGrey = const TextStyle(
    fontSize: 17,
    color: Coloors.lightGrey,

    fontWeight: FontWeight.w600,
  );
  final TextStyle hLBlue = const TextStyle(
    fontSize: 17,
    color: Coloors.lightBlue,
    fontWeight: FontWeight.w400,
  );
  final TextStyle subGrey = const TextStyle(
    fontSize: 14,
    color: Coloors.lightGrey,
    fontWeight: FontWeight.w400,

  );
  final TextStyle subWhite = const TextStyle(
    fontSize: 14,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );

  final TextStyle subBlack = const TextStyle(
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w400,
  );

  final TextStyle chatBlack = const TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w400,);

  final TextStyle chatGrey = const TextStyle(
    fontSize: 14,
    color: Coloors.lightGrey,
    fontWeight: FontWeight.w400,
  );

  final TextStyle navGrey = const TextStyle(
    fontSize: 10,
    color: Coloors.lightGrey,
    fontWeight: FontWeight.w500,
  );

  final TextStyle redText = const TextStyle(
    fontSize: 16,
    color: Colors.red,
    fontWeight: FontWeight.w400,
  );
}