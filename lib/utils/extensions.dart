import 'package:flutter/cupertino.dart';

extension PaddingExtension on BuildContext {
  EdgeInsets get padVertical => EdgeInsets.symmetric(vertical: 20);

  EdgeInsets get padHorizontal => EdgeInsets.symmetric(horizontal: 20);
}
