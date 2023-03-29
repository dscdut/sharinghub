import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
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
  })  : _userRepository = userRepository,
        _authBloc = authBloc,
        super(LoginInitial()) {
    on<LoginSubmit>(_onSubmitLogin);
  }

  Future<void> _onSubmitLogin(
    LoginSubmit event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    try {
      final LoginResponseDTO loginResponse = await _userRepository.loginByEmail(
        SubmitLoginDTO(email: event.email, password: event.password),
      );

      _authBloc.add(
        AuthUserAuthInfoSet(loginResponse),
      );
      emit(LoginSuccess());
    } on DioError catch (err) {
      if (err.response?.statusCode == 401) {
        emit(
          LoginNotSuccess(
            error: LocaleKeys.validator_incorrect_email_password.tr(),
          ),
        );
      } else {
        emit(
          const LoginNotSuccess(),
        );
      }
    } catch (err) {
      emit(
        const LoginNotSuccess(),
      );
    }
  }
}
