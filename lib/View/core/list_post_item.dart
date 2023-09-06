import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/View/core/divider_widget.dart';
import 'package:whatsapp_clone/utils/extensions.dart';

import '../../Model/post.dart';
import '../../Control/post_bloc.dart';
import '../../utils/coloors.dart';
import '../../utils/text_theme.dart';

class ListPostItem extends StatefulWidget {
  const ListPostItem({super.key, required this.post});

  final Post post;

  @override
  State<ListPostItem> createState() => _ListPostItemState();
}

class _ListPostItemState extends State<ListPostItem> {
  bool changePress = false;
  bool changeColor = true;
  Color dotColor = Coloors.lightGrey;
  final textTheme = MyTextTheme.instance!;
  final colorScheme = Coloors.instance!;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, postState) {
        return Padding(
          padding: context.padHorizontal20,
          child: GestureDetector(
            onLongPress: () {
              setState(() {
                changePress = !changePress;
              });
            },
            onTap: () {
              "changePress: $changePress".log();
              setState(() {
                changeColor = !changeColor;
                if (changeColor && changePress) {
                  dotColor = Coloors.lightGrey;
                } else {
                  dotColor = Coloors.lightGreen;
                }
              });
            },
            child: changePress == true
                ? Column(
                    children: [
                      Row(
                        children: [
                          changeColor == true
                              ? Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    shape: BoxShape.circle,
                                  ),
                                )
                              : Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.lightGreen,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                          Flexible(
                            child: ListTile(
                              leading: CircleAvatar(radius: 25, backgroundImage: NetworkImage(widget.post.photos)),
                              title: Text("${widget.post.id}"),
                              subtitle: Text(widget.post.title),
                            ),
                          ),
                        ],
                      ),
                      iDivider(height: 5, indent: 80),
                    ],
                  )
                : Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(radius: 25, backgroundImage: NetworkImage(widget.post.photos)),
                        title: Text(
                          "${widget.post.id}",
                          style: TextStyle(
                            color: postState.onLongPress == true ? Colors.red : Colors.lightGreen,
                          ),
                        ),
                        subtitle: Text(widget.post.title),
                      ),
                      iDivider(height: 5, indent: 80),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
