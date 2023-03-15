import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/utils/dialog.util.dart';
import 'package:mobile/common/utils/toast.util.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/common/widgets/custom_app_bar.widget.dart';
import 'package:mobile/data/dtos/set_organization.dto.dart';
import 'package:mobile/data/models/organization.model.dart';
import 'package:mobile/data/repositories/organization.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/management/bloc/set/set_organization.bloc.dart';
import 'package:mobile/modules/management/widgets/set/set_organization_form.widget.dart';

class SetOrganizationPage extends StatelessWidget {
  final OrganizationModel? organization;

  const SetOrganizationPage({super.key, this.organization});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SetOrganizationBloc(
        organizationRepository: getIt.get<OrganizationRepository>(),
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

    if (state.status == HandleStatus.error) {
      ToastUtil.showError(context, text: state.error);
    } else if (state.status == HandleStatus.success) {
    } else if (state.status == HandleStatus.loading) {
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
  SetOrganizationDTO setOrganization = SetOrganizationDTO();

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
      setOrganization = widget.organization!.toSetOrganizationDTO();
      _setOrganizationInfo();
    }
  }

  void _setOrganizationInfo() {
    _nameEditingController.text = setOrganization.name ?? '';
    _phoneNumberEditingController.text = setOrganization.phoneNumber ?? '';
    _addressEditingController.text = setOrganization.address ?? '';
    _descriptionEditingController.text = setOrganization.description ?? '';
  }

  void _submitSetOrganization(BuildContext context) {
    _collectDataForSetOrganization();

    context
        .read<SetOrganizationBloc>()
        .add(SetOrganizationFormValidate(setOrganizationDTO: setOrganization));
    print(context.read<SetOrganizationBloc>().state.isValid);

    if (_formKey.currentState!.validate()
        // &&
        //     context.read<SetOrganizationBloc>().state.isValid
        ) {
      context.read<SetOrganizationBloc>().add(
            SetOrganizationSubmit(
              setOrganization: SetOrganizationDTO(
                address: setOrganization.address,
                description: setOrganization.description,
                name: setOrganization.name,
                phoneNumber: setOrganization.phoneNumber,
              ),
            ),
          );
    }
  }

  void _collectDataForSetOrganization() {
    setOrganization = setOrganization.copyWith(
      avatar: '',
      name: _nameEditingController.text,
      phoneNumber: _phoneNumberEditingController.text,
      address: _phoneNumberEditingController.text,
      description: _descriptionEditingController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.organization == null
            ? LocaleKeys.organization_create.tr()
            : LocaleKeys.organization_update.tr(),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(AppSize.horizontalSpace),
        child: Column(
          children: [
            SetOrganizationForm(
              formKey: _formKey,
              nameEditingController: _nameEditingController,
              phoneNumberEditingController: _phoneNumberEditingController,
              addressEditingController: _addressEditingController,
              descriptionEditingController: _descriptionEditingController,
            ),
            const SizedBox(
              height: 30,
            ),
            AppRoundedButton(
              onPressed: () {
                _submitSetOrganization(context);
              },
              width: context.width / 2,
              content: widget.organization == null
                  ? LocaleKeys.button_create.tr()
                  : LocaleKeys.button_update.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
