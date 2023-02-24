import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/widgets/app_text_form_field.widget.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/auth/auth.dart';

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

  String? _validateEmail(String? value) {
    if (value != null) {
      final bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      ).hasMatch(value);

      if (!emailValid) {
        return LocaleKeys.validator_email_error.tr();
      }
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value != null) {
      if (value.length < 8) {
        return LocaleKeys.validator_password_length.tr();
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextFormField(
            validator: _validateEmail,
            textController: widget.emailEditingController,
            borderRadius: 10,
            borderColor: Colors.black26,
            keyboardType: TextInputType.emailAddress,
            hintText: LocaleKeys.auth_email.tr(),
            hintColor: Colors.black26,
          ),
          const SizedBox(height: 15),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (_, state) => AppTextFormField(
              //   focusNode: controller.passwordFocusNode,
              validator: _validatePassword,
              textController: widget.passwordEditingController,
              borderRadius: 10,
              suffixIcon: isObscure ? Icons.visibility_off : Icons.visibility,
              onTapSuffixIcon: () {
                setState(() {
                  isObscure = !isObscure;
                });
              },
              borderColor: Colors.black26,
              keyboardType: TextInputType.text,
              errorText: state.passwordError,
              isObscure: isObscure,
              hintText: LocaleKeys.auth_password.tr(),
              hintColor: Colors.black26,
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
