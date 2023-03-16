import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/utils/validator.util.dart';
import 'package:mobile/common/widgets/app_text_form_field.widget.dart';
import 'package:mobile/common/widgets/show_or_pick_multiple_image.widget.dart';
import 'package:mobile/common/widgets/star_rating.widget.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/management/management.dart';

class FeedbackCampaignForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final int locationRate;
  final TextEditingController trafficEditingController;
  final TextEditingController weatherEditingController;
  final TextEditingController sanitizationEditingController;
  final TextEditingController residenceEditingController;
  final TextEditingController authorityCooperationEditingController;
  final TextEditingController othersEditingController;
  final Future<void> Function(List<File>) setFeedbackImages;
  final void Function(int rating) onLocationRateChanged;
  final List<String?>? imagePath;

  const FeedbackCampaignForm({
    super.key,
    required this.formKey,
    required this.locationRate,
    required this.trafficEditingController,
    required this.weatherEditingController,
    required this.sanitizationEditingController,
    required this.residenceEditingController,
    required this.authorityCooperationEditingController,
    required this.othersEditingController,
    required this.setFeedbackImages,
    required this.onLocationRateChanged,
    this.imagePath,
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
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              LocaleKeys.feedback_location_rate.tr(),
              style: TextStyles.s17MediumText,
            ),
          ),
          _verticalSpacing,
          StarRating(
            rating: locationRate,
            size: 40.0,
            onRatingChanged: onLocationRateChanged,
          ),
          BlocBuilder<FeedbackCampaignBloc, FeedbackCampaignState>(
            builder: (context, state) {
              return Visibility(
                visible: state.rateError != null,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      state.rateError ?? '',
                      style: TextStyles.regularText
                          .copyWith(color: Colors.red, fontSize: 13, height: 0),
                    ),
                  ),
                ),
              );
            },
          ),
          _verticalSpacing,
          AppTextFormField(
            validator: ValidatorUtil.validateRequiredField,
            textController: trafficEditingController,
            labelText: LocaleKeys.feedback_traffic.tr(),
            extendField: false,
          ),
          _verticalSpacing,
          AppTextFormField(
            validator: ValidatorUtil.validateRequiredField,
            textController: weatherEditingController,
            labelText: LocaleKeys.feedback_weather.tr(),
            extendField: false,
          ),
          _verticalSpacing,
          AppTextFormField(
            validator: ValidatorUtil.validateRequiredField,
            textController: sanitizationEditingController,
            labelText: LocaleKeys.feedback_santization.tr(),
            extendField: false,
          ),
          _verticalSpacing,
          AppTextFormField(
            validator: ValidatorUtil.validateRequiredField,
            textController: residenceEditingController,
            labelText: LocaleKeys.feedback_residence.tr(),
            extendField: false,
          ),
          _verticalSpacing,
          AppTextFormField(
            validator: ValidatorUtil.validateRequiredField,
            textController: authorityCooperationEditingController,
            labelText: LocaleKeys.feedback_authority_cooperation.tr(),
            extendField: false,
          ),
          _verticalSpacing,
          AppTextFormField(
            textController: othersEditingController,
            hintText: LocaleKeys.feedback_others.tr(),
            maxLines: 6,
            contentPadding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            extendField: false,
          ),
          _verticalSpacing,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              LocaleKeys.feedback_images.tr(),
              style: TextStyles.s17MediumText,
            ),
          ),
          _verticalSpacing,
          BlocBuilder<FeedbackCampaignBloc, FeedbackCampaignState>(
            builder: (context, state) {
              return ShowOrPickMultipleImage(
                setImages: setFeedbackImages,
                imagePaths: imagePath,
                width: context.width - 2 * AppSize.horizontalSpace,
                height: (context.width - 2 * AppSize.horizontalSpace) *
                    (1 / AppSize.campaignAvatarRatio),
                error: state.imageError,
              );
            },
          )
        ],
      ),
    );
  }
}
