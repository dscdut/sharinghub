import 'package:flutter/material.dart';
import 'package:mobile/common/widgets/app_text_form_field.widget.dart';

class CampaignTextFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController textController;
  final String hintText;
  final TextInputType keyboardType;
  final String? errorText;
  final Function()? onTap;
  final int maxLines;
  final EdgeInsetsGeometry contentPadding;
  final bool readOnly;
  final bool enabled;

  const CampaignTextFormField({
    super.key,
    this.validator,
    required this.textController,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.errorText,
    this.onTap,
    this.maxLines = 1,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 20),
    this.readOnly = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextFormField(
          readOnly: readOnly,
          validator: validator,
          textController: textController,
          hintText: hintText,
          keyboardType: keyboardType,
          errorText: errorText,
          extendField: false,
          onTap: onTap,
          maxLines: maxLines,
          contentPadding: contentPadding,
          enabled: enabled,
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
