import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  const CustomDropdownButton({
    super.key,
    this.color = ColorStyles.primary1,
    required this.value,
    required this.onChange,
    required this.items,
    this.hint,
  });

  final Color color;
  final Function onChange;
  final List<DropdownMenuItem<T>> items;
  final T value;
  final Widget? hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 2),
      margin: const EdgeInsets.all(2),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          onChanged: (value) => onChange(value),
          value: value,
          hint: hint,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          items: items,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: color,
          ),
        ),
      ),
    );
  }
}
