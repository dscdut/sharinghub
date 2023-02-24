import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/utils/toast.util.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/data/repositories/personal.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/auth/bloc/register/register_bloc.dart';
import 'package:mobile/modules/auth/widgets/register_form_personal.widget.dart';
import 'package:mobile/router/app_routes.dart';

class PersonalRegisterPage extends StatelessWidget {
  const PersonalRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PersonalRegisterBloc(
        personalRepository: getIt.get<PersonalRepository>(),
      ),
      child: BlocListener<PersonalRegisterBloc, PersonalRegisterState>(
        listener: (context, state) {
          if (state.loadingStatus == LoadingStatus.error) {
            ToastUtil.showError(
              context,
              text: 'Lỗi nên là qua đăng nhập đi :< do chưa có API',
            );
          }
          if (state.loadingStatus == LoadingStatus.done) {
            ToastUtil.showSuccess(
              context,
              text: LocaleKeys.texts_success.tr(),
            );
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.login,
              (route) => false,
            );
          }
        },
        child: _PersonalRegisterView(),
      ),
    );
  }
}

class _PersonalRegisterView extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _personalNameEditingController =
      TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _rePasswordEditingController =
      TextEditingController();

  _PersonalRegisterView();

  void _onRegisterButtonPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<PersonalRegisterBloc>().add(
            PersonalRegisterButtonPressed(
              fullName: _personalNameEditingController.text,
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
                  PersonalRegisterForm(
                    formKey: _formKey,
                    personalNameEditingController:
                        _personalNameEditingController,
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
                  BlocBuilder<PersonalRegisterBloc, PersonalRegisterState>(
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
