import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:whatsapp_clone/utils/extensions.dart';

import '../../Control/post_bloc.dart';
import '../core/indicator_widget.dart';
import '../core/list_post_item.dart';

class MainList extends StatelessWidget {
  const MainList({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, postState) {
          switch (postState.status) {
            case PostStatus.failure:
              return Center(
                child: Text("Error"),
              );
            case PostStatus.success:
              if (postState.posts.isEmpty) {
                return Center(
                  child: Text("Not any post find"),
                );
              }
              return ListView.builder(
                itemCount: postState.hasReachedMax ? postState.posts.length : postState.posts.length + 1,
                controller: scrollController,
                itemBuilder: (context, postIndex) {
                  return postIndex >= postState.posts.length
                      ? IndicatorWidget()
                      : Slidable(
                    endActionPane: ActionPane(
                      extentRatio: 0.4,
                      motion: StretchMotion(),
                      children: [
                        SlidableAction(
                          spacing: 7,
                          backgroundColor: Colors.grey.shade400,
                          icon: Icons.more_horiz,
                          label: "More",
                          foregroundColor: Colors.white,
                          onPressed: (BuildContext context) => (),
                        ),
                        SlidableAction(
                          spacing: 7,
                          backgroundColor: Colors.blueAccent,
                          icon: Icons.archive,
                          label: "Archive",
                          onPressed: (BuildContext context) => (context.read<PostBloc>().removeFromList()),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: context.padHorizontal20,
                      child: Column(
                        children: [
                          ListPostItem(
                            post: postState.posts[postIndex], index: postIndex,
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            default:
              return Center(
                child: Text("Please wait..."),
              );
          }
        },
      ),
    );
  }
}
