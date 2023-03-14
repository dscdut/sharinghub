import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:mobile/data/models/user.model.dart';
import 'package:mobile/data/repositories/user.repository.dart';
part 'auth.event.dart';
part 'auth.state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;

  AuthBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const AuthState.unknown()) {
    on<AuthTokensSet>(_onSetTokens);
    on<AuthUserInfoChecked>(_onCheckUserInfo);
  }

  Future<void> _onCheckUserInfo(
    AuthUserInfoChecked event,
    Emitter<AuthState> emit,
  ) async {
    final token = _userRepository.getAccessToken();

    _changeAuthState(token, emit);
  }

  Future<void> _onSetTokens(
    AuthTokensSet event,
    Emitter<AuthState> emit,
  ) async {
    await _userRepository.setTokens(event.tokenDTO);

    _changeAuthState(event.tokenDTO?.accessToken, emit);
  }

  void _changeAuthState(
    String? token,
    Emitter<AuthState> emit,
  ) {
    if (token == null) {
      emit(const AuthState.unauthenticated());
    } else {
      emit(const AuthState.authenticated());
    }
  }
}
