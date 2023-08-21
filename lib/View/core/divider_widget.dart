import 'package:flutter/material.dart';

import '../../utils/coloors.dart';

Widget iDivider({required double height, required double indent}) {

  return Divider(
    indent: indent,
    color: Coloors.lightGrey,
    thickness: 1,
    height: height,
  );
}
