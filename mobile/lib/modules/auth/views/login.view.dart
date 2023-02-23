import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/utils/toast.util.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/data/repositories/user.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/auth/bloc/auth/auth.bloc.dart';
import 'package:mobile/modules/auth/bloc/login/login.bloc.dart';
import 'package:mobile/modules/auth/widgets/login_form.view.dart';
import 'package:mobile/router/app_routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(
        authBloc: context.read<AuthBloc>(),
        userRepository: getIt.get<UserRepository>(),
      ),
      child: BlocListener<LoginBloc, LoginState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is LoginNotSuccess) {
            ToastUtil.showError(
              context,
              text: LocaleKeys.texts_error_occur.tr(),
            );
          }
          if (state is LoginSuccess) {
            context.read<AuthBloc>().add(AuthGetUserInfo());
            ToastUtil.showSuccess(
              context,
              text: LocaleKeys.texts_success,
            );
            context.go(AppRoutes.root);
          }
        },
        child: _LoginView(),
      ),
    );
  }
}

class _LoginView extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();

  _LoginView();

  void _onLoginButtonPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<LoginBloc>().add(
            LoginButtonPressed(
              email: _emailEditingController.text,
              password: _passwordEditingController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppSize.horizontalSpace,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    child: Text(
                      LocaleKeys.auth_sign_in.tr(),
                      style: TextStyles.regularText.copyWith(fontSize: 34),
                    ),
                  ),
                  const SizedBox(height: 40),
                  LoginForm(
                    formKey: _formKey,
                    emailEditingController: _emailEditingController,
                    passwordEditingController: _passwordEditingController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.auth_sign_up.tr(),
                      ),
                      Text(LocaleKeys.auth_forgot_password.tr())
                    ],
                  ),
                  const SizedBox(height: 50),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return AppRoundedButton(
                        onPressed: () {
                          _onLoginButtonPressed(context);
                        },
                        content: LocaleKeys.auth_login.tr(),
                        width: double.infinity,
                        isLoading: state is LoginLoading,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
