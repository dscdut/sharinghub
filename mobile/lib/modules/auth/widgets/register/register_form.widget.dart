import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/utils/validator.util.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/auth/bloc/register/register.bloc.dart';
import 'package:mobile/modules/auth/widgets/auth_text_form_field.widget.dart';

class RegisterForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController nameEditingController;
  final TextEditingController emailEditingController;
  final TextEditingController passwordEditingController;
  final TextEditingController confirmPasswordEditingController;

  const RegisterForm({
    super.key,
    required this.formKey,
    required this.nameEditingController,
    required this.emailEditingController,
    required this.passwordEditingController,
    required this.confirmPasswordEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (_, state) => Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthTextFormField(
              validator: ValidatorUtil.validateRequiredField,
              textController: nameEditingController,
              hintText: LocaleKeys.texts_full_name.tr(),
            ),
            const SizedBox(height: 15),
            BlocBuilder<RegisterBloc, RegisterState>(
              builder: (context, state) {
                return AuthTextFormField(
                  validator: ValidatorUtil.validateEmail,
                  textController: emailEditingController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: LocaleKeys.texts_email_address.tr(),
                  errorText: state.emailError,
                );
              },
            ),
            const SizedBox(height: 15),
            AuthTextFormField(
              validator: ValidatorUtil.validatePassword,
              textController: passwordEditingController,
              hintText: LocaleKeys.auth_password.tr(),
              isPasswordField: true,
            ),
            const SizedBox(height: 15),
            AuthTextFormField(
              validator: (String? value) {
                return ValidatorUtil.validateConfirmPassword(
                  value,
                  passwordEditingController.text,
                );
              },
              textController: confirmPasswordEditingController,
              hintText: LocaleKeys.auth_confirm_password.tr(),
              isPasswordField: true,
            ),
          ],
        ),
      ),
    );
  }
}
