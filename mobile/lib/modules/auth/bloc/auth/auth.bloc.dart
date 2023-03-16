import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/utils/wrapped_value.dart';
import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:mobile/data/models/organization.model.dart';
import 'package:mobile/data/models/user.model.dart';
import 'package:mobile/data/repositories/user.repository.dart';

part 'auth.event.dart';
part 'auth.state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;

  AuthBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const AuthState.unknown()) {
    on<AuthUserInfoChecked>(_onCheckUserInfo);
    on<AuthUserAuthInfoSet>(_onSetUserInfo);
    on<AuthModeSwitch>(_onSwitchMode);
  }

  Future<void> _onCheckUserInfo(
    AuthUserInfoChecked event,
    Emitter<AuthState> emit,
  ) async {
    final userInfo = _userRepository.getUserInfo();

    _changeAuthState(userInfo, emit);
  }

  Future<void> _onSetUserInfo(
    AuthUserAuthInfoSet event,
    Emitter<AuthState> emit,
  ) async {
    await _userRepository.setUserAuthInfo(event.loginResponse);

    _changeAuthState(event.loginResponse?.user, emit);
  }

  Future<void> _onSwitchMode(
    AuthModeSwitch event,
    Emitter<AuthState> emit,
  ) async {
    _changeAuthState(
      await _setUserInfoWithOrganization(event.organization),
      emit,
    );
  }

  void _changeAuthState(
    UserModel? user,
    Emitter<AuthState> emit,
  ) {
    if (user == null) {
      emit(const AuthState.unauthenticated());
    } else if (user.isOrganizationMode) {
      emit(AuthState.authenticatedOrganization(user));
    } else {
      emit(AuthState.authenticatedUser(user));
    }
  }

  Future<UserModel> _setUserInfoWithOrganization(
    OrganizationModel? organization,
  ) async {
    final UserModel userInfo =
        state.user!.copyWith(currentOrganization: Wrapped.value(organization));

    _userRepository.setUserInfo(userInfo);

    return userInfo;
  }
}
