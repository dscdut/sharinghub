import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/generated/locale_keys.g.dart';

class GenderPicker extends StatefulWidget {
  final bool? gender;
  final void Function(bool?)? onChanged;
  const GenderPicker({
    super.key,
    required this.gender,
    this.onChanged,
  });

  @override
  State<GenderPicker> createState() => _GenderPickerState();
}

class _GenderPickerState extends State<GenderPicker> {
  bool? _gender;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey[400]!,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: DropdownButton<bool>(
          hint: Text(
            LocaleKeys.profile_gender.tr(),
            style: TextStyle(
              color: Colors.grey[400],
            ),
          ),
          style: const TextStyle(
            color: ColorStyles.zodiacBlue,
          ),
          value: _gender,
          underline: const SizedBox(),
          onChanged: (bool? value) {
            setState(() {
              _gender = value;
              widget.onChanged?.call(value);
            });
          },
          items: [
            DropdownMenuItem<bool>(
              child: Text(LocaleKeys.profile_gender.tr()),
            ),
            DropdownMenuItem<bool>(
              value: true,
              child: Text(LocaleKeys.profile_gender_male.tr()),
            ),
            DropdownMenuItem<bool>(
              value: false,
              child: Text(LocaleKeys.profile_gender_female.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
