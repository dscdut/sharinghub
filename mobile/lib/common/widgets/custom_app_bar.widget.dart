import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isCenterTitle;

  final Color backgroundColor;

  final double toolbarHeight;
  final double titleSpacing;
  final double elevation;
  final double bottomSize;

  final String title;
  final Widget? bottom;
  final List<Widget> actions;

  final Function()? onLeadingAction;

  const CustomAppBar({
    super.key,
    this.isCenterTitle = true,
    this.backgroundColor = ColorStyles.blue400,
    this.toolbarHeight = 60,
    this.titleSpacing = 15,
    this.elevation = 0,
    this.bottomSize = 45,
    required this.title,
    this.bottom,
    this.actions = const [],
    this.onLeadingAction,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: isCenterTitle,
      backgroundColor: backgroundColor,
      elevation: elevation,
      toolbarHeight: toolbarHeight,
      titleSpacing: titleSpacing,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: TextStyles.s14BoldText.copyWith(color: Colors.white),
      ),
      bottom: bottom != null
          ? PreferredSize(
              preferredSize: Size.fromHeight(bottomSize),
              child: bottom!,
            )
          : null,
      actions: actions,
      leading: const BackButton(
        color: Colors.white,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
