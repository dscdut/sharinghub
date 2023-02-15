import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/utils/toast.util.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/common/widgets/app_text_form_field.widget.dart';
import 'package:mobile/data/repositories/user.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/auth/bloc/auth/auth.bloc.dart';
import 'package:mobile/modules/auth/bloc/login/login.bloc.dart';

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
        listener: (context, state) {
          if (state is LoginNotSuccess) {
            ToastUtil.showError(
              context,
              text: 'Đăng nhập không thành công!',
            );
          }
        },
        child: _LoginView(),
      ),
    );
  }
}

class _LoginView extends StatelessWidget {
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();

  _LoginView();

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
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return Form(
                    key: context.read<LoginBloc>().formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.login_welcome_back.tr(),
                          style: TextStyles.s17BoldText,
                        ),
                        const SizedBox(height: 40),
                        AppTextFormField(
                          validator: context.read<LoginBloc>().validateEmail,
                          textController: emailEditingController,
                          labelText: LocaleKeys.texts_email_address.tr(),
                          keyboardType: TextInputType.emailAddress,
                          errorText: state.emailError,
                          hintText: 'name@email.com',
                          onChanged: (value) {},
                        ),
                        const SizedBox(height: 15),
                        AppTextFormField(
                          //   focusNode: controller.passwordFocusNode,
                          textController: passwordEditingController,
                          labelText: LocaleKeys.texts_password.tr(),
                          keyboardType: TextInputType.text,
                          errorText: state.passwordError,
                          isObscure: true,
                          hintText: '••••••••',
                          onChanged: (value) {},
                        ),
                        const SizedBox(height: 15),
                        AppRoundedButton(
                          onPressed: () async {
                            log(emailEditingController.text);

                            context.read<LoginBloc>().add(
                                  LoginButtonPressed(
                                    email: emailEditingController.text,
                                    password: passwordEditingController.text,
                                  ),
                                );
                          },
                          content: LocaleKeys.login_sign_in.tr(),
                          width: double.infinity,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
