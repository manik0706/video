import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sourcecad_app/utils/extensions/goto.dart';
import 'package:sourcecad_app/utils/extensions/theme_extension.dart';
import '../constant/my_theme.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleName;
  final String? title;
  final Widget? leading;
  final double height;
  final double? elevation;
  final Color? backgroundColor, titleColor, statusBarColor;
  final Brightness? statusBarIconBrightness;
  final bool? centerTitle;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  const MyAppBar({
    super.key,
    this.titleName,
    this.title,
    this.leading,
    this.height = kToolbarHeight,
    this.elevation = 0.0,
    this.backgroundColor = Colors.white,
    this.titleColor,
    this.statusBarColor,
    this.statusBarIconBrightness,
    this.centerTitle = false,
    this.actions,
    this.bottom,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.theme.background,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
      centerTitle: centerTitle,
      bottom: bottom,
      leading: leading ??
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color:context.theme.onBackground,
              size: 22,
            ),
            onPressed: () {
              context.pop();
            },
          ),
      title: Text(
        title ?? "",
        style: TextStyle(
          color:context.theme.onBackground,
          fontSize: 18,
          letterSpacing: 1,
          fontWeight: FontWeight.w900,),
      ),
      actions: actions,
    );
  }
}
