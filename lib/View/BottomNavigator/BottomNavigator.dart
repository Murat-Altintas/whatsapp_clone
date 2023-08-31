import 'package:flutter/material.dart';
import 'package:whatsapp_clone/View/core/top_bar_widget.dart';
import '../../utils/coloors.dart';
import '../../utils/text_theme.dart';

class IBottomNav extends StatefulWidget {
  const IBottomNav({super.key});

  @override
  State<IBottomNav> createState() => _IBottomNavState();
}

class _IBottomNavState extends State<IBottomNav> {
  @override
  Widget build(BuildContext context) {
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
