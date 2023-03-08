import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/utils/dialog.util.dart';
import 'package:mobile/common/utils/file.util.dart';
import 'package:mobile/common/utils/toast.util.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/data/datasources/user.mock.dart';
import 'package:mobile/data/dtos/set_campaign.dto.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/campaign/bloc/campaign/set_campaign.bloc.dart';
import 'package:mobile/modules/campaign/widgets/create_campaign/campaign_appbar.widget.dart';
import 'package:mobile/modules/campaign/widgets/create_campaign/campaign_form.widget.dart';
import 'package:mobile/router/app_routes.dart';

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
      ),
      child: BlocListener<SetCampaignBloc, SetCampaignState>(
        listener: _listenCampaignStateChanged,
        child: _SetCampaignView(campaign),
      ),
    );
  }

  _listenCampaignStateChanged(BuildContext context, SetCampaignState state) {
    DialogUtil.hideLoading(context);

    if (state.status == HandleStatus.error) {
      ToastUtil.showError(context);
    } else if (state.status == HandleStatus.success) {
      DialogUtil.showCustomDialog(
        context,
        title: LocaleKeys.texts_success.tr(),
        isConfirmDialog: true,
        content: campaign == null
            ? LocaleKeys.campaign_create_success.tr()
            : LocaleKeys.campaign_update_success.tr(),
        confirmButtonText: LocaleKeys.campaign_create.tr(),
        confirmAction: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.setCampaign,
            (route) => route.settings.name == AppRoutes.root,
          );
        },
        cancelButtonText: LocaleKeys.campaign_back_home.tr(),
        cancelAction: () {
          // Navigator.of(context).pushNamedAndRemoveUntil(
          //   AppRoutes.root,
          //   (route) => route.settings.name == AppRoutes.root,
          // );

          //TODO: test organization profile
          Navigator.of(context).pushNamed(
            AppRoutes.organizationProfile,
            arguments: UserMock.getOrganizations()[0],
          );
        },
      );
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
  late SetCampaignDTO setCampaign;

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

  Future<void> _setCampaignImage(File file) async {
    setCampaign.image = await FileUtil.toMultipartFile(file);
  }

  void _setCampaignPlaceId(String placeId) {
    setCampaign.placeId = placeId;
  }

  void _setCampaignDateRange(DateTime startDate, DateTime endDate) {
    setCampaign.startDate = startDate;
    setCampaign.endDate = endDate;
  }

  void _setCampaignDTO() {
    if (widget.campaign == null) {
      setCampaign = SetCampaignDTO();
    } else {
      setCampaign = widget.campaign!.toSetCampaignDTO();
      _setCampaignInfo();
    }
  }

  void _setCampaignInfo() {
    _nameController.text = setCampaign.name ?? '';
    _descriptionController.text = setCampaign.description ?? '';
    _addressController.text = setCampaign.address ?? '';
    _specificAddressController.text = setCampaign.specificAddress ?? '';
  }

  void _submitCampaign(BuildContext context) async {
    context
        .read<SetCampaignBloc>()
        .add(SetCampaignFormValidate(setCampaign: setCampaign));

    if (_formKey.currentState!.validate() &&
        context.read<SetCampaignBloc>().state.isValid) {
      context
          .read<SetCampaignBloc>()
          .add(SetCampaignSubmit(setCampaign: setCampaign));
    }
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
