import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/utils/dialog.util.dart';
import 'package:mobile/common/utils/toast.util.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/data/dtos/set_campaign.dto.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/data/repositories/place.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/auth/auth.dart';
import 'package:mobile/modules/campaign/bloc/management/campaign_management.bloc.dart';
import 'package:mobile/modules/campaign/bloc/set/set_campaign.bloc.dart';
import 'package:mobile/modules/campaign/widgets/set/campaign_appbar.widget.dart';
import 'package:mobile/modules/campaign/widgets/set/campaign_form.widget.dart';

class SetCampaignPage extends StatelessWidget {
  final CampaignModel? campaign;

  const SetCampaignPage({
    super.key,
    this.campaign,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SetCampaignBloc(
        campaignRepository: getIt.get<CampaignRepository>(),
        campaignManagementBloc: context.read<CampaignManagementBloc>(),
        placeRepository: getIt.get<PlaceRepository>(),
      ),
      child: BlocListener<SetCampaignBloc, SetCampaignState>(
        listener: _listenCampaignStateChanged,
        child: _SetCampaignView(campaign),
      ),
    );
  }

  void _listenCampaignStateChanged(
    BuildContext context,
    SetCampaignState state,
  ) {
    DialogUtil.hideLoading(context);

    if (state.status == HandleStatus.error) {
      ToastUtil.showError(context);
    } else if (state.status == HandleStatus.success) {
      ToastUtil.showSuccess(
        context,
        text: campaign == null
            ? LocaleKeys.campaign_create_success.tr()
            : LocaleKeys.campaign_update_success.tr(),
      );
      Navigator.of(context).pop();
    } else if (state.status == HandleStatus.loading) {
      DialogUtil.showLoading(context);
    }
  }
}

class _SetCampaignView extends StatefulWidget {
  final CampaignModel? campaign;

  const _SetCampaignView(this.campaign);

  @override
  State<_SetCampaignView> createState() => _SetCampaignViewState();
}

class _SetCampaignViewState extends State<_SetCampaignView> {
  late SetCampaignDTO _setCampaign;

  @override
  void initState() {
    _setCampaignDTO();
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _specificAddressController =
      TextEditingController();
  final TextEditingController _registerLinkController = TextEditingController();
  final TextEditingController _actifactDonateController =
      TextEditingController();
  final TextEditingController _otherInfoController = TextEditingController();

  void _setCampaignImage(File file) {
    _setCampaign.image = file;
  }

  void _setCampaignPlaceId(String placeId) {
    _setCampaign.placeId = placeId;
  }

  void _setCampaignDateRange(DateTime startDate, DateTime endDate) {
    _setCampaign.startDate = startDate;
    _setCampaign.endDate = endDate;
  }

  void _setCampaignDTO() {
    if (widget.campaign == null) {
      _setCampaign = SetCampaignDTO();
    } else {
      _setCampaign = widget.campaign!.toSetCampaignDTO();
      _setCampaignInfo();
    }
  }

  void _setCampaignInfo() {
    _nameController.text = _setCampaign.name ?? '';
    _descriptionController.text = _setCampaign.description ?? '';
    _addressController.text = _setCampaign.address ?? '';
    _specificAddressController.text = _setCampaign.specificAddress ?? '';
    _registerLinkController.text = _setCampaign.registerLink ?? '';
    _actifactDonateController.text = _setCampaign.donationRequirement ?? '';
  }

  void _submitCampaign(BuildContext context) {
    _collectDataForSetCampaign(context);

    context
        .read<SetCampaignBloc>()
        .add(SetCampaignFormValidate(setCampaign: _setCampaign));

    if (_formKey.currentState!.validate() &&
        context.read<SetCampaignBloc>().state.isValid) {
      context
          .read<SetCampaignBloc>()
          .add(SetCampaignSubmit(setCampaign: _setCampaign));
    }
  }

  void _collectDataForSetCampaign(BuildContext context) {
    _setCampaign = _setCampaign.copyWith(
      name: _nameController.text,
      address: _addressController.text,
      specificAddress: _specificAddressController.text,
      description: _descriptionController.text,
      registerLink: _registerLinkController.text,
      donationRequirement: _actifactDonateController.text,
      organizationId: context.read<AuthBloc>().state.currentOrganizationId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CampaignAppBar(isUpdate: widget.campaign != null),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(AppSize.horizontalSpace),
        child: Column(
          children: [
            CampaignForm(
              formKey: _formKey,
              nameController: _nameController,
              descriptionController: _descriptionController,
              addressController: _addressController,
              specificAddressController: _specificAddressController,
              registerLinkController: _registerLinkController,
              otherInfoController: _otherInfoController,
              actifactDonateController: _actifactDonateController,
              setCampaignPlaceId: _setCampaignPlaceId,
              setCampaignDateRange: _setCampaignDateRange,
              setCampaignImage: _setCampaignImage,
            ),
            const SizedBox(height: 20),
            AppRoundedButton(
              onPressed: () {
                _submitCampaign(context);
              },
              content: widget.campaign == null
                  ? LocaleKeys.button_finish.tr()
                  : LocaleKeys.button_update.tr(),
              width: context.width / 2,
            ),
          ],
        ),
      ),
    );
  }
}
