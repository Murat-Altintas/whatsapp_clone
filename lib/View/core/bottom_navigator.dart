import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/View/core/top_bar_widget.dart';
import 'package:whatsapp_clone/utils/extensions.dart';
import '../../Control/post_bloc.dart';
import '../../utils/coloors.dart';
import '../../utils/text_theme.dart';

class IBottomNav extends StatefulWidget {
  const IBottomNav({super.key});

  @override
  State<IBottomNav> createState() => _IBottomNavState();
}

class _IBottomNavState extends State<IBottomNav> {
  final textTheme = MyTextTheme.instance!;
  final colorScheme = Coloors.instance!;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, postState) {
        switch (postState.onLongPress) {
          case != true:
            return IBarWidget(
              alignment: Alignment.center,
              height: 90,
              widget: Padding(
                padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NavIcons(
                      voidCallback: () {
                        Navigator.of(context).pushNamed("/longPress");
                      },
                      iconData: Icons.track_changes,
                      text: "Status",
                    ),
                    NavIcons(
                      voidCallback: () {
                        Navigator.of(context).pushNamed("/");
                      },
                      iconData: Icons.call_outlined,
                      text: "Calls",
                    ),
                    NavIcons(
                      voidCallback: () {
                        Navigator.of(context).pushNamed("/");
                      },
                      iconData: Icons.camera_enhance_outlined,
                      text: "Camera",
                    ),
                    NavIcons(
                      voidCallback: () {
                        Navigator.of(context).pushNamed("/");
                      },
                      iconData: Icons.wechat_sharp,
                      text: "Chats",
                    ),
                    NavIcons(
                      voidCallback: () {
                        Navigator.of(context).pushNamed("/");
                      },
                      iconData: Icons.settings,
                      text: "Settings",
                    ),
                  ],
                ),
              ),
            );
          case == true:
            return IBarWidget(
              height: 100,
              alignment: Alignment.topCenter,
              widget: Padding(
                padding: EdgeInsets.only(top: 15, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: postState.onLongPress == true ? () {} : null,
                      child: Text(
                        "Archive",
                        style: postState.onLongPress == false ? textTheme.hLBlue : textTheme.subGrey,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TextButton(
                      onPressed: postState.onLongPress == true ? () {} : null,
                      child: Text(
                        "Read All",
                        style: postState.onLongPress == false ? textTheme.hLBlue : textTheme.subGrey,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TextButton(
                      onPressed: postState.onLongPress == true ? () {} : null,
                      child: Text(
                        "Delete",
                        style: postState.onLongPress == false ? textTheme.hLBlue : textTheme.subGrey,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          default:
            return Center(
              child: Text("Error"),
            );
        }
      },
    );
  }
}

class NavIcons extends StatelessWidget {
  NavIcons({
    super.key,
    required this.voidCallback,
    required this.iconData,
    required this.text,
  });

  final textTheme = MyTextTheme.instance!;

  final VoidCallback voidCallback;
  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: voidCallback,
      child: SizedBox(
        height: 50,
        child: Column(
          children: [
            Icon(
              iconData,
              size: 35,
              color: Coloors.lightGrey,
            ),
            Spacer(),
            Text(
              text,
              style: textTheme.navGrey,
            ),
          ],
        ),
      ),
    );
  }
}
