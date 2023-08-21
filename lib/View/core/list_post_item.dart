import 'package:flutter/material.dart';
import 'package:whatsapp_clone/View/core/divider_widget.dart';

import '../../Control/post.dart';

class ListPostItem extends StatelessWidget {
  const ListPostItem({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(radius: 25, backgroundImage: NetworkImage(post.photos)),
          title: Text("${post.id}"),
          subtitle: Text(post.title),
        ),
        iDivider(height: 5, indent: 80),
      ],
    );
  }
}
