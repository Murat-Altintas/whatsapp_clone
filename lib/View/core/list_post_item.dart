import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/View/core/divider_widget.dart';
import 'package:whatsapp_clone/utils/extensions.dart';

import '../../Control/post.dart';
import '../../Control/post_bloc.dart';

class ListPostItem extends StatefulWidget {
  const ListPostItem({super.key, required this.post});

  final Post post;

  @override
  State<ListPostItem> createState() => _ListPostItemState();
}

class _ListPostItemState extends State<ListPostItem> {
  bool changePress = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, postState) {
        return Padding(
          padding: context.padHorizontal20,
          child: GestureDetector(
            onTap: () {
              setState(() {
                changePress = !changePress;
              });
            },
            child: changePress == true
                ? Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
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
                        title: Text("${widget.post.id}"),
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