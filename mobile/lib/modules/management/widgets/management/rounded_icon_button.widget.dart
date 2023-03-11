
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';

class RoundedIconButton extends StatelessWidget {
  final IconData icon;
  final double size;

  const RoundedIconButton({super.key, required this.icon, this.size = 35});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        minimumSize: Size(size, size),
        maximumSize: Size(
          size,
          size,
        ),
        padding: EdgeInsets.zero,
        elevation: 0,
        backgroundColor: ColorStyles.gray100,
      ),
      child: Icon(
        icon,
        color: ColorStyles.zodiacBlue,
        size: 19,
      ),
    );
  }
}
