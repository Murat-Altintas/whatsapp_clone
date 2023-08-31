import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:whatsapp_clone/View/BottomNavigator/BottomNavigator.dart';
import 'package:whatsapp_clone/utils/extensions.dart';
import '../Control/post.dart';
import '../Control/post_bloc.dart';
import '../utils/coloors.dart';
import '../utils/text_theme.dart';
import 'core/IndıcatorWidget.dart';
import 'core/divider_widget.dart';
import 'core/list_post_item.dart';
import 'core/top_bar_widget.dart';

class ChatList extends StatefulWidget {
  const ChatList({
    super.key,
  });

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final textTheme = MyTextTheme.instance!;
  final colorScheme = Coloors.instance!;
  late ScrollController _scrollController;
  bool pressFalse = false;
  @override
  void initState() {

    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    //_scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) context.read<PostBloc>().add(PostFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;
      return currentScroll >= (maxScroll * .9);
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Column(
        children: [
          topBarWidget(context, textTheme),
          topNavigator(context, textTheme),
          TextButton(
              onPressed: () {
                setState(() {
                  //pressFalse == false ? true : false;
                  pressFalse = !pressFalse;
                  print(pressFalse);
                });
               //context.read<PostBloc>().cleanList(pressFalse);
              },
              child: Text("click")),
          mainList(context),
          IBottomNav(),
        ],
      ),
    );
  }

  IBarWidget topBarWidget(BuildContext context, MyTextTheme textTheme) {
    return IBarWidget(
      alignment: Alignment.bottomCenter,
      height: 100,
      widget: Padding(
        padding: context.padHorizontal10,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Edit",
                  style: textTheme.hLBlack,
                ),
              ),
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
  }

  Expanded mainList(BuildContext context) {
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
                controller: _scrollController,
                itemBuilder: (context, index) {
                  return index >= postState.posts.length
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
                                onPressed: (BuildContext context) => (context.read<PostBloc>().removeFromList(index)),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: context.padHorizontal20,
                            child: Column(
                              children: [
                                ListPostItem(
                                  post: postState.posts[index],
                                )
                              ],
                            ),
                          ),

                          /*
                          child: ListPostItem(

                            post: postState.posts[index],
                          ),












 Row(
                                  children: [
                                    GestureDetector(
                                      onLongPress: () {},
                                      child: postState.onLongPress == true
                                          ? Row(
                                              children: [
                                                Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: postState.onLongPress == true ? Colors.grey : Colors.red),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text("${postState.posts[index].id}"),

                                                CircleAvatar(radius: 25, backgroundImage: NetworkImage(postState.posts[index].photos)),
                                              ],
                                            )
                                          : Text("${postState.posts[index].id}"),
                                    )
                                  ],
                                ),
                                iDivider(height: 5, indent: 80),
                           */
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

Padding topNavigator(BuildContext context, textTheme) {
  return Padding(
    padding: context.padHorizontal10,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                "Broadcast Lists",
                style: textTheme.hLBlue,
                textAlign: TextAlign.center,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "New Group",
                style: textTheme.hLBlue,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
