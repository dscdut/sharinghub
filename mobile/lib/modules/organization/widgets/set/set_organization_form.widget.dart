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
import 'package:mobile/modules/organization/bloc/set/set_organization.bloc.dart';

class SetOrganizationForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  final dynamic image;
  final void Function(File) setAvatar;
  final TextEditingController nameEditingController;
  final TextEditingController phoneNumberEditingController;
  final TextEditingController addressEditingController;
  final TextEditingController descriptionEditingController;

  const SetOrganizationForm({
    super.key,
    required this.formKey,
    this.image,
    required this.setAvatar,
    required this.nameEditingController,
    required this.phoneNumberEditingController,
    required this.addressEditingController,
    required this.descriptionEditingController,
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
          BlocBuilder<SetOrganizationBloc, SetOrganizationState>(
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
            textController: descriptionEditingController,
            labelText: LocaleKeys.organization_description.tr(),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            maxLines: 6,
            extendField: false,
          ),
        ],
      ),
    );
  }
}
