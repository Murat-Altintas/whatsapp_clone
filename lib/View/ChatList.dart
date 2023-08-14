import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/utils/extensions.dart';
import '../Control/post_bloc.dart';
import '../utils/coloors.dart';
import '../utils/text_theme.dart';
import 'core/list_post_item.dart';
import 'core/top_bar_widget.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostBloc>(
      create: (_) => PostBloc(
        client: HttpClient(),
      )..add(PostFetched()),
      child: DataList(),
    );
  }
}

class DataList extends StatefulWidget {
  const DataList({
    super.key,
  });

  @override
  State<DataList> createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  final textTheme = MyTextTheme.instance!;
  final colorScheme = Coloors.instance!;
  late ScrollController _scrollController;

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
    _scrollController.addListener(_onScroll);
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
          TopBar(textTheme: textTheme),
          topNavigator(context),
          Expanded(
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
                      itemBuilder: (context, index) {
                        return index >= postState.posts.length ? IndicatorWidget() : ListPostItem(post: postState.posts[index]);
                      },
                      itemCount: postState.hasReachedMax ? postState.posts.length : postState.posts.length + 1,
                      controller: _scrollController,
                    );
                  default:
                    return Center(
                      child: Text("Please wait..."),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
    required this.textTheme,
  });

  final MyTextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return TopBarWidget(
      widget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Edit",
              style: textTheme.hLBlue,
            ),
          ),
          Expanded(
            flex: 0,
            child: Text(
              "Chats",
              style: textTheme.hLBlack,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 0,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.message_rounded),
              color: Coloors.lightBlue,
            ),
          ),
        ],
      ),
    );
  }
}


Padding topNavigator(BuildContext context) {
  return Padding(
    padding: context.padHorizontal,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                "Broadcast Lists",
                //style: textTheme.hLBlue,
                textAlign: TextAlign.center,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "New Group",
                //style: textTheme.hLBlue,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class IndicatorWidget extends StatelessWidget {
  const IndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 36,
        height: 36,
        child: CircularProgressIndicator(
          strokeWidth: 1.5,
        ),
      ),
    );
  }
}
