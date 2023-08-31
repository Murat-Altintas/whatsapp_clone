import 'package:flutter/cupertino.dart';
import 'dart:developer' as devtools show log;

extension PaddingExtension on BuildContext {
  EdgeInsets get padVertical20 => EdgeInsets.symmetric(vertical: 20);
  EdgeInsets get padVertical30 => EdgeInsets.symmetric(vertical: 30);

  EdgeInsets get padHorizontal10 => EdgeInsets.symmetric(horizontal: 10);
  EdgeInsets get padHorizontal20 => EdgeInsets.symmetric(horizontal: 20);
}

extension Log on Object {
  void log() => devtools.log(toString());
}
