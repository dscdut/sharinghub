import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:mobile/data/repositories/user.repository.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/auth/bloc/auth/auth.bloc.dart';

part 'login.event.dart';
part 'login.state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthBloc _authBloc;
  final UserRepository _userRepository;

  LoginBloc({
    required UserRepository userRepository,
    required AuthBloc authBloc,
  })  : _authBloc = authBloc,
        _userRepository = userRepository,
        super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return LocaleKeys.validator_email_required.tr();
    }

    return null;
  }

  String? validatePassword(String? email) {
    if (email == null || email.isEmpty) {
      return LocaleKeys.validator_password_required.tr();
    }

    return null;
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emitter,
  ) async {
    try {
      final LoginResponseDTO loginRepsonse = await _userRepository.loginByEmail(
        AuthenticationDTO(email: event.email, password: event.password),
      );

      _authBloc.add(
        AuthSetUser(
          currentUser: loginRepsonse.user,
        ),
      );

      _authBloc.add(
        AuthSetTokens(
          refreshToken: RefreshTokenDTO(
            accessToken: loginRepsonse.accessToken,
            refreshToken: loginRepsonse.refreshToken,
            expiresIn: loginRepsonse.expiresIn,
          ),
        ),
      );
    } on DioError catch (err) {
      log(err.response.toString());
    }
  }
}
