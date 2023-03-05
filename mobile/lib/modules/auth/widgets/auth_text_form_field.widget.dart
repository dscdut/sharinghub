import 'package:flutter/material.dart';
import 'package:mobile/common/widgets/app_text_form_field.widget.dart';

class AuthTextFormField extends StatefulWidget {
  final String? Function(String?) validator;
  final TextEditingController textController;
  final bool isPasswordField;
  final String hintText;
  final TextInputType keyboardType;
  final String? errorText;

  const AuthTextFormField({
    super.key,
    required this.validator,
    required this.textController,
    this.isPasswordField = false,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.errorText,
  });

  @override
  State<AuthTextFormField> createState() => _AuthTextFormFieldState();
}

class _AuthTextFormFieldState extends State<AuthTextFormField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      validator: widget.validator,
      textController: widget.textController,
      borderColor: Colors.black26,
      suffixIcon: widget.isPasswordField
          ? (_isObscure ? Icons.visibility_off : Icons.visibility)
          : null,
      onTapSuffixIcon: () {
        setState(() {
          _isObscure = !_isObscure;
        });
      },
      isObscure: widget.isPasswordField && _isObscure,
      hintText: widget.hintText,
      hintColor: Colors.black26,
      keyboardType: widget.keyboardType,
      errorText: widget.errorText,
    );
  }
}
