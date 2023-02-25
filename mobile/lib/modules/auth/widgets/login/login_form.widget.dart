import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/utils/validator.util.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/auth/auth.dart';
import 'package:mobile/modules/auth/widgets/auth_text_form_field.widget.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController emailEditingController;

  final TextEditingController passwordEditingController;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailEditingController,
    required this.passwordEditingController,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthTextFormField(
            validator: ValidatorUtil.validateEmail,
            textController: widget.emailEditingController,
            keyboardType: TextInputType.emailAddress,
            hintText: LocaleKeys.auth_email.tr(),
          ),
          const SizedBox(height: 15),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (_, state) {
              return AuthTextFormField(
                //   focusNode: controller.passwordFocusNode,
                validator: ValidatorUtil.validatePassword,
                textController: widget.passwordEditingController,
                isPasswordField: true,
                hintText: LocaleKeys.auth_password.tr(),
                errorText: state.error,
              );
            },
          ),
        ],
      ),
    );
  }
}
