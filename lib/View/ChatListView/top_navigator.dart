import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/utils/extensions.dart';

import '../../Control/post_bloc.dart';
import '../../utils/coloors.dart';
import '../../utils/text_theme.dart';

class TopNavigator extends StatelessWidget {
   TopNavigator({super.key});

  final textTheme = MyTextTheme.instance!;
  final colorScheme = Coloors.instance!;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, postState) {
        return Padding(
          padding: context.padHorizontal10,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: postState.onLongPress == false ? () {} : null,
                    child: Text(
                      "Broadcast Lists",
                      style:
                      postState.onLongPress == false ?
                      textTheme.hLBlue
                          :
                      textTheme.subGrey,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TextButton(
                    onPressed: postState.onLongPress == false ? () {} : null,
                    child: Text(
                      "New Group",
                      style:
                      postState.onLongPress == false ?
                      textTheme.hLBlue
                          :
                      textTheme.subGrey,
                      textAlign: TextAlign.center,
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
