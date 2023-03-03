import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/utils/validator.util.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/campaign/campaign.dart';
import 'package:mobile/modules/campaign/widgets/campaign_dropdown.widget.dart';

class CampaignForm extends StatefulWidget {
  final CampaignModel? campaign;

  final bool isChecked;

  final GlobalKey<FormState> formKey;

  final String province;
  final String district;
  final String ward;

  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController specificAddressController;
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final TextEditingController registerLinkController;
  final TextEditingController otherInfoController;
  final TextEditingController actifactRequirementController;

  final void Function() onStartDateTap;
  final void Function() onEndDateTap;
  final void Function(String?) onProvinceDropdownChanged;
  final void Function(String?) onDistrictDropdownChanged;
  final void Function(String?) onWardDropdownChanged;
  final void Function(bool?) onArtifactChecked;

  const CampaignForm({
    super.key,
    this.campaign,
    required this.isChecked,
    required this.formKey,
    required this.province,
    required this.district,
    required this.ward,
    required this.nameController,
    required this.descriptionController,
    required this.specificAddressController,
    required this.startDateController,
    required this.endDateController,
    required this.registerLinkController,
    required this.otherInfoController,
    required this.actifactRequirementController,
    required this.onStartDateTap,
    required this.onEndDateTap,
    required this.onProvinceDropdownChanged,
    required this.onDistrictDropdownChanged,
    required this.onWardDropdownChanged,
    required this.onArtifactChecked,
  });

  @override
  State<CampaignForm> createState() => CampaignFormState();
}

class CampaignFormState extends State<CampaignForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          CampaignTextFormField(
            validator: ValidatorUtil.validateName,
            textController: widget.nameController,
            hintText: LocaleKeys.campaign_campaign_name.tr(),
          ),
          CampaignTextFormField(
            validator: ValidatorUtil.validateName,
            textController: widget.descriptionController,
            hintText: LocaleKeys.campaign_campaign_description.tr(),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 19,
              runSpacing: 19,
              children: [
                CampaignDropdownButton(
                  valueDivision: widget.province,
                  hintDivision: LocaleKeys.campaign_province.tr(),
                  listDropdownItems: const [
                    DropdownMenuItem(
                      value: 'Đà Nẵng',
                      child: Text(
                        'Đà Nẵng',
                      ),
                    ),
                  ],
                  onDropdownChanged: widget.onProvinceDropdownChanged,
                ),
                CampaignDropdownButton(
                  valueDivision: widget.district,
                  hintDivision: LocaleKeys.campaign_district.tr(),
                  listDropdownItems: const [
                    DropdownMenuItem(
                      value: 'Liên Chiểu',
                      child: Text(
                        'Liên Chiểu',
                      ),
                    ),
                  ],
                  onDropdownChanged: widget.onDistrictDropdownChanged,
                ),
                CampaignDropdownButton(
                  valueDivision: widget.ward,
                  hintDivision: LocaleKeys.campaign_ward.tr(),
                  listDropdownItems: const [
                    DropdownMenuItem(
                      value: 'Hòa Khánh Bắc',
                      child: Text(
                        'Hòa Khánh Bắc',
                      ),
                    ),
                  ],
                  onDropdownChanged: widget.onWardDropdownChanged,
                ),
              ],
            ),
          ),
          const SizedBox(height: 19),
          CampaignTextFormField(
            validator: ValidatorUtil.validateName,
            textController: widget.specificAddressController,
            hintText: LocaleKeys.campaign_address.tr(),
          ),
          CampaignTextFormField(
            validator: ValidatorUtil.validateName,
            textController: widget.startDateController,
            hintText: LocaleKeys.campaign_start_date.tr(),
            onTap: widget.onStartDateTap,
          ),
          CampaignTextFormField(
            textController: widget.endDateController,
            validator: (String? value) {
              return ValidatorUtil.validateDateEnd(
                value,
                widget.startDateController.text,
              );
            },
            hintText: LocaleKeys.campaign_end_date.tr(),
            onTap: widget.onEndDateTap,
          ),
          CampaignTextFormField(
            textController: widget.registerLinkController,
            hintText: LocaleKeys.campaign_register_link.tr(),
          ),
          CheckboxListTile(
            value: widget.isChecked,
            checkColor: Colors.black,
            activeColor: Colors.transparent,
            checkboxShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
              side: const BorderSide(
                color: Colors.black26,
              ),
            ),
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.black26,
              ),
            ),
            onChanged: widget.onArtifactChecked,
            title: Text(
              LocaleKeys.campaign_artifact_requirement.tr(),
              style: TextStyles.s14RegularText.copyWith(
                color: Colors.black,
              ),
            ),
          ),
          if (widget.isChecked)
            Column(
              children: [
                const SizedBox(height: 19),
                CampaignTextFormField(
                  textController: widget.actifactRequirementController,
                  hintText: LocaleKeys.campaign_artifact_requirement.tr(),
                ),
              ],
            )
          else
            const SizedBox(height: 19),
          CampaignTextFormField(
            textController: widget.otherInfoController,
            hintText: LocaleKeys.campaign_other_info.tr(),
          ),
        ],
      ),
    );
  }
}
