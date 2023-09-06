import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/View/core/bottom_navigator.dart';
import 'package:whatsapp_clone/View/ChatListView/main_list.dart';
import 'package:whatsapp_clone/View/ChatListView/top_bar.dart';
import 'package:whatsapp_clone/View/ChatListView/top_navigator.dart';
import '../../Control/post_bloc.dart';
import '../../utils/coloors.dart';
import '../../utils/text_theme.dart';

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
          TopBarWidget(),
          TopNavigator(),
          TextButton(
              onPressed: () {
                context.read<PostBloc>().changeName();
              },
              child: Text("click")),
          MainList(scrollController: _scrollController),
          IBottomNav(),
        ],
      ),
    );
  }
}
