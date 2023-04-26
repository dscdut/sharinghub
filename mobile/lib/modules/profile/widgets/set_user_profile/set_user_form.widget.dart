import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:mobile/common/utils/validator.util.dart';
import 'package:mobile/common/widgets/app_text_form_field.widget.dart';
import 'package:mobile/common/widgets/show_or_pick_image.widget.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/profile/profile.dart';
import 'package:mobile/modules/profile/widgets/set_user_profile/birthday_picker.widget.dart';
import 'package:mobile/modules/profile/widgets/set_user_profile/gender_picker.widget.dart';

class SetUserProfileForm extends StatelessWidget {
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
  final void Function(bool?)? onGenderChanged;
  final void Function(DateTime?)? onBirthdaySelected;

  const SetUserProfileForm({
    super.key,
    required this.formKey,
    required this.emailEditingController,
    required this.gender,
    this.onGenderChanged,
    this.onBirthdaySelected,
    this.image,
    required this.birthday,
    required this.setAvatar,
    required this.nameEditingController,
    required this.phoneNumberEditingController,
    required this.addressEditingController,
    required this.workplaceEditingController,
  });

  final Widget _verticalSpacing = const SizedBox(
    height: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          BlocBuilder<SetUserBloc, SetUserState>(
            builder: (context, state) {
              return ShowOrPickImage(
                width: context.width / 3,
                height: context.width / 3,
                borderRadius: context.width / 3,
                setImage: setAvatar,
                cropStyle: CropStyle.circle,
                error: state.avatarError,
                image: image,
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          AppTextFormField(
            validator: ValidatorUtil.validateRequiredField,
            textController: nameEditingController,
            labelText: LocaleKeys.texts_organization_name.tr(),
            extendField: false,
          ),
          _verticalSpacing,
          AppTextFormField(
            validator: ValidatorUtil.validateEmail,
            textController: emailEditingController,
            labelText: LocaleKeys.texts_email_address.tr(),
            extendField: false,
          ),
          _verticalSpacing,
          GenderPicker(
            gender: gender,
            onChanged: onGenderChanged,
          ),
          _verticalSpacing,
          BirthdayPicker(
            birthday: birthday,
            onSelected: onBirthdaySelected,
          ),
          _verticalSpacing,
          AppTextFormField(
            validator: ValidatorUtil.validateRequiredField,
            textController: phoneNumberEditingController,
            keyboardType: TextInputType.number,
            labelText: LocaleKeys.organization_phone_number.tr(),
            extendField: false,
          ),
          _verticalSpacing,
          AppTextFormField(
            validator: ValidatorUtil.validateRequiredField,
            textController: addressEditingController,
            labelText: LocaleKeys.organization_address.tr(),
            extendField: false,
          ),
          _verticalSpacing,
          AppTextFormField(
            validator: ValidatorUtil.validateRequiredField,
            textController: workplaceEditingController,
            labelText: LocaleKeys.organization_description.tr(),
            extendField: false,
          ),
        ],
      ),
    );
  }
}
