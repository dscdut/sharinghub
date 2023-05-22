import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log(
      'onBlocCreate -- ${bloc.runtimeType}',
      name: '${bloc.runtimeType}_CREATE',
    );
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('onAddEvent -- $event', name: '${bloc.runtimeType}_EVENT');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log(
      'onStateTransition -- ${bloc.runtimeType}\n',
      name: '${bloc.runtimeType}_TRANSITION',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log(
      'onError -- ${bloc.runtimeType}, $error',
      name: '${bloc.runtimeType}_ERROR',
    );
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log(
      'onBlocClose -- ${bloc.runtimeType}',
      name: '${bloc.runtimeType}_CLOSE',
    );
  }
}
