import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/utils/validator.util.dart';
import 'package:mobile/common/widgets/app_text_form_field.widget.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/common/widgets/show_or_pick_image.widget.dart';
import 'package:mobile/modules/campaign/bloc/set/set_campaign.bloc.dart';
import 'package:mobile/modules/campaign/widgets/set/date_range_picker.widget.dart';
import 'package:mobile/router/app_routes.dart';

class CampaignForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController addressController;
  final TextEditingController specificAddressController;
  final TextEditingController registerLinkController;
  final TextEditingController actifactDonateController;
  final TextEditingController otherInfoController;

  final void Function(String) setCampaignPlaceId;
  final void Function(DateTime, DateTime) setCampaignDateRange;
  final void Function(File) setCampaignImage;

  final String? imagePath;

  final DateTime? startDate;
  final DateTime? endDate;

  const CampaignForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.descriptionController,
    required this.addressController,
    required this.specificAddressController,
    required this.registerLinkController,
    required this.otherInfoController,
    required this.actifactDonateController,
    required this.setCampaignPlaceId,
    required this.setCampaignDateRange,
    required this.setCampaignImage,
    this.imagePath,
    this.startDate,
    this.endDate,
  });

  final Widget _verticalSpacing = const SizedBox(
    height: 10,
  );

  Future<void> _setAddress(BuildContext context) async {
    final Map<String, String>? result = (await Navigator.of(context)
        .pushNamed(AppRoutes.locationSearch) as Map<String, String>?);

    if (result != null) {
      addressController.text = result['description']!;
      setCampaignPlaceId(result['place_id']!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          BlocBuilder<SetCampaignBloc, SetCampaignState>(
            builder: (context, state) {
              return ShowOrPickImage(
                setImage: setCampaignImage,
                image: imagePath,
                width: context.width - 2 * AppSize.horizontalSpace,
                height: (context.width - 2 * AppSize.horizontalSpace) *
                    (1 / AppSize.campaignAvatarRatio),
                error: state.imageError,
              );
            },
          ),
          _verticalSpacing,
          AppTextFormField(
            validator: ValidatorUtil.validateRequiredField,
            textController: nameController,
            hintText: LocaleKeys.campaign_name.tr(),
            extendField: false,
          ),
          _verticalSpacing,
          AppTextFormField(
            validator: ValidatorUtil.validateRequiredField,
            textController: descriptionController,
            hintText: LocaleKeys.campaign_description.tr(),
            maxLines: 6,
            contentPadding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            extendField: false,
          ),
          _verticalSpacing,
          AppTextFormField(
            validator: ValidatorUtil.validateRequiredField,
            textController: addressController,
            hintText: LocaleKeys.campaign_ward_district_province.tr(),
            readOnly: true,
            focusedBorderColor: ColorStyles.gray200,
            onTap: () async {
              await _setAddress(context);
            },
            extendField: false,
          ),
          _verticalSpacing,
          AppTextFormField(
            validator: ValidatorUtil.validateRequiredField,
            textController: specificAddressController,
            hintText: LocaleKeys.campaign_address.tr(),
            extendField: false,
          ),
          _verticalSpacing,
          DateRangePicker(
            setCampaignDateRange: setCampaignDateRange,
            startDate: startDate,
            endDate: endDate,
          ),
          _verticalSpacing,
          AppTextFormField(
            validator: (p0) => ValidatorUtil.validateURL(p0?.trim()),
            textController: registerLinkController,
            hintText: LocaleKeys.campaign_form_link.tr(),
            extendField: false,
          ),
          _verticalSpacing,
          AppTextFormField(
            textController: actifactDonateController,
            hintText: LocaleKeys.campaign_artifact_donate.tr(),
            extendField: false,
          ),
          // _verticalSpacing,
          // AppTextFormField(
          //   textController: otherInfoController,
          //   hintText: LocaleKeys.campaign_other_info.tr(),
          //   maxLines: 6,
          //   contentPadding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          //   extendField: false,
          // ),
        ],
      ),
    );
  }
}
