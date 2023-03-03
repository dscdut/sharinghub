import 'package:flutter/material.dart';
import 'package:mobile/common/widgets/app_text_form_field.widget.dart';

class CampaignTextFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController textController;
  final String hintText;
  final TextInputType keyboardType;
  final String? errorText;
  final Function()? onTap;

  const CampaignTextFormField({
    super.key,
    this.validator,
    required this.textController,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.errorText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextFormField(
          validator: validator,
          textController: textController,
          borderRadius: 10,
          borderColor: Colors.black26,
          hintText: hintText,
          hintColor: Colors.black26,
          keyboardType: keyboardType,
          errorText: errorText,
          extendField: false,
          onTap: onTap,
        ),
        const SizedBox(height: 19),
      ],
    );
  }
}
