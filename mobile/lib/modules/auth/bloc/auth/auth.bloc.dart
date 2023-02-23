import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/constants/hive_keys.dart';
import 'package:mobile/common/helpers/hive/hive.helper.dart';
part 'auth.event.dart';
part 'auth.state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.unknown()) {
    on<AuthSetUser>(_onSetUser);
    // on<AuthSetTokens>(_onSetTokens);
    on<AuthGetUserInfo>(_onGetUserInfo);
  }

  Future<void> _onGetUserInfo(
    AuthGetUserInfo event,
    Emitter<AuthState> emitter,
  ) async {
    final String? accessToken = await HiveHelper.get(
      boxName: HiveKeys.authBox,
      keyValue: HiveKeys.accessToken,
    );

    if (accessToken == null) {
      emitter(const AuthState.unauthenticated());
    } else {
      emitter(const AuthState.authenticated(email: '', password: ''));
    }
  }

  void _onSetUser(AuthSetUser event, Emitter<AuthState> emitter) {
    if (event.currentEmail == null || event.password == null) {
      emitter(const AuthState.unauthenticated());
    } else {
      emitter(AuthState.authenticated(
          email: event.currentEmail!, password: event.password!));
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
