import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/extensions/date_time.extension.dart';
import 'package:mobile/common/utils/validator.util.dart';
import 'package:mobile/common/widgets/app_text_form_field.widget.dart';
import 'package:mobile/generated/locale_keys.g.dart';

class BirthdayPicker extends StatefulWidget {
  final DateTime? birthday;
  final void Function(DateTime?)? onSelected;
  const BirthdayPicker({
    super.key,
    required this.birthday,
    this.onSelected,
  });

  @override
  State<BirthdayPicker> createState() => _BirthdayPickerState();
}

class _BirthdayPickerState extends State<BirthdayPicker> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: _selectedDate ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (picked != null && picked != _selectedDate) {
          setState(() {
            _selectedDate = picked;
            widget.onSelected?.call(picked);
          });
        }
      },
      child: AbsorbPointer(
        child: AppTextFormField(
          extendField: false,
          labelText: LocaleKeys.profile_birthday.tr(),
          textController: TextEditingController(
            text: _selectedDate != null ? _selectedDate!.toDisplay : '',
          ),
          validator: ValidatorUtil.validateRequiredField,
        ),
      ),
    );
  }
}
