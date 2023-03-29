import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/utils/dialog.util.dart';
import 'package:mobile/common/utils/toast.util.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/data/dtos/set_organization.dto.dart';
import 'package:mobile/data/models/organization.model.dart';
import 'package:mobile/data/repositories/organization.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/organization/management.dart';
import 'package:mobile/modules/organization/widgets/set/set_organization_appbar.widget.dart';
import 'package:mobile/modules/organization/widgets/set/set_organization_form.widget.dart';

class SetOrganizationPage extends StatelessWidget {
  final OrganizationModel? organization;

  const SetOrganizationPage({super.key, this.organization});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SetOrganizationBloc(
        organizationRepository: getIt.get<OrganizationRepository>(),
        organizationManagementBloc: organization == null
            ? context.read<OrganizationManagementBloc>()
            : null,
      ),
      child: BlocListener<SetOrganizationBloc, SetOrganizationState>(
        listener: _listenSetOrganizationStateChanged,
        child: _SetOrganizationView(
          organization: organization,
        ),
      ),
    );
  }

  void _listenSetOrganizationStateChanged(
    BuildContext context,
    SetOrganizationState state,
  ) {
    DialogUtil.hideLoading(context);

    if (state.status.isError) {
      ToastUtil.showError(context, text: state.error);
    } else if (state.status.isSuccess) {
      Navigator.of(context).pop();
      ToastUtil.showSuccess(
        context,
        text: LocaleKeys.organization_create_success.tr(),
      );
    } else if (state.status.isLoading) {
      DialogUtil.showLoading(context);
    }
  }
}

class _SetOrganizationView extends StatefulWidget {
  final OrganizationModel? organization;

  const _SetOrganizationView({this.organization});

  @override
  State<_SetOrganizationView> createState() => _SetOrganizationViewState();
}

class _SetOrganizationViewState extends State<_SetOrganizationView> {
  SetOrganizationDTO _setOrganization = SetOrganizationDTO();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _phoneNumberEditingController =
      TextEditingController();
  final TextEditingController _addressEditingController =
      TextEditingController();
  final TextEditingController _descriptionEditingController =
      TextEditingController();

  @override
  void initState() {
    _setOrganizationDTO();
    super.initState();
  }

  void _setOrganizationDTO() {
    if (widget.organization != null) {
      _setOrganization = widget.organization!.toSetOrganizationDTO();
      _setOrganizationInfo();
    }
  }

  void _setOrganizationInfo() {
    _nameEditingController.text = _setOrganization.name ?? '';
    _phoneNumberEditingController.text = _setOrganization.phoneNumber ?? '';
    _addressEditingController.text = _setOrganization.address ?? '';
    _descriptionEditingController.text = _setOrganization.description ?? '';
  }

  void _submitSetOrganization(BuildContext context) {
    _collectDataForSetOrganization();

    context
        .read<SetOrganizationBloc>()
        .add(SetOrganizationFormValidate(setOrganizationDTO: _setOrganization));

    if (_formKey.currentState!.validate() &&
        context.read<SetOrganizationBloc>().state.isValid) {
      context.read<SetOrganizationBloc>().add(
            SetOrganizationSubmit(
              setOrganization: _setOrganization,
            ),
          );
    }
  }

  Future<void> _collectDataForSetOrganization() async {
    _setOrganization = _setOrganization.copyWith(
      name: _nameEditingController.text,
      phoneNumber: _phoneNumberEditingController.text,
      address: _addressEditingController.text,
      description: _descriptionEditingController.text,
    );
  }

  void _setAvatar(File file) {
    _setOrganization.image = file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SetOrganizationAppbar(
        isUpdate: _setOrganization.id != null,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(AppSize.horizontalSpace),
        child: Column(
          children: [
            SetOrganizationForm(
              formKey: _formKey,
              setAvatar: _setAvatar,
              nameEditingController: _nameEditingController,
              phoneNumberEditingController: _phoneNumberEditingController,
              addressEditingController: _addressEditingController,
              descriptionEditingController: _descriptionEditingController,
              image: _setOrganization.image,
            ),
            const SizedBox(
              height: 30,
            ),
            Visibility(
              visible: _setOrganization.id == null,
              child: AppRoundedButton(
                onPressed: () {
                  _submitSetOrganization(context);
                },
                width: context.width / 2,
                content: LocaleKeys.button_create.tr(),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
