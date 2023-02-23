import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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

  Future<void> _onSplashStarted(
    SplashStarted event,
    Emitter<SplashState> emitter,
  ) async {
    await Future.delayed(const Duration(milliseconds: 600));

    _authBloc.add(AuthGetUserInfo());
  }
}
