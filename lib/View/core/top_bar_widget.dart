import 'package:flutter/material.dart';
import '../../utils/coloors.dart';

class iTopBarWidgetWidget extends StatelessWidget {
   const iTopBarWidgetWidget( {super.key, required this.widget, required this.alignment, required this.height, this.color});
  final double height;
  final AlignmentGeometry alignment;
  final Widget widget;
  final Color? color;

  @override
  Widget build(BuildContext context) {

    return Container(
        width: Size.infinite.width,
        height: height,
        color: color ?? Coloors.lightWhite,
        child: Align(
          alignment: alignment,
          child: widget,
        ));
  }
}
