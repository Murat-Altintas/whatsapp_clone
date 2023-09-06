import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/utils/extensions.dart';

import '../../Control/post_bloc.dart';
import '../../utils/coloors.dart';
import '../../utils/text_theme.dart';
import '../core/top_bar_widget.dart';

class TopBarWidget extends StatelessWidget {
  TopBarWidget({super.key});

  final textTheme = MyTextTheme.instance!;
  final colorScheme = Coloors.instance!;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, postState) {
        switch (postState.onLongPress) {
          case != true:
            return iTopBarWidgetWidget(
              alignment: Alignment.bottomCenter,
              height: 100,
              widget: Padding(
                padding: context.padHorizontal10,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextButton(
                          onPressed: () {
                            context.read<PostBloc>().onPressChange();
                          },
                          child: Text(
                            "Edit",
                            style: textTheme.hLBlue,
                          )),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text(
                        "Chats",
                        style: textTheme.hLBlack,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.message_rounded),
                        color: Coloors.lightBlue,
                      ),
                    ),
                  ],
                ),
              ),
            );
          case == true:
            return Padding(
              padding: EdgeInsets.only(top: 50),
              child: iTopBarWidgetWidget(
                color: Colors.transparent,
                alignment: Alignment.bottomLeft,
                height: 100,
                widget: Padding(
                  padding: context.padHorizontal10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: () {
                            context.read<PostBloc>().onPressChange();
                          },
                          child: Text(
                            "Done",
                            style: textTheme.hLBlue,
                          )),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "Chats",
                          style: textTheme.hLBlack.copyWith(fontSize: 34),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          default:
            return Text("Error");
        }
      },
    );
  }
}
