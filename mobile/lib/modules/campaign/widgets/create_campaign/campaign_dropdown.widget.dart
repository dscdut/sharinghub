import 'package:flutter/material.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/utils/validator.util.dart';

class CampaignDropdownButton extends StatelessWidget {
  final String valueDivision;
  final String hintDivision;
  final List<DropdownMenuItem<String>>? listDropdownItems;
  final void Function(String?) onDropdownChanged;

  const CampaignDropdownButton({
    super.key,
    required this.valueDivision,
    required this.hintDivision,
    required this.listDropdownItems,
    required this.onDropdownChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: DropdownButtonFormField(
        validator: ValidatorUtil.validateName,
        value: valueDivision == '' ? null : valueDivision,
        style: TextStyles.s14RegularText.copyWith(
          color: Colors.black,
        ),
        hint: Text(
          hintDivision,
          style: TextStyles.s14RegularText.copyWith(
            color: Colors.black26,
          ),
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.black26,
            ),
          ),
        ),
        items: listDropdownItems,
        onChanged: onDropdownChanged,
      ),
    );
  }
}
