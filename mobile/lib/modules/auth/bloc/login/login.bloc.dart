import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:mobile/data/repositories/user.repository.dart';
import 'package:mobile/modules/auth/bloc/auth/auth.bloc.dart';

part 'login.event.dart';
part 'login.state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthBloc _authBloc;
  final UserRepository _userRepository;

  LoginBloc({
    required UserRepository userRepository,
    required AuthBloc authBloc,
  })  : _userRepository = userRepository,
        _authBloc = authBloc,
        super(LoginInitial()) {
    on<LoginSubmit>(_onLoginSubmit);
  }

  Future<void> _onLoginSubmit(
    LoginSubmit event,
    Emitter<LoginState> emitter,
  ) async {
    emitter(LoginLoading());

    try {
      final AuthResponseDTO loginResponse = await _userRepository.loginByEmail(
        SubmitLoginDTO(email: event.email, password: event.password),
      );

      // _authBloc.add(AuthUserInfoSet(authResponse: loginResponse));

      // _authBloc.add(
      //   AuthSetUser(
      //     currentEmail: loginRepsonse.email,
      //     password: loginRepsonse.password,
      //   ),
      // );

      // log(loginRepsonse.toString());

      _authBloc.add(
        AuthSetTokens(
          accessToken: AccessTokenDTO(
            accessToken: loginResponse.accessToken,
          ),
        ),
      );
      emitter(LoginSuccess());
    } on DioError catch (error) {
      emitter(
        const LoginNotSuccess(),
      );
      log(error.toString());
    }
  }
}
