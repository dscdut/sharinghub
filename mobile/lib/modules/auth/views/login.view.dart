import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/utils/toast.util.dart';
import 'package:mobile/data/repositories/user.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/assets.gen.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/auth/bloc/auth/auth.bloc.dart';
import 'package:mobile/modules/auth/bloc/login/login.bloc.dart';
import 'package:mobile/modules/auth/widgets/auth_navigate_option.widget.dart';
import 'package:mobile/modules/auth/widgets/login/login_form.widget.dart';
import 'package:mobile/modules/auth/widgets/login/option_and_submit_button.widget.dart';
import 'package:mobile/modules/auth/widgets/login/switch_language_button.widget.dart';

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
          _listenLoginStateChanged(context, state);
        },
        child: _LoginView(),
      ),
    );
  }

  void _listenLoginStateChanged(BuildContext context, LoginState state) {
    if (state is LoginNotSuccess && state.error == null) {
      ToastUtil.showError(
        context,
      );
    }
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
            LoginSubmit(
              email: _emailEditingController.text,
              password: _passwordEditingController.text,
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
                const SizedBox(
                  height: 50,
                ),
                const SwitchLanguageButtonWidget(),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Assets.images.imgLogo.image(width: 100, height: 100),
                ),
                const SizedBox(height: 40),
                Align(
                  child: Text(
                    LocaleKeys.auth_login.tr(),
                    style: TextStyles.regularText.copyWith(fontSize: 34),
                  ),
                ),
                const SizedBox(height: 40),
                LoginForm(
                  formKey: _formKey,
                  emailEditingController: _emailEditingController,
                  passwordEditingController: _passwordEditingController,
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return OptionsAndSubmitButton(
                      onSubmit: () {
                        _onLoginButtonPressed(context);
                      },
                      isLoading: state is LoginLoading,
                    );
                  },
                ),
                const Spacer(),
                const AuthNavigateOption(
                  haveAccount: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
