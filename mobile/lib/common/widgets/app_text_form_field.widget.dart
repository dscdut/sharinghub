import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController? textController;

  final bool isObscure;
  final bool readOnly;
  final bool extendField;
  final bool enabled;
  final bool isCenterText;

  final String? hintText;
  final String? errorText;
  final String? labelText;
  final String? initialValue;

  final double borderRadius;

  final Color focusedBorderColor;
  final Color borderColor;
  final Color fillColor;
  final Color hintColor;
  final Color? prefixIconColor;
  final Color? suffixIconColor;

  final IconData? suffixIcon;
  final IconData? prefixIcon;

  final TextInputType? keyboardType;

  final String? Function(String?)? validator;

  final void Function()? onTap;
  final void Function(String)? onChanged;
  final VoidCallback? onTapPrefixIcon;
  final VoidCallback? onTapSuffixIcon;

  final TextStyle? labelStyle;

  final FocusNode? focusNode;

  const AppTextFormField({
    Key? key,
    this.textController,
    this.isObscure = false,
    this.readOnly = false,
    this.extendField = true,
    this.enabled = true,
    this.isCenterText = false,
    this.hintText,
    this.errorText,
    this.labelText,
    this.initialValue,
    this.borderRadius = 6,
    this.borderColor = ColorStyles.gray100,
    this.focusedBorderColor = ColorStyles.blue400,
    this.fillColor = Colors.white,
    this.hintColor = ColorStyles.gray200,
    this.prefixIconColor,
    this.suffixIconColor,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.validator,
    this.onTap,
    this.onChanged,
    this.onTapPrefixIcon,
    this.onTapSuffixIcon,
    this.labelStyle = TextStyles.s14MediumText,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Text(
            labelText!,
            style: labelStyle,
          ),
        if (labelText != null)
          const SizedBox(
            height: 5,
          ),
        TextFormField(
          controller: textController,
          focusNode: focusNode,
          textInputAction: TextInputAction.done,
          onChanged: onChanged,
          onTap: onTap,
          validator: validator,
          obscureText: isObscure,
          readOnly: readOnly,
          enableSuggestions: false,
          enabled: enabled,
          keyboardType: keyboardType,
          initialValue: initialValue,
          style:
              TextStyles.s14RegularText.copyWith(color: ColorStyles.zodiacBlue),
          textAlign: isCenterText ? TextAlign.center : TextAlign.start,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyles.s14RegularText.copyWith(color: hintColor),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(
                color: ColorStyles.red600,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: focusedBorderColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: borderColor,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: borderColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(
                color: ColorStyles.red600,
              ),
            ),
            // isDense: true,
            filled: true,
            fillColor: fillColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            prefixIcon: prefixIcon != null
                ? GestureDetector(
                    onTap: onTapPrefixIcon,
                    behavior: HitTestBehavior.opaque,
                    child: Icon(
                      prefixIcon,
                      color: prefixIconColor,
                    ),
                  )
                : null,
            suffixIcon: suffixIcon != null
                ? GestureDetector(
                    onTap: onTapSuffixIcon,
                    behavior: HitTestBehavior.opaque,
                    child: Icon(
                      suffixIcon,
                      color: suffixIconColor,
                    ),
                  )
                : null,
            helperText: extendField ? '' : null,
            helperStyle: extendField
                ? TextStyles.regularText.copyWith(fontSize: 13)
                : null,
            errorText: errorText == '' || errorText == null ? null : errorText,
            errorStyle: TextStyles.regularText
                .copyWith(color: Colors.red, fontSize: 13, height: 0),
          ),
        ),
      ],
    );
  }
}
