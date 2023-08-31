import 'package:flutter/material.dart';
import '../../utils/coloors.dart';

class IBarWidget extends StatelessWidget {
   const IBarWidget( {super.key, this.widget, required this.alignment, required this.height});
  final double height;
  final AlignmentGeometry alignment;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Size.infinite.width,
        height: height,
        color: Coloors.lightWhite,
        child: Align(
          alignment: alignment,
          child: widget,
        ));
  }
}
