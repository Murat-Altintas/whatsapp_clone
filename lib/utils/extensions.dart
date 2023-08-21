import 'package:flutter/cupertino.dart';
import 'dart:developer' as devtools show log;

extension PaddingExtension on BuildContext {
  EdgeInsets get padVertical => EdgeInsets.symmetric(vertical: 20);

  EdgeInsets get padHorizontal => EdgeInsets.symmetric(horizontal: 10);
}

extension Log on Object {
  void log() => devtools.log(toString());
}
