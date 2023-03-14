import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/constants/hive_keys.dart';
import 'package:mobile/common/helpers/hive/hive.helper.dart';
import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:mobile/data/models/user.model.dart';
part 'auth.event.dart';
part 'auth.state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.unknown()) {
    // on<AuthUserInfoSet>(_onUserInfoSet);
    on<AuthSetTokens>(_onSetTokens);
    on<AuthUserInfoChecked>(_onUserInfoChecked);
  }

  // Future<void> _getUserInfo(
  //   Emitter<AuthState> emitter,
  // ) async {
  //   try {
  //     emitter(const AuthState.authenticated());
  //   } catch (err) {
  //     emitter(const AuthState.unauthenticated());
  //   }
  // }

  Future<void> _onUserInfoChecked(
    AuthUserInfoChecked event,
    Emitter<AuthState> emitter,
  ) async {
    final token = await HiveHelper.get(
      boxName: HiveKeys.authBox,
      keyValue: HiveKeys.accessToken,
    );

    if (token == null) {
      emitter(const AuthState.unauthenticated());
    } else {
      // await _getUserInfo(emitter);
      emitter(const AuthState.authenticated());
    }
  }

  // Future<void> _onUserInfoSet(
  //   AuthUserInfoSet event,
  //   Emitter<AuthState> emitter,
  // ) async {
  //   if (event.authResponse == null) {
  //     emitter(const AuthState.unauthenticated());
  //   } else {
  //     await HiveHelper.putAll(
  //       boxName: HiveKeys.authBox,
  //       value: event.authResponse!.toJson(),
  //     );

  //     emitter(
  //       const AuthState.authenticated(),
  //     );
  //   }
  // }

  Future<void> _onSetTokens(
    AuthSetTokens event,
    Emitter<AuthState> emitter,
  ) async {
    if (event.accessToken == null) {
      await HiveHelper.clear(boxName: HiveKeys.authBox);
    } else {
      await HiveHelper.putAll(
        boxName: HiveKeys.authBox,
        value: event.accessToken!.toLocalJson(),
      );
    }
  }
}
