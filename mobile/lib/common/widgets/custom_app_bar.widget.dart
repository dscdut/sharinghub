import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/widgets/app_back_button.widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isCenterTitle;
  final bool automaticallyImplyLeading;

  final Color backgroundColor;
  final Color titleColor;

  final double toolbarHeight;
  final double titleSpacing;
  final double elevation;
  final double bottomSize;

  final String title;
  final Widget? bottom;
  final List<Widget> actions;

  final Color leadingColor;
  final Function()? onLeadingAction;

  const CustomAppBar({
    super.key,
    this.isCenterTitle = true,
    this.automaticallyImplyLeading = true,
    this.backgroundColor = ColorStyles.primary4,
    this.titleColor = Colors.black,
    this.leadingColor = ColorStyles.primary1,
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
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: AppBar(
          centerTitle: isCenterTitle,
          backgroundColor: backgroundColor,
          elevation: elevation,
          toolbarHeight: toolbarHeight,
          titleSpacing: titleSpacing,
          automaticallyImplyLeading: false,
          title: Text(
            title,
            style:
                TextStyles.boldText.copyWith(color: titleColor, fontSize: 16),
          ),
          bottom: bottom != null
              ? PreferredSize(
                  preferredSize: Size.fromHeight(bottomSize),
                  child: bottom!,
                )
              : null,
          actions: actions,
          leading: (automaticallyImplyLeading && Navigator.of(context).canPop())
              ? AppBackButton(
                  iconColor: leadingColor,
                )
              : null,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
