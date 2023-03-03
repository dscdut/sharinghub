import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/constants/hive_keys.dart';
import 'package:mobile/common/helpers/hive/hive.helper.dart';
import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:mobile/data/models/user.model.dart';
import 'package:mobile/data/repositories/user.repository.dart';
part 'auth.event.dart';
part 'auth.state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;

  AuthBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const AuthState.unknown()) {
    on<AuthUserInfoSet>(_onUserInfoSet);
    // on<AuthSetTokens>(_onSetTokens);
    on<AuthUserInfoChecked>(_onUserInfoChecked);
  }

  Future<void> _getUserInfo(
    Emitter<AuthState> emitter,
  ) async {
    try {
      final BaseUserModel user = await _userRepository.getUserInfo();

      emitter(AuthState.authenticated(user: user));
    } catch (err) {
      emitter(const AuthState.unauthenticated());
    }
  }

  Future<void> _onUserInfoChecked(
    AuthUserInfoChecked event,
    Emitter<AuthState> emitter,
  ) async {
    final user = await HiveHelper.get(
      boxName: HiveKeys.authBox,
      keyValue: HiveKeys.user,
    );

    if (user == null) {
      emitter(const AuthState.unauthenticated());
    } else {
      await _getUserInfo(emitter);
    }
  }

  Future<void> _onUserInfoSet(
    AuthUserInfoSet event,
    Emitter<AuthState> emitter,
  ) async {
    if (event.authResponse == null) {
      emitter(const AuthState.unauthenticated());
    } else {
      await HiveHelper.putAll(
        boxName: HiveKeys.authBox,
        value: event.authResponse!.toJson(),
      );

      emitter(
        AuthState.authenticated(
          user: event.authResponse!.user.toModel(),
        ),
      );
    }
  }

  // Future<void> _onSetTokens(
  //   AuthSetTokens event,
  //   Emitter<AuthState> emitter,
  // ) async {
  //   if (event.refreshToken == null) {
  //     await HiveHelper.clear(boxName: HiveKeys.authBox);
  //   } else {
  //     await HiveHelper.putAll(
  //       boxName: HiveKeys.authBox,
  //       value: event.refreshToken!.toLocalJson(),
  //     );
  //   }
  // }
}
