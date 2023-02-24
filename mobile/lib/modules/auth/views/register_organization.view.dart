import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/data/repositories/organization.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/auth/bloc/register/register_bloc.dart';
import 'package:mobile/modules/auth/widgets/register_form_organization.widget.dart';
import 'package:mobile/router/app_routes.dart';

class OrganizationRegisterPage extends StatelessWidget {
  const OrganizationRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrganizationRegisterBloc(
        organizationRepository: getIt.get<OrganizationRepository>(),
      ),
      child: _OrganizationRegisterView(),
    );
  }
}

class _OrganizationRegisterView extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _organizationNameEditingController =
      TextEditingController();
  final TextEditingController _organizationCEOEditingController =
      TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _rePasswordEditingController =
      TextEditingController();

  _OrganizationRegisterView();

  void _onRegisterButtonPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<OrganizationRegisterBloc>().add(
            OrganizationRegisterButtonPressed(
              organizationName: _organizationNameEditingController.text,
              organizationCEO: _organizationCEOEditingController.text,
              email: _emailEditingController.text,
              password: _passwordEditingController.text,
              confirmPassword: _rePasswordEditingController.text,
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
                      LocaleKeys.auth_sign_up.tr(),
                      style: TextStyles.regularText.copyWith(fontSize: 34),
                    ),
                  ),
                  const SizedBox(height: 40),
                  OrganizationRegisterForm(
                    formKey: _formKey,
                    organizationNameEditingController: _organizationNameEditingController,
                    organizationCEOEditingController: _organizationCEOEditingController,
                    emailEditingController: _emailEditingController,
                    passwordEditingController: _passwordEditingController,
                    rePasswordEditingController: _rePasswordEditingController,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.login,
                          );
                        },
                        child: Text(
                          LocaleKeys.auth_sign_in.tr(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  BlocBuilder<OrganizationRegisterBloc, OrganizationRegisterState>(
                    builder: (context, state) {
                      return AppRoundedButton(
                        onPressed: () {
                          _onRegisterButtonPressed(context);
                        },
                        content: LocaleKeys.auth_sign_up.tr(),
                        width: double.infinity,
                        isLoading: state.loadingStatus == LoadingStatus.loading,
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
