import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/utils/file.util.dart';
import 'package:mobile/modules/auth/bloc/auth/auth.bloc.dart';

part 'splash.event.dart';
part 'splash.state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AuthBloc _authBloc;

  SplashBloc({required AuthBloc authBloc})
      : _authBloc = authBloc,
        super(const SplashState()) {
    on<SplashStarted>(_onSplashStarted);
    add(SplashStarted());
  }

  Future<void> _getApplicationDir() async {
    try {
      await FileUtil.getApplicationDir();
    } catch (err) {
      log('Error in getApplicationDir: $err');
    }
  }

  Future<void> _onSplashStarted(
    SplashStarted event,
    Emitter<SplashState> emitter,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));

    _getApplicationDir();

    _authBloc.add(AuthUserInfoChecked());
  }
}
