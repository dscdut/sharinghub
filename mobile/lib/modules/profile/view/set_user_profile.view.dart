import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/utils/dialog.util.dart';
import 'package:mobile/common/utils/toast.util.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/data/dtos/set_user.dto.dart';
import 'package:mobile/data/models/user.model.dart';
import 'package:mobile/data/repositories/user.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/profile/profile.dart';
import 'package:mobile/modules/profile/widgets/set_user_profile/set_user_appbar.widget.dart';
import 'package:mobile/modules/profile/widgets/set_user_profile/set_user_form.widget.dart';

class SetUserPage extends StatelessWidget {
  final UserModel? user;

  const SetUserPage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SetUserBloc(
        userRepository: getIt.get<UserRepository>(),
      ),
      child: BlocListener<SetUserBloc, SetUserState>(
        listener: _listenSetUserStateChanged,
        child: _SetUserView(
          user: user,
        ),
      ),
    );
  }

  void _listenSetUserStateChanged(
    BuildContext context,
    SetUserState state,
  ) {
    DialogUtil.hideLoading(context);

    if (state.status.isError) {
      ToastUtil.showError(context, text: state.error);
    } else if (state.status.isSuccess) {
      Navigator.of(context).pop();
      ToastUtil.showSuccess(
        context,
        text: LocaleKeys.texts_success.tr(),
      );
    } else if (state.status.isLoading) {
      DialogUtil.showLoading(context);
    }
  }
}

class _SetUserView extends StatefulWidget {
  final UserModel? user;

  const _SetUserView({this.user});

  @override
  State<_SetUserView> createState() => _SetUserViewState();
}

class _SetUserViewState extends State<_SetUserView> {
  SetUserDTO _setUser = SetUserDTO();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _phoneNumberEditingController =
      TextEditingController();
  final TextEditingController _addressEditingController =
      TextEditingController();
  final TextEditingController _workplaceEditingController =
      TextEditingController();

  @override
  void initState() {
    _setUserDTO();
    super.initState();
  }

  void _setUserDTO() {
    if (widget.user != null) {
      _setUser = widget.user!.toSetUserDTO();
      _setUserInfo();
    }
  }

  void _setUserInfo() {
    _emailEditingController.text = _setUser.email ?? '';
    _nameEditingController.text = _setUser.fullName ?? '';
    _phoneNumberEditingController.text = _setUser.phoneNumber ?? '';
    _addressEditingController.text = _setUser.address ?? '';
    _workplaceEditingController.text = _setUser.workplace ?? '';
  }

  void _submitSetUser(BuildContext context) {
    _collectDataForSetUser();

    context.read<SetUserBloc>().add(SetUserFormValidate(setUserDTO: _setUser));

    if (_formKey.currentState!.validate() &&
        context.read<SetUserBloc>().state.isValid) {
      context.read<SetUserBloc>().add(
            SetUserSubmit(
              setUser: _setUser,
            ),
          );
    }
  }

  Future<void> _collectDataForSetUser() async {
    _setUser = _setUser.copyWith(
      email: _emailEditingController.text,
      birthDate: _setUser.birthDate,
      gender: _setUser.gender,
      fullName: _nameEditingController.text,
      phoneNumber: _phoneNumberEditingController.text,
      address: _addressEditingController.text,
      workplace: _workplaceEditingController.text,
    );
  }

  void _setAvatar(File file) {
    _setUser.avatar = file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SetUserAppbar(
        isUpdate: _setUser.id != null,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(AppSize.horizontalSpace),
        child: Column(
          children: [
            SetUserProfileForm(
              formKey: _formKey,
              setAvatar: _setAvatar,
              nameEditingController: _nameEditingController,
              phoneNumberEditingController: _phoneNumberEditingController,
              addressEditingController: _addressEditingController,
              workplaceEditingController: _workplaceEditingController,
              emailEditingController: _emailEditingController,
              gender: _setUser.gender,
              birthday: _setUser.birthDate,
              image: _setUser.avatar,
            ),
            const SizedBox(
              height: 30,
            ),
            Visibility(
              visible: _setUser.id == null,
              child: AppRoundedButton(
                onPressed: () {
                  _submitSetUser(context);
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
