import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:mobile/common/utils/validator.util.dart';
import 'package:mobile/common/widgets/app_text_form_field.widget.dart';
import 'package:mobile/common/widgets/show_or_pick_image.widget.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/campaign/campaign.dart';

class DonateForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  final dynamic image;
  final void Function(File) setAvatar;
  final TextEditingController nameEditingController;
  final TextEditingController quantityEditingController;

  const DonateForm({
    super.key,
    required this.formKey,
    this.image,
    required this.setAvatar,
    required this.nameEditingController,
    required this.quantityEditingController,
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
          BlocBuilder<DonateBloc, DonateState>(
            builder: (context, state) {
              return ShowOrPickImage(
                width: context.width,
                height: context.width / 1.5,
                borderRadius: 20,
                setImage: setAvatar,
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
            labelText: LocaleKeys.donate_artifact_name.tr(),
            extendField: false,
          ),
          _verticalSpacing,
          AppTextFormField(
            validator: ValidatorUtil.validateQuantity,
            textController: quantityEditingController,
            keyboardType: TextInputType.number,
            labelText: LocaleKeys.donate_artifact_quantity.tr(),
            extendField: false,
          ),
          _verticalSpacing,
        ],
      ),
    );
  }
}
