import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sync_note/util/export.dart';
import 'package:sync_note/util/global_variable.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: kWidth * 0.6,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.0.h, horizontal: 5.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: kHeight * 0.05),

            //  Align(
            //   alignment: Alignment.center,
            //   child: SizedBox(
            //     height: kWidth * 0.1,
            //     width: kWidth * 0.1,
            //     child : Image.asset("images/splash_screen_icon.jpg")
            //   ),
            // ),
            // SizedBox(height: kHeight * 0.1),
            // Divider(endIndent: 8.0.w, indent: 8.0.w, height: 1.0),
           
             DrawerItem(
              icon: LineIcons.file,
              text: "Draft",
              function: () => context.pushNamed("Draft"),
            ),
            SizedBox(height: 8.h),
            
             DrawerItem(
              icon: LineIcons.userLock,
              text: "PrivaCorner",
              function: () => context.pushNamed("PrivaCorner"),
            ),
            SizedBox(height: 8.h),
            DrawerItem(
              icon: LineIcons.cog,
              text: "Settings",
              function: () => context.pushNamed("Settings"),
            ),
            const Expanded(child: SizedBox(height: 10)),
            // const Align(alignment: Alignment.center, child: Text("Made in Algeria"))s
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({super.key, required this.icon, required this.text, this.function});
  final IconData? icon;
  final String text;
  final void Function()? function;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
      ),
      title: Text(
        text,
        style: context.theme.textTheme.labelMedium,
      ),
      splashColor: context.theme.primaryColor,
      onTap: function,
    );
  }
}
