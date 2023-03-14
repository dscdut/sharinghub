import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/utils/toast.util.dart';
import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:mobile/data/repositories/user.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/auth/bloc/register/register.bloc.dart';
import 'package:mobile/modules/auth/widgets/auth_navigate_option.widget.dart';
import 'package:mobile/modules/auth/widgets/login/option_and_submit_button.widget.dart';
import 'package:mobile/modules/auth/widgets/register/register_form.widget.dart';
import 'package:mobile/router/app_routes.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterBloc(
        userRepository: getIt.get<UserRepository>(),
      ),
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: _listenRegisterStateChanged,
        child: _RegisterView(),
      ),
    );
  }

  void _listenRegisterStateChanged(
    BuildContext context,
    RegisterState state,
  ) {
    if (state.status == HandleStatus.error) {
      ToastUtil.showError(
        context,
        position: ToastPosition.TOP,
      );
    } else if (state.status == HandleStatus.success) {
      ToastUtil.showSuccess(
        context,
        position: ToastPosition.TOP,
        text: LocaleKeys.auth_registration_successful.tr(),
      );

      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.login,
        (route) => false,
      );
    }
  }
}

class _RegisterView extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _confirmPasswordEditingController =
      TextEditingController();

  _RegisterView();

  void _onRegisterButtonPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<RegisterBloc>().add(
            RegisterSubmit(
              SubmitRegisterDTO(
                fullName: _nameEditingController.text,
                email: _emailEditingController.text,
                password: _passwordEditingController.text,
                confirmPassword: _confirmPasswordEditingController.text,
              ),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Container(
            height: context.height,
            padding: EdgeInsets.fromLTRB(
              40,
              0,
              40,
              context.paddingBottom + 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Align(
                  child: Text(
                    LocaleKeys.auth_sign_up.tr(),
                    style: TextStyles.regularText.copyWith(fontSize: 34),
                  ),
                ),
                const SizedBox(height: 40),
                RegisterForm(
                  formKey: _formKey,
                  nameEditingController: _nameEditingController,
                  emailEditingController: _emailEditingController,
                  passwordEditingController: _passwordEditingController,
                  confirmPasswordEditingController:
                      _confirmPasswordEditingController,
                ),
                BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    return OptionsAndSubmitButton(
                      onSubmit: () {
                        _onRegisterButtonPressed(context);
                      },
                      isLoading: state.status == HandleStatus.loading,
                      isLogin: false,
                    );
                  },
                ),
                const Spacer(),
                const AuthNavigateOption()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
