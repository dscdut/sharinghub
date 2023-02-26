import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.color,
    this.length,
    this.isVertical,
  });

  final Color? color;
  final double? length;
  final bool? isVertical;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Colors.transparent,
      width: (isVertical == false || isVertical == null)
          ? (length ?? 4)
          : double.infinity,
      height: isVertical == true ? double.infinity : (length ?? 4),
    );
  }
}
