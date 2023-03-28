import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/utils/validator.util.dart';
import 'package:mobile/common/widgets/app_text_form_field.widget.dart';
import 'package:mobile/common/widgets/show_or_pick_image.widget.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/profile/profile.dart';

class SetUserProfileForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  final dynamic image;
  final void Function(File) setAvatar;
  final TextEditingController nameEditingController;
  final TextEditingController emailEditingController;
  final TextEditingController phoneNumberEditingController;
  final TextEditingController addressEditingController;
  final TextEditingController workplaceEditingController;
  final bool? gender;
  final DateTime? birthday;
  final void Function(bool?)? onChanged;

  const SetUserProfileForm({
    super.key,
    required this.formKey,
    required this.emailEditingController,
    this.gender,
    this.onChanged,
    this.image,
    this.birthday,
    required this.setAvatar,
    required this.nameEditingController,
    required this.phoneNumberEditingController,
    required this.addressEditingController,
    required this.workplaceEditingController,
  });

  @override
  State<SetUserProfileForm> createState() => _SetUserProfileFormState();
}

class _SetUserProfileFormState extends State<SetUserProfileForm> {
  bool? _value;
  DateTime? _selectedDate;

  @override
  void initState() {
    _selectedDate = widget.birthday;
    _value = widget.gender;
    super.initState();
  }

  final Widget _verticalSpacing = const SizedBox(
    height: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          BlocBuilder<SetUserBloc, SetUserState>(
            builder: (context, state) {
              return ShowOrPickImage(
                width: context.width / 3,
                height: context.width / 3,
                borderRadius: context.width / 3,
                setImage: widget.setAvatar,
                cropStyle: CropStyle.circle,
                error: state.avatarError,
                image: widget.image,
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          AppTextFormField(
            validator: ValidatorUtil.validateRequiredField,
            textController: widget.nameEditingController,
            labelText: LocaleKeys.texts_organization_name.tr(),
            extendField: false,
          ),
          _verticalSpacing,
          AppTextFormField(
            validator: ValidatorUtil.validateEmail,
            textController: widget.emailEditingController,
            labelText: LocaleKeys.texts_email_address.tr(),
            extendField: false,
          ),
          _verticalSpacing,
          Container(
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
                  'Gender',
                  style: TextStyle(
                    color: Colors.grey[400],
                  ),
                ),
                style: const TextStyle(
                  color: ColorStyles.zodiacBlue,
                ),
                value: _value,
                underline: const SizedBox(),
                onChanged: (bool? value) {
                  setState(() {
                    _value = value;
                    widget.onChanged?.call(value);
                  });
                },
                items: [
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
          ),
          _verticalSpacing,
          GestureDetector(
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
                });
              }
            },
            child: AbsorbPointer(
              child: AppTextFormField(
                extendField: false,
                labelText: 'Birthday',
                textController: TextEditingController(
                  text: _selectedDate != null
                      ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                      : '',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your birthday';
                  }
                  return null;
                },
              ),
            ),
          ),
          _verticalSpacing,
          AppTextFormField(
            validator: ValidatorUtil.validateRequiredField,
            textController: widget.phoneNumberEditingController,
            keyboardType: TextInputType.number,
            labelText: LocaleKeys.organization_phone_number.tr(),
            extendField: false,
          ),
          _verticalSpacing,
          AppTextFormField(
            validator: ValidatorUtil.validateRequiredField,
            textController: widget.addressEditingController,
            labelText: LocaleKeys.organization_address.tr(),
            extendField: false,
          ),
          _verticalSpacing,
          AppTextFormField(
            validator: ValidatorUtil.validateRequiredField,
            textController: widget.workplaceEditingController,
            labelText: LocaleKeys.organization_description.tr(),
            extendField: false,
          ),
        ],
      ),
    );
  }
}
