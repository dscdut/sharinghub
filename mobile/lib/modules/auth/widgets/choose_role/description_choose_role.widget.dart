import 'package:flutter/material.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';

class DescriptionChooseRole extends StatelessWidget {
  final String description;
  final String buttonContent;
  final VoidCallback onPressed;

  const DescriptionChooseRole({
    super.key,
    required this.description,
    required this.buttonContent,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          description,
          style: TextStyles.s14RegularText,
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.all(38),
          child: AppRoundedButton(
            onPressed: onPressed,
            content: buttonContent,
            borderRadius: 10,
            width: double.infinity,
          ),
        ),
      ],
    );
  }
}
