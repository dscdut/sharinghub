import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';

part 'notification.event.dart';
part 'notification.state.dart';

class NotificationBloc
    extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(const NotificationState.initial()) {
    on<NotificationStarted>(_start);
    add(const NotificationStarted());
  }

  Future<void> _start(
    NotificationStarted event,
    Emitter<NotificationState> emit,
  ) async {
    emit(state.copyWith(status: HandleStatus.loading));
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(status: HandleStatus.success));
  }
}
