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
  final TextInputAction? textInputAction;

  final String? Function(String?)? validator;

  final void Function()? onTap;
  final void Function(String)? onChanged;
  final VoidCallback? onTapPrefixIcon;
  final VoidCallback? onTapSuffixIcon;
  final Function? onEditingComplete;

  final TextStyle? labelStyle;

  final FocusNode? focusNode;

  final int maxLines;

  final EdgeInsetsGeometry contentPadding;

  AppTextFormField({
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
    this.borderRadius = 10,
    this.borderColor = ColorStyles.gray200,
    this.focusedBorderColor = ColorStyles.primary1,
    this.fillColor = Colors.transparent,
    this.hintColor = ColorStyles.gray200,
    this.prefixIconColor,
    this.suffixIconColor,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onTap,
    this.onChanged,
    this.onTapPrefixIcon,
    this.onTapSuffixIcon,
    this.focusNode,
    this.maxLines = 1,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 20),
    this.textInputAction,
    this.onEditingComplete,
  })  : labelStyle =
            TextStyles.s14RegularText.copyWith(color: ColorStyles.gray200),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      focusNode: focusNode,
      textInputAction: textInputAction ?? TextInputAction.done,
      onChanged: onChanged,
      onTap: onTap,
      validator: validator,
      obscureText: isObscure,
      readOnly: readOnly,
      enableSuggestions: false,
      enabled: enabled,
      keyboardType: keyboardType,
      initialValue: initialValue,
      maxLines: maxLines,
      onEditingComplete: onEditingComplete == null
          ? null
          : () {
              FocusScope.of(context).unfocus();
              onEditingComplete!();
            },
      style: TextStyles.regularBody14.copyWith(color: ColorStyles.zodiacBlue),
      textAlign: isCenterText ? TextAlign.center : TextAlign.start,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: labelText,
        labelStyle: labelStyle,
        hintText: hintText,
        hintStyle: TextStyles.regularBody14.copyWith(color: hintColor),
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
        contentPadding: contentPadding,
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
            ? TextStyles.regularBody14.copyWith(fontSize: 13)
            : null,
        errorText: errorText == '' || errorText == null ? null : errorText,
        errorStyle: TextStyles.regularBody14
            .copyWith(color: Colors.red, fontSize: 13, height: 0),
      ),
    );
  }
}
