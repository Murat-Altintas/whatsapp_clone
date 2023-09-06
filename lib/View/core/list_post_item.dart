import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/View/core/divider_widget.dart';
import 'package:whatsapp_clone/utils/extensions.dart';

import '../../Model/post.dart';
import '../../Control/post_bloc.dart';
import '../../utils/coloors.dart';
import '../../utils/text_theme.dart';

class ListPostItem extends StatefulWidget {
  const ListPostItem({super.key, required this.post, required this.index});

  final int index;
  final Post post;

  @override
  State<ListPostItem> createState() => _ListPostItemState();
}

class _ListPostItemState extends State<ListPostItem> {
  final textTheme = MyTextTheme.instance!;
  final colorScheme = Coloors.instance!;
  late bool changeColor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, postState) {
        if (context.read<PostBloc>().selectAndRemove.contains(widget.index)) {
          changeColor = false;
        } else {
          changeColor = true;
        }
        return Padding(
          padding: context.padHorizontal20,
          child: GestureDetector(
            onTap: () {
              if (postState.onLongPress && changeColor) {
                context.read<PostBloc>().selectAndRemove.add(widget.index);
                context.read<PostBloc>().selectAndRemove.log();
              } else {
                context.read<PostBloc>().selectAndRemove.remove(widget.index);
              }
              context.read<PostBloc>().onChangeColor();
            },
            child: postState.onLongPress == true
                ? Column(
                    children: [
                      Row(
                        children: [
                          changeColor
                              ? Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Coloors.lightGrey),
                                    shape: BoxShape.circle,
                                  ),
                                )
                              : Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Coloors.lightGreen,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                          Flexible(
                            child: ListTile(
                              leading: CircleAvatar(radius: 25, backgroundImage: NetworkImage(widget.post.photos)),
                              title: Text(
                                "${widget.post.id}",
                                style: textTheme.hLBlack,
                              ),
                              subtitle: Text(
                                widget.post.title,
                                style: textTheme.chatGrey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      iDividerWidget(height: 5, indent: 80),
                    ],
                  )
                : Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(radius: 25, backgroundImage: NetworkImage(widget.post.photos)),
                        title: Text(
                          "${widget.post.id}",
                          style: textTheme.hLBlack,
                        ),
                        subtitle: Text(
                          widget.post.title,
                          style: textTheme.chatGrey,
                        ),
                      ),
                      iDividerWidget(height: 5, indent: 80),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
