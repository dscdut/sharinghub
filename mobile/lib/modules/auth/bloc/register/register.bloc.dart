import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:mobile/data/repositories/user.repository.dart';
import 'package:mobile/generated/locale_keys.g.dart';

part 'register.event.dart';
part 'register.state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(RegisterInitial()) {
    on<RegisterSubmit>(_onSubmitRegister);
  }

  Future<void> _onSubmitRegister(
    RegisterSubmit event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());

    try {
      await _userRepository.registerByEmail(
        event.submitRegister,
      );

      emit(RegisterSuccess());
    } on DioError catch (dioError) {
      if (dioError.response?.statusCode == 409) {
        emit(
          RegisterNotSuccess(
            emailError: LocaleKeys.validator_existed_email.tr(),
          ),
        );
      } else {
        emit(
          const RegisterNotSuccess(),
        );
      }
    } catch (_) {
      emit(
        const RegisterNotSuccess(),
      );
    }
  }
}
