import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';

class AppBackButton extends StatelessWidget {
  final Color iconColor;

  const AppBackButton({
    super.key,
    this.iconColor = ColorStyles.zodiacBlue,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icon(
        Icons.chevron_left_rounded,
        color: iconColor,
        size: 35,
      ),
      padding: EdgeInsets.zero,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
    );
  }
}
