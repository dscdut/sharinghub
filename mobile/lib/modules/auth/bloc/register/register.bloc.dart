import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:mobile/data/repositories/user.repository.dart';

part 'register.event.dart';
part 'register.state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const RegisterState()) {
    on<RegisterSubmit>(_onRegisterSubmit);
  }

  Future<void> _onRegisterSubmit(
    RegisterSubmit event,
    Emitter<RegisterState> emitter,
  ) async {
    emitter(state.copyWith(status: HandleStatus.loading));

    try {
      bool result = await _userRepository.registerByEmail(
        SubmitRegisterDTO(
          name: event.name,
          representativeName: event.representativeName,
          email: event.email,
          password: event.password,
        ),
      );
      if (result) {
        emitter(state.copyWith(status: HandleStatus.success));
      } else {
        emitter(state.copyWith(status: HandleStatus.error));
      }
    } catch (_) {
      emitter(
        state.copyWith(
          status: HandleStatus.error,
        ),
      );
    }
  }
}
