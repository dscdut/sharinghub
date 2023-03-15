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
    on<RegisterSubmit>(_onSubmitRegister);
  }

  Future<void> _onSubmitRegister(
    RegisterSubmit event,
    Emitter<RegisterState> emitter,
  ) async {
    emitter(state.copyWith(status: HandleStatus.loading));

    try {
      await _userRepository.registerByEmail(
        event.submitRegister,
      );

      emitter(state.copyWith(status: HandleStatus.success));
    } catch (_) {
      emitter(
        state.copyWith(
          status: HandleStatus.error,
        ),
      );
    }
  }
}
