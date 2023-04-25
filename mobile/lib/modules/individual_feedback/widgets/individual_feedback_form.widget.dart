import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/utils/validator.util.dart';
import 'package:mobile/common/widgets/app_text_form_field.widget.dart';
import 'package:mobile/common/widgets/show_or_pick_multiple_image.widget.dart';
import 'package:mobile/common/widgets/star_rating.widget.dart';

class IndividualFeedbackForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final int campRate;
  final int orgRate;
  final TextEditingController campEditingController;
  final TextEditingController orgEditingController;
  final void Function(int rating) onCampRateChanged;
  final void Function(int rating) onOrgRateChanged;
  final Future<void> Function(List<File>) setFeedbackImages;
  final List<dynamic>? imagePaths;

  const IndividualFeedbackForm({
    super.key,
    required this.formKey,
    required this.campRate,
    required this.orgRate,
    required this.campEditingController,
    required this.orgEditingController,
    required this.onCampRateChanged,
    required this.onOrgRateChanged,
    required this.setFeedbackImages,
    this.imagePaths,
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
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Rate the campaign',
              style: TextStyles.s17MediumText,
            ),
          ),
          _verticalSpacing,
          StarRating(
            rating: campRate,
            size: 40.0,
            onRatingChanged: onCampRateChanged,
          ),
          _verticalSpacing,
          AppTextFormField(
            validator: ValidatorUtil.validateRequiredField,
            textController: campEditingController,
            maxLines: 6,
            labelText: 'Review the campaign',
            extendField: false,
          ),
          _verticalSpacing,
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Rate the organization',
              style: TextStyles.s17MediumText,
            ),
          ),
          _verticalSpacing,
          StarRating(
            rating: campRate,
            size: 40.0,
            onRatingChanged: onCampRateChanged,
          ),
          _verticalSpacing,
          AppTextFormField(
            validator: ValidatorUtil.validateRequiredField,
            textController: orgEditingController,
            maxLines: 6,
            labelText: 'Review the organization',
            extendField: false,
          ),
          _verticalSpacing,
          ShowOrPickMultipleImage(
            setImages: setFeedbackImages,
            imagePaths: imagePaths,
            width: context.width - 2 * AppSize.horizontalSpace,
            height: (context.width - 2 * AppSize.horizontalSpace) *
                (1 / AppSize.campaignAvatarRatio),
          ),
        ],
      ),
    );
  }
}
