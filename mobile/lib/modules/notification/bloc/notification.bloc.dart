import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notification.event.dart';
part 'notification.state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(const NotificationState()) {
    on<NotificationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
