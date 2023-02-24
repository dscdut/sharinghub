import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:mobile/data/repositories/user.repository.dart';

part 'login.event.dart';
part 'login.state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  // final AuthBloc _authBloc;
  final UserRepository _userRepository;

  LoginBloc({
    required UserRepository userRepository,
    // required AuthBloc authBloc,
  })  : _userRepository = userRepository,
        // _authBloc = authBloc,
        super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emitter,
  ) async {
    emitter(LoginLoading());

    try {
      await _userRepository.loginByEmail(
        AuthenticationDTO(email: event.email, password: event.password),
      );

      // _authBloc.add(
      //   AuthSetUser(
      //     currentEmail: loginRepsonse.email,
      //     password: loginRepsonse.password,
      //   ),
      // );

      // log(loginRepsonse.toString());

      // _authBloc.add(
      //   AuthSetTokens(
      //     refreshToken: RefreshTokenDTO(
      //       accessToken: loginRepsonse.accessToken,
      //       refreshToken: loginRepsonse.refreshToken,
      //       expiresIn: loginRepsonse.expiresIn,
      //     ),
      //   ),
      // );
      emitter(LoginSuccess());
    } on DioError catch (error) {
      emitter(
        const LoginNotSuccess(),
      );
      log(error.toString());
    }
  }
}
