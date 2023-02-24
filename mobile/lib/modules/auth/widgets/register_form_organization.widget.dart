import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/widgets/app_text_form_field.widget.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/auth/bloc/register/register_bloc.dart';

class OrganizationRegisterForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController organizationNameEditingController;
  final TextEditingController organizationCEOEditingController;
  final TextEditingController emailEditingController;
  final TextEditingController passwordEditingController;
  final TextEditingController rePasswordEditingController;

  const OrganizationRegisterForm({
    super.key,
    required this.formKey,
    required this.organizationNameEditingController,
    required this.organizationCEOEditingController,
    required this.emailEditingController,
    required this.passwordEditingController,
    required this.rePasswordEditingController,
  });

  @override
  State<OrganizationRegisterForm> createState() =>
      _OrganizationRegisterFormState();
}

class _OrganizationRegisterFormState extends State<OrganizationRegisterForm> {
  bool _isObscure = true;
  bool _isObscureRe = true;

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrganizationRegisterBloc, OrganizationRegisterState>(
      builder: (_, state) => Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextFormField(
              errorText: state.organizationNameError,
              textController: widget.organizationNameEditingController,
              borderRadius: 10,
              borderColor: Colors.black26,
              keyboardType: TextInputType.name,
              hintText: LocaleKeys.texts_organizationName.tr(),
              hintColor: Colors.black26,
            ),
            const SizedBox(height: 15),
            AppTextFormField(
              errorText: state.organizationCEOError,
              textController: widget.organizationCEOEditingController,
              borderRadius: 10,
              borderColor: Colors.black26,
              keyboardType: TextInputType.name,
              hintText: LocaleKeys.texts_organizationCEO.tr(),
              hintColor: Colors.black26,
            ),
            const SizedBox(height: 15),
            AppTextFormField(
              validator: _validateEmail,
              errorText: state.emailError,
              textController: widget.emailEditingController,
              borderRadius: 10,
              borderColor: Colors.black26,
              keyboardType: TextInputType.emailAddress,
              hintText: LocaleKeys.texts_email_address.tr(),
              hintColor: Colors.black26,
            ),
            const SizedBox(height: 15),
            AppTextFormField(
              errorText: state.passwordError,
              textController: widget.passwordEditingController,
              borderRadius: 10,
              borderColor: Colors.black26,
              keyboardType: TextInputType.text,
              suffixIcon: _isObscure ? Icons.visibility_off : Icons.visibility,
              onTapSuffixIcon: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
              isObscure: _isObscure,
              hintText: LocaleKeys.auth_password.tr(),
              hintColor: Colors.black26,
            ),
            const SizedBox(height: 15),
            AppTextFormField(
              errorText: state.confirmPasswordError,
              textController: widget.rePasswordEditingController,
              borderRadius: 10,
              borderColor: Colors.black26,
              keyboardType: TextInputType.text,
              suffixIcon: _isObscureRe ? Icons.visibility_off : Icons.visibility,
              onTapSuffixIcon: () {
                setState(() {
                  _isObscureRe = !_isObscureRe;
                });
              },
              isObscure: _isObscureRe,
              hintText: LocaleKeys.auth_confirm_password.tr(),
              hintColor: Colors.black26,
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
