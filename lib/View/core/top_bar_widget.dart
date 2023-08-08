import 'package:flutter/material.dart';
import '../../utils/coloors.dart';

class TopBarWidget extends StatelessWidget {
   const TopBarWidget( {super.key, this.widget, });

  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Size.infinite.width,
        height: 132,
        color: Coloors.lightWhite,
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: widget,
        ));
  }
}