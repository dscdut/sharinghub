import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/utils/dialog.util.dart';
import 'package:mobile/common/utils/toast.util.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/common/widgets/custom_app_bar.widget.dart';
import 'package:mobile/data/dtos/set_donate.dto.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/campaign/campaign.dart';
import 'package:mobile/modules/campaign/widgets/donate/donate_form.widget.dart';

class DonatePage extends StatelessWidget {
  final int campaignId;

  const DonatePage({
    super.key,
    required this.campaignId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DonateBloc(
        campaignRepository: getIt.get<CampaignRepository>(),
      ),
      child: BlocListener<DonateBloc, DonateState>(
        listener: _listenDonateStateChanged,
        child: _DonateView(campaignId),
      ),
    );
  }

  void _listenDonateStateChanged(
    BuildContext context,
    DonateState state,
  ) {
    DialogUtil.hideLoading(context);

    if (state.status == HandleStatus.error) {
      ToastUtil.showError(context);
    } else if (state.status == HandleStatus.success) {
      ToastUtil.showSuccess(
        context,
        text: LocaleKeys.donate_thank_you.tr(),
      );
      Navigator.of(context).pop();
    } else if (state.status == HandleStatus.loading) {
      DialogUtil.showLoading(context);
    }
  }
}

class _DonateView extends StatefulWidget {
  final int campaignId;

  const _DonateView(this.campaignId);

  @override
  State<_DonateView> createState() => _DonateViewState();
}

class _DonateViewState extends State<_DonateView> {
  late SetDonateDTO _setDonate;

  @override
  void initState() {
    _setDonate = SetDonateDTO();
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  dynamic imagePath;

  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _quantityEditingController =
      TextEditingController();

  void _setAvatar(File file) {
    imagePath = file;
  }

  void _submitDonate(BuildContext context) {
    _collectDataForDonate(context);

    context.read<DonateBloc>().add(DonateFormValidate(setDonate: _setDonate));

    if (_formKey.currentState!.validate() &&
        context.read<DonateBloc>().state.isValid) {
      context.read<DonateBloc>().add(DonateSubmit(setDonate: _setDonate));
    }
  }

  void _collectDataForDonate(BuildContext context) {
    _setDonate = _setDonate.copyWith(
      itemName: _nameEditingController.text,
      quantity: int.parse(_quantityEditingController.text),
      campaignId: widget.campaignId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.button_donate.tr(),
        titleColor: ColorStyles.zodiacBlue,
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(AppSize.horizontalSpace),
        child: Column(
          children: [
            DonateForm(
              formKey: _formKey,
              setAvatar: _setAvatar,
              nameEditingController: _nameEditingController,
              quantityEditingController: _quantityEditingController,
              image: imagePath,
            ),
            const SizedBox(
              height: 30,
            ),
            AppRoundedButton(
              onPressed: () {
                _submitDonate(context);
              },
              width: context.width / 2,
              content: LocaleKeys.button_donate.tr(),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
